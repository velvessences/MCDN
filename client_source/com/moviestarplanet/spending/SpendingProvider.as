package com.moviestarplanet.spending
{
   import com.moviestarplanet.amf.PagerResultObject;
   import com.moviestarplanet.amf.valueobjects.ServiceResultData;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   import com.moviestarplanet.media.valueobjects.Animation;
   import com.moviestarplanet.media.valueobjects.Background;
   import com.moviestarplanet.media.valueobjects.Music;
   import com.moviestarplanet.msg.events.CareerQuestEvent;
   import com.moviestarplanet.msg.events.CareerQuestsGoToDestinations;
   import com.moviestarplanet.services.spendingservice.ISpendingService;
   import com.moviestarplanet.services.spendingservice.SpendingAmfService;
   import com.moviestarplanet.services.spendingservice.valueObjects.ActiveSpecialsResultType;
   import com.moviestarplanet.services.spendingservice.valueObjects.BuyCharacterPopUpResultType;
   import com.moviestarplanet.services.spendingservice.valueObjects.BuyDiamondCharacterEffectResultType;
   import com.moviestarplanet.services.spendingservice.valueObjects.BuyFameBoosterResultType;
   import com.moviestarplanet.services.spendingservice.valueObjects.BuyShoppingSpreeResultType;
   import com.moviestarplanet.services.spendingservice.valueObjects.ServiceResultDataOfActorDetails;
   import com.moviestarplanet.services.spendingservice.valueObjects.ServiceResultDataOfBuyStarcoinsWheelSpinResultType;
   import com.moviestarplanet.services.spendingservice.valueObjects.SpecialsItem;
   import flash.utils.ByteArray;
   
   public class SpendingProvider
   {
      
      public static const RESULT_CODE_SUCCESS:int = 0;
      
      public static const RESULT_CODE_EXCEPTION:int = -1;
      
      public static const RESULT_CODE_NOT_ENOUGH_DIAMONDS:int = -2;
      
      public static const RESULT_CODE_ALREADY_BOUGHT_TODAY:int = -3;
      
      public static var spendingService:ISpendingService = SpendingAmfService.Instance;
      
      public function SpendingProvider()
      {
         super();
      }
      
      public static function getPagedShopSpecials(param1:int, param2:int, param3:int, param4:Function) : void
      {
         var diamondShopCache:Object = null;
         var cacheKey:String = null;
         var doneCallback:Function = null;
         var actorId:int = param1;
         var pageindex:int = param2;
         var pagesize:int = param3;
         var resultCallback:Function = param4;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:Boolean = param1.items.length == pagesize;
            var _loc3_:Array = new Array();
            var _loc4_:int = 0;
            while(_loc4_ < param1.items.length)
            {
               _loc3_[_loc4_] = new SpecialsItem(param1.items[_loc4_]);
               _loc4_++;
            }
            var _loc5_:PagerResultObject = new PagerResultObject(param1.totalRecords,_loc2_,_loc3_,pageindex);
            diamondShopCache[cacheKey] = param1;
            resultCallback(_loc5_);
         };
         diamondShopCache = ShopContentProvider.getDiamondShopCache();
         cacheKey = "DIAMOND_SHOP_SPECIALS" + actorId + "_" + pageindex;
         if(diamondShopCache[cacheKey] != null)
         {
            doneCallback(SerializeUtils.clone(diamondShopCache[cacheKey]));
            return;
         }
         spendingService.getPagedShopSpecials(actorId,pageindex,pagesize,doneCallback);
      }
      
      public static function getGreetingIndices(param1:int, param2:Function) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var resultCallback:Function = param2;
         doneCallback = function(param1:Array):void
         {
            var _loc2_:Array = new Array();
            var _loc3_:int = 0;
            while(_loc3_ < param1.length)
            {
               _loc2_[_loc3_] = param1[_loc3_] as int;
               _loc3_++;
            }
            resultCallback(_loc2_);
         };
         spendingService.getGreetingIndices(actorId,doneCallback);
      }
      
      public static function getSpecialsGreetingItems(param1:int, param2:int, param3:Function) : void
      {
         spendingService.getSpecialsGreetingItems(param1,param2,param3);
      }
      
      public static function buyStarcoinsWheelSpin(param1:int, param2:Function = null) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var resultCallback:Function = param2;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(new ServiceResultDataOfBuyStarcoinsWheelSpinResultType(param1));
            }
         };
         spendingService.buyStarcoinsWheelSpin(actorId,doneCallback);
      }
      
      public static function buyShoppingSpree(param1:int, param2:Function = null) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var resultCallback:Function = param2;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(new BuyShoppingSpreeResultType(param1));
            }
         };
         spendingService.buyShoppingSpree(actorId,doneCallback);
      }
      
      public static function buyDiamondCharacterEffect(param1:int, param2:Function = null) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var resultCallback:Function = param2;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(new BuyDiamondCharacterEffectResultType(param1));
            }
         };
         spendingService.buyDiamondCharacterEffect(actorId,doneCallback);
      }
      
      public static function buyCharacterPopUp(param1:int, param2:Function = null) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var resultCallback:Function = param2;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(new BuyCharacterPopUpResultType(param1));
            }
         };
         spendingService.buyCharacterPopUp(actorId,doneCallback);
      }
      
      public static function buyFameWheelSpin(param1:int, param2:Function = null) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var resultCallback:Function = param2;
         doneCallback = function(param1:ServiceResultData):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1);
            }
         };
         spendingService.buyFameWheelSpin(actorId,doneCallback);
      }
      
      public static function getActiveSpecialsItems(param1:int, param2:Function = null) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var resultCallback:Function = param2;
         doneCallback = function(param1:Array):void
         {
            var _loc2_:Array = null;
            var _loc3_:Object = null;
            if(resultCallback != null)
            {
               _loc2_ = new Array();
               for each(_loc3_ in param1)
               {
                  _loc2_.push(new ActiveSpecialsResultType(_loc3_));
               }
               resultCallback(_loc2_);
            }
         };
         spendingService.getActiveSpecialsItems(actorId,doneCallback);
      }
      
      public static function getSpecialsItemPrice(param1:int, param2:String, param3:Function = null) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var internalName:String = param2;
         var resultCallback:Function = param3;
         doneCallback = function(param1:int):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1);
            }
         };
         spendingService.getSpecialsItemPrice(actorId,internalName,doneCallback);
      }
      
      public static function BuyBackground(param1:int, param2:Background, param3:Function) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var background:Background = param2;
         var done:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:ServiceResultDataOfActorDetails = new ServiceResultDataOfActorDetails(param1);
            done(_loc2_.code,_loc2_.description,_loc2_.data,_loc2_.fameAwarded);
         };
         spendingService.buyBackground(actorId,background != null ? background.BackgroundId : -1,webMethodDone);
      }
      
      public static function BuyMusic(param1:int, param2:Music, param3:Function) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var music:Music = param2;
         var done:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:ServiceResultDataOfActorDetails = new ServiceResultDataOfActorDetails(param1);
            done(_loc2_.code,_loc2_.description,_loc2_.data,_loc2_.fameAwarded);
         };
         spendingService.buyMusic(actorId,music != null ? music.MusicId : -1,webMethodDone);
      }
      
      public static function BuyAnimationById(param1:int, param2:int, param3:Function) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var animationId:int = param2;
         var done:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:ServiceResultDataOfActorDetails = new ServiceResultDataOfActorDetails(param1);
            done(_loc2_.code,_loc2_.description,_loc2_.data,_loc2_.fameAwarded);
         };
         spendingService.buyAnimation(actorId,animationId,webMethodDone);
      }
      
      public static function BuyAnimation(param1:int, param2:Animation, param3:Function) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var animation:Animation = param2;
         var done:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:ServiceResultDataOfActorDetails = new ServiceResultDataOfActorDetails(param1);
            done(_loc2_.code,_loc2_.description,_loc2_.data,_loc2_.fameAwarded);
         };
         spendingService.buyAnimation(actorId,animation != null ? animation.AnimationId : -1,webMethodDone);
      }
      
      public static function buyFameBooster(param1:int, param2:Function = null) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var resultCallback:Function = param2;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(new BuyFameBoosterResultType(param1));
            }
         };
         spendingService.buyFameBooster(actorId,doneCallback);
      }
      
      public static function buyDiamondTwit(param1:int, param2:Function = null) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var resultCallback:Function = param2;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1.Code);
            }
         };
         spendingService.buyDiamondTwit(actorId,doneCallback);
      }
      
      public static function buyInstantPetGrow(param1:int, param2:int, param3:Function = null) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var actorClickItemId:int = param2;
         var resultCallback:Function = param3;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1);
            }
         };
         spendingService.buyInstantPetGrow(actorId,actorClickItemId,doneCallback);
      }
      
      public static function buyChangePet(param1:int, param2:int, param3:ByteArray, param4:int, param5:Function = null) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var actorClickItemId:int = param2;
         var configuration:ByteArray = param3;
         var clickItemId:int = param4;
         var resultCallback:Function = param5;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1);
            }
         };
         spendingService.buyChangePet(actorId,actorClickItemId,configuration,clickItemId,doneCallback);
      }
      
      public static function buySpecialGreeting(param1:int, param2:int, param3:int, param4:Function = null) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var friendId:int = param2;
         var greetingTypeId:int = param3;
         var resultCallback:Function = param4;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1);
            }
         };
         spendingService.buySpecialGreeting(actorId,friendId,greetingTypeId,doneCallback);
      }
      
      public static function buyStarcoinShooter(param1:int, param2:Function = null) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var resultCallback:Function = param2;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1);
            }
         };
         spendingService.buyStarcoinShooter(actorId,doneCallback);
      }
      
      public static function buyClothes(param1:int, param2:Array, param3:int, param4:Function = null) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var items:Array = param2;
         var lookId:int = param3;
         var resultCallback:Function = param4;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null && param1 != null)
            {
               if(param1.Data == null)
               {
                  resultCallback(param1.Code,param1.Description,null,null,0);
               }
               else
               {
                  MessageCommunicator.send(new MsgEvent(CareerQuestEvent.OBJECTIVE_PROGRESS,{
                     "progress":param1.Data.items.length,
                     "name":CareerQuestsGoToDestinations.BUY_CLOTHES
                  }));
                  MessageCommunicator.send(new MsgEvent(CareerQuestEvent.OBJECTIVE_PROGRESS,{
                     "progress":param1.Data.items.length,
                     "name":CareerQuestsGoToDestinations.BUY_TOP_CLOTHES
                  }));
                  resultCallback(param1.Code,param1.Description,param1.Data.actorDetails,param1.Data.items,param1.Data.awardedFame);
               }
            }
         };
         spendingService.buyClothes(actorId,items,lookId,doneCallback);
      }
      
      public static function GetSpecialsItems(param1:Function, param2:Function = null) : void
      {
         spendingService.GetSpecialsItems(param1,param2);
      }
   }
}

