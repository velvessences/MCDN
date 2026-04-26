package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.amf.ServiceUrlUtil;
   import com.moviestarplanet.services.wrappers.SessionService;
   
   public class SnapshotServiceSettings
   {
      
      public function SnapshotServiceSettings()
      {
         super();
      }
      
      public function execute() : void
      {
         var useSnapshotServiceAppSettingCallback:Function = null;
         useSnapshotServiceAppSettingCallback = function(param1:String):void
         {
            ServiceUrlUtil.snapshotServiceHostName = param1;
         };
         SessionService.GetAppSetting("SnapshotServiceHostName",useSnapshotServiceAppSettingCallback);
      }
   }
}

