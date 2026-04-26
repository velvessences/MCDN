package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.chat.ChatChannel;
   import com.moviestarplanet.configurations.AppSettings;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.friends.notifications.DualBandNotificationChannel;
   import com.moviestarplanet.groupchat.helpers.*;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.messaging.module.moduleparts.control.MessagingFacade;
   import com.moviestarplanet.msgservice.IMsgService;
   import com.moviestarplanet.notification.INotificationChannel;
   import com.moviestarplanet.notification.INotificationListener;
   import com.moviestarplanet.xmppConnection.XMPPStatus;
   import com.moviestarplanet.xmppConnection.channel.FriendNotificationChannel;
   import com.moviestarplanet.xmppConnection.channel.GroupChatChannel;
   import com.moviestarplanet.xmppConnection.channel.helpers.GroupChatChannelConnectionMonitor;
   
   public class SetupGroupChatCommand
   {
      
      private static var isInitialized:Boolean = false;
      
      public function SetupGroupChatCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         if(isInitialized)
         {
            return;
         }
         isInitialized = true;
         this.setupGroupChatChannel();
         if(AppSettings.getInstance().getSetting(AppSettings.USE_OLD_MESSAGES_LIST) == "true")
         {
            MessagingFacade.GROUPCHAT_ENABLED = false;
         }
         else
         {
            MessagingFacade.GROUPCHAT_ENABLED = true;
         }
      }
      
      private function setupGroupChatChannel() : void
      {
         var _loc1_:GroupChatChannel = this.instantiateGroupChatChannel();
         GroupChatChannel.DEBUG_ON = Config.IsRunningInDevelopment;
         var _loc2_:INotificationChannel = InjectionManager.mapper().getInstance(INotificationChannel);
         var _loc3_:GroupChatChannelConnectionMonitor = new GroupChatChannelConnectionMonitor(_loc2_,_loc1_);
         InjectionManager.mapper().map(GroupChatChannelConnectionMonitor).toValue(_loc3_);
      }
      
      private function retrieveUserConversationStates() : void
      {
         var _loc1_:IMsgService = null;
         if(InjectionManager.mapper().satisfies(IMsgService))
         {
            _loc1_ = InjectionManager.mapper().getInstance(IMsgService);
            _loc1_.getUserConversationStates(this.getUserConversationStatesSuccess,this.getUserConversationStatesFail);
         }
      }
      
      private function getUserConversationStatesSuccess(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.initActiveGroupConversations(param1.ActiveGroupConversations);
         this.initMutedConversations(param1.MutedConversations);
      }
      
      private function getUserConversationStatesFail() : void
      {
         throw new Error("Initial conversation states not found");
      }
      
      private function initActiveGroupConversations(param1:Array) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:ChatChannel = InjectionManager.mapper().getInstance(ChatChannel);
         _loc2_.joinPrioritizedConversations(param1);
      }
      
      private function initMutedConversations(param1:Array) : void
      {
         if(!param1)
         {
            return;
         }
         MutedConversations.getInstance().setMutedConversationIds(param1);
      }
      
      private function instantiateGroupChatChannel() : GroupChatChannel
      {
         var _loc1_:INotificationChannel = InjectionManager.mapper().getInstance(INotificationChannel);
         var _loc2_:FriendNotificationChannel = null;
         var _loc3_:GroupChatChannel = null;
         if(_loc1_ is FriendNotificationChannel)
         {
            _loc2_ = _loc1_ as FriendNotificationChannel;
         }
         else if(_loc1_ is DualBandNotificationChannel)
         {
            _loc2_ = (_loc1_ as DualBandNotificationChannel).getXMPPChannel();
         }
         var _loc4_:INotificationListener = InjectionManager.mapper().getInstance(INotificationListener);
         _loc3_ = new GroupChatChannel(_loc2_.connection,_loc2_.country,XMPPStatus.xmppUseLocalhost,_loc4_,_loc2_.conferenceServer);
         InjectionManager.mapper().map(GroupChatChannel).toValue(_loc3_);
         this.retrieveUserConversationStates();
         return _loc3_;
      }
   }
}

