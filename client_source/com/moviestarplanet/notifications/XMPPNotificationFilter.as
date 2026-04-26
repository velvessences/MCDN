package com.moviestarplanet.notifications
{
   import com.moviestarplanet.model.friends.IFriendList;
   import com.moviestarplanet.model.notification.NotificationType;
   import com.moviestarplanet.notification.INotification;
   
   public class XMPPNotificationFilter
   {
      
      private const requiredNotificationTypes:Array = [NotificationType.FRIENDREQ_RECEIVED.type,NotificationType.SERVER_NUDGE.type];
      
      [Inject]
      public var friendList:IFriendList;
      
      [Inject(name="AllowedNonFriendCommunication")]
      public var appSetting:String;
      
      private var _types:Array;
      
      public function XMPPNotificationFilter()
      {
         super();
      }
      
      public function isNotificationAllowed(param1:INotification) : Boolean
      {
         if(this.friendList.getFriendById(param1.actorId) != null)
         {
            return true;
         }
         var _loc2_:Array = this.getTypes();
         return _loc2_.indexOf(param1.type) >= 0;
      }
      
      private function getTypes() : Array
      {
         if(this._types == null)
         {
            this._types = this.appSetting.split(";");
            this._types = this._types.concat(this.requiredNotificationTypes);
         }
         return this._types;
      }
   }
}

class SingletonBlocker
{
   
   public function SingletonBlocker()
   {
      super();
   }
}
