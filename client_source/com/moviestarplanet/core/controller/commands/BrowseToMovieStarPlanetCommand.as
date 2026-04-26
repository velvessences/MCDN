package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.configurations.Config;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class BrowseToMovieStarPlanetCommand
   {
      
      public function BrowseToMovieStarPlanetCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         navigateToURL(new URLRequest(Config.basePath),"_top");
      }
   }
}

