package com.moviestarplanet.notifications.delegators
{
   import com.moviestarplanet.notifications.delegatees.IChatNotificationDelegatee;
   
   public interface IChatNotificationDelegator
   {
      
      function registerAsDelegatee(param1:IChatNotificationDelegatee) : void;
      
      function registerAsDelegateeAt(param1:IChatNotificationDelegatee, param2:int) : void;
      
      function unregisterAsDelegatee(param1:IChatNotificationDelegatee) : void;
      
      function destroy() : void;
   }
}

