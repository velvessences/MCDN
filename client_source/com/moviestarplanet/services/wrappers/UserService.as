package com.moviestarplanet.services.wrappers
{
   import com.moviestarplanet.services.service.Service;
   import com.moviestarplanet.usersession.valueobjects.ActorPersonalInfo;
   import mx.rpc.CallResponder;
   
   public class UserService extends WebService
   {
      
      public function UserService()
      {
         super();
      }
      
      public static function UpdateActorPersonalInfo(param1:ActorPersonalInfo, param2:String = null, param3:Function = null) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var api:ActorPersonalInfo = param1;
         var hashCode:String = param2;
         var doneCallback:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            if(doneCallback != null)
            {
               doneCallback();
            }
         };
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.UpdateActorPersonalInfo(api,hashCode),webMethodDone);
      }
      
      public static function GetActorPersonalInfo(param1:int, param2:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var doneCallback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            doneCallback(param1.result);
         };
         var service:Service = getService();
         responder = registerResponder(service.GetActorPersonalInfo(actorId,""),webMethodDone);
      }
      
      public static function SaveChatAllowed(param1:int, param2:int, param3:Function = null) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorID:int = param1;
         var chatAllowed:int = param2;
         var doneCallback:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            if(doneCallback != null)
            {
               doneCallback(param1.result as Boolean);
            }
         };
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.SaveChatAllowed(actorID,chatAllowed),webMethodDone);
      }
      
      public static function SaveActorPersonalInfo(param1:int, param2:int, param3:int, param4:int, param5:String, param6:int, param7:Function = null) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var age:int = param2;
         var month:int = param3;
         var day:int = param4;
         var parentEmail:String = param5;
         var chatAllowed:int = param6;
         var doneCallback:Function = param7;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            if(doneCallback != null)
            {
               doneCallback(param1.result);
            }
         };
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.SaveActorPersonalInfo(actorId,age,month,day,parentEmail,chatAllowed),webMethodDone);
      }
      
      public static function EmailValidated(param1:int, param2:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var done:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            var _loc2_:Boolean = Boolean(Boolean(param1.result));
            done(_loc2_);
         };
         var service:Service = getService();
         responder = registerResponder(service.EmailValidated(actorId),webMethodDone);
      }
      
      public static function EmailValidatedCancel(param1:int) : void
      {
         var _loc2_:Service = getService();
         _loc2_.EmailValidatedCancel(param1);
      }
   }
}

