package com.moviestarplanet.configurations.environment
{
   import com.moviestarplanet.configurations.Config;
   
   public class DebugEnvironmentInitializerWeb
   {
      
      private var environmentReadyCallback:Function;
      
      public function DebugEnvironmentInitializerWeb()
      {
         super();
      }
      
      public function initEnvironment(param1:Function) : void
      {
         this.environmentReadyCallback = param1;
         var _loc2_:String = Config.debugRemote() ? Config.GetCountry : "LOCAL";
         EnvironmentManager.getInstance().loadCountryEnvironment(_loc2_,this.debugEnvironmentLoaded,this.debugEnvironmentLoadFailure);
      }
      
      private function debugEnvironmentLoadFailure() : void
      {
         throw new Error("WEB Preloader failed to load debug environment through Discovery Service");
      }
      
      private function debugEnvironmentLoaded() : void
      {
         var _loc1_:Environment = EnvironmentManager.getInstance().getCurrentEnvironment;
         Config.initializeCdnPathsWeb(_loc1_.cdnContentPath,"",_loc1_.webServerPath);
         Config.setBaseBranch(null);
         Config.setBaseHost(null);
         var _loc2_:String = null;
         this.environmentReadyCallback(_loc1_.cdnAssetPath,_loc2_);
      }
   }
}

