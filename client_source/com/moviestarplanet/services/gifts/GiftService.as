package com.moviestarplanet.services.gifts
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.amf.PagerResultObject;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.media.valueobjects.ActorAnimationRel;
   import com.moviestarplanet.media.valueobjects.ActorBackgroundRel;
   import com.moviestarplanet.media.valueobjects.Animation;
   import com.moviestarplanet.media.valueobjects.Background;
   import com.moviestarplanet.media.valueobjects.GiftPurchaseType;
   import com.moviestarplanet.media.valueobjects.VipCertificate;
   import com.moviestarplanet.model.contentJoiner.ContentActorInfo;
   import com.moviestarplanet.moviestar.valueObjects.Actor;
   import com.moviestarplanet.moviestar.valueObjects.ActorClothesRel;
   import com.moviestarplanet.moviestar.valueObjects.Cloth;
   import com.moviestarplanet.moviestar.valueObjects.ClothesCategory;
   import com.moviestarplanet.services.gifts.valueObjects.AMFGift;
   import com.moviestarplanet.services.gifts.valueObjects.AMFTradeLogLinkedItem;
   import com.moviestarplanet.services.gifts.valueObjects.AMFUnifiedGiftLog;
   import com.moviestarplanet.services.gifts.valueObjects.AMFWishlistItem;
   import com.moviestarplanet.services.gifts.valueObjects.GenericGiftLogItem;
   import com.moviestarplanet.services.gifts.valueObjects.Gift;
   import com.moviestarplanet.services.gifts.valueObjects.GiftActorName;
   import com.moviestarplanet.services.gifts.valueObjects.GiftLog;
   import com.moviestarplanet.services.gifts.valueObjects.GiftLogItem;
   import com.moviestarplanet.services.gifts.valueObjects.GiftSwfAndName;
   import com.moviestarplanet.services.gifts.valueObjects.WishlistItem;
   import flash.net.registerClassAlias;
   
   public class GiftService
   {
      
      public static const GIVE_GIFT_RETURN_CODE_OKAY:int = 0;
      
      public static const GIVE_GIFT_RETURN_CODE_ERROR:int = -1;
      
      public static const GIVE_GIFT_RETURN_CODE_NON_VIP_LEVEL_6:int = -10;
      
      public static const GIVE_GIFT_RETURN_CODE_DAILY_LIMIT_REACHED:int = -20;
      
      public static const GIVE_GIFT_RETURN_CODE_HAS_ITEM_ALREADY:int = -30;
      
      private static var amfCaller:AmfCaller = new AmfCaller("MovieStarPlanet.WebService.Gifts.AMFGiftsService+Version2");
      
      private var giveGiftCallback:Function;
      
      public function GiftService()
      {
         super();
      }
      
      public function registerClassAliases() : void
      {
         registerClassAlias("MovieStarPlanet.Model.Actor.ValueObjects.ActorItem",ContentActorInfo);
         registerClassAlias("MovieStarPlanet.Model.Gifts.AMFModels.Gifts.AMFGiftPurchaseType",GiftPurchaseType);
         registerClassAlias("MovieStarPlanet.Model.Gifts.AMFModels.Gifts.AMFGiftableMembership",VipCertificate);
         registerClassAlias("MovieStarPlanet.Model.Gifts.AMFModels.AMFActorClothesRel",ActorClothesRel);
         registerClassAlias("MovieStarPlanet.Model.Gifts.AMFModels.AMFActorBackgroundRel",ActorBackgroundRel);
         registerClassAlias("MovieStarPlanet.Model.Gifts.AMFModels.AMFActorAnimationRel",ActorAnimationRel);
         registerClassAlias("MovieStarPlanet.Model.Gifts.AMFModels.AMFCloth",Cloth);
         registerClassAlias("MovieStarPlanet.Model.Gifts.AMFModels.AMFActor",Actor);
         registerClassAlias("MovieStarPlanet.Model.Gifts.AMFModels.AMFAnimation",Animation);
         registerClassAlias("MovieStarPlanet.Model.Gifts.AMFModels.AMFBackground",Background);
         registerClassAlias("MovieStarPlanet.Model.Gifts.AMFModels.Gifts.AMFGift",AMFGift);
         registerClassAlias("MovieStarPlanet.Model.Gifts.AMFModels.Gifts.AMFUnifiedGiftLog",AMFUnifiedGiftLog);
         registerClassAlias("MovieStarPlanet.WebService.Gifts.Gift",Gift);
         registerClassAlias("MovieStarPlanet.WebService.Gifts.GiftActorName",GiftActorName);
         registerClassAlias("MovieStarPlanet.WebService.Gifts.GiftLogItem",GiftLogItem);
         registerClassAlias("MovieStarPlanet.WebService.Gifts.GiftSwfAndName",GiftSwfAndName);
         registerClassAlias("MovieStarPlanet.WebService.Gifts.WishlistItem",WishlistItem);
         registerClassAlias("MovieStarPlanet.Model.Gifts.AMFModels.Gifts.AMFWishlistItem",AMFWishlistItem);
         registerClassAlias("MovieStarPlanet.WebService.Gifts.GiftLog",GiftLog);
         registerClassAlias("MovieStarPlanet.Model.Gifts.AMFModels.Gifts.AMFGenericGiftLogItem",GenericGiftLogItem);
         registerClassAlias("MovieStarPlanet.Model.Gifts.AMFModels.Gifts.AMFTradeLogLinkedItem",AMFTradeLogLinkedItem);
         registerClassAlias("MovieStarPlanet.Model.Gifts.AMFModels.AMFClothesCategory",ClothesCategory);
      }
      
      public function returnGift(param1:Number, param2:Number, param3:Function = null) : void
      {
         var webMethodDone:Function = null;
         var giftId:Number = param1;
         var giftLogId:Number = param2;
         var doneCallback:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            if(doneCallback != null)
            {
               doneCallback();
            }
         };
         amfCaller.callFunction("returnGift",[giftLogId,giftId],true,webMethodDone);
      }
      
      public function returnMassGifts(param1:int, param2:Array, param3:Boolean, param4:Function = null) : void
      {
         var webMethodDone:Function = null;
         var singleActorId:int = param1;
         var multipleActorIds:Array = param2;
         var received:Boolean = param3;
         var doneCallback:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            if(doneCallback != null)
            {
               doneCallback(param1 as int);
            }
         };
         amfCaller.callFunction("ReturnMassGifts",[singleActorId,multipleActorIds,received],true,webMethodDone);
      }
      
      public function refundGift(param1:Number, param2:Number, param3:Function = null) : void
      {
         var webMethodDone:Function = null;
         var giftId:Number = param1;
         var giftLogId:Number = param2;
         var doneCallback:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            if(doneCallback != null)
            {
               doneCallback();
            }
         };
         amfCaller.callFunction("refundGift",[giftLogId,giftId],true,webMethodDone);
      }
      
      public function openGift(param1:Number, param2:Number, param3:Function = null) : void
      {
         var webMethodDone:Function = null;
         var receiverId:Number = param1;
         var giftId:Number = param2;
         var doneCallback:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            if(doneCallback != null)
            {
               doneCallback(param1 as AMFUnifiedGiftLog);
            }
         };
         amfCaller.callFunction("OpenGift",[receiverId,giftId],true,webMethodDone);
      }
      
      public function removeFromWishlist(param1:Number, param2:Number, param3:Function = null) : void
      {
         var webMethodDone:Function = null;
         var actorId:Number = param1;
         var giftId:Number = param2;
         var doneCallback:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            if(doneCallback != null)
            {
               doneCallback();
            }
         };
         amfCaller.callFunction("removeFromWishlist",[actorId,giftId],true,webMethodDone);
      }
      
      public function giveGift(param1:Number, param2:Number, param3:Number, param4:int, param5:Number = 0, param6:String = "", param7:Function = null) : void
      {
         this.giveGiftCallback = param7;
         GiftsAmfService.giveGift(param1,param2,param3,param4,param5,param6,this.onGiveGiftDone);
      }
      
      private function onGiveGiftDone(param1:Object) : void
      {
         if(this.giveGiftCallback != null)
         {
            this.giveGiftCallback(param1.Code);
         }
      }
      
      public function buyGift(param1:Number, param2:Number, param3:Number, param4:String, param5:Function = null) : void
      {
         var webMethodDone:Function = null;
         var senderId:Number = param1;
         var receiverId:Number = param2;
         var giftId:Number = param3;
         var SWF:String = param4;
         var doneCallback:Function = param5;
         webMethodDone = function(param1:Object):void
         {
            if(doneCallback != null)
            {
               doneCallback(param1.Code,param1.Description);
            }
         };
         amfCaller.callFunction("BuyGift",[senderId,receiverId,giftId,SWF],true,webMethodDone);
      }
      
      public function addToWishlist(param1:int, param2:Array, param3:Function = null) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var clothes:Array = param2;
         var doneCallback:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            if(doneCallback != null)
            {
               doneCallback(param1 as int);
            }
         };
         var clothIds:Array = new Array();
         var clothColors:Array = new Array();
         var i:int = 0;
         while(i < clothes.length)
         {
            clothIds.push(clothes[i].ClothesId);
            clothColors.push(clothes[i].Color);
            i++;
         }
         amfCaller.callFunction("AddItemToWishlist",[clothIds,clothColors],true,webMethodDone);
      }
      
      public function getWishlist(param1:Number, param2:int, param3:int, param4:Function) : void
      {
         var webMethodDone:Function = null;
         var actorId:Number = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var doneCallback:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:Object = param1 as Object;
            var _loc3_:Boolean = _loc2_.Items.length == pageSize;
            var _loc4_:PagerResultObject = new PagerResultObject(_loc2_.totalRecords,_loc3_,_loc2_.Items,pageIndex);
            if(doneCallback != null)
            {
               doneCallback(_loc4_);
            }
         };
         amfCaller.callFunction("getWishlist",[actorId,pageIndex,pageSize],true,webMethodDone);
      }
      
      public function getGiftList(param1:Number, param2:Function) : void
      {
         var webMethodDone:Function = null;
         var actorId:Number = param1;
         var doneCallback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            if(doneCallback != null)
            {
               doneCallback(param1);
            }
         };
         amfCaller.callFunction("getGiftList",[actorId],true,webMethodDone);
      }
      
      public function getGiftsReceived(param1:Number, param2:int, param3:int, param4:Function) : void
      {
         var webMethodDone:Function = null;
         var actorId:Number = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var doneCallback:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:Object = param1 as Object;
            var _loc3_:Boolean = _loc2_.Items.length == pageSize;
            var _loc4_:PagerResultObject = new PagerResultObject(_loc2_.totalRecords,_loc3_,_loc2_.Items,pageIndex);
            if(doneCallback != null)
            {
               doneCallback(_loc4_);
            }
         };
         amfCaller.callFunction("getGiftsReceived",[actorId,pageIndex,pageSize],true,webMethodDone);
      }
      
      public function getGiftsGiven(param1:Number, param2:int, param3:int, param4:Function) : void
      {
         var webMethodDone:Function = null;
         var actorId:Number = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var doneCallback:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:Object = param1 as Object;
            var _loc3_:Boolean = _loc2_.Items.length == pageSize;
            var _loc4_:PagerResultObject = new PagerResultObject(_loc2_.totalRecords,_loc3_,_loc2_.Items,pageIndex);
            if(doneCallback != null)
            {
               doneCallback(_loc4_);
            }
         };
         amfCaller.callFunction("getGiftsGiven",[actorId,pageIndex,pageSize],true,webMethodDone);
      }
      
      public function GetAllGiftLogListPaged(param1:Array, param2:Number, param3:Number, param4:Function = null) : void
      {
         var webMethodDone:Function = null;
         var params:Array = param1;
         var pageindex:Number = param2;
         var pagesize:Number = param3;
         var doneCallback:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:Object = param1 as Object;
            var _loc3_:Boolean = _loc2_.Items.length == pagesize;
            var _loc4_:PagerResultObject = new PagerResultObject(_loc2_.totalRecords,_loc3_,_loc2_.Items,pageindex);
            if(doneCallback != null)
            {
               doneCallback(_loc4_);
            }
         };
         var actorId:Number = Number(params[0]);
         var type:Number = Number(params[1]);
         var direction:Number = Number(params[2]);
         amfCaller.callFunction("GetAllGiftLogListPaged",[actorId,type,direction,pageindex,pagesize],true,webMethodDone);
      }
      
      public function GetAllGiftList(param1:Number, param2:Number, param3:Number, param4:Number, param5:Function) : void
      {
         var webMethodDone:Function = null;
         var actorId:Number = param1;
         var type:Number = param2;
         var state:Number = param3;
         var direction:Number = param4;
         var doneCallback:Function = param5;
         webMethodDone = function(param1:Object):void
         {
            if(doneCallback != null)
            {
               doneCallback(param1);
            }
         };
         amfCaller.callFunction("GetAllGiftList",[actorId,type,state,direction],true,webMethodDone);
      }
      
      public function GetGiftLog(param1:Number, param2:Function = null) : void
      {
         var webMethodDone:Function = null;
         var giftLogId:Number = param1;
         var doneCallback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            if(doneCallback != null)
            {
               doneCallback(param1);
            }
         };
         amfCaller.callFunction("GetGiftLog",[giftLogId],true,webMethodDone);
      }
      
      public function GetGift(param1:Number, param2:Function = null) : void
      {
         var webMethodDone:Function = null;
         var giftId:Number = param1;
         var doneCallback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            if(doneCallback != null)
            {
               doneCallback(param1);
            }
         };
         amfCaller.callFunction("GetGift",[giftId],true,webMethodDone);
      }
      
      public function GiveTradeGift(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Function = null) : void
      {
         var webMethodDone:Function = null;
         var senderId:Number = param1;
         var receiverId:Number = param2;
         var senderRelId:Number = param3;
         var senderRelCategory:Number = param4;
         var receiverRelId:Number = param5;
         var receiverRelCategory:Number = param6;
         var doneCallback:Function = param7;
         webMethodDone = function(param1:Object):void
         {
            if(doneCallback != null)
            {
               doneCallback(param1);
            }
         };
         MessageCommunicator.send(new MsgEvent(MSPEvent.GIFT_GIVEN));
         amfCaller.callFunction("GiveTradeGift",[senderId,receiverId,senderRelId,senderRelCategory,receiverRelId,receiverRelCategory],true,webMethodDone);
      }
      
      public function CancelTrade(param1:int, param2:int, param3:Function = null) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var giftId:int = param2;
         var done:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            if(null != done)
            {
               done();
            }
         };
         amfCaller.callFunction("CancelTrade",[actorId,giftId],true,webMethodDone);
      }
      
      public function TradeItem(param1:int, param2:int, param3:int, param4:int, param5:Function = null) : void
      {
         var webMethodDone:Function = null;
         var firstActorId:int = param1;
         var secondActorId:int = param2;
         var firstGiftId:int = param3;
         var secondGiftId:int = param4;
         var done:Function = param5;
         webMethodDone = function(param1:Object):void
         {
            if(null != done)
            {
               done(param1);
            }
         };
         amfCaller.callFunction("TradeItem",[firstActorId,secondActorId,firstGiftId,secondGiftId],true,webMethodDone);
      }
      
      public function RevertTrade(param1:int, param2:Function = null) : void
      {
         var webMethodDone:Function = null;
         var giftLogId:int = param1;
         var callback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            if(callback != null)
            {
               callback(param1);
            }
         };
         amfCaller.callFunction("RevertTrade",[giftLogId],true,webMethodDone);
      }
      
      public function setMarketingStep(param1:int, param2:int, param3:int) : void
      {
         amfCaller.callFunction("SetMarketingStep",[param1,param2,param3],true,null);
      }
      
      public function handleGift(param1:Function) : void
      {
         var webMethodDone:Function = null;
         var resultCallBack:Function = param1;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:int = 0;
            if(resultCallBack != null)
            {
               _loc2_ = int(int(param1));
               resultCallBack(_loc2_);
            }
         };
         amfCaller.callFunction("HandleGift",[],true,webMethodDone);
      }
      
      public function UpdateRetention(param1:int, param2:Function = null) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var doneCallback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            if(doneCallback != null)
            {
               doneCallback();
            }
         };
         amfCaller.callFunction("UpdateRetention",[actorId],true,webMethodDone);
      }
      
      public function UpdateGift(param1:int, param2:Function = null) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var doneCallback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:GiftSwfAndName = null;
            if(doneCallback != null)
            {
               _loc2_ = GiftSwfAndName(param1);
               doneCallback(_loc2_);
            }
         };
         amfCaller.callFunction("UpdateGift",[actorId],true,webMethodDone);
      }
      
      public function GetMarketingStepGift(param1:int, param2:Function = null) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var doneCallback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:GiftSwfAndName = null;
            if(doneCallback != null)
            {
               _loc2_ = GiftSwfAndName(param1);
               doneCallback(_loc2_);
            }
         };
         amfCaller.callFunction("GetMarketingStepGift",[actorId],true,webMethodDone);
      }
      
      public function AwardStartupReward(param1:int, param2:Function = null) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var callback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            if(callback != null)
            {
               callback(GiftSwfAndName(param1));
            }
         };
         amfCaller.callFunction("AwardStartupReward",[actorId],true,webMethodDone);
      }
      
      public function GetIsInUseInRoom(param1:int, param2:Function = null) : void
      {
         var webMethodDone:Function = null;
         var actorClothesRelId:int = param1;
         var onResponse:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            if(onResponse != null)
            {
               onResponse(param1 as Boolean);
            }
         };
         amfCaller.callFunction("IsInUseInRooms",[actorClothesRelId],true,webMethodDone,null);
      }
   }
}

