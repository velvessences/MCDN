package com.moviestarplanet.notifications.delegators
{
   import com.moviestarplanet.model.notification.NotificationType;
   import com.moviestarplanet.notification.INotification;
   import com.moviestarplanet.notification.INotificationBroadcaster;
   import com.moviestarplanet.notification.INotificationChatObject;
   import com.moviestarplanet.notification.INotificationListener;
   import com.moviestarplanet.notifications.delegatees.IChatNotificationDelegatee;
   
   public class ChatNotificationDelegator implements INotificationListener, IChatNotificationDelegator
   {
      
      private var _notificationBroadcaster:INotificationBroadcaster;
      
      private var delegatees:Vector.<IChatNotificationDelegatee>;
      
      public function ChatNotificationDelegator()
      {
         super();
         this.delegatees = new Vector.<IChatNotificationDelegatee>();
      }
      
      public function onNotification(param1:INotification) : void
      {
         if(param1.notificationObject is INotificationChatObject)
         {
            this.delegate(param1);
            return;
         }
         switch(param1.type)
         {
            case NotificationType.CHAT_TYPE.type:
               this.delegate(param1);
         }
      }
      
      private function delegate(param1:INotification) : void
      {
         var _loc2_:Boolean = true;
         var _loc3_:int = 0;
         while(_loc3_ < this.delegatees.length && _loc2_)
         {
            _loc2_ = this.delegatees[_loc3_].onChatNotification(param1);
            _loc3_++;
         }
      }
      
      public function onFriendOnlineStatus(param1:Number, param2:String) : void
      {
      }
      
      public function registerAsDelegatee(param1:IChatNotificationDelegatee) : void
      {
         this.delegatees.push(param1);
      }
      
      public function registerAsDelegateeAt(param1:IChatNotificationDelegatee, param2:int) : void
      {
         this.delegatees.splice(param2,0,param1);
      }
      
      public function unregisterAsDelegatee(param1:IChatNotificationDelegatee) : void
      {
         if(this.delegatees == null)
         {
            return;
         }
         var _loc2_:int = int(this.delegatees.indexOf(param1));
         if(_loc2_ >= 0)
         {
            this.delegatees.splice(_loc2_,1);
         }
      }
      
      public function set notificationBroadcaster(param1:INotificationBroadcaster) : void
      {
         this._notificationBroadcaster = param1;
         this._notificationBroadcaster.listenForNotifications(this);
      }
      
      public function destroy() : void
      {
         if(this._notificationBroadcaster != null)
         {
            this._notificationBroadcaster.stopListening(this);
            this._notificationBroadcaster = null;
         }
         if(this.delegatees != null)
         {
            this.delegatees.length = 0;
            this.delegatees = null;
         }
      }
   }
}

