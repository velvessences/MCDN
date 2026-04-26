package com.moviestarplanet.core.controller.commands.startupcommands
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.connections.LogoutHandler;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   
   public class SetupLogoutHandlerCommand
   {
      
      public function SetupLogoutHandlerCommand()
      {
         super();
      }
      
      private static function onLogout(param1:MsgEvent) : void
      {
         if(!HandleBrowserUnloadCommand.hasUserBrowsedAway)
         {
            LogoutHandler.getInstance().logout();
         }
         AmfCaller.doCleanup();
      }
      
      public function execute() : void
      {
         MessageCommunicator.subscribe(MSPEvent.DO_LOGOUT,onLogout);
      }
   }
}

