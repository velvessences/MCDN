package com.moviestarplanet.services.userservice
{
   import com.moviestarplanet.advertisement.AdvertisementCountryMapping;
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.amf.PagerResultObject;
   import com.moviestarplanet.amf.TicketGenerator;
   import com.moviestarplanet.commonvalueobjects.advertisement.AdTechAdImpressions;
   import com.moviestarplanet.entities.valueobjects.EntityComment;
   import com.moviestarplanet.logging.Log;
   import com.moviestarplanet.services.userservice.valueObjects.CreateNewUserStatus;
   import com.moviestarplanet.services.userservice.valueObjects.LoginStatus2;
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import com.moviestarplanet.userbehavior.UserBehaviorResult;
   import com.moviestarplanet.userbehavior.valueObjects.EvaluateResponse;
   import com.moviestarplanet.usersession.ChecksumCalculator;
   import com.moviestarplanet.usersession.valueobjects.NewActorCreationData;
   import com.moviestarplanet.usersession.valueobjects.ServiceResultDataHash;
   import com.moviestarplanet.valueObjects.PagedEntityCommentList;
   import flash.external.ExternalInterface;
   import flash.net.registerClassAlias;
   
   public class UserAmfServiceWeb
   {
      
      private static var amfCaller:AmfCaller = new AmfCaller("MovieStarPlanet.WebService.User.AMFUserServiceWeb");
      
      public function UserAmfServiceWeb()
      {
         super();
      }
      
      private static function initReg() : void
      {
         registerClassAlias("MovieStarPlanet.WebService.User.UserService+CreateNewUserStatus",CreateNewUserStatus);
         registerClassAlias("MovieStarPlanet.DBML.AdvertisementCountryMapping",AdvertisementCountryMapping);
         registerClassAlias("MovieStarPlanet.WebService.Advertisement.AmfAdImpressions",AdTechAdImpressions);
      }
      
      public static function logInput(param1:int, param2:int, param3:int, param4:int, param5:String, param6:Function) : void
      {
         var webMethodDone:Function = null;
         var locationId:int = param1;
         var actorId:int = param2;
         var roomInstanceId:int = param3;
         var destinationType:int = param4;
         var message:String = param5;
         var doneCallback:Function = param6;
         webMethodDone = function(param1:Number):void
         {
            if(doneCallback != null)
            {
               doneCallback(param1);
            }
         };
         amfCaller.callFunction("LogInput",[locationId,actorId,roomInstanceId,message,destinationType],true,webMethodDone);
      }
      
      public static function logInputGroupChat(param1:int, param2:int, param3:String, param4:int, param5:String, param6:Function) : void
      {
         var webMethodDone:Function = null;
         var locationId:int = param1;
         var actorId:int = param2;
         var roomInstanceId:String = param3;
         var destinationType:int = param4;
         var message:String = param5;
         var doneCallback:Function = param6;
         webMethodDone = function(param1:Number):void
         {
            if(doneCallback != null)
            {
               doneCallback(param1);
            }
         };
         amfCaller.callFunction("LogInputGroupChat",[locationId,actorId,roomInstanceId,message,destinationType],true,webMethodDone);
      }
      
      public static function SaveAlertWordsCount(param1:int, param2:Array) : void
      {
         amfCaller.callFunction("SaveAlertWordsCount",[param1,param2],true,null);
      }
      
      public static function IsCommunicationAllowedWith(param1:int, param2:int, param3:Function) : void
      {
         var webMethodDone:Function = null;
         var communicationType:int = param1;
         var actorid:int = param2;
         var doneCallback:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:ServiceResultDataHash = new ServiceResultDataHash(param1.Hash,param1.Data,param1.Description,param1.Code,param1.ActorId);
            doneCallback(_loc2_);
         };
         amfCaller.callFunction("IsCommunicationAllowedWith",[communicationType,actorid],true,webMethodDone);
      }
      
      public static function EntityCommentDelete(param1:int, param2:int, param3:Function) : void
      {
         var webMethodDone:Function = null;
         var entityCommentId:int = param1;
         var actorId:int = param2;
         var doneCallback:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            doneCallback(param1);
         };
         amfCaller.callFunction("EntityCommentDelete",[entityCommentId,actorId],true,webMethodDone);
      }
      
      public static function CommentEntity(param1:EntityComment, param2:UserBehaviorResult, param3:Function) : void
      {
         var webMethodDone:Function = null;
         var entityComment:EntityComment = param1;
         var userBehaviorResult:UserBehaviorResult = param2;
         var doneCallback:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            doneCallback(param1);
         };
         var originalComment:String = entityComment.Comment;
         entityComment.Comment = UserBehaviorMessageFormatter.getInstance().embedFilteredMessages2(originalComment,userBehaviorResult);
         amfCaller.callFunction("CommentEntity",[entityComment],true,webMethodDone);
      }
      
      public static function GetEntityComments(param1:Array, param2:int, param3:int, param4:Function) : void
      {
         var webMethodDone:Function = null;
         var params:Array = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var doneCallback:Function = param4;
         webMethodDone = function(param1:PagedEntityCommentList):void
         {
            var _loc2_:PagerResultObject = new PagerResultObject(param1.totalRecords,param1.items.length == pageSize,param1.items,pageIndex);
            doneCallback(_loc2_);
         };
         var entityType:String = params[0];
         var entityId:int = int(params[1]);
         if(entityType == "scrapblog" && entityId == 0)
         {
            return;
         }
         amfCaller.callFunction("GetEntityComments",[entityType,entityId,pageIndex,pageSize],true,webMethodDone);
      }
      
      public static function CreateNewUser(param1:NewActorCreationData, param2:EvaluateResponse, param3:Function) : void
      {
         var checksumCalculator:ChecksumCalculator;
         var checksum:String;
         var webMethodDone:Function = null;
         var newActor:NewActorCreationData = param1;
         var res:EvaluateResponse = param2;
         var done:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            TicketGenerator.sessionTicket = param1.ticket;
            var _loc2_:CreateNewUserStatus = CreateNewUserStatus(param1);
            done(_loc2_);
         };
         initReg();
         checksumCalculator = new ChecksumCalculator();
         checksum = checksumCalculator.calculateFromNewActorCreationData(newActor);
         amfCaller.callFunction("CreateNewUser",[newActor,checksum,prepareMarketingVariables()],false,webMethodDone,null);
      }
      
      public static function Login(param1:String, param2:String, param3:Array, param4:Function) : void
      {
         var webMethodDone:Function = null;
         var username:String = param1;
         var password:String = param2;
         var userIps:Array = param3;
         var done:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:LoginStatus2 = LoginStatus2.fromObject(param1);
            TicketGenerator.sessionTicket = _loc2_.loginStatus.ticket;
            done(_loc2_);
         };
         initReg();
         amfCaller.callFunction("Login",[username,password,userIps,prepareMarketingVariables()],false,webMethodDone,null);
      }
      
      public static function LoginRegisterFingerprint(param1:String, param2:String, param3:Array, param4:String, param5:Function) : void
      {
         var webMethodDone:Function = null;
         var username:String = param1;
         var password:String = param2;
         var userIps:Array = param3;
         var browserFingerprint:String = param4;
         var done:Function = param5;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:LoginStatus2 = LoginStatus2.fromObject(param1);
            TicketGenerator.sessionTicket = _loc2_.loginStatus.ticket;
            Log.getInstance().setFingerPrint(browserFingerprint);
            done(_loc2_);
         };
         initReg();
         amfCaller.callFunction("Login",[username,password,userIps,prepareMarketingVariables(),null,browserFingerprint],false,webMethodDone,null);
      }
      
      private static function prepareMarketingVariables() : Array
      {
         var _loc2_:Array = null;
         var _loc1_:String = ExternalInterface.call("window.location.href.toString");
         if(_loc1_)
         {
            _loc2_ = _loc1_.split("?");
            if(_loc2_.length > 0 && Boolean(_loc2_[1]))
            {
               _loc1_ = _loc2_[1];
               return _loc1_.split("&");
            }
         }
         return null;
      }
      
      public static function LoginModerator(param1:String, param2:String, param3:Array, param4:String, param5:Function) : void
      {
         var webMethodDone:Function = null;
         var username:String = param1;
         var password:String = param2;
         var userIps:Array = param3;
         var otp:String = param4;
         var done:Function = param5;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:LoginStatus2 = LoginStatus2.fromObject(param1);
            TicketGenerator.sessionTicket = _loc2_.loginStatus.ticket;
            done(_loc2_);
         };
         initReg();
         amfCaller.callFunction("LoginModetator",[username,password,userIps,otp],false,webMethodDone,null);
      }
   }
}

