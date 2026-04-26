package com.moviestarplanet.assetManager
{
   import com.moviestarplanet.commonaccesspoints.DebugAccessPoint;
   import com.moviestarplanet.resources.GenericResourceManager;
   import flash.utils.Dictionary;
   
   public class AssetManagerStats
   {
      
      public static var debugCreatedPanel:String = "assetmanager-created";
      
      public static var debugLoadingPanel:String = "assetmanager-loading (bugged)";
      
      public static var gatherStats:Boolean = true;
      
      public static var loadsStarted:int = 0;
      
      public static var loadsFromHDD:int = 0;
      
      public static var savesToHDD:int = 0;
      
      public static var nativeMovieClipsGenerated:int = 0;
      
      public static var assetsGenerated:int = -1;
      
      public static var optimizedAssetsGenerated:int = 0;
      
      public static var optimizedAssetsDisposed:int = 0;
      
      private static var fileLoadList:Dictionary = new Dictionary();
      
      public function AssetManagerStats()
      {
         super();
      }
      
      public static function showAssetManagerStats() : void
      {
         DebugAccessPoint.log("");
         DebugAccessPoint.log("//-----------------------------------------//");
         DebugAccessPoint.log("//---------- Asset Manager Stats ----------//");
         DebugAccessPoint.log("- Loads:                            " + numberWithSpaces(7,loadsStarted) + " -");
         DebugAccessPoint.log("- Loads from HDD:                   " + numberWithSpaces(7,loadsFromHDD) + " -");
         DebugAccessPoint.log("- Saves to HDD:                     " + numberWithSpaces(7,savesToHDD) + " -");
         DebugAccessPoint.log("-                                           -");
         DebugAccessPoint.log("- getNativeMovieClip Generated:     " + numberWithSpaces(7,nativeMovieClipsGenerated) + " -");
         DebugAccessPoint.log("- Optimized Assets Generated:       " + numberWithSpaces(7,optimizedAssetsGenerated) + " -");
         DebugAccessPoint.log("- Optimized Assets Disposed:        " + numberWithSpaces(7,optimizedAssetsDisposed) + " -");
         DebugAccessPoint.log("//-----------------------------------------//");
         DebugAccessPoint.log("");
      }
      
      public static function showAssetManagerLeaks() : void
      {
         DebugAccessPoint.log("");
         DebugAccessPoint.log("//-----------------------------------------//");
         DebugAccessPoint.log("//---------- Asset/Resource Manager Leaks ----------//");
         DebugAccessPoint.log(GenericResourceManager.showUsageList());
         DebugAccessPoint.log("//-----------------------------------------//");
         DebugAccessPoint.log("");
      }
      
      private static function numberWithSpaces(param1:int, param2:Number) : String
      {
         var _loc3_:String = param2.toString();
         if(_loc3_.length > param1)
         {
            return _loc3_.substr(0,param1);
         }
         while(_loc3_.length < param1)
         {
            _loc3_ = " " + _loc3_;
         }
         return _loc3_;
      }
      
      public static function showAssetLoaderLoadsByCount() : void
      {
         showAssetLoaderLoads(true);
      }
      
      public static function showAssetLoaderLoads(param1:Boolean = false) : void
      {
         var _loc3_:String = null;
         DebugAccessPoint.log("");
         DebugAccessPoint.log("//-----------------------------------------//");
         DebugAccessPoint.log("//---------- Asset Manager Loads ----------//");
         var _loc2_:Array = [];
         for(_loc3_ in fileLoadList)
         {
            _loc2_.push({
               "count":fileLoadList[_loc3_],
               "name":_loc3_
            });
         }
         if(param1)
         {
            _loc2_.sortOn("count",Array.DESCENDING | Array.NUMERIC);
         }
         else
         {
            _loc2_.sortOn("name");
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            DebugAccessPoint.log(_loc2_[_loc4_]["name"] + " (" + _loc2_[_loc4_]["count"] + ")");
            _loc4_++;
         }
         DebugAccessPoint.log("");
         DebugAccessPoint.log("//-----------------------------------------//");
      }
      
      public static function clearFileLoadList() : void
      {
         fileLoadList = new Dictionary();
      }
      
      public static function addFileLoadToLoadRequestList(param1:String) : void
      {
         if(!fileLoadList[param1])
         {
            fileLoadList[param1] = 1;
            return;
         }
         ++fileLoadList[param1];
      }
   }
}

