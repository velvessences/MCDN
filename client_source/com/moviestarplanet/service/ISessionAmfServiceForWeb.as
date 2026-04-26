package com.moviestarplanet.service
{
   public interface ISessionAmfServiceForWeb extends ISessionAmfService
   {
      
      function getModuleVersion(param1:String, param2:Function) : void;
      
      function GetAppSettings(param1:Array, param2:Function) : void;
      
      function GetChatPermissionInfo(param1:Function) : void;
   }
}

