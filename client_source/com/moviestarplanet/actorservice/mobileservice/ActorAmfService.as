package com.moviestarplanet.actorservice.mobileservice
{
   import com.moviestarplanet.actor.IActorDetails;
   import com.moviestarplanet.actor.INewActorCreationData;
   import com.moviestarplanet.actorservice.valueObjects.CategoryGroupPage;
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.amf.PagerResultObject;
   import com.moviestarplanet.amf.TicketGenerator;
   import com.moviestarplanet.blob.service.AmfBlobService;
   import com.moviestarplanet.commonvalueobjects.actor.Mood;
   import com.moviestarplanet.configurations.AppSettings;
   import com.moviestarplanet.logging.Log;
   import com.moviestarplanet.moviestar.service.IMovieStarService;
   import flash.utils.ByteArray;
   
   public class ActorAmfService implements IMovieStarService
   {
      
      protected static var _instance:ActorAmfService;
      
      private static var amfCaller:AmfCaller = new AmfCaller("MovieStarPlanet.WebService.AMFActorService");
      
      public function ActorAmfService(param1:Function)
      {
         super();
         if(param1 != _singletonUnBlocker)
         {
            throw new Error("Error: Instantiation failed: Use getInstance() instead of new.");
         }
      }
      
      protected static function _singletonUnBlocker() : void
      {
      }
      
      public static function GetPostLoginBundle(param1:int, param2:Function = null, param3:Function = null) : void
      {
         amfCaller.callFunction("GetPostLoginBundle",[param1],true,param2,param3);
      }
      
      public static function getInstance() : ActorAmfService
      {
         if(_instance == null)
         {
            _instance = new ActorAmfService(_singletonUnBlocker);
         }
         return _instance;
      }
      
      public static function loadActorWithCurrentClothesBasicDataOnly(param1:int, param2:Function, param3:Function = null) : void
      {
         amfCaller.callFunction("LoadActorWithCurrentClothesBasicDataOnly",[param1],false,param2,param3);
      }
      
      public static function bulkLoadActors(param1:Array, param2:Function, param3:Function = null) : void
      {
         amfCaller.callFunction("BulkLoadActors",[param1],true,param2,param3);
      }
      
      public static function LoadActorDetails(param1:int, param2:Boolean, param3:Function, param4:Function) : void
      {
         amfCaller.callFunction("LoadActorDetails",[param1,param2],true,param3,param4);
      }
      
      public static function LoadActorDetailsExtended(param1:int, param2:Function, param3:Function) : void
      {
         amfCaller.callFunction("LoadActorDetailsExtended",[param1],true,param2,param3);
      }
      
      public static function PickupGuidePresent(param1:int, param2:int, param3:int, param4:Function = null, param5:Function = null) : void
      {
         amfCaller.callFunction("PickupGuidePresent",[param1,param2,param3],true,param4,param5);
      }
      
      public static function loginWithRedirectToken(param1:int, param2:String, param3:String, param4:int, param5:String, param6:Function, param7:Function) : void
      {
         var onRet:Function = null;
         var userId:int = param1;
         var redirectToken:String = param2;
         var version:String = param3;
         var store:int = param4;
         var deviceId:String = param5;
         var onSuccess:Function = param6;
         var faultHandler:Function = param7;
         onRet = function(param1:*):void
         {
            TicketGenerator.sessionTicket = param1.ticket;
            onSuccess(param1.status);
         };
         amfCaller.callFunction("LoginMobile",[userId,redirectToken,version,store,deviceId],false,onRet,faultHandler);
      }
      
      public static function loginMobile(param1:String, param2:String, param3:String, param4:int, param5:String, param6:String, param7:Function, param8:Function) : void
      {
         var onRet:Function = null;
         var userName:String = param1;
         var password:String = param2;
         var version:String = param3;
         var store:int = param4;
         var deviceId:String = param5;
         var dfp:String = param6;
         var onSuccess:Function = param7;
         var faultHandler:Function = param8;
         onRet = function(param1:*):void
         {
            TicketGenerator.sessionTicket = param1.ticket;
            Log.getInstance().setFingerPrint(dfp);
            onSuccess(param1.status);
         };
         if(AppSettings.getInstance().getSetting(AppSettings.DEVICE_FINGERPRINT_COLLECTION_ENABLED) == "true")
         {
            amfCaller.callFunction("loginMobile",[userName,password,version,store,deviceId,dfp],false,onRet,faultHandler);
         }
         else
         {
            amfCaller.callFunction("loginMobile",[userName,password,version,store,deviceId],false,onRet,faultHandler);
         }
      }
      
      public static function loginThirdParty(param1:INewActorCreationData, param2:ByteArray, param3:ByteArray, param4:String, param5:String, param6:String, param7:int, param8:String, param9:Function, param10:Function) : void
      {
         var done:Function = null;
         var nacd:INewActorCreationData = param1;
         var fullSizeSnapshot:ByteArray = param2;
         var movieStarSnapshot:ByteArray = param3;
         var username:String = param4;
         var password:String = param5;
         var version:String = param6;
         var store:int = param7;
         var deviceId:String = param8;
         var onSuccess:Function = param9;
         var faultHandler:Function = param10;
         done = function(param1:Object):void
         {
            onSuccess(param1.status);
         };
         amfCaller.callFunction("ThirdPartyLoginMobile",[nacd,fullSizeSnapshot,movieStarSnapshot,username,password,version,store,deviceId],false,done,faultHandler);
      }
      
      public static function setMood(param1:Mood, param2:Function) : void
      {
         amfCaller.callFunction("SetMood",[param1],true,param2);
      }
      
      public static function loadMood(param1:int, param2:Function, param3:Function) : void
      {
         amfCaller.callFunction("LoadMood",[param1],false,param2,param3);
      }
      
      public static function giveAutographAndCalculateTimestamp(param1:int, param2:int, param3:Function) : void
      {
         amfCaller.callFunction("GiveAutographAndCalculateTimestamp",[param1,param2],true,param3);
      }
      
      public static function getTwitActivitiesForFriends(param1:int, param2:int, param3:int, param4:Function) : void
      {
         var result:Function = null;
         var userId:int = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var onSuccess:Function = param4;
         result = function(param1:Object):void
         {
            var list:Array = null;
            var activity:Object = null;
            var isFullPage:Boolean = false;
            var totalRecs:int = 0;
            var callResultCallback:Function = null;
            var ret:Object = param1;
            callResultCallback = function():void
            {
               var _loc1_:PagerResultObject = new PagerResultObject(totalRecs,isFullPage,list,pageIndex);
               onSuccess(_loc1_);
            };
            var lookDataArray:Array = [];
            list = ret["items"];
            for each(activity in list)
            {
               if(activity.ActivityLook != null)
               {
                  lookDataArray.push(activity.ActivityLook);
               }
            }
            isFullPage = list.length == pageSize;
            totalRecs = int(ret["totalRecords"]);
            new AmfBlobService().FillInWithLookData(lookDataArray,callResultCallback);
         };
         amfCaller.callFunction("GetTwitActivitiesForFriends",[userId,pageIndex,pageSize],true,result);
      }
      
      public static function getWallActivitiesForActor(param1:int, param2:int, param3:int, param4:Function) : void
      {
         var result:Function = null;
         var userId:int = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var onSuccess:Function = param4;
         result = function(param1:Object):void
         {
            var list:Array = null;
            var activity:Object = null;
            var isFullPage:Boolean = false;
            var totalRecs:int = 0;
            var callResultCallback:Function = null;
            var ret:Object = param1;
            callResultCallback = function():void
            {
               var _loc1_:PagerResultObject = new PagerResultObject(totalRecs,isFullPage,list,pageIndex);
               onSuccess(_loc1_);
            };
            var lookDataArray:Array = [];
            list = ret["items"];
            for each(activity in list)
            {
               if(activity.ActivityLook != null)
               {
                  lookDataArray.push(activity.ActivityLook);
               }
            }
            isFullPage = list.length == pageSize;
            totalRecs = int(ret["totalRecords"]);
            new AmfBlobService().FillInWithLookData(lookDataArray,callResultCallback);
         };
         amfCaller.callFunction("GetWallActivitiesForActor",[userId,-1,pageIndex,pageSize],true,result);
      }
      
      public static function GetPagedActorClothesByCategories(param1:int, param2:Array, param3:int, param4:int, param5:Function, param6:Function) : void
      {
         var result:Function = null;
         var actorId:int = param1;
         var categories:Array = param2;
         var pageindex:int = param3;
         var pagesize:int = param4;
         var onSuccess:Function = param5;
         var onFail:Function = param6;
         result = function(param1:Object):void
         {
            var _loc2_:Array = param1["items"];
            var _loc3_:Boolean = _loc2_.length == pagesize;
            var _loc4_:int = int(param1["totalRecords"]);
            var _loc5_:PagerResultObject = new PagerResultObject(_loc4_,_loc3_,_loc2_,pageindex);
            onSuccess(_loc5_);
         };
         amfCaller.callFunction("GetPagedActorClothesByCategories",[actorId,categories,pageindex,pagesize],true,result,onFail);
      }
      
      public static function UpdateClothes(param1:int, param2:Array, param3:Function, param4:Function) : void
      {
         amfCaller.callFunction("UpdateClothes",[param1,param2],true,param3,param4);
      }
      
      public static function buyClothes(param1:int, param2:Array, param3:Function, param4:Function) : void
      {
         amfCaller.callFunction("BuyClothesNew",[param1,param2],true,param3,param4);
      }
      
      public static function GetPagedClothByCategoryGroups(param1:int, param2:Vector.<CategoryGroupPage>, param3:Function, param4:Function) : void
      {
         var _loc5_:Array = [];
         var _loc6_:int = 0;
         while(_loc6_ < param2.length)
         {
            _loc5_.push(param2[_loc6_]);
            _loc6_++;
         }
         amfCaller.callFunction("GetPagedClothByCategoryGroups",[param1,_loc5_],true,param3,param4);
      }
      
      public static function GetPagedClothByCategoryGroups_14(param1:int, param2:Vector.<CategoryGroupPage>, param3:Function, param4:Function) : void
      {
         var _loc5_:Array = [];
         var _loc6_:int = 0;
         while(_loc6_ < param2.length)
         {
            _loc5_.push(param2[_loc6_]);
            _loc6_++;
         }
         amfCaller.callFunction("GetPagedClothByCategoryGroups_14",[param1,_loc5_],true,param3,param4);
      }
      
      public static function GetClothesFromNewestClothesSection(param1:int, param2:int, param3:int, param4:Function, param5:Function) : void
      {
         amfCaller.callFunction("GetClothesFromNewestClothesSection",[param1,param2,param3],true,param4,param5);
      }
      
      public static function IsNameBlocked(param1:String, param2:Function) : void
      {
         amfCaller.callFunction("IsNameBlocked",[param1],false,param2,null);
      }
      
      public static function IsActorNameUsed(param1:String, param2:Function) : void
      {
         amfCaller.callFunction("IsActorNameUsed",[param1],false,param2,null);
      }
      
      public static function CreateNewUser(param1:INewActorCreationData, param2:String, param3:int, param4:String, param5:Function) : void
      {
         amfCaller.callFunction("CreateNewUser",[param1,param2,param3,param4],false,param5,null);
      }
      
      public static function CreateNewUserOld(param1:IActorDetails, param2:String, param3:String, param4:Array, param5:int, param6:String, param7:Function) : void
      {
         amfCaller.callFunction("CreateNewUser",[param1,param2,param4,param3,param5,param6],false,param7,null);
      }
      
      public static function SaveBirthInfo(param1:String, param2:int, param3:int, param4:Function) : void
      {
         amfCaller.callFunction("SaveBirthInfoWithTicket",[param1,param2,param3],false,param4,null);
      }
      
      public static function ValidateCaptcha(param1:String, param2:Function) : void
      {
         amfCaller.callFunction("ValidateCaptcha",[param1],false,param2);
      }
      
      public static function RequestMobileStartupReward(param1:int, param2:Function) : void
      {
         amfCaller.callFunction("RequestMobileStartupReward",[param1],true,param2);
      }
      
      public static function SubmitMobileStartupReward(param1:int, param2:int, param3:int, param4:Function) : void
      {
         amfCaller.callFunction("SubmitMobileStartupReward",[param1,param2,param3],true,param4);
      }
      
      public static function LoadBlockedAndBlockingActors(param1:int, param2:Function) : void
      {
         amfCaller.callFunction("LoadBlockedAndBlockingActors",[param1],true,param2);
      }
      
      public static function SaveAlertWordsCount(param1:int, param2:Array) : void
      {
         amfCaller.callFunction("SaveAlertWordsCount",[param1,param2],true,null);
      }
      
      public static function LockOutUser(param1:int, param2:int, param3:String, param4:Number, param5:int, param6:Function) : void
      {
         amfCaller.callFunction("LockOutUser",[param1,param2,param3,param4,param5],true,param6);
      }
      
      public static function BlockActor(param1:int, param2:int, param3:Function, param4:Function) : void
      {
         amfCaller.callFunction("BlockActor",[param1,param2],true,param3,param4);
      }
      
      public static function UnblockActor(param1:int, param2:int, param3:Function, param4:Function) : void
      {
         amfCaller.callFunction("UnblockActor",[param1,param2],true,param3,param4);
      }
      
      public static function ReportActor(param1:*, param2:Function, param3:Function) : void
      {
         amfCaller.callFunction("ReportActor",[param1],true,param2,param3);
      }
      
      public static function ReportTabletIOSConversion(param1:String, param2:String) : void
      {
         amfCaller.callFunction("ReportTabletIOSConversion",[param1,param2],true,null,null);
      }
      
      public static function ReportTabletAndroidConversion(param1:String, param2:String) : void
      {
         amfCaller.callFunction("ReportTabletAndroidConversion",[param1,param2],true,null,null);
      }
      
      public static function SearchActorByName(param1:int, param2:String, param3:Function) : void
      {
         amfCaller.callFunction("SearchActorByName",[param1,param2],true,param3);
      }
      
      public static function sendPasswordResetRequest(param1:String, param2:String, param3:Function) : void
      {
         amfCaller.callFunction("sendPasswordResetRequest",[param1,param2],false,param3);
      }
      
      public static function resetPassword(param1:String, param2:String, param3:Function) : void
      {
         amfCaller.callFunction("resetPassword",[param1,param2],false,param3);
      }
      
      public static function ModerationSearchActorByName(param1:Object, param2:int, param3:int, param4:Function) : void
      {
         var onSuccess:Function = null;
         var params:Object = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var resultCallBack:Function = param4;
         onSuccess = function(param1:Object):void
         {
            var _loc2_:Array = param1 as Array;
            var _loc3_:int = pageSize * pageIndex + _loc2_.length;
            var _loc4_:Boolean = _loc2_.length >= pageSize;
            var _loc5_:PagerResultObject = new PagerResultObject(_loc3_,_loc4_,_loc2_,pageIndex);
            resultCallBack(_loc5_);
         };
         amfCaller.callFunction("ModerationSearchActorByName",[params.searchString,pageIndex,pageSize + 1],true,onSuccess);
      }
      
      public static function ModerationSearchMassDeleteActorByName(param1:Object, param2:int, param3:int, param4:Function) : void
      {
         var onSuccess:Function = null;
         var params:Object = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var resultCallBack:Function = param4;
         onSuccess = function(param1:Object):void
         {
            var _loc2_:Array = param1 as Array;
            var _loc3_:int = pageSize * pageIndex + _loc2_.length;
            var _loc4_:Boolean = _loc2_.length >= pageSize;
            var _loc5_:PagerResultObject = new PagerResultObject(_loc3_,_loc4_,_loc2_,pageIndex);
            resultCallBack(_loc5_);
         };
         amfCaller.callFunction("ModerationSearchMassDeleteActorByName",[params.searchString,pageIndex,pageSize + 1],true,onSuccess);
      }
      
      public static function loadModeratorInformation(param1:int, param2:Function, param3:Function) : void
      {
         amfCaller.callFunction("LoadModeratorInformation",[param1],true,param2,param3);
      }
      
      public function getWallActivitiesForActorNewest(param1:int, param2:int, param3:Function) : void
      {
         amfCaller.callFunction("getWallActivitiesForActor",[1,-1,param1,param2],true,param3);
      }
      
      public function GetActorZooItems(param1:int, param2:Function, param3:Function) : void
      {
         amfCaller.callFunction("GetActorZooItems",[param1],true,param2,param3);
      }
      
      public function GetActorProps(param1:int, param2:Function, param3:Function) : void
      {
         amfCaller.callFunction("GetActorProps",[param1],true,param2,param3);
      }
      
      public function getActorClothesByCategories(param1:Number, param2:Array, param3:Function, param4:Function) : void
      {
         amfCaller.callFunction("GetActorClothesByCategories",[param1,param2],true,param3,param4);
      }
      
      public function loadMovieStarActor(param1:int, param2:Function, param3:Function = null) : void
      {
         loadActorWithCurrentClothesBasicDataOnly(param1,param2,param3);
      }
      
      public function loadMovieStarActorFlat(param1:int, param2:Function, param3:Function = null) : void
      {
      }
      
      public function loadMovieStarActorList(param1:Array, param2:Function) : void
      {
         amfCaller.callFunction("LoadMovieStarList",[param1],false,param2);
      }
      
      public function GetActorSpecialSummary(param1:int, param2:int, param3:Function, param4:Function) : void
      {
         amfCaller.callFunction("GetActorSpecialSummary",[param1,param2],true,param3,param4);
      }
      
      public function LoadActorItems(param1:int, param2:Function, param3:Function = null) : void
      {
         amfCaller.callFunction("LoadActorItems",[param1],true,param2,param3);
      }
      
      public function fameOverhaul(param1:int, param2:Function) : void
      {
         amfCaller.callFunction("fameOverhaul",[param1],true,param2);
      }
   }
}

