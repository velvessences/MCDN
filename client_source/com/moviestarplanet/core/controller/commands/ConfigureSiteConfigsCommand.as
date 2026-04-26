package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.Forms.ValidateEmailInstantiator;
   import com.moviestarplanet.access.SiteRestriction;
   import com.moviestarplanet.advertisement.TrafficTracking;
   import com.moviestarplanet.anchorCharacters.service.AMFSponsoredCharacterService;
   import com.moviestarplanet.config.ISiteConfig;
   import com.moviestarplanet.config.ISiteRestriction;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.pleaseremoveasap.IValidateEmail;
   
   public class ConfigureSiteConfigsCommand
   {
      
      public function ConfigureSiteConfigsCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         TrafficTracking.siteConfig = Config.getCurrentSiteConfig() as ISiteConfig;
         InjectionManager.mapper().map(ISiteConfig).toValue(Config.getCurrentSiteConfig());
         InjectionManager.mapper().map(ISiteRestriction).toSingleton(SiteRestriction);
         InjectionManager.mapper().map(IValidateEmail).toSingleton(ValidateEmailInstantiator);
         InjectionManager.mapper().map(AMFSponsoredCharacterService).toSingleton(AMFSponsoredCharacterService);
      }
   }
}

