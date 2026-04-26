package com.moviestarplanet.core.controller.commands.startupcommands
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import flash.external.ExternalInterface;
   
   public class HandleBrowserUnloadCommand
   {
      
      public static var hasUserBrowsedAway:Boolean;
      
      public function HandleBrowserUnloadCommand()
      {
         super();
      }
      
      private static function browserUnload() : void
      {
         hasUserBrowsedAway = true;
         MessageCommunicator.send(new MsgEvent(MSPEvent.DO_LOGOUT));
      }
      
      public function execute() : void
      {
         ExternalInterface.addCallback("browserUnload",browserUnload);
      }
   }
}

