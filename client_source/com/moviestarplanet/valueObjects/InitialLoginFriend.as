package com.moviestarplanet.valueObjects
{
   import com.adobe.fiber.core.model_internal;
   
   use namespace model_internal;
   
   public class InitialLoginFriend extends _Super_InitialLoginFriend
   {
      
      _Super_InitialLoginFriend.model_internal::initRemoteClassAliasSingle(InitialLoginFriend);
      
      public function InitialLoginFriend()
      {
         super();
      }
      
      public static function _initRemoteClassAlias() : void
      {
         _Super_InitialLoginFriend.model_internal::initRemoteClassAliasSingle(InitialLoginFriend);
         _Super_InitialLoginFriend.model_internal::initRemoteClassAliasAllRelated();
      }
      
      model_internal static function initRemoteClassAliasSingleChild() : void
      {
         _Super_InitialLoginFriend.model_internal::initRemoteClassAliasSingle(InitialLoginFriend);
      }
   }
}

