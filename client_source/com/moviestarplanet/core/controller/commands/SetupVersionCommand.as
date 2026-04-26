package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.version.CheckVersion;
   import com.moviestarplanet.version.ValidateClientVersion;
   
   public class SetupVersionCommand
   {
      
      public function SetupVersionCommand()
      {
         super();
      }
      
      private static function checkVersion(param1:MsgEvent) : void
      {
         var _loc2_:CheckVersion = param1.data as CheckVersion;
         ValidateClientVersion.isVersionValid(Main.Instance.stage,_loc2_.version,_loc2_.forceUpdate);
      }
      
      public function execute() : void
      {
         MessageCommunicator.subscribe(MSPEvent.CHECK_VERSION,checkVersion);
      }
   }
}

