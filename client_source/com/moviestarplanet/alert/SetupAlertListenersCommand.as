package com.moviestarplanet.alert
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.utils.ui.AdHandler;
   
   public class SetupAlertListenersCommand
   {
      
      public function SetupAlertListenersCommand()
      {
         super();
      }
      
      private static function onDebugMessage(param1:MsgEvent) : void
      {
         new DebugAlert().show(param1.data);
      }
      
      private static function onErrorAlert(param1:MsgEvent) : void
      {
         var _loc2_:Object = param1.data;
         MSP_ErrorAlert.show(_loc2_.msg,200,100,_loc2_.logout);
      }
      
      private static function onShowAlert(param1:MsgEvent) : void
      {
         HTMLAlert.show(param1.data.text,param1.data.title);
      }
      
      private static function showUserAlertAndSafetyScreen(param1:MsgEvent) : void
      {
         onShowAlert(param1);
         AdHandler.Instance.openAd(AdHandler.SAFETYAD);
      }
      
      public function execute() : void
      {
         MessageCommunicator.subscribe(MSPEvent.DEBUG_ALERT,onDebugMessage);
         MessageCommunicator.subscribe(MSPEvent.ERROR_ALERT,onErrorAlert);
         MessageCommunicator.subscribe(MSPEvent.SHOW_USER_ALERT,onShowAlert);
         MessageCommunicator.subscribe(MSPEvent.SHOW_USER_ALERT_AND_SAFETY_SCREEN,showUserAlertAndSafetyScreen);
      }
   }
}

