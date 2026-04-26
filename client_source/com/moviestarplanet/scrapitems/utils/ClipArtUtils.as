package com.moviestarplanet.scrapitems.utils
{
   import com.moviestarplanet.scrapitems.IClipArtInfo;
   
   public class ClipArtUtils
   {
      
      private static var _clipArtCategorySubPaths:Array = ["","stickers/love","stickers/food","stickers/party","stickers/music","stickers/misc","backgrounds/backgrounds","frames/frames","stickers/ornaments","speechbubbles/speechbubbles","stickers/smileys","newsart/newsart","newsbackgrounds/newsbackgrounds","stickers/xmas","doodles/doodles","doodles/letters","doodles/cupcakes","newsbuttons/newsbuttons","patterns/patterns","stickers/halloween","stickers/shapes"];
      
      public function ClipArtUtils()
      {
         super();
      }
      
      public static function clipArtToData(param1:IClipArtInfo) : Object
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:Object = new Object();
         _loc2_.clipArtId = param1.ClipArtId;
         _loc2_.clipArtCategoryId = param1.ClipArtCategoryId;
         _loc2_.FileName = param1.Filename;
         _loc2_.ColorScheme = param1.ColorScheme;
         return _loc2_;
      }
      
      public static function dataToClipArt(param1:Object) : IClipArtInfo
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:ClipArtInfo = new ClipArtInfo();
         _loc2_.ClipArtId = param1.clipArtId;
         _loc2_.ClipArtCategoryId = param1.clipArtCategoryId;
         _loc2_.Filename = param1.FileName;
         if(param1.ColorScheme)
         {
            _loc2_.ColorScheme = param1.ColorScheme;
         }
         return _loc2_;
      }
      
      public static function get clipArtCategorySubPaths() : Array
      {
         return _clipArtCategorySubPaths;
      }
   }
}

