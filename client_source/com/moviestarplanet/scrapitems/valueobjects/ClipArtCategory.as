package com.moviestarplanet.scrapitems.valueobjects
{
   public class ClipArtCategory
   {
      
      private static var _clipArtCategorySubPaths:Array = ["","stickers/love","stickers/food","stickers/party","stickers/music","stickers/misc","backgrounds/backgrounds","frames/frames","stickers/ornaments","speechbubbles/speechbubbles","stickers/smileys","newsart/newsart","newsbackgrounds/newsbackgrounds","stickers/xmas","doodles/doodles","doodles/letters","doodles/cupcakes","newsbuttons/newsbuttons","patterns/patterns","stickers/halloween","stickers/shapes"];
      
      public var ClipArtCategoryId:int;
      
      public var Name:String;
      
      public var ClipArtTypeId:int;
      
      public var ClipArtType:com.moviestarplanet.scrapitems.valueobjects.ClipArtType;
      
      public function ClipArtCategory()
      {
         super();
      }
      
      public static function get clipArtCategorySubPaths() : Array
      {
         return _clipArtCategorySubPaths;
      }
   }
}

