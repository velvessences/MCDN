package com.moviestarplanet.services.actorservice
{
   import com.moviestarplanet.admin.valueobjects.Report;
   import com.moviestarplanet.commonvalueobjects.actor.BlockedAndBlockingActorsResult;
   import com.moviestarplanet.services.ServiceManager;
   import com.moviestarplanet.services.service.Service;
   import com.moviestarplanet.services.userservice.UserService;
   import com.moviestarplanet.services.wrappers.WebService;
   import com.moviestarplanet.valueObjects.LoginStatus2;
   import mx.collections.ArrayCollection;
   import mx.rpc.CallResponder;
   
   public class ActorService extends WebService
   {
      
      private static var _userServiceInstance:UserService;
      
      private static var userServiceManager:ServiceManager;
      
      public function ActorService()
      {
         super();
      }
      
      private static function getUserService() : UserService
      {
         if(_userServiceInstance == null)
         {
            _userServiceInstance = new UserService();
            _userServiceInstance.manager = new ServiceManager(_userServiceInstance);
         }
         return _userServiceInstance;
      }
      
      public static function Login(param1:String, param2:String, param3:Function, param4:Function = null) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var un:String = param1;
         var pw:String = param2;
         var callback:Function = param3;
         var faultHandler:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            GetTicketFromXMLHeader(param1.headers[0]);
            callback(param1.result as LoginStatus2);
         };
         var service:Service = getService();
         responder = registerResponder(service.Login2(un,pw),webMethodDone,faultHandler);
      }
      
      public static function SaveActorLocale(param1:Number, param2:String, param3:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorId:Number = param1;
         var locale:String = param2;
         var done:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            if(done != null)
            {
               done();
            }
         };
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.SaveActorLocale(actorId,locale),webMethodDone);
      }
      
      public static function NewReport(param1:Report, param2:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var report:Report = param1;
         var resultCallBack:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            resultCallBack();
         };
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.ReportActor(report),webMethodDone);
      }
      
      public static function isNameBlocked(param1:String, param2:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var name:String = param1;
         var doneCallback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            doneCallback(param1.result as Boolean);
         };
         var service:UserService = getUserService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.IsNameBlocked(name),webMethodDone);
      }
      
      public static function IsActorNameUsed(param1:String, param2:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var name:String = param1;
         var done:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            var _loc2_:Boolean = Boolean(Boolean(param1.result));
            done(_loc2_);
         };
         var service:UserService = getUserService();
         responder = registerResponder(service.IsActorNameUsed(name),webMethodDone);
      }
      
      public static function BlockActor(param1:int, param2:int, param3:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var blockerActorId:int = param1;
         var blockedActorId:int = param2;
         var callback:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            callback(param1.result);
         };
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.BlockActor(blockerActorId,blockedActorId),webMethodDone);
      }
      
      public static function UnblockActor(param1:int, param2:int, param3:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var blockerActorId:int = param1;
         var blockedActorId:int = param2;
         var callback:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            callback(param1.result);
         };
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.UnblockActor(blockerActorId,blockedActorId),webMethodDone);
      }
      
      public static function BlockedActors(param1:int, param2:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var blockerActorId:int = param1;
         var callback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            callback(param1.result as ArrayCollection);
         };
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.BlockedActors(blockerActorId),webMethodDone);
      }
      
      public static function LoadBlockedAndBlockingActors(param1:int, param2:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var callback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:BlockedAndBlockingActorsResult = new BlockedAndBlockingActorsResult();
            _loc2_.BlockedActors = param1.result.BlockedActors;
            _loc2_.BlockingActors = param1.result.BlockingActors;
            clearResponder(responder,webMethodDone);
            callback(_loc2_);
         };
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.BlockedAndBlockingActors(actorId),webMethodDone);
      }
      
      public static function GetAppSettings(param1:Array, param2:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var keys:Array = param1;
         var resultCallBack:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            if(resultCallBack != null)
            {
               resultCallBack(param1.result);
            }
         };
         var service:UserService = getUserService();
         responder = registerResponder(service.GetAppSettings(new ArrayCollection(keys)),webMethodDone);
      }
   }
}

