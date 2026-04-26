package com.moviestarplanet.valueObjects
{
   import com.adobe.fiber.core.model_internal;
   
   use namespace model_internal;
   
   public class ClipArtCategoryObject extends _Super_ClipArtCategoryObject
   {
      
      _Super_ClipArtCategoryObject.model_internal::initRemoteClassAliasSingle(ClipArtCategoryObject);
      
      public function ClipArtCategoryObject()
      {
         super();
      }
      
      public static function _initRemoteClassAlias() : void
      {
         _Super_ClipArtCategoryObject.model_internal::initRemoteClassAliasSingle(ClipArtCategoryObject);
         _Super_ClipArtCategoryObject.model_internal::initRemoteClassAliasAllRelated();
      }
      
      model_internal static function initRemoteClassAliasSingleChild() : void
      {
         _Super_ClipArtCategoryObject.model_internal::initRemoteClassAliasSingle(ClipArtCategoryObject);
      }
   }
}

