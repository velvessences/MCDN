package com.moviestarplanet.core.controller.commands.startupcommands
{
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.ecoSystem.initializer.EcoVariables;
   import com.moviestarplanet.services.wrappers.SessionService;
   
   public class InitEcoSystemVariablesCommand
   {
      
      public function InitEcoSystemVariablesCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         SessionService.GetAppSetting("EcosystemUrl",this.gotEcoUrl);
      }
      
      private function gotEcoUrl(param1:String) : void
      {
         EcoVariables.init(Config.GetCountry,param1);
      }
   }
}

