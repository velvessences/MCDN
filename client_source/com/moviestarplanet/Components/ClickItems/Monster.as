package com.moviestarplanet.Components.ClickItems
{
   import com.moviestarplanet.Components.EditMyRoom;
   import com.moviestarplanet.Components.Friends.FriendshipManager;
   import com.moviestarplanet.Components.MonsterPopup;
   import com.moviestarplanet.analytics.AnalyticsSpendCurrencyCommand;
   import com.moviestarplanet.analytics.constants.AnalyticsConstants;
   import com.moviestarplanet.chat.ChatRoomController;
   import com.moviestarplanet.clickitems.ClickItem;
   import com.moviestarplanet.clickitems.ClickItemCatalog;
   import com.moviestarplanet.clickitems.MonsterGraphicsDriver;
   import com.moviestarplanet.core.model.actor.reload.ActorReload;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.flash.components.popups.GetDiamondsPopUp;
   import com.moviestarplanet.frame.congratspopups.InstantPetGrowAnimation;
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.pet.service.PetAMFService;
   import com.moviestarplanet.pet.utils.ClickItemUtil;
   import com.moviestarplanet.pet.utils.MonsterConstants;
   import com.moviestarplanet.pet.valueobjects.ActorClickItemRel;
   import com.moviestarplanet.services.spendingservice.valueObjects.SpecialsItem;
   import com.moviestarplanet.spending.SpendingProvider;
   import com.moviestarplanet.utils.DateUtils;
   import com.moviestarplanet.utils.loader.ContentUrl;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import mx.events.PropertyChangeEvent;
   
   public class Monster extends ClickItem
   {
      
      private var _3478mc:MovieClip;
      
      private var _659240129isPopupEnabled:Boolean = true;
      
      protected var _dispatchUpdates:Boolean = true;
      
      protected var _monsterPopup:MonsterPopup;
      
      private var _monsterGraphicsDriver:MonsterGraphicsDriver;
      
      private var _healthStatus:String = "normal";
      
      private var _foodPoints:int = -1;
      
      private var _lastPetTime:Number;
      
      private var _hatchTimer:Timer;
      
      private var _hasHatched:Boolean = false;
      
      protected const E_MONSTER_UPDATED:String = "E_MONSTER_UPDATED";
      
      public function Monster(param1:ActorClickItemRel)
      {
         var _loc2_:Object = null;
         this._lastPetTime = DateUtils.nowUTC.getTime() - MonsterConstants.PET_INTERVAL;
         super(param1);
         this._monsterGraphicsDriver = new MonsterGraphicsDriver();
         if(Boolean(param1.Data) && param1.Data.length > 0)
         {
            _loc2_ = SerializeUtils.deserialize(param1.Data);
            this._monsterGraphicsDriver.configuration = this.checkAndAdjustConfiguration(param1.ClickItemId,_loc2_);
         }
         this.update();
         MessageCommunicator.subscribe(this.E_MONSTER_UPDATED,this.externalUpdate);
      }
      
      public static function cloneActorClickItemRel(param1:ActorClickItemRel, param2:Boolean = false) : ActorClickItemRel
      {
         var _loc3_:ActorClickItemRel = new ActorClickItemRel();
         _loc3_.ActorClickItemRelId = param1.ActorClickItemRelId;
         _loc3_.ActorId = param1.ActorId;
         _loc3_.ClickItemId = param1.ClickItemId;
         _loc3_.Data = param1.Data;
         _loc3_.LastFeedTime = param1.LastFeedTime;
         _loc3_.FoodPoints = param1.FoodPoints;
         _loc3_.LastWashTime = param1.LastWashTime;
         _loc3_.Name = param1.Name;
         _loc3_.PlayPoints = param1.PlayPoints;
         _loc3_.Stage = param1.Stage;
         if(param2 == true)
         {
            _loc3_.Stage += 1;
         }
         return _loc3_;
      }
      
      public static function isPetRandomisable(param1:Monster) : Boolean
      {
         return param1.monsterGraphicsDriver.bodyOptions.length > 1;
      }
      
      override public function get yOffSet() : int
      {
         if(clickItemData.ActorId != ActorSession.loggedInActor.ActorId || clickItemData.Stage == 0)
         {
            return 20;
         }
         return -30;
      }
      
      public function randomize() : void
      {
         this._monsterGraphicsDriver.randomizeConfiguration();
      }
      
      public function playAnimation(param1:String) : void
      {
         this._monsterGraphicsDriver.playAnimation(param1);
      }
      
      public function stopAnimation() : void
      {
         this._monsterGraphicsDriver.stopAnimation();
      }
      
      public function repaint() : void
      {
         this._monsterGraphicsDriver.repaint();
      }
      
      public function paintMood() : void
      {
         this._monsterGraphicsDriver.paintMood();
      }
      
      public function setMood(param1:String) : void
      {
         this._monsterGraphicsDriver.setMood(param1);
      }
      
      override public function loadClickItemSwf(param1:Function = null) : void
      {
         var ready:Function = null;
         var loadDone:Function = null;
         var done:Function = param1;
         ready = function():void
         {
            var _loc1_:String = swf + "_" + clickItemData.Stage.toString() + ".swf";
            addEventListener(Event.COMPLETE,loadDone,false,0,false);
            LoadUrl(new ContentUrl(_loc1_,ContentUrl.PET),2,false);
         };
         loadDone = function(param1:Event):void
         {
            removeEventListener(Event.COMPLETE,loadDone);
            mc = content as MovieClip;
            _monsterGraphicsDriver.graphicsMc = mc;
            mc.scaleX = 0.4;
            mc.scaleY = 0.4;
            _isLoaded = true;
            dispatchEvent(new Event(E_SWFLOADED));
            if(done != null)
            {
               done();
            }
         };
         ClickItemCatalog.init(ready);
      }
      
      public function get healthStatus() : String
      {
         return this._healthStatus;
      }
      
      private function set _517704046healthStatus(param1:String) : void
      {
         this._healthStatus = param1;
         switch(this._healthStatus)
         {
            case "sick":
               this._monsterGraphicsDriver.setMood("_sick");
               break;
            default:
               this._monsterGraphicsDriver.setMood("");
         }
      }
      
      public function get foodPoints() : int
      {
         return this._foodPoints;
      }
      
      private function set _497936671foodPoints(param1:int) : void
      {
         this._foodPoints = param1;
      }
      
      public function get NextFeedTime() : Date
      {
         var _loc1_:Date = new Date();
         _loc1_.setTime(clickItemData.LastFeedTime.getTime() + MonsterConstants.MIN_FEEDING_INTERVAL_MS);
         return _loc1_;
      }
      
      public function get CanBeFed() : Boolean
      {
         var _loc1_:Number = DateUtils.nowUTC.getTime() - clickItemData.LastFeedTime.getTime() + 10000;
         return _loc1_ >= MonsterConstants.MIN_FEEDING_INTERVAL_MS;
      }
      
      override public function update() : void
      {
         if(clickItemData.LastFeedTime == null)
         {
            this.healthStatus = "normal";
            return;
         }
         this.foodPoints = ClickItemUtil.calcActualFoodPoints(clickItemData.FoodPoints,clickItemData.LastFeedTime);
         if(this.foodPoints < 0)
         {
            if(this.foodPoints <= MonsterConstants.FOODPOINT_SICK_LEVEL)
            {
               this.healthStatus = "sick";
            }
            this.foodPoints = 0;
         }
         else
         {
            this.healthStatus = this.CanBeFed ? "normal" : "wait";
         }
      }
      
      public function curePet(param1:Function) : void
      {
         var done:Function = null;
         var doneCallback:Function = param1;
         done = function(param1:ActorClickItemRel):void
         {
            if(clickItemData.LastFeedTime.time != param1.LastFeedTime.time)
            {
               AnalyticsSpendCurrencyCommand.execute(AnalyticsConstants.PET_CURE,AnalyticsConstants.STARCOINS,MEDICINPRICE);
            }
            clickItemData = param1;
            update();
            ActorReload.getInstance().requestReload();
            doneCallback();
         };
         if(this.healthStatus != "sick")
         {
            throw new Error("Cannot cure because healthstatus is " + this.healthStatus);
         }
         new PetAMFService().CurePet(clickItemData.ActorClickItemRelId,done);
      }
      
      public function feed(param1:int, param2:Function) : void
      {
         var feedDone:Function = null;
         var value:int = param1;
         var done:Function = param2;
         feedDone = function(param1:Object):void
         {
            var awardedFame:int = 0;
            var doneLoadClickItemSwf:Function = null;
            var data:Object = param1;
            doneLoadClickItemSwf = function():void
            {
               done(awardedFame);
            };
            var loadedActorData:ActorClickItemRel = ActorClickItemRel.GetInstance(data.actorClickItemRel);
            awardedFame = int(data.awardedFame);
            var stageChanged:Boolean = false;
            if(loadedActorData.Stage != clickItemData.Stage)
            {
               stageChanged = false;
            }
            if(clickItemData.LastFeedTime.time != loadedActorData.LastFeedTime.time)
            {
               AnalyticsSpendCurrencyCommand.execute(AnalyticsConstants.PET_FEED,AnalyticsConstants.STARCOINS,FOODPRICE);
            }
            clickItemData = loadedActorData;
            loadClickItemSwf(doneLoadClickItemSwf);
            update();
            setMood("_eat");
            if(stageChanged)
            {
               MessageCommunicator.sendMessage(EditMyRoom.E_CLICKITEM_LIST_CHANGED,null);
            }
         };
         if(this.healthStatus != "normal")
         {
            throw new Error("Cannot feed because healthstatus is " + this.healthStatus);
         }
         new PetAMFService().FeedPet(clickItemData.ActorClickItemRelId,value,feedDone);
      }
      
      private function get canPet() : Boolean
      {
         var _loc1_:Number = DateUtils.nowUTC.getTime() - this._lastPetTime;
         return _loc1_ > MonsterConstants.PET_INTERVAL;
      }
      
      public function pet() : void
      {
         this._lastPetTime = DateUtils.nowUTC.getTime();
         this.setMood("_happy");
      }
      
      public function hatch() : void
      {
         if(this._hasHatched)
         {
            return;
         }
         this._hasHatched = true;
         this._monsterGraphicsDriver.hatch();
         this._hatchTimer = new Timer(3000,1);
         this._hatchTimer.addEventListener(TimerEvent.TIMER,this.hatchDone,false,0,true);
         this._hatchTimer.start();
      }
      
      private function checkAndAdjustConfiguration(param1:int, param2:Object) : Object
      {
         var _loc3_:Object = param2;
         switch(param1)
         {
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 7:
               break;
            case 6:
            case 8:
               if(_loc3_.body != "body1" && _loc3_.body != "body2" && _loc3_.body != "body3")
               {
                  _loc3_.body = "body1";
               }
               if(_loc3_.horns != "horns1" && _loc3_.horns != "horns2" && _loc3_.horns != "horns3")
               {
                  _loc3_.horns = "horns1";
               }
               _loc3_.acc = null;
               _loc3_.paws = "paws1";
               _loc3_.mouth = "mouth1";
               break;
            case 19:
               _loc3_.acc = "acc1";
               _loc3_.body = "body1";
               _loc3_.eyes = "eyes2";
               _loc3_.horns = "horns1";
               _loc3_.mouth = "mouth1";
               _loc3_.paws = "paws1";
               break;
            default:
               _loc3_.acc = "acc1";
               _loc3_.body = "body1";
               _loc3_.eyes = "eyes2";
               _loc3_.horns = "horns1";
               _loc3_.mouth = "mouth2";
               _loc3_.paws = "paws1";
         }
         return _loc3_;
      }
      
      protected function hatchDone(param1:Event) : void
      {
         var saveDone:Function = null;
         var event:Event = param1;
         saveDone = function():void
         {
            MessageCommunicator.sendMessage(EditMyRoom.E_CLICKITEM_LIST_CHANGED,null);
         };
         this._monsterGraphicsDriver.adjustConfigurationOptions(clickItemData.ClickItemId);
         this._monsterGraphicsDriver.randomizeConfiguration();
         ClickItemUtil.startHatching(clickItemData,this._monsterGraphicsDriver.configuration);
         this.healthStatus = "normal";
         this._hasHatched = true;
         this.loadClickItemSwf();
         new PetAMFService().HatchPet(clickItemData.ActorClickItemRelId,clickItemData.Data,saveDone);
      }
      
      private function externalUpdate(param1:MsgEvent) : void
      {
         var _loc2_:Monster = param1.data as Monster;
         if(!_loc2_ || _loc2_ == this)
         {
            return;
         }
         if(_loc2_.clickItemData.ActorClickItemRelId == this.clickItemData.ActorClickItemRelId)
         {
            this.clickItemData = _loc2_.clickItemData;
            this._dispatchUpdates = false;
            this.update();
            this._dispatchUpdates = true;
         }
      }
      
      override public function set allowPopup(param1:Boolean) : void
      {
         if(param1)
         {
            this.isPopupEnabled = true;
            buttonMode = true;
            useHandCursor = true;
            addEventListener(MouseEvent.CLICK,this.click);
         }
         else
         {
            this.isPopupEnabled = false;
            buttonMode = false;
            useHandCursor = false;
            removeEventListener(MouseEvent.CLICK,this.click);
         }
      }
      
      override public function click(param1:Event = null) : void
      {
         if(ChatRoomController.isPlayingChatroomGame || !this.isPopupEnabled)
         {
            return;
         }
         param1.stopImmediatePropagation();
         MonsterPopup.closeCurrent();
         if(this._monsterPopup == null)
         {
            this._monsterPopup = new MonsterPopup();
            this._monsterPopup.monster = this;
         }
         var _loc2_:Rectangle = getBounds(Main.Instance.mainCanvas.applicationViewStack.mainView.popupCanvas);
         MonsterPopup.Show(this._monsterPopup,new Point(_loc2_.x + _loc2_.width,_loc2_.y),IS_PLANT);
      }
      
      public function buyInstantPetGrowCallback(param1:Object) : void
      {
         var _loc2_:InstantPetGrowAnimation = null;
         if(param1.Code == SpendingProvider.RESULT_CODE_SUCCESS)
         {
            _loc2_ = new InstantPetGrowAnimation(Pet(this));
            FriendshipManager.getInstance().sendBasicEventToFriends(SpecialsItem.INSTANT_PET_GROW);
            clickItemData.Stage = param1.Data;
            this.update();
            this.loadClickItemSwf();
         }
         else if(param1.Code == SpendingProvider.RESULT_CODE_NOT_ENOUGH_DIAMONDS)
         {
            GetDiamondsPopUp.Show();
         }
      }
      
      public function get isFullyGrown() : Boolean
      {
         if(clickItemData.Stage == ClickItemCatalog.itemAt(clickItemData.ClickItemId).MaxStage)
         {
            return true;
         }
         return false;
      }
      
      public function get monsterGraphicsDriver() : MonsterGraphicsDriver
      {
         return this._monsterGraphicsDriver;
      }
      
      private function set _1932752118configuration(param1:Object) : void
      {
         this._monsterGraphicsDriver.configuration = param1;
      }
      
      public function get configuration() : Object
      {
         return this._monsterGraphicsDriver.configuration;
      }
      
      override public function destroy() : void
      {
         MessageCommunicator.unscribe(this.E_MONSTER_UPDATED,this.externalUpdate);
         removeEventListener(MouseEvent.CLICK,this.click);
         if(this._monsterGraphicsDriver != null)
         {
            this._monsterGraphicsDriver.destroy();
            this._monsterGraphicsDriver = null;
         }
         this._monsterPopup = null;
         super.destroy();
      }
      
      [Bindable(event="propertyChange")]
      public function get mc() : MovieClip
      {
         return this._3478mc;
      }
      
      public function set mc(param1:MovieClip) : void
      {
         var _loc2_:Object = this._3478mc;
         if(_loc2_ !== param1)
         {
            this._3478mc = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mc",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get isPopupEnabled() : Boolean
      {
         return this._659240129isPopupEnabled;
      }
      
      public function set isPopupEnabled(param1:Boolean) : void
      {
         var _loc2_:Object = this._659240129isPopupEnabled;
         if(_loc2_ !== param1)
         {
            this._659240129isPopupEnabled = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isPopupEnabled",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set healthStatus(param1:String) : void
      {
         var _loc2_:Object = this.healthStatus;
         if(_loc2_ !== param1)
         {
            this._517704046healthStatus = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"healthStatus",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set foodPoints(param1:int) : void
      {
         var _loc2_:Object = this.foodPoints;
         if(_loc2_ !== param1)
         {
            this._497936671foodPoints = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"foodPoints",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set configuration(param1:Object) : void
      {
         var _loc2_:Object = this.configuration;
         if(_loc2_ !== param1)
         {
            this._1932752118configuration = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"configuration",_loc2_,param1));
            }
         }
      }
   }
}

