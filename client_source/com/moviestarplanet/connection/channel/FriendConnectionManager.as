package com.moviestarplanet.connection.channel
{
   import com.moviestarplanet.connection.IComServerConnector;
   import com.moviestarplanet.notification.INotification;
   import com.moviestarplanet.notification.INotificationChannel;
   import com.moviestarplanet.notification.INotificationListener;
   import flash.utils.Dictionary;
   
   public class FriendConnectionManager implements INotificationChannel, IOnlineStatusListener
   {
      
      [Inject]
      public var userConnectionManager:UserConnectionManager;
      
      [Inject]
      public var comServerConnector:IComServerConnector;
      
      [Inject]
      public var notificationListener:INotificationListener;
      
      private var _friendConnections:Dictionary;
      
      public function FriendConnectionManager()
      {
         super();
         this._friendConnections = new Dictionary();
      }
      
      public function disconnect() : void
      {
         this._friendConnections = new Dictionary();
      }
      
      public function closeChannel() : void
      {
         if(this.comServerConnector)
         {
            this.comServerConnector.close();
         }
         this.disconnect();
         if(this.userConnectionManager)
         {
            this.userConnectionManager.close();
         }
      }
      
      public function isChannelReady() : Boolean
      {
         return this.comServerConnector.isConnected;
      }
      
      public function connectToFriend(param1:Number) : void
      {
         var _loc2_:FriendFMSConnection = this.getFriendConnection(param1);
         if(!_loc2_)
         {
            _loc2_ = new FriendFMSConnection(param1,this.comServerConnector.userId,this.comServerConnector,this);
            this._friendConnections[param1] = _loc2_;
         }
         _loc2_.connectSharedObjects();
      }
      
      private function getFriendConnection(param1:Number) : FriendFMSConnection
      {
         return this._friendConnections[param1];
      }
      
      public function disconnectFromFriend(param1:Number) : void
      {
         var _loc2_:FriendFMSConnection = this.getFriendConnection(param1);
         if(_loc2_)
         {
            _loc2_.destroy();
            this._friendConnections[param1] = null;
            delete this._friendConnections[param1];
         }
      }
      
      public function sendNotificationToFriend(param1:Number, param2:INotification) : void
      {
         var _loc3_:FriendFMSConnection = this.getFriendConnection(param1);
         if(_loc3_)
         {
            _loc3_.sendNotificationToFriend(param2);
         }
      }
      
      public function sendNotificationToOnlineFriends(param1:INotification) : void
      {
         var _loc2_:FriendFMSConnection = null;
         for each(_loc2_ in this._friendConnections)
         {
            _loc2_.sendNotificationToFriend(param1);
         }
      }
      
      public function onFriendOnlineStatus(param1:Number, param2:String) : void
      {
         if(param2 == "disconnected")
         {
            delete this._friendConnections[param1];
         }
         this.notificationListener.onFriendOnlineStatus(param1,param2);
      }
      
      public function sendNotificationToNonFriend(param1:int, param2:INotification) : void
      {
         if(this.userConnectionManager != null)
         {
            this.userConnectionManager.sendNotificationToNonFriend(param1,param2);
            return;
         }
         throw new Error("UserConnectionManager must be injected into FriendConnectionManager, change by Emin 14/10-14");
      }
      
      public function isFriendOnline(param1:int) : Boolean
      {
         return true;
      }
   }
}

