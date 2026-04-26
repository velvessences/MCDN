package com.moviestarplanet.services.gifts
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.amf.PagerResultObject;
   import com.moviestarplanet.media.MediaListUtils;
   
   public class GiftsAmfService
   {
      
      private static var amfCaller:AmfCaller = new AmfCaller("MovieStarPlanet.WebService.Gifts.AMFGiftsService+Version2");
      
      public function GiftsAmfService()
      {
         super();
      }
      
      public static function giveGift(param1:int, param2:int, param3:int, param4:int, param5:int, param6:String, param7:Function) : void
      {
         var done:Function = null;
         var senderActorId:int = param1;
         var receiverActorId:int = param2;
         var relId:int = param3;
         var contentCategory:int = param4;
         var giftId:int = param5;
         var swf:String = param6;
         var resultCallBack:Function = param7;
         done = function(param1:Object):void
         {
            if(resultCallBack != null)
            {
               resultCallBack(param1);
            }
         };
         amfCaller.callFunction("GiveGiftOfCategory",[senderActorId,receiverActorId,relId,giftId,contentCategory,swf],true,done);
      }
      
      public static function getGiftLog(param1:int, param2:Function) : void
      {
         amfCaller.callFunction("GetGiftLog",[param1],true,param2);
      }
      
      public static function getGiftsNewPaged(param1:Array, param2:int, param3:int, param4:Function) : void
      {
         var servicecallback:Function = null;
         var parameters:Array = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var callback:Function = param4;
         servicecallback = function(param1:Object):void
         {
            var _loc2_:PagerResultObject = new PagerResultObject(param1.TotalRecords,param1.Items.length >= param1.PageSize,param1.Items,param1.PageIndex);
            callback(_loc2_);
         };
         var actorId:int = int(parameters[0]);
         amfCaller.callFunction("GetGiftsNewPaged",[actorId,pageIndex,pageSize],true,servicecallback);
      }
      
      public static function getWishListPaged(param1:Array, param2:int, param3:int, param4:Function) : void
      {
         var servicecallback:Function = null;
         var parameters:Array = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var callback:Function = param4;
         servicecallback = function(param1:Object):void
         {
            var _loc2_:PagerResultObject = new PagerResultObject(param1.TotalRecords,param1.Items.length >= param1.PageSize,param1.Items,param1.PageIndex);
            callback(_loc2_);
         };
         var actorId:int = int(parameters[0]);
         amfCaller.callFunction("GetWishListPaged",[actorId,pageIndex,pageSize],true,servicecallback);
      }
      
      public static function getGiftsReceivedPaged(param1:Array, param2:int, param3:int, param4:Function) : void
      {
         var servicecallback:Function = null;
         var parameters:Array = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var callback:Function = param4;
         servicecallback = function(param1:Object):void
         {
            var _loc2_:PagerResultObject = new PagerResultObject(param1.TotalRecords,param1.Items.length >= param1.PageSize,param1.Items,param1.PageIndex);
            callback(_loc2_);
         };
         var actorId:int = int(parameters[0]);
         amfCaller.callFunction("GetGiftsReceivedPaged",[actorId,pageIndex,pageSize],true,servicecallback);
      }
      
      public static function getGiftsGivenPaged(param1:Array, param2:int, param3:int, param4:Function) : void
      {
         var servicecallback:Function = null;
         var parameters:Array = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var callback:Function = param4;
         servicecallback = function(param1:Object):void
         {
            var _loc2_:PagerResultObject = new PagerResultObject(param1.TotalRecords,param1.Items.length >= param1.PageSize,param1.Items,param1.PageIndex);
            callback(_loc2_);
         };
         var actorId:int = int(parameters[0]);
         amfCaller.callFunction("GetGiftsGivenPaged",[actorId,pageIndex,pageSize],true,servicecallback);
      }
      
      public static function GetBackgrounds(param1:int, param2:Function, param3:Boolean = true) : void
      {
         MediaListUtils.getBackgrounds(param1,param2,param3);
      }
      
      public static function GetAnimations(param1:int, param2:Function, param3:Boolean = true) : void
      {
         MediaListUtils.getAnimations(param1,param2,param3);
      }
      
      public static function GetVipCertificates(param1:Function) : void
      {
         MediaListUtils.getVipCertificates(param1);
      }
      
      public function getAllGiftsReceived(param1:Number, param2:int, param3:int, param4:Function) : void
      {
         var webMethodDone:Function = null;
         var actorId:Number = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var doneCallback:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:Object = param1 as Object;
            var _loc3_:Boolean = _loc2_.items.length == pageSize;
            var _loc4_:PagerResultObject = new PagerResultObject(_loc2_.totalRecords,_loc3_,_loc2_.items,pageIndex);
            if(doneCallback != null)
            {
               doneCallback(_loc4_);
            }
         };
         amfCaller.callFunction("GetAllGiftsReceived",[actorId,pageIndex,pageSize],true,webMethodDone);
      }
      
      public function getAllGiftsGiven(param1:Number, param2:int, param3:int, param4:Function) : void
      {
         var webMethodDone:Function = null;
         var actorId:Number = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var doneCallback:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:Object = null;
            var _loc3_:Boolean = false;
            var _loc4_:PagerResultObject = null;
            if(doneCallback != null)
            {
               _loc2_ = param1 as Object;
               _loc3_ = _loc2_.items.length == pageSize;
               _loc4_ = new PagerResultObject(_loc2_.totalRecords,_loc3_,_loc2_.items,pageIndex);
               doneCallback(_loc4_);
            }
         };
         amfCaller.callFunction("GetAllGiftsGiven",[actorId,pageIndex,pageSize],true,webMethodDone);
      }
   }
}

