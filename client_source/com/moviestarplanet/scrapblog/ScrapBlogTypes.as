package com.moviestarplanet.scrapblog
{
   import flash.geom.Rectangle;
   
   public class ScrapBlogTypes
   {
      
      public static const TEMPLATE:int = 0;
      
      public static const ARTBOOK:int = 1;
      
      public static const NEWS:int = 2;
      
      public static const GROUP_BG:int = 3;
      
      public static const GROUP_LOGO:int = 4;
      
      public static const BIO:int = 5;
      
      public static var sizes:Array = initSizes();
      
      public function ScrapBlogTypes()
      {
         super();
      }
      
      public static function initSizes() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_[TEMPLATE] = null;
         _loc1_[ARTBOOK] = new Rectangle(0,30,980,500 - 30 - 45);
         _loc1_[NEWS] = new Rectangle(0,0,570,500);
         _loc1_[GROUP_BG] = new Rectangle(0,30,980,500 - 30);
         _loc1_[GROUP_LOGO] = new Rectangle(0,0,500,500);
         _loc1_[BIO] = new Rectangle(0,0,980,500);
         return _loc1_;
      }
   }
}

