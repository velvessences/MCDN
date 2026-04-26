package com.moviestarplanet.friends.notifications
{
   import com.moviestarplanet.connection.channel.FriendConnectionManager;
   import com.moviestarplanet.notification.INotification;
   import com.moviestarplanet.notification.INotificationChannel;
   import com.moviestarplanet.xmppConnection.channel.FriendNotificationChannel;
   
   public class DualBandNotificationChannel implements INotificationChannel
   {
      
      private var fmsChannel:FriendConnectionManager;
      
      private var xmppChannel:FriendNotificationChannel;
      
      public function DualBandNotificationChannel(param1:FriendConnectionManager, param2:FriendNotificationChannel)
      {
         super();
         this.fmsChannel = param1;
         this.xmppChannel = param2;
      }
      
      public function closeChannel() : void
      {
         this.fmsChannel.closeChannel();
         if(this.isXMPPWorking)
         {
            this.xmppChannel.closeChannel();
         }
      }
      
      public function connectToFriend(param1:Number) : void
      {
         this.fmsChannel.connectToFriend(param1);
         if(this.isXMPPWorking)
         {
            this.xmppChannel.connectToFriend(param1);
         }
      }
      
      public function disconnect() : void
      {
         this.fmsChannel.disconnect();
         if(this.isXMPPWorking)
         {
            this.xmppChannel.disconnect();
         }
      }
      
      public function disconnectFromFriend(param1:Number) : void
      {
         this.fmsChannel.disconnectFromFriend(param1);
         if(this.isXMPPWorking)
         {
            this.xmppChannel.disconnectFromFriend(param1);
         }
      }
      
      public function isChannelReady() : Boolean
      {
         return this.fmsChannel.isChannelReady();
      }
      
      public function sendNotificationToFriend(param1:Number, param2:INotification) : void
      {
         this.fmsChannel.sendNotificationToFriend(param1,param2);
         if(this.isXMPPWorking)
         {
            this.xmppChannel.sendNotificationToFriend(param1,param2);
         }
      }
      
      public function sendNotificationToNonFriend(param1:int, param2:INotification) : void
      {
         this.fmsChannel.sendNotificationToNonFriend(param1,param2);
         if(this.isXMPPWorking)
         {
            this.xmppChannel.sendNotificationToNonFriend(param1,param2);
         }
      }
      
      public function sendNotificationToOnlineFriends(param1:INotification) : void
      {
         this.fmsChannel.sendNotificationToOnlineFriends(param1);
         if(this.isXMPPWorking)
         {
            this.xmppChannel.sendNotificationToOnlineFriends(param1);
         }
      }
      
      private function get isXMPPWorking() : Boolean
      {
         return this.xmppChannel.isChannelReady();
      }
      
      public function getXMPPChannel() : FriendNotificationChannel
      {
         return this.xmppChannel;
      }
      
      public function isFriendOnline(param1:int) : Boolean
      {
         return true;
      }
   }
}

