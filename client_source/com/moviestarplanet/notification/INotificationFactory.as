package com.moviestarplanet.notification
{
   public interface INotificationFactory
   {
      
      function fromObject(param1:Object) : INotification;
      
      function fromString(param1:String) : INotification;
      
      function generateNotificationWithStrictType(param1:INotificationObject) : INotification;
      
      function generateMyNotification(param1:String) : INotification;
      
      function generateMyNotificationFromObject(param1:Object) : INotification;
   }
}

