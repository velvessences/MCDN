package com.moviestarplanet.core.controller.commands.startupcommands
{
   import com.moviestarplanet.amf.ServiceUrlUtil;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.configurations.SiteConfig;
   
   public class SetupServiceUrlUtilCommand
   {
      
      public function SetupServiceUrlUtilCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         var _loc1_:SiteConfig = Config.getCurrentSiteConfig();
         if(_loc1_ != null)
         {
            ServiceUrlUtil.webServerUrl = Config.webserverPath;
            ServiceUrlUtil.domain = Config.webserverPath;
         }
         else
         {
            ServiceUrlUtil.webServerUrl = Config.LOCALHOST_WEBSERVER_URL;
            ServiceUrlUtil.domain = "SOAP_SERVICE_XML_DEFINITION/msp";
         }
      }
   }
}

