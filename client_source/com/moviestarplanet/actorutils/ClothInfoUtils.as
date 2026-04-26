package com.moviestarplanet.actorutils
{
   import com.moviestarplanet.actor.IClothInfo;
   
   public class ClothInfoUtils
   {
      
      public static var categoryInfo:ICategoryInfo;
      
      public function ClothInfoUtils()
      {
         super();
      }
      
      public static function isImage(param1:IClothInfo) : Boolean
      {
         return param1.Filename != null && param1.Filename.length > 0;
      }
      
      public static function getRealSwfName(param1:IClothInfo) : String
      {
         if(isImage(param1))
         {
            return param1.Filename;
         }
         return param1.SWF + ".swf";
      }
      
      public static function getPath(param1:IClothInfo) : String
      {
         return categoryInfo.GetCategorySubPath(param1.ClothesCategoryId) + getRealSwfName(param1);
      }
   }
}

