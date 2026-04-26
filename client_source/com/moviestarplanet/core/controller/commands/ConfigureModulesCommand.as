package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.Module.AbstractModuleManager;
   import com.moviestarplanet.award.visualization.AwardVisualizationController;
   import com.moviestarplanet.dailyCompetition.DailyCompetition;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.moviestar.controller.CheckClothingCommand;
   import com.moviestarplanet.pets.IPetModuleManager;
   import com.moviestarplanet.pets.PetModuleManager;
   import com.moviestarplanet.services.wrappers.SessionService;
   
   public class ConfigureModulesCommand
   {
      
      public function ConfigureModulesCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         var malesMustWearTopsSettingReturned:Function = null;
         malesMustWearTopsSettingReturned = function(param1:String):void
         {
            if(param1 != null && param1 == "true")
            {
               CheckClothingCommand.malesMustWearTops = true;
            }
         };
         AbstractModuleManager.applicationRoot = ApplicationReference.getApplicationRoot();
         SessionService.GetAppSetting("MalesMustWearTops",malesMustWearTopsSettingReturned);
         DailyCompetition.localAwardSpawner = AwardVisualizationController.getInstance();
         InjectionManager.mapper().map(IPetModuleManager).toValue(PetModuleManager.getInstance());
      }
   }
}

