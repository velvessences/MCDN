package com.moviestarplanet.services.wrappers.parentalconsentwebservice
{
   import com.moviestarplanet.services.ServiceManager;
   import com.moviestarplanet.services.parentalconsentwebservice.ParentalConsentWebService;
   import com.moviestarplanet.services.wrappers.BaseServiceWrapper;
   import com.moviestarplanet.valueObjects.ActorParentalConsent;
   import mx.rpc.CallResponder;
   
   public class ParentalConsentWebService extends BaseServiceWrapper
   {
      
      private static var _parentalConsentWebServiceInstance:com.moviestarplanet.services.parentalconsentwebservice.ParentalConsentWebService;
      
      private static var pcServiceManager:ServiceManager;
      
      public function ParentalConsentWebService()
      {
         super();
      }
      
      private static function getPCService() : com.moviestarplanet.services.parentalconsentwebservice.ParentalConsentWebService
      {
         if(_parentalConsentWebServiceInstance == null)
         {
            _parentalConsentWebServiceInstance = new com.moviestarplanet.services.parentalconsentwebservice.ParentalConsentWebService();
            _parentalConsentWebServiceInstance.manager = new ServiceManager(_parentalConsentWebServiceInstance);
         }
         return _parentalConsentWebServiceInstance;
      }
      
      public static function GrantParentalConsent(param1:int, param2:String, param3:Function = null) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var parentalConsentConfirmCode:String = param2;
         var callback:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            if(callback != null)
            {
               callback(param1.result as int);
            }
         };
         var service:com.moviestarplanet.services.parentalconsentwebservice.ParentalConsentWebService = getPCService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.GrantParentalConsent(actorId,parentalConsentConfirmCode),webMethodDone);
      }
      
      public static function SetActorsParentalConsent(param1:int, param2:Boolean, param3:Function = null) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorID:int = param1;
         var toGrant:Boolean = param2;
         var callback:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            if(callback != null)
            {
               callback();
            }
         };
         var service:com.moviestarplanet.services.parentalconsentwebservice.ParentalConsentWebService = getPCService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.SetActorsParentalConsent(actorID,toGrant),webMethodDone);
      }
      
      public static function RequestParentalConsent(param1:int) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorId:int = param1;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
         };
         var service:com.moviestarplanet.services.parentalconsentwebservice.ParentalConsentWebService = getPCService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.RequestParentalConsent(actorId),webMethodDone);
      }
      
      public static function SaveParentEmailAddress(param1:int, param2:String, param3:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var parentEmail:String = param2;
         var callback:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            callback(param1.result as Boolean);
         };
         var service:com.moviestarplanet.services.parentalconsentwebservice.ParentalConsentWebService = getPCService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.SaveParentEmailAddress(actorId,parentEmail),webMethodDone);
      }
      
      public static function GetUserType(param1:int, param2:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var callback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            callback(param1.result as String);
         };
         var service:com.moviestarplanet.services.parentalconsentwebservice.ParentalConsentWebService = getPCService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.GetUserType(actorId),webMethodDone);
      }
      
      public static function HideParentalConsentCode(param1:int, param2:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var callback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            callback(param1.result as Object);
         };
         var service:com.moviestarplanet.services.parentalconsentwebservice.ParentalConsentWebService = getPCService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.HideParentalConsentCode(actorId),webMethodDone);
      }
      
      public static function MatchActorIdToParentalConsentConfirmCode(param1:int, param2:String, param3:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var confirmCode:String = param2;
         var callBack:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            callBack(param1.result as Boolean);
         };
         var service:com.moviestarplanet.services.parentalconsentwebservice.ParentalConsentWebService = getPCService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.MatchActorIdToParentalConsentConfirmCode(actorId,confirmCode),webMethodDone);
      }
      
      public static function HasVisibleParentalConsentCode(param1:int, param2:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var callback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            callback(param1.result as Boolean);
         };
         var service:com.moviestarplanet.services.parentalconsentwebservice.ParentalConsentWebService = getPCService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.HasVisibleParentalConsentCode(actorId),webMethodDone);
      }
      
      public static function ReSendParentalConsentCode(param1:int) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorId:int = param1;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
         };
         var service:com.moviestarplanet.services.parentalconsentwebservice.ParentalConsentWebService = getPCService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.ReSendParentalConsentCode(actorId),webMethodDone);
      }
      
      public static function RememberParentalConsentCode(param1:int) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorId:int = param1;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
         };
         var service:com.moviestarplanet.services.parentalconsentwebservice.ParentalConsentWebService = getPCService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.RememberParentalConsentCode(actorId),webMethodDone);
      }
      
      public static function GetActorParentalConsent(param1:int, param2:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var callBack:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            callBack(param1.result as ActorParentalConsent);
         };
         var service:com.moviestarplanet.services.parentalconsentwebservice.ParentalConsentWebService = getPCService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.GetActorParentalConsent(actorId),webMethodDone);
      }
   }
}

