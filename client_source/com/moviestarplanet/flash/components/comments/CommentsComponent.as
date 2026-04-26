package com.moviestarplanet.flash.components.comments
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.configuration.InputLocations;
   import com.moviestarplanet.clientcensor.Censor;
   import com.moviestarplanet.comments.ICommentsComponent;
   import com.moviestarplanet.entities.valueobjects.EntityComment;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.services.userservice.UserAmfServiceWeb;
   import com.moviestarplanet.userbehavior.UserBehaviorResult;
   import com.moviestarplanet.userbehavior.utils.chatfilter.userbehaviorcontrol.UserBehaviorControl;
   import com.moviestarplanet.utils.EntityTypeType;
   import com.moviestarplanet.utils.input.InputUtils;
   import com.moviestarplanet.utils.loader.RawUrl;
   import com.moviestarplanet.utils.translation.Localizer;
   import com.moviestarplanet.utils.ui.FlashInstanceUtils;
   import com.moviestarplanet.window.stack.WindowStack;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.net.registerClassAlias;
   import flash.system.ApplicationDomain;
   import mx.controls.SWFLoader;
   
   public class CommentsComponent extends Sprite implements ICommentsComponent
   {
      
      private static var _instance:CommentsComponent;
      
      private static var _instanceEntityType:int;
      
      private static var _instanceCallback:Function;
      
      private static var _instanceShown:Boolean;
      
      private var commentsList:CommentsList;
      
      private var commentInput:CommentInputArea;
      
      private var componentWidth:Number;
      
      private var componentHeight:Number;
      
      private var _params:Array;
      
      private var entityType:int;
      
      private var _entityId:int;
      
      public var pageSize:int = 4;
      
      private var _creatorId:int;
      
      private var loadCallback:Function;
      
      public function CommentsComponent(param1:int, param2:Number, param3:int = 4, param4:int = 0, param5:int = 0)
      {
         super();
         this.pageSize = param3;
         this._entityId = param2;
         this.entityType = param1;
         this.componentWidth = param4;
         this.componentHeight = param5;
         this.graphics.beginFill(78146);
         this.graphics.drawRect(0,0,this.componentWidth,this.componentHeight);
         MessageCommunicator.subscribe(CommentEvent.COMMENT_DELETED,this.refresh);
      }
      
      public static function get instanceEntityType() : int
      {
         return _instanceEntityType;
      }
      
      public static function getInstance(param1:int) : CommentsComponent
      {
         if(_instance == null || _instanceEntityType != param1)
         {
            _instance = new CommentsComponent(param1,0,5,227,430);
            _instanceEntityType = param1;
            _instanceShown = false;
         }
         return _instance;
      }
      
      public static function test() : void
      {
         var sprite:Sprite = null;
         var commentsComponent:CommentsComponent = null;
         var done:Function = null;
         done = function():void
         {
            sprite.addChild(commentsComponent);
            WindowStack.showSpriteAsViewStackable(sprite,750,130,WindowStack.Z_INFO);
         };
         sprite = new Sprite();
         var bg:Shape = new Shape();
         bg.graphics.beginFill(16776960);
         bg.graphics.drawRect(0,0,223,437);
         bg.graphics.endFill();
         sprite.addChild(bg);
         commentsComponent = new CommentsComponent(EntityTypeType.SCRAPBLOG,531,5,223,437);
         commentsComponent.load(done);
      }
      
      public function showCommentsComponentOnce(param1:Number, param2:Function, param3:int) : void
      {
         this._creatorId = param3;
         if(_instanceShown == false)
         {
            this.showCommentsComponent(param1,param2);
            _instanceShown = true;
         }
         else
         {
            this.entityId = param1;
            this.setSaveCommentCallback(param2);
            this.commentsList.refresh();
            this.commentsList.reset();
         }
      }
      
      private function refresh(param1:CommentEvent = null) : void
      {
         this.commentsList.refresh();
         dispatchEvent(new CommentEvent(CommentEvent.COMMENT_DELETED));
      }
      
      public function load(param1:Function) : void
      {
         this.loadCallback = param1;
         registerClassAlias("CommentsComponent",CommentsCtrls);
         registerClassAlias("InputArea",CommentInputArea);
         FlashInstanceUtils.loadFlashInstance(ApplicationDomain.currentDomain,new RawUrl("swf/comments/CommentsComponent.swf"),this.loadDone);
      }
      
      private function loadDone(param1:SWFLoader) : void
      {
         var _loc3_:CommentsCtrls = null;
         var _loc4_:Number = NaN;
         var _loc2_:Object = param1.content;
         if(_loc2_.CommentsComponent)
         {
            _loc3_ = _loc2_.CommentsComponent;
            _loc4_ = this.initSizes(_loc3_);
            addChild(_loc3_);
            Localizer.localizeBasic(_loc3_);
            this.commentsList = new CommentsList(this.pageSize,this.componentWidth,_loc4_ * this.pageSize);
            this.commentsList.initPageButtons(_loc3_.PrevButton,_loc3_.NextButton);
            _loc3_.CommentsList.addChild(this.commentsList);
            this.commentsList.params = [EntityTypeType.EntityTypeAsString(this.entityType),this.entityId];
            this.commentInput = _loc3_.inputArea;
            InputUtils.mapInput(this.commentInput,this.submitComment);
            if(this.loadCallback != null)
            {
               this.loadCallback();
            }
         }
      }
      
      public function set entityId(param1:Number) : void
      {
         this._entityId = param1;
         this.commentsList.params = [EntityTypeType.EntityTypeAsString(this.entityType),this.entityId];
      }
      
      public function get entityId() : Number
      {
         return this._entityId;
      }
      
      private function submitComment() : void
      {
         if(!this.commentInput.enabled || this.entityId <= 0)
         {
            return;
         }
         UserBehaviorControl.getInstance().inputUserBehaviorFilterAndLog(this.commentInput.textArea,this.inputUserBehaviorFilterCallback,ActorSession.getActorId(),String(0),InputLocations.LOC_COMMENT,true,true,true);
      }
      
      private function inputUserBehaviorFilterCallback(param1:UserBehaviorResult) : void
      {
         var saveDone:Function;
         var entityComment:EntityComment = null;
         var userBehaviorResult:UserBehaviorResult = param1;
         if(userBehaviorResult.isSafe)
         {
            saveDone = function(param1:Object):void
            {
               commentInput.textArea.text = "";
               commentInput.enabled = true;
               refreshList();
               dispatchEvent(new CommentEvent(CommentEvent.SAVE_COMMENT_DONE,{
                  "type":entityType,
                  "id":entityId
               }));
               if(_instance != null && _instanceCallback != null)
               {
                  _instanceCallback();
               }
            };
            Censor.logInput(this.commentInput.text,InputLocations.LOC_COMMENT,"");
            this.commentInput.enabled = false;
            entityComment = new EntityComment();
            entityComment.EntityCommentId = 0;
            entityComment.EntityType = this.entityType;
            entityComment.EntityId = this.entityId;
            entityComment.ActorId = ActorSession.getActorId();
            entityComment.Created = new Date(2001,1,1);
            entityComment.IsDeleted = 0;
            entityComment.Comment = this.commentInput.text;
            UserAmfServiceWeb.CommentEntity(entityComment,userBehaviorResult,saveDone);
         }
      }
      
      private function refreshList(param1:CommentEvent = null) : void
      {
         this.commentsList.retriveAndStartPager();
      }
      
      private function initSizes(param1:CommentsCtrls) : Number
      {
         if(this.componentWidth == 0)
         {
            this.componentWidth = param1.width;
         }
         if(this.componentHeight == 0)
         {
            this.componentHeight = param1.height;
         }
         var _loc2_:Number = this.componentWidth - param1.width;
         param1.inputArea.itemWidth = this.componentWidth;
         param1.inputArea.index = this.pageSize + 1;
         var _loc3_:Number = (this.componentHeight - param1.CommentsList.y) / (this.pageSize + 1);
         param1.inputArea.itemHeight = _loc3_;
         param1.inputArea.y = param1.CommentsList.y + _loc3_ * this.pageSize;
         param1.PrevButton.x += _loc2_;
         param1.NextButton.x += _loc2_;
         return _loc3_;
      }
      
      public function showCommentsComponent(param1:Number, param2:Function) : void
      {
         var loadDone:Function = null;
         var entityId:Number = param1;
         var cb:Function = param2;
         loadDone = function():void
         {
            _instance.entityId = entityId;
            cb();
         };
         _instance.load(loadDone);
      }
      
      public function setSaveCommentCallback(param1:Function) : void
      {
         _instanceCallback = param1;
      }
      
      public function get creatorId() : int
      {
         return this._creatorId;
      }
   }
}

