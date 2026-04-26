package com.moviestarplanet.Components.pushcontent.frienddisplayer
{
   import com.moviestarplanet.Components.Friends.FriendshipManager;
   import com.moviestarplanet.Components.Friends.MyOnlineFriendsItem;
   import com.moviestarplanet.Components.pushcontent.utils.FriendDisplayerEvent;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.globalsharedutils.SnapshotUrl;
   import com.moviestarplanet.model.friends.IFriend;
   import com.moviestarplanet.utils.EntityTypeType;
   import flash.events.MouseEvent;
   
   public class FriendDisplayerListItemForSocialShopping extends MyOnlineFriendsItem
   {
      
      private static var invitedFriends:Array = new Array();
      
      public function FriendDisplayerListItemForSocialShopping()
      {
         super();
      }
      
      public static function friendHasBeenInvited(param1:int) : Boolean
      {
         if(invitedFriends.indexOf(param1) < 0)
         {
            return false;
         }
         return true;
      }
      
      public static function addFriendToInvitedList(param1:int) : void
      {
         invitedFriends.push(param1);
      }
      
      public static function clearInvitedFriends() : void
      {
         invitedFriends = new Array();
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1 != null)
         {
            super.data = param1;
            super.lbl_Name.text = (data.friend as IFriend).name;
            super.img_Snapshot.source = new SnapshotUrl((data.friend as IFriend).userId,EntityTypeType.MOVIESTAR,"moviestar").toString();
            super.img_ChatBubble.width = 23;
            super.img_ChatBubble.height = 23;
            super.img_ChatBubble.y = 3;
            if(!super.data.isClicked)
            {
               this.activate();
            }
         }
         super.cnv_SnapshotAndText.removeEventListener(MouseEvent.CLICK,super.cnv_SnapshotAndText_ClickHandler);
      }
      
      private function activate() : void
      {
         if(friendHasBeenInvited((data.friend as IFriend).userId) == false)
         {
            super.img_ChatBubble.source = Config.toAbsoluteURL("swf/Icons/push/PushFriends2.swf",Config.LOCAL_CDN_URL);
         }
         else
         {
            super.img_ChatBubble.source = Config.toAbsoluteURL("swf/Icons/ChatRoom/friendInvited_icon.swf",Config.LOCAL_CDN_URL);
         }
         super.img_ChatBubble.useHandCursor = true;
         super.img_ChatBubble.buttonMode = true;
         super.img_ChatBubble.glowEffect.alphaTo = 1;
      }
      
      override protected function img_ChatBubble_ClickHandler() : void
      {
         if(!super.data.isClicked)
         {
            FriendshipManager.getInstance().sendLegacyObjectEventToFriend(super.data.activityObj,(super.data.friend as IFriend).userId);
            super.data.isClicked = true;
            MessageCommunicator.sendMessage(MSPEvent.SOCIAL_SHOPPING_INVITE_FRIEND,(super.data.friend as IFriend).userId);
         }
         MessageCommunicator.sendMessage(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_SOCIALSHOPPING,null);
      }
   }
}

