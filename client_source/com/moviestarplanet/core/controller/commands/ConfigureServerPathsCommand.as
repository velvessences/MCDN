package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.Module.AbstractFlashModuleManager;
   import com.moviestarplanet.Module.AbstractModuleManager;
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.amf.AmfResponseFilter;
   import com.moviestarplanet.blob.service.BlobLoader;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.configurations.SiteConfig;
   import com.moviestarplanet.dragonbones.loading.SwfArmatureLoader;
   import com.moviestarplanet.globalsharedutils.SnapshotUrl;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.services.wrappers.SessionService;
   import com.moviestarplanet.shopping.modifiers.ShoppingModifierUtility;
   import com.moviestarplanet.utils.SnapshotUtils;
   import com.moviestarplanet.utils.loader.AssetUrl;
   import com.moviestarplanet.utils.loader.ContentUrl;
   import com.moviestarplanet.utils.loader.MSP_LoaderManager;
   import com.moviestarplanet.video.module.YouTube.YouTubeBrowser.utils.YouTubeBrowserHelpers;
   
   public class ConfigureServerPathsCommand
   {
      
      public function ConfigureServerPathsCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         InjectionManager.mapper().map(String,"cdnLocalBasePath").toValue(Config.cdnLocalBasePath);
         AssetUrl.serverCdnPrefix = Config.cdnLocalBasePath;
         ContentUrl.serverCdnPrefix = Config.cdnBasePath;
         ContentUrl.forceReload = Config.isUploadServer && ActorSession.isModerator();
         ContentUrl.countryCode = Config.GetCountry;
         MSP_LoaderManager.defaultCdnBasePath = Config.cdnLocalBasePath;
         SnapshotUtils.serverCdnPrefix = Config.cdnLocalBasePath;
         SnapshotUrl.serverCdnPrefix = Config.cdnBasePath + "/" + Config.GetCountry + "/";
         SnapshotUrl.serverCdnLocalPrefix = Config.cdnLocalBasePath;
         AbstractModuleManager.serverCdnPrefix = Config.cdnLocalBasePath;
         AbstractFlashModuleManager.serverCdnPrefix = Config.cdnLocalBasePath;
         ShoppingModifierUtility.serverCdnPrefix = Config.cdnLocalBasePath;
         SwfArmatureLoader.cdnLocalBasePath = Config.cdnBasePath;
         SnapshotUrl.youtubeSnapshotPathNormal = YouTubeBrowserHelpers.SNAPSHOT_URL;
         SnapshotUrl.youtubeSnapshotPathDefault = YouTubeBrowserHelpers.SNAPSHOT_URL_DEFAULT;
         SnapshotUrl.youtubeSnapshotPathWide = YouTubeBrowserHelpers.SNAPSHOT_URL_WIDE;
         if(Config.isUploadServer)
         {
            AmfCaller.callTimeoutMillis = 120000;
         }
         AmfCaller.responseFilter = new AmfResponseFilter();
         this.loadSettings();
      }
      
      private function loadSettings() : void
      {
         var settingReturned:Function = null;
         var amfSettingReturned:Function = null;
         var snapshotSettingReturned:Function = null;
         settingReturned = function(param1:String):void
         {
            MSP_LoaderManager.setMaxLoadsSetting(param1);
            settingsReady();
         };
         var settingsReady:Function = function():void
         {
            SessionService.GetAppSetting("SnapshotServerUrl",snapshotSettingReturned);
            SessionService.GetAppSetting("MaxConcurrentAmfCalls",amfSettingReturned);
         };
         amfSettingReturned = function(param1:String):void
         {
            var _loc2_:int = int(parseInt(param1));
            if(_loc2_ > 0)
            {
               AmfCaller.maxConcurrentCalls = _loc2_;
            }
         };
         snapshotSettingReturned = function(param1:String):void
         {
            var _loc2_:SiteConfig = null;
            var _loc3_:String = null;
            if(param1 != null)
            {
               _loc2_ = Config.getCurrentSiteConfig();
               if(Config.isCustomBranch())
               {
                  _loc3_ = Config.getBaseBranch();
               }
               else if(_loc2_)
               {
                  _loc3_ = _loc2_.country;
               }
               else
               {
                  _loc3_ = "test";
               }
               SnapshotUrl.setupServerUrls(param1,_loc3_);
               BlobLoader.BlobServerUrl = param1 + "MSP_" + _loc3_ + "_blob_";
            }
         };
         SessionService.GetAppSetting("MaxConcurrentLoads",settingReturned);
      }
   }
}

