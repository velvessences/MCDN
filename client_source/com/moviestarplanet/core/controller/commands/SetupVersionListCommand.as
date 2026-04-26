package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.configurations.AppSettings;
   import com.moviestarplanet.utils.loader.VersionURLAppender;
   
   public class SetupVersionListCommand
   {
      
      public function SetupVersionListCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         VersionURLAppender.getInstance().releaseVersion = AppSettings.getInstance().getSetting(AppSettings.RELEASE_VERSION);
      }
   }
}

