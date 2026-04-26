package com.moviestarplanet.valueObjects
{
   import com.adobe.fiber.core.model_internal;
   
   use namespace model_internal;
   
   public class ClipArtTypeObject extends _Super_ClipArtTypeObject
   {
      
      _Super_ClipArtTypeObject.model_internal::initRemoteClassAliasSingle(ClipArtTypeObject);
      
      public function ClipArtTypeObject()
      {
         super();
      }
      
      public static function _initRemoteClassAlias() : void
      {
         _Super_ClipArtTypeObject.model_internal::initRemoteClassAliasSingle(ClipArtTypeObject);
         _Super_ClipArtTypeObject.model_internal::initRemoteClassAliasAllRelated();
      }
      
      model_internal static function initRemoteClassAliasSingleChild() : void
      {
         _Super_ClipArtTypeObject.model_internal::initRemoteClassAliasSingle(ClipArtTypeObject);
      }
   }
}

