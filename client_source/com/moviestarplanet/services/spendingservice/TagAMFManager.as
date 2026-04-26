package com.moviestarplanet.services.spendingservice
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.services.shopcontentservice.valueObjects.Tag;
   
   public class TagAMFManager
   {
      
      private static var amfCaller:AmfCaller = new AmfCaller("MovieStarPlanet.WebService.TagManager.AMFTagManager");
      
      public function TagAMFManager()
      {
         super();
      }
      
      public static function saveTag(param1:Tag, param2:Function) : void
      {
         amfCaller.callFunction("SaveTag",[param1],true,param2);
      }
      
      public static function deleteTag(param1:Tag, param2:Function) : void
      {
         amfCaller.callFunction("DeleteTag",[param1],true,param2);
      }
      
      public static function getAllTags(param1:Function) : void
      {
         amfCaller.callFunction("GetAllTags",[],true,param1);
      }
      
      public static function GetTagsInCategorySkin(param1:Function, param2:int, param3:int) : void
      {
         amfCaller.callFunction("GetTagsInCategorySkin",[param2,param3],true,param1);
      }
      
      public static function getTagsForSkin(param1:Function, param2:int) : void
      {
         amfCaller.callFunction("GetTagsForSkinClothes",[param2],true,param1);
      }
      
      public static function getBackgroundTags(param1:Function) : void
      {
         amfCaller.callFunction("GetBackgroundTags",[],true,param1);
      }
   }
}

