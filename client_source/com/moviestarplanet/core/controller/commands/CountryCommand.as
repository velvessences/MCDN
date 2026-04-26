package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.chatpermission.ChatPermissionManager;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.utils.numbers.NumberFormatter;
   
   public class CountryCommand
   {
      
      public function CountryCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         NumberFormatter.country = Config.GetCountry;
         ChatPermissionManager.instance.country = Config.GetCountry;
      }
   }
}

