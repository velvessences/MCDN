package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.award.visualization.AwardVisualizationController;
   import com.moviestarplanet.award.visualization.IAwardSpawner;
   import com.moviestarplanet.award.visualization.IMobileAwardSpawner;
   import com.moviestarplanet.injection.InjectionManager;
   
   public class ConfigureAwardsCommand
   {
      
      public function ConfigureAwardsCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         InjectionManager.mapper().map(IMobileAwardSpawner).toValue(null);
         InjectionManager.mapper().map(IAwardSpawner).toValue(AwardVisualizationController.getInstance());
      }
   }
}

