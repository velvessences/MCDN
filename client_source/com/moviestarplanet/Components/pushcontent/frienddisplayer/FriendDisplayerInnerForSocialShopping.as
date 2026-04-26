package com.moviestarplanet.Components.pushcontent.frienddisplayer
{
   import mx.core.ClassFactory;
   import mx.events.FlexEvent;
   
   public class FriendDisplayerInnerForSocialShopping extends FriendDisplayerInner
   {
      
      public function FriendDisplayerInnerForSocialShopping(param1:Object, param2:String = "")
      {
         super(param1,param2);
      }
      
      override protected function this_creationCompleteHandler(param1:FlexEvent) : void
      {
         list.itemRenderer = new ClassFactory(FriendDisplayerListItemForSocialShopping);
         super.btn_Invite.visible = false;
         super.btn_Invite.includeInLayout = false;
      }
   }
}

