package com.moviestarplanet.friends.notifications
{
   import com.moviestarplanet.Components.Friends.FriendshipManager;
   import com.moviestarplanet.chat.ChatChannel;
   import com.moviestarplanet.chat.ChatListener;
   import com.moviestarplanet.chatutils.ComServerConnector;
   import com.moviestarplanet.configurations.AppSettings;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.connection.IComServerConnector;
   import com.moviestarplanet.connection.channel.FriendConnectionManager;
   import com.moviestarplanet.connection.channel.UserConnectionManager;
   import com.moviestarplanet.events.ComChannelEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.notification.INotificationChannel;
   import com.moviestarplanet.notification.INotificationListener;
   import com.moviestarplanet.notifications.XMPPNotificationFilter;
   import com.moviestarplanet.notifications.delegators.ChatNotificationDelegator;
   import com.moviestarplanet.notifications.delegators.IChatNotificationDelegator;
   import com.moviestarplanet.notifications.delegators.ISystemMessageNotificationDelegator;
   import com.moviestarplanet.notifications.delegators.SystemMessageNotificationDelegator;
   import com.moviestarplanet.utils.net.ComServerMessenger;
   import com.moviestarplanet.xmppConnection.XMPPStatus;
   import com.moviestarplanet.xmppConnection.channel.FriendNotificationChannel;
   import robotlegs.bender.extensions.commandCenter.api.ICommand;
   
   public class SetupNotificationsCommand implements ICommand
   {
      
      public static const FMS_INITIALIZED:String = "SetupNotificationsCommand.ON_FMS_INITIALIZED";
      
      private var _xmppFeatureState:String;
      
      private var _allowedNonFriendCommunication:String;
      
      public function SetupNotificationsCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         this._xmppFeatureState = AppSettings.getInstance().getSetting(AppSettings.XMPP_STATUS);
         this._allowedNonFriendCommunication = AppSettings.getInstance().getSetting(AppSettings.ALLOWED_NON_FRIEND_COMMUNICATION);
         XMPPStatus.xmppUseLocalhost = AppSettings.getInstance().getSetting(AppSettings.XMPP_USE_LOCALHOST) != "false";
         this.setup();
      }
      
      private function setup() : void
      {
         switch(this._xmppFeatureState)
         {
            case "AMS":
               XMPPStatus.currentXMPPStatus = XMPPStatus.XMPP_STATUS_AMS;
               break;
            case "AMS+XMPP":
               XMPPStatus.currentXMPPStatus = XMPPStatus.XMPP_STATUS_DUAL_MODE;
               break;
            case "XMPP":
               XMPPStatus.currentXMPPStatus = XMPPStatus.XMPP_STATUS_XMPP_ONLY;
               break;
            default:
               XMPPStatus.currentXMPPStatus = XMPPStatus.XMPP_STATUS_AMS;
         }
         this.setupNotifications();
      }
      
      private function setupNotifications() : void
      {
         switch(XMPPStatus.currentXMPPStatus)
         {
            case XMPPStatus.XMPP_STATUS_AMS:
               this.setupAMSOnly();
               break;
            case XMPPStatus.XMPP_STATUS_DUAL_MODE:
               this.setupDualMode();
               break;
            case XMPPStatus.XMPP_STATUS_XMPP_ONLY:
               this.setupXMPPOnly();
               break;
            default:
               this.setupAMSOnly();
         }
         this.postInitialization();
      }
      
      private function postInitialization() : void
      {
         this.broadcastComChannelInitialized();
      }
      
      private function broadcastComChannelInitialized() : void
      {
         switch(XMPPStatus.currentXMPPStatus)
         {
            case XMPPStatus.XMPP_STATUS_AMS:
               MessageCommunicator.send(new MsgEvent(FMS_INITIALIZED));
               break;
            case XMPPStatus.XMPP_STATUS_DUAL_MODE:
               MessageCommunicator.send(new MsgEvent(FMS_INITIALIZED));
               break;
            case XMPPStatus.XMPP_STATUS_XMPP_ONLY:
               MessageCommunicator.send(new ComChannelEvent(ComChannelEvent.COMCHANNEL_INITIALIZED));
               break;
            default:
               MessageCommunicator.send(new MsgEvent(FMS_INITIALIZED));
         }
      }
      
      private function setupAMSOnly() : void
      {
         InjectionManager.mapper().map(IComServerConnector).toSingleton(ComServerConnector);
         InjectionManager.mapper().map(INotificationListener).toSingleton(WebNotificationListener);
         InjectionManager.mapper().map(UserConnectionManager).asSingleton();
         InjectionManager.mapper().map(INotificationChannel).toSingleton(FriendConnectionManager);
         var _loc1_:INotificationListener = InjectionManager.mapper().getInstance(INotificationListener);
         ComServerMessenger.notificationListener = _loc1_;
         var _loc2_:INotificationChannel = InjectionManager.mapper().getInstance(INotificationChannel);
         FriendshipManager.getInstance().notificationChannel = _loc2_;
         ComServerMessenger.notificationChannel = _loc2_;
      }
      
      private function setupDualMode() : void
      {
         XMPPLifeHandler.getInstance().hookup();
         var _loc1_:DummyNotificationListener = new DummyNotificationListener();
         InjectionManager.mapper().map(String,"AllowedNonFriendCommunication").toValue(this._allowedNonFriendCommunication);
         InjectionManager.mapper().map(XMPPNotificationFilter).asSingleton();
         var _loc2_:FriendNotificationChannel = new FriendNotificationChannel();
         _loc2_.notificationListener = _loc1_;
         XMPPLifeHandler.getInstance().channel = _loc2_;
         XMPPLifeHandler.getInstance().country = Config.GetCountry;
         InjectionManager.mapper().map(INotificationListener).toSingleton(WebNotificationListener);
         var _loc3_:INotificationListener = InjectionManager.mapper().getInstance(INotificationListener);
         ComServerMessenger.notificationListener = _loc3_;
         InjectionManager.mapper().map(IComServerConnector).toSingleton(ComServerConnector);
         InjectionManager.mapper().map(UserConnectionManager).asSingleton();
         var _loc4_:FriendConnectionManager = new FriendConnectionManager();
         InjectionManager.mapper().injectInto(_loc4_);
         var _loc5_:INotificationChannel = new DualBandNotificationChannel(_loc4_,_loc2_);
         InjectionManager.mapper().map(INotificationChannel).toValue(_loc5_);
         var _loc6_:INotificationChannel = InjectionManager.mapper().getInstance(INotificationChannel);
         var _loc7_:XMPPNotificationFilter = InjectionManager.mapper().getInstance(XMPPNotificationFilter);
         _loc2_.xmppNotificationFilter = _loc7_;
         FriendshipManager.getInstance().notificationChannel = _loc6_;
         ComServerMessenger.notificationChannel = _loc6_;
         InjectionManager.mapper().map(ChatChannel).asSingleton();
         InjectionManager.mapper().map(ChatListener).asSingleton();
         InjectionManager.mapper().map(IChatNotificationDelegator).toSingleton(ChatNotificationDelegator);
      }
      
      private function setupXMPPOnly() : void
      {
         XMPPLifeHandler.getInstance().hookup();
         var _loc1_:FriendNotificationChannel = new FriendNotificationChannel();
         InjectionManager.mapper().map(String,"AllowedNonFriendCommunication").toValue(this._allowedNonFriendCommunication);
         InjectionManager.mapper().map(XMPPNotificationFilter).asSingleton();
         XMPPLifeHandler.getInstance().channel = _loc1_;
         XMPPLifeHandler.getInstance().country = Config.GetCountry;
         InjectionManager.mapper().map(INotificationChannel).toValue(_loc1_);
         var _loc2_:INotificationChannel = InjectionManager.mapper().getInstance(INotificationChannel);
         var _loc3_:XMPPNotificationFilter = InjectionManager.mapper().getInstance(XMPPNotificationFilter);
         _loc1_.xmppNotificationFilter = _loc3_;
         InjectionManager.mapper().map(INotificationListener).toSingleton(WebNotificationListener);
         var _loc4_:INotificationListener = InjectionManager.mapper().getInstance(INotificationListener);
         _loc1_.notificationListener = _loc4_;
         InjectionManager.mapper().map(ChatChannel).asSingleton();
         InjectionManager.mapper().map(ChatListener).asSingleton();
         InjectionManager.mapper().map(IChatNotificationDelegator).toSingleton(ChatNotificationDelegator);
         InjectionManager.mapper().map(ISystemMessageNotificationDelegator).toSingleton(SystemMessageNotificationDelegator);
      }
   }
}

