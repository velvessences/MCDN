package com.moviestarplanet.valueObjects
{
   import com.adobe.fiber.core.model_internal;
   
   use namespace model_internal;
   
   public class FriendListItem extends _Super_FriendListItem
   {
      
      _Super_FriendListItem.model_internal::initRemoteClassAliasSingle(FriendListItem);
      
      public function FriendListItem()
      {
         super();
      }
      
      public static function _initRemoteClassAlias() : void
      {
         _Super_FriendListItem.model_internal::initRemoteClassAliasSingle(FriendListItem);
         _Super_FriendListItem.model_internal::initRemoteClassAliasAllRelated();
      }
      
      model_internal static function initRemoteClassAliasSingleChild() : void
      {
         _Super_FriendListItem.model_internal::initRemoteClassAliasSingle(FriendListItem);
      }
   }
}

