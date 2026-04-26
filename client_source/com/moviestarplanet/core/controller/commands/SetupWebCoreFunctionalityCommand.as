package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.controller.NotificationController;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.model.FriendList;
   import com.moviestarplanet.model.contentJoiner.ContentFriendlistJoiner;
   import com.moviestarplanet.model.friends.IContentFriendlistJoiner;
   import com.moviestarplanet.model.friends.IFriendList;
   import com.moviestarplanet.model.notification.NotificationFactory;
   import com.moviestarplanet.notification.INotificationBroadcaster;
   import com.moviestarplanet.notification.INotificationFactory;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class SetupWebCoreFunctionalityCommand
   {
      
      private var webEventDispatcher:IEventDispatcher;
      
      public function SetupWebCoreFunctionalityCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         this.webEventDispatcher = new EventDispatcher();
         InjectionManager.mapper().map(IEventDispatcher).toValue(this.webEventDispatcher);
         InjectionManager.mapper().map(INotificationBroadcaster).toSingleton(NotificationController);
         InjectionManager.mapper().map(IContentFriendlistJoiner).toSingleton(ContentFriendlistJoiner);
         InjectionManager.mapper().map(IFriendList).toSingleton(FriendList);
         InjectionManager.mapper().map(INotificationFactory).toSingleton(NotificationFactory);
      }
   }
}

