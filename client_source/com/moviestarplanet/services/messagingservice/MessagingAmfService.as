package com.moviestarplanet.services.messagingservice
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.amf.valueobjects.ServiceResultData;
   import com.moviestarplanet.messaging.IMessagingService;
   import com.moviestarplanet.services.messagingservice.valueObjects.SetMessengerSessionResult;
   import flash.net.registerClassAlias;
   
   public class MessagingAmfService implements IMessagingService
   {
      
      registerClassAlias("MovieStarPlanet.WebService.ServiceResultData`1[[MovieStarPlanet.WebService.Messaging.SetMessengerSessionResult, MSPWebservice, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null]]",ServiceResultData);
      registerClassAlias("MovieStarPlanet.WebService.Messaging.SetMessengerSessionResult",SetMessengerSessionResult);
      
      private var amfCaller:AmfCaller = new AmfCaller("MovieStarPlanet.WebService.Messaging.AMFMessagingService");
      
      public function MessagingAmfService()
      {
         super();
      }
      
      public function SetMessengerSession(param1:int, param2:Function, param3:Function) : void
      {
         this.amfCaller.callFunction("SetMessengerSession",[param1],true,param2,param3);
      }
   }
}

