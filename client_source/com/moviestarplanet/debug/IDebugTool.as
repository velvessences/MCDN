package com.moviestarplanet.debug
{
   public interface IDebugTool
   {
      
      function log(param1:String) : void;
      
      function addSlashCommand(param1:String, param2:Function) : void;
      
      function showDebugPopup() : void;
   }
}

