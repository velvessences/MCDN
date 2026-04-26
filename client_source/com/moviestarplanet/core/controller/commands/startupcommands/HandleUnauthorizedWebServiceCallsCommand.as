package com.moviestarplanet.core.controller.commands.startupcommands
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.gift.GetIpAddressesCommand;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.services.userservice.UserAmfServiceWeb;
   import com.moviestarplanet.services.userservice.valueObjects.LoginStatus2;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   
   public class HandleUnauthorizedWebServiceCallsCommand
   {
      
      private static var _isUnauthorizedWebServicePopupBeingDisplayed:Boolean = false;
      
      public function HandleUnauthorizedWebServiceCallsCommand()
      {
         super();
      }
      
      private static function handleUnauthorizedWebServiceCall(param1:MsgEvent) : void
      {
         if(!_isUnauthorizedWebServicePopupBeingDisplayed)
         {
            _isUnauthorizedWebServicePopupBeingDisplayed = true;
            Prompt.showEvil(MSPLocaleManagerWeb.getInstance().getString("ERRORMESSAGE_BODY"),MSPLocaleManagerWeb.getInstance().getString("ERRORMESSAGE_HEADER"),4,null,setFlagToFalse);
         }
         UserAmfServiceWeb.Login(ActorSession.actorName,ActorSession.actorPassword,new GetIpAddressesCommand().execute(),onRelogin);
      }
      
      private static function setFlagToFalse() : void
      {
         _isUnauthorizedWebServicePopupBeingDisplayed = false;
      }
      
      private static function onRelogin(param1:LoginStatus2) : void
      {
         if(param1.loginStatus.status != "Success")
         {
            MessageCommunicator.send(new MsgEvent(MSPEvent.DO_LOGOUT));
         }
      }
      
      public function execute() : void
      {
         MessageCommunicator.subscribe(AmfCaller.UNAUTHORIZED_WEB_SERVICE_CALL,handleUnauthorizedWebServiceCall);
      }
   }
}

