package com.moviestarplanet.assetManager.assetHandlers
{
   import com.moviestarplanet.assetManager.AssetManager;
   import com.moviestarplanet.assetManager.AssetManagerStats;
   import com.moviestarplanet.commonaccesspoints.DebugAccessPoint;
   import com.moviestarplanet.minimalCompsWrapper.MinimalCompsWrapper;
   import flash.utils.ByteArray;
   
   public class AssetHandlerBase
   {
      
      protected static var _localStorageDir:*;
      
      protected static var CACHE_DIR:String = "";
      
      public function AssetHandlerBase()
      {
         super();
         DebugAccessPoint.addSlashCommand("showAssetManagerStats",AssetManagerStats.showAssetManagerStats);
         DebugAccessPoint.addSlashCommand("showAssetManagerLeaks",AssetManagerStats.showAssetManagerLeaks);
         DebugAccessPoint.addSlashCommand("showLoads",AssetManagerStats.showAssetLoaderLoads);
         DebugAccessPoint.addSlashCommand("showLoadsByCount",AssetManagerStats.showAssetLoaderLoadsByCount);
         DebugAccessPoint.addSlashCommand("showCallManager",this.showCallManager);
         MinimalCompsWrapper.createPanel(AssetManagerStats.debugCreatedPanel,200,500);
         MinimalCompsWrapper.createPanel(AssetManagerStats.debugLoadingPanel,200,500);
      }
      
      private function showCallManager() : void
      {
         MinimalCompsWrapper.showMinimalComps(AssetManagerStats.debugCreatedPanel,AssetManager.nativeStage);
         MinimalCompsWrapper.showMinimalComps(AssetManagerStats.debugLoadingPanel,AssetManager.nativeStage);
      }
      
      public function tryToStoreOnLocal(param1:String, param2:ByteArray) : void
      {
      }
      
      public function getLocalURL(param1:String) : String
      {
         return "";
      }
      
      public function getLocalNativePath(param1:String) : String
      {
         return "";
      }
      
      public function hasOnLocal(param1:String) : Boolean
      {
         return false;
      }
      
      protected function getLocalStorageDir() : *
      {
         return null;
      }
   }
}

