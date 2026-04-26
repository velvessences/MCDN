package com.moviestarplanet.quest.gifthunt
{
   import com.moviestarplanet.actor.IActorDetails;
   import com.moviestarplanet.actorservice.mobileservice.ActorAmfService;
   import com.moviestarplanet.actorservice.service.ActorAmfServiceForWeb;
   import com.moviestarplanet.amf.valueobjects.ServiceResultData;
   import com.moviestarplanet.awarding.valueobjects.AwardAmount;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.giftHunt.IGiftArea;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.mangroveanalytics.MangroveAnalytics;
   import com.moviestarplanet.mangroveanalytics.constants.EntityActionEventConst;
   import com.moviestarplanet.msg.events.CareerQuestEvent;
   import com.moviestarplanet.msg.events.CareerQuestsGoToDestinations;
   import com.moviestarplanet.msg.events.QuestEvent;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import mx.collections.ArrayCollection;
   import starling.display.DisplayObjectContainer;
   import starling.events.Event;
   
   public class GiftHuntManager
   {
      
      private static var _instance:GiftHuntManager;
      
      private const WORLD_MAP_AREA_MOBILE:int = 0;
      
      private const WORLD_MAP_AREA_WEB:int = 1;
      
      private var _injectedActorDetails:IActorDetails;
      
      private var giftHuntLookup:Dictionary;
      
      private var giftHuntMappingList:Vector.<GiftHuntMapping>;
      
      private var hasGiftHuntDataBeenReceived:Boolean;
      
      private var requestsQueue:Vector.<Function> = new Vector.<Function>();
      
      private var requestsForQuestsQueue:Vector.<Function> = new Vector.<Function>();
      
      private var onScreenGifts:Vector.<Object>;
      
      public function GiftHuntManager(param1:Function = null)
      {
         super();
         if(param1 != singletonBlocker)
         {
            throw new Error("GiftHuntManger is a singleton class, use GiftHuntManager.instance instead!");
         }
         this.giftHuntLookup = new Dictionary();
         this.hasGiftHuntDataBeenReceived = false;
         this.giftHuntMappingList = new Vector.<GiftHuntMapping>();
         this.onScreenGifts = new Vector.<Object>();
         MessageCommunicator.subscribe(MSPEvent.DO_LOGOUT,this.loggedOut);
      }
      
      private static function singletonBlocker() : void
      {
      }
      
      public static function getInstance() : GiftHuntManager
      {
         if(_instance == null)
         {
            _instance = new GiftHuntManager(singletonBlocker);
         }
         return _instance;
      }
      
      private function loggedOut(param1:MsgEvent) : void
      {
         MessageCommunicator.unscribe(MSPEvent.DO_LOGOUT,this.loggedOut);
         this.hasGiftHuntDataBeenReceived = false;
         this.giftHuntLookup = null;
         this._injectedActorDetails = null;
         _instance = null;
      }
      
      public function doGiftHuntMapping(param1:Vector.<GiftHuntMapping>) : void
      {
         this.giftHuntMappingList = param1;
      }
      
      public function giftHuntDataReceived(param1:ArrayCollection) : void
      {
         var _loc2_:GiftHuntData = null;
         var _loc3_:int = 0;
         trace("giftHuntDataReceived");
         for each(_loc2_ in param1)
         {
            this.giftHuntLookup[_loc2_.GiftType] = _loc2_.GiftData;
         }
         this.hasGiftHuntDataBeenReceived = true;
         _loc3_ = 0;
         while(_loc3_ < this.requestsQueue.length)
         {
            this.requestsQueue[_loc3_]();
            _loc3_++;
         }
         MessageCommunicator.send(new MsgEvent(GiftHuntEventFlash.GIFT_DATA_UPDATED));
      }
      
      public function questGiftHuntDataReceived(param1:GiftHuntData) : void
      {
         var _loc2_:int = 0;
         if(param1 != null)
         {
            this.giftHuntLookup[param1.GiftType] = param1.GiftData;
            _loc2_ = 0;
            while(_loc2_ < this.requestsForQuestsQueue.length)
            {
               this.requestsForQuestsQueue[_loc2_](param1.GiftType);
               _loc2_++;
            }
         }
         MessageCommunicator.send(new MsgEvent(GiftHuntEventFlash.GIFT_DATA_UPDATED));
      }
      
      public function getGiftsMappingFromArea(param1:IGiftArea, param2:Function) : void
      {
         var continueMethod:Function = null;
         var area:IGiftArea = param1;
         var callback:Function = param2;
         continueMethod = function():void
         {
            var _loc3_:int = 0;
            var _loc4_:String = null;
            var _loc1_:int = area.getAreaType();
            var _loc2_:Vector.<GiftHuntMapping> = new Vector.<GiftHuntMapping>();
            var _loc5_:int = 0;
            while(_loc5_ < giftHuntMappingList.length)
            {
               if(_loc1_ == giftHuntMappingList[_loc5_].areaType)
               {
                  _loc3_ = giftHuntMappingList[_loc5_].giftCategory;
                  _loc4_ = giftHuntLookup[_loc3_];
                  if(_loc4_ != null && _loc4_.charAt(giftHuntMappingList[_loc5_].giftId) == "0")
                  {
                     _loc2_.push(giftHuntMappingList[_loc5_]);
                  }
               }
               _loc5_++;
            }
            callback(_loc2_);
         };
         if(this.hasGiftHuntDataBeenReceived == true)
         {
            continueMethod();
         }
         else
         {
            this.requestsQueue.push(continueMethod);
         }
      }
      
      public function clearSubscribedQueues() : void
      {
         this.requestsForQuestsQueue.length = 0;
         this.requestsQueue.length = 0;
      }
      
      public function subscribeToQuestGiftDataReceived(param1:IGiftArea, param2:Function) : void
      {
         var continueMethod:Function = null;
         var area:IGiftArea = param1;
         var callback:Function = param2;
         continueMethod = function(param1:int):void
         {
            var _loc4_:int = 0;
            var _loc5_:String = null;
            var _loc2_:int = area.getAreaType();
            var _loc3_:Vector.<GiftHuntMapping> = new Vector.<GiftHuntMapping>();
            var _loc6_:int = 0;
            while(_loc6_ < giftHuntMappingList.length)
            {
               if(_loc2_ == giftHuntMappingList[_loc6_].areaType && giftHuntMappingList[_loc6_].giftCategory == param1)
               {
                  _loc4_ = giftHuntMappingList[_loc6_].giftCategory;
                  _loc5_ = giftHuntLookup[_loc4_];
                  if(_loc5_ != null && _loc5_.charAt(giftHuntMappingList[_loc6_].giftId) == "0")
                  {
                     _loc3_.push(giftHuntMappingList[_loc6_]);
                  }
               }
               _loc6_++;
            }
            callback(_loc3_);
         };
         this.requestsForQuestsQueue.push(continueMethod);
      }
      
      private function countGiftsOpenedByGiftCategory(param1:int) : int
      {
         var _loc2_:String = this.giftHuntLookup[param1] as String;
         if(_loc2_ == null)
         {
            return 0;
         }
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(_loc2_.charAt(_loc4_) == "1")
            {
               _loc3_++;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function countGiftsToBeOpenedByGiftCategory(param1:int) : int
      {
         if(this.giftHuntLookup[param1] != null)
         {
            return this.giftHuntLookup[param1].length - this.countGiftsOpenedByGiftCategory(param1);
         }
         return 0;
      }
      
      public function hasUnopenedGiftsByAreaType(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.giftHuntMappingList.length)
         {
            if(this.giftHuntMappingList[_loc2_].areaType == param1 && this.giftHuntLookup[this.giftHuntMappingList[_loc2_].giftCategory] != null && this.giftHuntLookup[this.giftHuntMappingList[_loc2_].giftCategory].charAt([this.giftHuntMappingList[_loc2_].giftId]) == "0")
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function savePickUp(param1:int, param2:int) : void
      {
         var _loc3_:String = this.giftHuntLookup[param1];
         this.giftHuntLookup[param1] = _loc3_.substr(0,param2) + "1" + _loc3_.substr(param2 + 1);
         MessageCommunicator.send(new MsgEvent(GiftHuntEventFlash.GIFT_DATA_UPDATED));
      }
      
      public function giftPickupService(param1:GiftHuntMapping, param2:Function) : void
      {
         var webMethodCallback:Function = null;
         var mobileMethodCallback:Function = null;
         var giftMapping:GiftHuntMapping = param1;
         var callback:Function = param2;
         webMethodCallback = function(param1:ServiceResultData):void
         {
            var _loc3_:String = null;
            var _loc2_:AwardAmount = param1.Data as AwardAmount;
            if(giftMapping.areaType == WORLD_MAP_AREA_WEB)
            {
               _loc3_ = EntityActionEventConst.ENTITY_SUB2_GIFT_LOCATION_WORLD_SCREEN;
            }
            else
            {
               _loc3_ = EntityActionEventConst.ENTITY_SUB2_GIFT_LOCATION_SUB_MENU;
            }
            MangroveAnalytics.registerAwardClaim(EntityActionEventConst.ENTITY_SUB1_GIFT_HUNT,_loc3_,_loc2_.Fame,_loc2_.Starcoins,_loc2_.Diamonds);
            callback(param1.Data as AwardAmount);
         };
         mobileMethodCallback = function(param1:ServiceResultData):void
         {
            var _loc3_:String = null;
            var _loc2_:AwardAmount = param1.Data as AwardAmount;
            if(giftMapping.areaType == WORLD_MAP_AREA_MOBILE)
            {
               _loc3_ = EntityActionEventConst.ENTITY_SUB2_GIFT_LOCATION_WORLD_SCREEN;
            }
            else
            {
               _loc3_ = EntityActionEventConst.ENTITY_SUB2_GIFT_LOCATION_SUB_MENU;
            }
            MangroveAnalytics.registerAwardClaim(EntityActionEventConst.ENTITY_SUB1_GIFT_HUNT,_loc3_,_loc2_.Fame,_loc2_.Starcoins,_loc2_.Diamonds);
            callback(param1.Data as AwardAmount);
         };
         this.savePickUp(giftMapping.giftCategory,giftMapping.giftId);
         this.sendQuestUpdateEvent(giftMapping.giftCategory);
         if(Config.isMobile)
         {
            ActorAmfService.PickupGuidePresent(this.actorDetails.actorId,giftMapping.giftCategory,giftMapping.giftId,mobileMethodCallback);
         }
         else
         {
            ActorAmfServiceForWeb.PickupGuidePresent(this.actorDetails.actorId,giftMapping.giftCategory,giftMapping.giftId,webMethodCallback);
         }
      }
      
      private function sendQuestUpdateEvent(param1:int) : void
      {
         switch(param1)
         {
            case GiftHuntData.TYPE_QUEST_DAILY_BLUE:
               MessageCommunicator.send(new MsgEvent(CareerQuestEvent.OBJECTIVE_PROGRESS,{
                  "progress":1,
                  "name":CareerQuestsGoToDestinations.FIND_DAILY_PRESENTS
               }));
               break;
            case GiftHuntData.SPECIAL_EVENT_QUEST_1:
               MessageCommunicator.send(new QuestEvent(QuestEvent.SPECIAL_QUEST_UPDATE,{
                  "action":QuestEvent.ACTION_SPECIAL_GIFT_HUNT_1,
                  "increment":1
               }));
               break;
            case GiftHuntData.SPECIAL_EVENT_QUEST_2:
               MessageCommunicator.send(new QuestEvent(QuestEvent.SPECIAL_QUEST_UPDATE,{
                  "action":QuestEvent.ACTION_SPECIAL_GIFT_HUNT_2,
                  "increment":1
               }));
               break;
            case GiftHuntData.SPECIAL_EVENT_QUEST_3:
               MessageCommunicator.send(new QuestEvent(QuestEvent.SPECIAL_QUEST_UPDATE,{
                  "action":QuestEvent.ACTION_SPECIAL_GIFT_HUNT_3,
                  "increment":1
               }));
               break;
            default:
               MessageCommunicator.send(new MsgEvent(CareerQuestEvent.OBJECTIVE_PROGRESS,{
                  "progress":1,
                  "name":CareerQuestsGoToDestinations.FIND_PRESENTS
               }));
         }
      }
      
      public function placeGiftFlash(param1:flash.display.DisplayObjectContainer, param2:GiftHuntMapping) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:GiftHuntGiftFlash = new GiftHuntGiftFlash(param2);
         param1.addChild(_loc3_);
         _loc3_.addEventListener(GiftHuntEventFlash.GIFT_PICKED_UP,this.giftPickedUpFlash);
         _loc3_.addEventListener(flash.events.Event.REMOVED_FROM_STAGE,this.giftRemovedFromStageFlash);
         this.onScreenGifts.push(_loc3_);
      }
      
      private function giftPickedUpFlash(param1:GiftHuntEventFlash) : void
      {
         var _loc2_:GiftHuntGiftFlash = param1.data as GiftHuntGiftFlash;
         _loc2_.removeEventListener(GiftHuntEventFlash.GIFT_PICKED_UP,this.giftPickedUpFlash);
         if(_loc2_.parent != null)
         {
            _loc2_.parent.removeChild(_loc2_);
         }
      }
      
      private function giftRemovedFromStageFlash(param1:flash.events.Event) : void
      {
         var _loc2_:GiftHuntGiftFlash = param1.target as GiftHuntGiftFlash;
         _loc2_.removeEventListener(flash.events.Event.REMOVED_FROM_STAGE,this.giftRemovedFromStageFlash);
         this.onScreenGifts.splice(this.onScreenGifts.indexOf(_loc2_),1);
         _loc2_.destroy();
      }
      
      public function placeGiftStarling(param1:starling.display.DisplayObjectContainer, param2:GiftHuntMapping) : void
      {
         var _loc3_:GiftHuntGiftStarling = new GiftHuntGiftStarling(param2);
         param1.addChild(_loc3_);
         _loc3_.addEventListener(GiftHuntEventStarling.GIFT_PICKED_UP,this.giftPickedUpStarling);
         _loc3_.addEventListener(starling.events.Event.REMOVED_FROM_STAGE,this.giftRemovedFromStageStarling);
         this.onScreenGifts.push(_loc3_);
      }
      
      private function giftPickedUpStarling(param1:GiftHuntEventStarling) : void
      {
         var _loc2_:GiftHuntGiftStarling = param1.data as GiftHuntGiftStarling;
         _loc2_.removeEventListener(GiftHuntEventStarling.GIFT_PICKED_UP,this.giftPickedUpStarling);
         if(_loc2_.parent != null)
         {
            _loc2_.parent.removeChild(_loc2_);
         }
      }
      
      private function giftRemovedFromStageStarling(param1:starling.events.Event) : void
      {
         var _loc2_:GiftHuntGiftStarling = param1.target as GiftHuntGiftStarling;
         _loc2_.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE,this.giftRemovedFromStageStarling);
         this.onScreenGifts.splice(this.onScreenGifts.indexOf(_loc2_),1);
         _loc2_.destroy();
      }
      
      public function removeGiftsOfCategory(param1:int) : void
      {
         var _loc2_:GiftHuntGiftFlash = null;
         var _loc3_:GiftHuntGiftStarling = null;
         var _loc4_:* = int(this.onScreenGifts.length - 1);
         while(_loc4_ >= 0)
         {
            if(this.onScreenGifts[_loc4_] is GiftHuntGiftFlash)
            {
               _loc2_ = this.onScreenGifts[_loc4_] as GiftHuntGiftFlash;
               if(_loc2_.getMappingData().giftCategory == param1)
               {
                  _loc2_.removeEventListener(GiftHuntEventFlash.GIFT_PICKED_UP,this.giftPickedUpFlash);
                  if(_loc2_.parent != null)
                  {
                     _loc2_.parent.removeChild(_loc2_);
                  }
               }
            }
            else if(this.onScreenGifts[_loc4_] is GiftHuntGiftStarling)
            {
               _loc3_ = this.onScreenGifts[_loc4_] as GiftHuntGiftStarling;
               if(_loc3_.getMappingData().giftCategory == param1)
               {
                  _loc3_.removeEventListener(GiftHuntEventFlash.GIFT_PICKED_UP,this.giftPickedUpStarling);
                  if(_loc3_.parent != null)
                  {
                     _loc3_.parent.removeChild(_loc3_);
                  }
               }
            }
            _loc4_--;
         }
         this.giftHuntLookup[param1] = null;
         MessageCommunicator.send(new MsgEvent(GiftHuntEventFlash.GIFT_DATA_UPDATED));
      }
      
      private function get actorDetails() : IActorDetails
      {
         if(this._injectedActorDetails == null)
         {
            this._injectedActorDetails = InjectionManager.manager().getInstance(IActorDetails);
         }
         return this._injectedActorDetails;
      }
   }
}

