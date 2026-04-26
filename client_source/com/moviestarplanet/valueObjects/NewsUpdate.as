package com.moviestarplanet.valueObjects
{
   import com.adobe.fiber.core.model_internal;
   
   use namespace model_internal;
   
   public class NewsUpdate extends _Super_NewsUpdate
   {
      
      _Super_NewsUpdate.model_internal::initRemoteClassAliasSingle(NewsUpdate);
      
      public function NewsUpdate()
      {
         super();
      }
      
      public static function _initRemoteClassAlias() : void
      {
         _Super_NewsUpdate.model_internal::initRemoteClassAliasSingle(NewsUpdate);
         _Super_NewsUpdate.model_internal::initRemoteClassAliasAllRelated();
      }
      
      model_internal static function initRemoteClassAliasSingleChild() : void
      {
         _Super_NewsUpdate.model_internal::initRemoteClassAliasSingle(NewsUpdate);
      }
   }
}

