package com.moviestarplanet.valueObjects
{
   import com.adobe.fiber.core.model_internal;
   
   use namespace model_internal;
   
   public class PagedLocaleResourceList extends _Super_PagedLocaleResourceList
   {
      
      _Super_PagedLocaleResourceList.model_internal::initRemoteClassAliasSingle(PagedLocaleResourceList);
      
      public function PagedLocaleResourceList()
      {
         super();
      }
      
      public static function _initRemoteClassAlias() : void
      {
         _Super_PagedLocaleResourceList.model_internal::initRemoteClassAliasSingle(PagedLocaleResourceList);
         _Super_PagedLocaleResourceList.model_internal::initRemoteClassAliasAllRelated();
      }
      
      model_internal static function initRemoteClassAliasSingleChild() : void
      {
         _Super_PagedLocaleResourceList.model_internal::initRemoteClassAliasSingle(PagedLocaleResourceList);
      }
   }
}

