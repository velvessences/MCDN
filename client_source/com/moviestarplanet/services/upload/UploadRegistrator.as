package com.moviestarplanet.services.upload
{
   import com.moviestarplanet.commoninterfaces.IRegistrator;
   import com.moviestarplanet.media.valueobjects.AnimationCategory;
   import com.moviestarplanet.services.shopcontentservice.valueObjects.ClothUpdater;
   import com.moviestarplanet.services.shopcontentservice.valueObjects.Tag;
   import com.moviestarplanet.valueObjects.ClipArtCategoryObject;
   import com.moviestarplanet.valueObjects.ClipArtTypeObject;
   import flash.net.registerClassAlias;
   
   public class UploadRegistrator implements IRegistrator
   {
      
      private static var hasRegistered:Boolean = false;
      
      public function UploadRegistrator()
      {
         super();
      }
      
      public function registerClassAliases() : void
      {
         registerClassAlias("MovieStarPlanet.WebService.Upload.ClipArtService+ClipArtTypeObject",ClipArtTypeObject);
         registerClassAlias("MovieStarPlanet.WebService.Upload.ClipArtService+ClipArtCategoryObject",ClipArtCategoryObject);
         registerClassAlias("MovieStarPlanet.WebService.Upload.ClipArtService+AnimationCategory",AnimationCategory);
         registerClassAlias("MovieStarPlanet.DBML.ClothUpdater",ClothUpdater);
         registerClassAlias("MovieStarPlanet.DBML.Tag",Tag);
         hasRegistered = true;
      }
   }
}

