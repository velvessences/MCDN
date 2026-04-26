package com.moviestarplanet.chat.video.videochatroom
{
   import com.greensock.TweenLite;
   import com.moviestarplanet.Forms.ChatRoom;
   import com.moviestarplanet.chat.ChatRoomType;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.media.youtube.PlayerStateEvent;
   import com.moviestarplanet.media.youtube.YouTubeAPI;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.msg.events.CareerQuestEvent;
   import com.moviestarplanet.msg.events.CareerQuestsGoToDestinations;
   import com.moviestarplanet.services.videoservice.VideoServiceProvider;
   import com.moviestarplanet.services.videoservice.valueObjects.ExternalVideoData;
   import com.moviestarplanet.utils.ComponentUtilities;
   import com.moviestarplanet.utils.displayobject.FlattenUtilities;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import mx.containers.Canvas;
   import mx.core.ScrollPolicy;
   import mx.core.UIComponent;
   
   public class VideoChatRoom extends ChatRoom
   {
      
      private var canvasFront:Canvas;
      
      private var player:VideoChatRoomPlayer;
      
      private const CHATROOM_WIDTH:Number = 1700;
      
      private var forbiddenXStart:Number = 610;
      
      private var forbiddenXEnd:Number = 1060;
      
      private var separationMiddle:Number = this.forbiddenXStart + (this.forbiddenXEnd - this.forbiddenXStart) / 2;
      
      private var currentVideoInfo:VideoInfo = new VideoInfo();
      
      public function VideoChatRoom()
      {
         super();
         MessageCommunicator.send(new MsgEvent(CareerQuestEvent.USER_CLICKED_BUTTON,CareerQuestsGoToDestinations.CINEMA));
      }
      
      override protected function invokeClassSpecificLogic(param1:ChatRoomType) : void
      {
         btnGames.visible = btnGames.includeInLayout = false;
         showSpecialsService(false);
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         HORIZON_Y_COORD = 305;
         X_MIN_COORD = 0;
         X_MAX_COORD = this.CHATROOM_WIDTH;
         canvasBackground.width = this.CHATROOM_WIDTH;
         canvasStuff.width = this.CHATROOM_WIDTH;
         canvasActor.width = this.CHATROOM_WIDTH;
         canvasSpeach.width = this.CHATROOM_WIDTH;
         this.canvasFront = new Canvas();
         this.canvasFront.width = this.CHATROOM_WIDTH;
         this.canvasFront.height = 445;
         this.canvasFront.horizontalScrollPolicy = ScrollPolicy.OFF;
         this.canvasFront.verticalScrollPolicy = ScrollPolicy.OFF;
         sliderCanvas.addChild(this.canvasFront);
         this.player = new VideoChatRoomPlayer();
         canvasBackground.addChild(this.player);
         this.player.addEventListener(PlayerStateEvent.PLAYER_STATE_CHANGED,this.onPlayerStateChange);
         this.player.addEventListener(PlayerStateEvent.PLAYER_STATE_ERROR,this.onVideoError);
         this.player.addEventListener(VideoChatRoomPlayer.NO_ACTION_EVENT,this.onNoAction);
         this.player.x = canvasBackground.width / 2 - this.player.width / 2;
         this.player.y = 27;
      }
      
      private function onPlayerStateChange(param1:PlayerStateEvent) : void
      {
         if(param1.data == YouTubeAPI.STATE_PLAYING)
         {
            if(!this.currentVideoInfo.isWatching)
            {
               this.currentVideoInfo.readyToSeek = true;
            }
         }
         if(param1.data == YouTubeAPI.STATE_ENDED)
         {
            if(this.currentVideoInfo.isWatching)
            {
               roomConnection.call("doneWatching",null,roomId,this.currentVideoInfo.index);
            }
         }
      }
      
      private function onNoAction(param1:Event) : void
      {
         this.currentVideoInfo.index = 0;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:DisplayObject = null;
         for each(_loc2_ in actorMessageTable)
         {
            if(_loc2_ != null)
            {
               if(_loc2_.x > this.forbiddenXStart && _loc2_.x < this.forbiddenXEnd)
               {
                  if(_loc2_.alpha == 1)
                  {
                     TweenLite.to(_loc2_,0.2,{"alpha":0});
                  }
               }
               else if(_loc2_.alpha == 0)
               {
                  TweenLite.to(_loc2_,0.2,{"alpha":1});
               }
            }
         }
      }
      
      override protected function onBackgroundLoaded() : void
      {
         var _loc3_:UIComponent = null;
         var _loc1_:MovieClip = ComponentUtilities.findInstanceBFS("audience",binder.content) as MovieClip;
         var _loc2_:Number = ApplicationReference.getApplicationScale();
         if(_loc1_ != null)
         {
            binder.content.removeChild(_loc1_);
            _loc3_ = new UIComponent();
            _loc3_.addChild(_loc1_);
            this.canvasFront.addChild(_loc3_);
            FlattenUtilities.flattenSprite(_loc1_,_loc2_,true,false,true);
            _loc1_.mouseEnabled = false;
            _loc1_.mouseChildren = false;
            _loc3_.mouseChildren = false;
            _loc3_.mouseEnabled = false;
            this.canvasFront.mouseChildren = false;
            this.canvasFront.mouseEnabled = false;
         }
         FlattenUtilities.flattenSprite(binder.content,_loc2_,true,false,false);
      }
      
      private function onVideoError(param1:PlayerStateEvent) : void
      {
         roomConnection.call("reportError",null,roomId,this.currentVideoInfo.index,ActorSession.loggedInActor.ActorId);
      }
      
      override protected function onVideoSync(param1:Object) : void
      {
         var done:Function;
         var valueObj:Object = param1;
         if(valueObj.index != this.currentVideoInfo.index)
         {
            done = function(param1:ExternalVideoData):void
            {
               if(param1 != null)
               {
                  player.playVideo(param1.ExternalRef);
               }
            };
            this.currentVideoInfo.readyToSeek = false;
            this.currentVideoInfo.isWatching = false;
            this.currentVideoInfo.index = valueObj.index;
            VideoServiceProvider.getExternalVideoForChatRoom(this.currentVideoInfo.index,done);
         }
         if(this.currentVideoInfo.readyToSeek && !this.currentVideoInfo.isWatching)
         {
            this.player.seekTo(valueObj.seconds);
            this.currentVideoInfo.isWatching = true;
         }
      }
      
      override protected function applyRestrictionX(param1:Number) : Number
      {
         if(param1 > this.forbiddenXStart && param1 < this.forbiddenXEnd && param1 <= this.separationMiddle)
         {
            param1 = this.forbiddenXStart;
         }
         else if(param1 > this.forbiddenXStart && param1 < this.forbiddenXEnd && param1 > this.separationMiddle)
         {
            param1 = this.forbiddenXEnd;
         }
         return param1;
      }
      
      override protected function applyGameObjectRestrictionX(param1:Number) : Number
      {
         var _loc2_:Number = 50;
         var _loc3_:Number = (this.CHATROOM_WIDTH - _loc2_ * 2 - VideoChatRoomPlayer.PLAYER_WIDTH) / 2;
         var _loc4_:Number = Math.random() * _loc3_;
         var _loc5_:Boolean = Math.random() > 0.5;
         if(_loc5_)
         {
            param1 = this.forbiddenXStart - 50 - _loc4_;
         }
         else
         {
            param1 = this.forbiddenXEnd + 50 + _loc4_;
         }
         return param1;
      }
      
      override protected function applyQuizCanvasPosRestriction(param1:Number) : Number
      {
         if(param1 > this.forbiddenXStart - 400 && param1 < this.forbiddenXEnd + 30 && param1 <= this.separationMiddle)
         {
            param1 = this.forbiddenXStart - 400;
         }
         else if(param1 > this.forbiddenXStart - 400 && param1 < this.forbiddenXEnd + 30 && param1 > this.separationMiddle)
         {
            param1 = this.forbiddenXEnd + 30;
         }
         return param1;
      }
      
      override protected function loadMyActorExtras() : void
      {
         var _loc1_:Number = 550;
         var _loc2_:Number = (this.CHATROOM_WIDTH - _loc1_ * 2 - VideoChatRoomPlayer.PLAYER_WIDTH) / 2;
         var _loc3_:Number = Math.random() * _loc2_;
         var _loc4_:Boolean = Math.random() > 0.5;
         if(_loc4_)
         {
            initialX = this.forbiddenXStart - _loc3_;
         }
         else
         {
            initialX = this.forbiddenXEnd + _loc3_;
         }
      }
      
      override public function close() : void
      {
         super.close();
         this.currentVideoInfo.index = 0;
      }
   }
}

