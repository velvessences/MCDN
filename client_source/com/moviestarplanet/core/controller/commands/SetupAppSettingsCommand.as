package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.configurations.AppSettings;
   import com.moviestarplanet.core.controller.commands.startupcommands.CheckInactivityLogoutCommand;
   import com.moviestarplanet.friends.notifications.SetupNotificationsCommand;
   
   public class SetupAppSettingsCommand
   {
      
      public function SetupAppSettingsCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         AppSettings.getInstance().initialize(this.onSuccess,this.onFail,false);
      }
      
      private function onSuccess() : void
      {
         new SetupNotificationsCommand().execute();
         new SetupVersionListCommand().execute();
         new CheckInactivityLogoutCommand().execute();
      }
      
      private function onFail(param1:String) : void
      {
         throw new Error("Call AppSettings.getInstance().initialize() failed inside SetupAppSettingsCommand.");
      }
   }
}

