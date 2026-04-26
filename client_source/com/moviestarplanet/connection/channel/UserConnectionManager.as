package com.moviestarplanet.connection.channel
{
   import com.moviestarplanet.connection.IComServerConnector;
   import com.moviestarplanet.notification.INotification;
   import flash.utils.Dictionary;
   
   public class UserConnectionManager implements IOnlineStatusListener
   {
      
      [Inject]
      public var comServerConnector:IComServerConnector;
      
      private var _pendingConnections:Dictionary;
      
      private var _pendingNotes:Dictionary;
      
      public function UserConnectionManager()
      {
         super();
      }
      
      public function sendNotificationToNonFriend(param1:int, param2:INotification) : void
      {
         var _loc3_:FriendFMSConnection = null;
         this.initDictionariesIfNeeded();
         if(this._pendingConnections[param1] == null)
         {
            _loc3_ = new FriendFMSConnection(param1,this.comServerConnector.userId,this.comServerConnector,this);
            this._pendingConnections[param1] = _loc3_;
            this._pendingNotes[param1] = new Vector.<INotification>();
            _loc3_.connectSharedObjects();
         }
         Vector.<INotification>(this._pendingNotes[param1]).push(param2);
      }
      
      private function initDictionariesIfNeeded() : void
      {
         if(this._pendingConnections == null)
         {
            this._pendingConnections = new Dictionary();
            this._pendingNotes = new Dictionary();
         }
      }
      
      public function onFriendOnlineStatus(param1:Number, param2:String) : void
      {
         var _loc4_:INotification = null;
         var _loc3_:FriendFMSConnection = this._pendingConnections[param1];
         if(_loc3_ != null)
         {
            for each(_loc4_ in this._pendingNotes[param1])
            {
               _loc3_.sendNotificationToFriend(_loc4_);
            }
            this._pendingConnections[param1] = null;
            this._pendingNotes[param1] = null;
         }
      }
      
      public function close() : void
      {
         var _loc1_:FriendFMSConnection = null;
         for each(_loc1_ in this._pendingConnections)
         {
            if(_loc1_)
            {
               _loc1_.destroy();
            }
         }
         this._pendingConnections = null;
         this._pendingNotes = null;
      }
      
      public function destroy() : void
      {
         this.close();
         this.comServerConnector = null;
      }
   }
}

