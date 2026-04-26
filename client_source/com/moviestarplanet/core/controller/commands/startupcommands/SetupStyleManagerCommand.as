package com.moviestarplanet.core.controller.commands.startupcommands
{
   import com.moviestarplanet.configurations.Config;
   import flash.system.ApplicationDomain;
   import flash.system.SecurityDomain;
   
   public class SetupStyleManagerCommand
   {
      
      public function SetupStyleManagerCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         Main.Instance.styleManager.loadStyleDeclarations(Config.cdnLocalBasePath + "styles/fonts_default.swf?v=20130422",true,false,ApplicationDomain.currentDomain,SecurityDomain.currentDomain);
         Main.Instance.styleManager.loadStyleDeclarations(Config.cdnLocalBasePath + "styles/tooltip_styles.swf?v=20130422",true,false,ApplicationDomain.currentDomain,SecurityDomain.currentDomain);
         Main.Instance.styleManager.loadStyleDeclarations(Config.cdnLocalBasePath + "styles/styles.swf?v=20130422",true,false,ApplicationDomain.currentDomain,SecurityDomain.currentDomain);
         Main.Instance.styleManager.loadStyleDeclarations(Config.cdnLocalBasePath + "styles/ColorPickers.swf?v=20130422",true,false,ApplicationDomain.currentDomain,SecurityDomain.currentDomain);
      }
   }
}

