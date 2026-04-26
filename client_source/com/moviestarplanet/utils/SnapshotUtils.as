package com.moviestarplanet.utils
{
   import com.moviestarplanet.services.snapshotservice.SnapshotAmfService;
   import com.moviestarplanet.utils.displayobject.DisplayConverter;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import mx.graphics.codec.PNGEncoder;
   
   public class SnapshotUtils
   {
      
      private static var initialMovieStarSnapshotDate:Date;
      
      public static const FULLSIZE_MOVIESTAR:String = "fullSizeMovieStar";
      
      public static const MOVIESTAR:String = "moviestar";
      
      public static const FULLSIZE_LOOK:String = "fullSizeLook";
      
      public static var serverCdnPrefix:String = "";
      
      public function SnapshotUtils()
      {
         super();
      }
      
      private static function getSnapshotSourcePathLocalDisc(param1:String, param2:Number) : String
      {
         var _loc3_:Number = Number(Math.floor(param2 / 10000));
         if(param1 == "movie")
         {
            return serverCdnPrefix + "movie-snapshots/" + _loc3_.toString() + "/" + param2.toString() + ".jpg";
         }
         return serverCdnPrefix + "entity-snapshots/" + param1 + "/" + _loc3_.toString() + "/" + param2.toString() + ".jpg";
      }
      
      public static function getSnapshotSourcePath(param1:String, param2:Number) : String
      {
         return getSnapshotSourcePathLocalDisc(param1,param2);
      }
      
      private static function getSnapshotCompetitionSourcePathLocalDisc(param1:String, param2:Number, param3:Number) : String
      {
         return serverCdnPrefix + "entity-snapshots/" + param1 + "/" + param2.toString() + "/" + param3.toString() + ".jpg";
      }
      
      public static function getSnapshotCompetitionSourcePath(param1:String, param2:Number, param3:Number) : String
      {
         return getSnapshotCompetitionSourcePathLocalDisc(param1,param2,param3);
      }
      
      private static function fullBodySetup(param1:DisplayObject, param2:Rectangle, param3:int, param4:Boolean, param5:Number) : BitmapData
      {
         if(param2 == null)
         {
            param2 = param1.getBounds(param1);
         }
         var _loc6_:BitmapData = new BitmapData(param2.width * param5,param2.height * param5,param4,param3);
         var _loc7_:Matrix = new Matrix();
         _loc7_.translate(-param2.x,-param2.y);
         _loc7_.scale(param5,param5);
         _loc6_.draw(param1,_loc7_);
         return _loc6_;
      }
      
      public static function getFullBodyPngShot(param1:DisplayObject, param2:Rectangle = null) : ByteArray
      {
         var _loc3_:Bitmap = DisplayConverter.spriteToScaledBitmap(param1 as Sprite,param1.getBounds(param1),1,true,true);
         return new PNGEncoder().encode(_loc3_.bitmapData);
      }
      
      public static function saveSnapshot(param1:int, param2:String, param3:Number, param4:ByteArray, param5:String, param6:Function = null) : void
      {
         SnapshotAmfService.SaveSnapshotInAWS(param1,param3,param2,param5,param4);
         if(param6 != null)
         {
            param6();
         }
      }
      
      public static function saveSnapshotNew(param1:int, param2:String, param3:Array, param4:ByteArray, param5:String, param6:Function = null) : void
      {
         SnapshotAmfService.SaveSnapshotInAWSNew(param1,param3,param2,param5,param4,param6);
      }
      
      public static function getInitialMovieStarSnapshotDate() : Date
      {
         if(initialMovieStarSnapshotDate == null)
         {
            initialMovieStarSnapshotDate = new Date();
         }
         return initialMovieStarSnapshotDate;
      }
      
      public static function clearInitialMovieStarSnapshotDate() : void
      {
         initialMovieStarSnapshotDate = null;
      }
   }
}

