package com.moviestarplanet.connections
{
   import com.moviestarplanet.combat.CombatProfileUpdaterWeb;
   import com.moviestarplanet.core.controller.commands.BrowseToMovieStarPlanetCommand;
   import com.moviestarplanet.mangroveanalytics.configuration.MangroveConfig;
   import com.moviestarplanet.utils.loader.MSP_LoaderManager;
   import com.swrve.SwrveService;
   
   public class LogoutHandler
   {
      
      private static var instance:LogoutHandler;
      
      public var isLoggingOut:Boolean;
      
      public function LogoutHandler()
      {
         super();
      }
      
      public static function getInstance() : LogoutHandler
      {
         if(instance == null)
         {
            instance = new LogoutHandler();
         }
         return instance;
      }
      
      public function logout() : void
      {
         CombatProfileUpdaterWeb.getInstance().destroy();
         SwrveService.getInstance().sessionEnd();
         this.isLoggingOut = true;
         Main.Instance.mainCanvas.applicationViewStack.selectedChild = Main.Instance.mainCanvas.applicationViewStack.logoutView;
         this.shutDown();
         instance = null;
         new BrowseToMovieStarPlanetCommand().execute();
         MangroveConfig.shutDownMangrove();
      }
      
      public function shutDown() : void
      {
         MSP_LoaderManager.Reset(true);
      }
   }
}

