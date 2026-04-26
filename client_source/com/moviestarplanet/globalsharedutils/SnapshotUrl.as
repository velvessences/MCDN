package com.moviestarplanet.globalsharedutils
{
   import com.moviestarplanet.loader.ILoaderUrl;
   
   public class SnapshotUrl implements ILoaderUrl
   {
      
      private static var _externalSnapshotServerUrl:String;
      
      private static var _externalSnapshotServerUrlBuilder:String;
      
      private static var _externalSnapshotServerUrlBoonieverse:String;
      
      private static var _externalSnapshotServerUrlPictureUpload:String;
      
      private static var _sponsoredCheck:Function;
      
      public static var youtubeSnapshotPathNormal:String;
      
      public static var youtubeSnapshotPathDefault:String;
      
      public static var youtubeSnapshotPathWide:String;
      
      public static const LOOK:int = 1;
      
      public static const ROOM:int = 2;
      
      public static const MOVIE:int = 3;
      
      public static const MOVIESTAR:int = 4;
      
      public static const ROOM_COMPETITION:int = 6;
      
      public static const SCRAPBLOG:int = 7;
      
      public static const FULL_SIZE_MOVIESTAR:int = 11;
      
      public static const FULL_SIZE_LOOK:int = 12;
      
      public static const DESIGN:int = 22;
      
      public static const BOONIEVERSE:int = 26;
      
      public static const BOONIEVERSE_SMALL:int = 27;
      
      public static const BOONIEVERSE_BOONIE:int = 29;
      
      public static const BOONIEVERSE_LOOK:int = 200;
      
      public static const BOONIEVERSE_LOOK_SMALL:int = 201;
      
      public static const IMAGE_UPLOAD:int = 28;
      
      public static const SCRAPBLOG_BIG:int = 33;
      
      public static const ROOM_MEDIUM:int = 34;
      
      public static const ROOM_PROFILE:int = 35;
      
      public static const BUILDERGAME_AVATAR_REPORT:int = 100;
      
      public static const BUILDERGAME_VEHICLE_REPORT:int = 101;
      
      public static const BUILDERGAME_LEVEL_REPORT:int = 102;
      
      public static const BUILDERGAME_PREFAB_REPORT:int = 103;
      
      public static const BUILDERGAME_ROBOTPART_REPORT:int = 104;
      
      public static const BUILDERGAME_AVATAR:int = 110;
      
      public static const BUILDERGAME_VEHICLE:int = 111;
      
      public static const BUILDERGAME_LEVEL:int = 112;
      
      public static const BUILDERGAME_PREFAB:int = 113;
      
      public static const BUILDERGAME_ROBOTPART:int = 114;
      
      public static var serverCdnPrefix:String = "";
      
      public static var serverCdnLocalPrefix:String = "";
      
      protected static const MSP_SUBPATH:String = "MSP";
      
      protected static const RBP_SUBPATH:String = "buildergame";
      
      protected static const BP_SUBPATH:String = "Boonieverse";
      
      private var _path:String;
      
      public function SnapshotUrl(param1:*, param2:int, param3:String, param4:Date = null)
      {
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         super();
         if(this.isBitmapSponsoredCharacter(param2,param1))
         {
            this._path = serverCdnPrefix + "marketing/sponsoredCharacters/" + param1 + "/faceSnap.png";
         }
         else if(this.isExternalServer(param2))
         {
            if(param1 is int || param1 is Number)
            {
               _loc5_ = [param1];
            }
            else
            {
               if(!(param1 is Array))
               {
                  throw Error("Unsupported type for " + param1 + " can only take int or array of int");
               }
               _loc5_ = param1;
            }
            this._path = this.prefix(param2,param3) + fileNameFromIds(_loc5_) + this.postFix(param2);
            if(ForceNoCacheRequired(param2))
            {
               this._path = this._path + "?v=" + Math.random();
            }
         }
         else
         {
            if(param1 is int)
            {
               _loc6_ = param1;
            }
            else
            {
               if(!(param1 is Array && param1.length > 0))
               {
                  throw Error("Unsupported type for " + param1 + " can only take int or array of int");
               }
               _loc6_ = int(param1[0]);
            }
            this._path = serverCdnLocalPrefix + this.localFolderByType(param3) + this.localFileNameFromId(_loc6_) + this.postFix(param2);
         }
         if(param4 != null)
         {
            this._path = this._path + "?v=" + param4.time;
         }
      }
      
      public static function setupServerUrls(param1:String, param2:String) : void
      {
         _externalSnapshotServerUrl = param1 + MSP_SUBPATH + "_" + param2 + "_";
         _externalSnapshotServerUrlBuilder = param1 + RBP_SUBPATH + "_" + param2 + "_";
         _externalSnapshotServerUrlBoonieverse = param1 + BP_SUBPATH + "_" + param2 + "_";
         _externalSnapshotServerUrlPictureUpload = param1 + MSP_SUBPATH + "_" + param2 + "_";
      }
      
      public static function setupSponsoredFunction(param1:Function) : void
      {
         _sponsoredCheck = param1;
      }
      
      private static function ForceNoCacheRequired(param1:int) : Boolean
      {
         return false;
      }
      
      public static function fileNameFromIds(param1:Array) : String
      {
         var _loc3_:int = 0;
         var _loc2_:Array = new Array();
         for each(_loc3_ in param1)
         {
            _loc2_.push(fileNamePartFromId(_loc3_));
         }
         return _loc2_.join("_");
      }
      
      private static function fileNamePartFromId(param1:int) : String
      {
         var _loc2_:String = "" + int(param1 / 1000000000) + "_";
         _loc2_ += int(param1 / 1000000) % 1000 + "_";
         _loc2_ += int(param1 / 1000) % 1000 + "_";
         return _loc2_ + param1 % 1000;
      }
      
      public static function getExternalSnapshotServerUrl() : String
      {
         return _externalSnapshotServerUrl;
      }
      
      private function isBitmapSponsoredCharacter(param1:int, param2:*) : Boolean
      {
         return _sponsoredCheck != null && param1 == MOVIESTAR && Boolean(_sponsoredCheck(param2));
      }
      
      private function localFolderByType(param1:String) : String
      {
         if(param1 == "movie")
         {
            return "movie-snapshots/";
         }
         return "entity-snapshots/" + param1 + "/";
      }
      
      private function localFileNameFromId(param1:int) : String
      {
         var _loc2_:Number = Number(Math.floor(param1 / 10000));
         return _loc2_.toString() + "/" + param1.toString();
      }
      
      private function isExternalServer(param1:int) : Boolean
      {
         switch(param1)
         {
            case LOOK:
            case ROOM:
            case ROOM_MEDIUM:
            case ROOM_PROFILE:
            case MOVIE:
            case MOVIESTAR:
            case ROOM_COMPETITION:
            case SCRAPBLOG:
            case SCRAPBLOG_BIG:
            case FULL_SIZE_MOVIESTAR:
            case FULL_SIZE_LOOK:
            case DESIGN:
            case BUILDERGAME_AVATAR:
            case BUILDERGAME_LEVEL_REPORT:
            case BUILDERGAME_VEHICLE_REPORT:
            case BUILDERGAME_PREFAB_REPORT:
            case BUILDERGAME_ROBOTPART_REPORT:
            case BOONIEVERSE:
            case BOONIEVERSE_SMALL:
            case IMAGE_UPLOAD:
               return this.externalSnapshotServerUrl != null && this.externalSnapshotServerUrl.length > 0;
            default:
               return false;
         }
      }
      
      protected function postFix(param1:int) : String
      {
         switch(param1)
         {
            case BUILDERGAME_AVATAR:
            case BUILDERGAME_LEVEL_REPORT:
            case BUILDERGAME_VEHICLE_REPORT:
            case BUILDERGAME_PREFAB_REPORT:
            case BUILDERGAME_ROBOTPART_REPORT:
            case BOONIEVERSE:
            case BOONIEVERSE_SMALL:
            case DESIGN:
               return ".png";
            default:
               return ".jpg";
         }
      }
      
      private function prefix(param1:int, param2:String) : String
      {
         switch(param1)
         {
            case BUILDERGAME_AVATAR:
            case BUILDERGAME_LEVEL_REPORT:
            case BUILDERGAME_VEHICLE_REPORT:
            case BUILDERGAME_PREFAB_REPORT:
            case BUILDERGAME_ROBOTPART_REPORT:
               return this.externalSnapshotServerUrlBuilder + param2 + "_";
            case BOONIEVERSE:
            case BOONIEVERSE_SMALL:
               return this.externalSnapshotServerUrlBoonieverse + param2 + "_";
            case IMAGE_UPLOAD:
               return this.externalSnapshotServerUrlPictureUpload + param2 + "_";
            default:
               return this.externalSnapshotServerUrl + param2 + "_";
         }
      }
      
      public function toString() : String
      {
         return this.path;
      }
      
      public function get path() : String
      {
         return this._path;
      }
      
      public function allowCodeImport() : Boolean
      {
         return false;
      }
      
      protected function get externalSnapshotServerUrlBuilder() : String
      {
         return _externalSnapshotServerUrlBuilder;
      }
      
      protected function get externalSnapshotServerUrlBoonieverse() : String
      {
         return _externalSnapshotServerUrlBoonieverse;
      }
      
      protected function get externalSnapshotServerUrlPictureUpload() : String
      {
         return _externalSnapshotServerUrlPictureUpload;
      }
      
      protected function get externalSnapshotServerUrl() : String
      {
         return _externalSnapshotServerUrl;
      }
   }
}

