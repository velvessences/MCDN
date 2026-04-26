package com.moviestarplanet.session.service
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.service.ISessionAmfServiceForWeb;
   
   public class SessionAmfServiceForWeb extends SessionAmfService implements ISessionAmfServiceForWeb
   {
      
      private static var _amfCaller:AmfCaller = new AmfCaller("MovieStarPlanet.WebService.Session.AMFSessionServiceForWeb");
      
      public function SessionAmfServiceForWeb()
      {
         super();
      }
      
      override protected function get amfCaller() : AmfCaller
      {
         return _amfCaller;
      }
      
      public function getModuleVersion(param1:String, param2:Function) : void
      {
         GetAppSetting(param1,param2);
      }
      
      public function GetChatPermissionInfo(param1:Function) : void
      {
         this.amfCaller.callFunction("GetChatPermissionInfo",[],true,param1,null);
      }
      
      public function getAppSetting(param1:String, param2:Function) : void
      {
         this.amfCaller.callFunction("GetAppSetting",[param1],true,param2);
      }
   }
}

