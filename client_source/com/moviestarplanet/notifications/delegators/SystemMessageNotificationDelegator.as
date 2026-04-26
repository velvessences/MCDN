package com.moviestarplanet.notifications.delegators
{
   import com.moviestarplanet.model.notification.NotificationType;
   import com.moviestarplanet.notification.INotification;
   import com.moviestarplanet.notification.INotificationBroadcaster;
   import com.moviestarplanet.notification.INotificationListener;
   import com.moviestarplanet.notification.INotificationSystemMessageObject;
   import com.moviestarplanet.notifications.delegatees.ISystemMessageNotificationDelegatee;
   
   public class SystemMessageNotificationDelegator implements INotificationListener, ISystemMessageNotificationDelegator
   {
      
      private var _notificationBroadcaster:INotificationBroadcaster;
      
      private var delegatees:Vector.<ISystemMessageNotificationDelegatee>;
      
      public function SystemMessageNotificationDelegator()
      {
         super();
         this.delegatees = new Vector.<ISystemMessageNotificationDelegatee>();
      }
      
      public function onNotification(param1:INotification) : void
      {
         if(param1.notificationObject is INotificationSystemMessageObject)
         {
            this.delegate(param1);
            return;
         }
         switch(param1.type)
         {
            case NotificationType.AUTOGRAPH.type:
               this.delegate(param1);
         }
      }
      
      private function delegate(param1:INotification) : void
      {
         var _loc2_:Boolean = true;
         var _loc3_:int = 0;
         while(_loc3_ < this.delegatees.length && _loc2_)
         {
            _loc2_ = this.delegatees[_loc3_].onSystemMessageNotification(param1);
            _loc3_++;
         }
      }
      
      public function onFriendOnlineStatus(param1:Number, param2:String) : void
      {
      }
      
      public function registerAsDelegatee(param1:ISystemMessageNotificationDelegatee) : void
      {
         this.delegatees.push(param1);
      }
      
      public function registerAsDelegateeAt(param1:ISystemMessageNotificationDelegatee, param2:int) : void
      {
         this.delegatees.splice(param2,0,param1);
      }
      
      public function unregisterAsDelegatee(param1:ISystemMessageNotificationDelegatee) : void
      {
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

