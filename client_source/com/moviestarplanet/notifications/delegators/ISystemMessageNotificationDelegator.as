package com.moviestarplanet.notifications.delegators
{
   import com.moviestarplanet.notifications.delegatees.ISystemMessageNotificationDelegatee;
   
   public interface ISystemMessageNotificationDelegator
   {
      
      function registerAsDelegatee(param1:ISystemMessageNotificationDelegatee) : void;
      
      function registerAsDelegateeAt(param1:ISystemMessageNotificationDelegatee, param2:int) : void;
      
      function unregisterAsDelegatee(param1:ISystemMessageNotificationDelegatee) : void;
      
      function destroy() : void;
   }
}

