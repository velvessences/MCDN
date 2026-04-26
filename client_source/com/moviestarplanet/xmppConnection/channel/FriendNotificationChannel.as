package com.moviestarplanet.xmppConnection.channel
{
   import com.hurlant.crypto.tls.TLSConfig;
   import com.hurlant.crypto.tls.TLSEngine;
   import com.hurlant.util.Base64;
   import com.moviestarplanet.notification.INotification;
   import com.moviestarplanet.notification.INotificationChannel;
   import com.moviestarplanet.notification.INotificationListener;
   import com.moviestarplanet.notifications.XMPPNotificationFilter;
   import com.moviestarplanet.notifications.model.NotificationNudgeObject;
   import com.moviestarplanet.xmppConnection.NotificationConverter;
   import com.moviestarplanet.xmppConnection.XMPPStatus;
   import com.moviestarplanet.xmppConnection.model.ChatUser;
   import com.moviestarplanet.xmppConnection.model.LoginCredentials;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.system.Security;
   import flash.utils.Timer;
   import org.igniterealtime.xiff.auth.External;
   import org.igniterealtime.xiff.auth.Plain;
   import org.igniterealtime.xiff.auth.XFacebookPlatform;
   import org.igniterealtime.xiff.collections.ArrayCollection;
   import org.igniterealtime.xiff.collections.events.CollectionEvent;
   import org.igniterealtime.xiff.conference.InviteListener;
   import org.igniterealtime.xiff.core.EscapedJID;
   import org.igniterealtime.xiff.core.InBandRegistrator;
   import org.igniterealtime.xiff.core.UnescapedJID;
   import org.igniterealtime.xiff.core.XMPPTLSConnection;
   import org.igniterealtime.xiff.data.Message;
   import org.igniterealtime.xiff.data.Presence;
   import org.igniterealtime.xiff.data.im.RosterItemVO;
   import org.igniterealtime.xiff.events.ConnectionSuccessEvent;
   import org.igniterealtime.xiff.events.DisconnectionEvent;
   import org.igniterealtime.xiff.events.IncomingDataEvent;
   import org.igniterealtime.xiff.events.InviteEvent;
   import org.igniterealtime.xiff.events.LoginEvent;
   import org.igniterealtime.xiff.events.MessageEvent;
   import org.igniterealtime.xiff.events.OutgoingDataEvent;
   import org.igniterealtime.xiff.events.PresenceEvent;
   import org.igniterealtime.xiff.events.RegistrationFieldsEvent;
   import org.igniterealtime.xiff.events.RegistrationSuccessEvent;
   import org.igniterealtime.xiff.events.RosterEvent;
   import org.igniterealtime.xiff.events.XIFFErrorEvent;
   import org.igniterealtime.xiff.util.Zlib;
   
   public class FriendNotificationChannel extends EventDispatcher implements INotificationChannel
   {
      
      public static const LOGGED_IN_ELSEWHERE:String = "LOGGED_IN_ELSEWHERE";
      
      public static var RETRY_COUNT_MAX:int = 10;
      
      public var xmppNotificationFilter:XMPPNotificationFilter;
      
      private const KEEP_ALIVE_TIME:int = 30000;
      
      private const XIFF_ERROR_CONFLICT:String = "conflict";
      
      public var notificationListener:INotificationListener;
      
      public var compress:Boolean = false;
      
      public var useTls:Boolean = false;
      
      private var serverName:String;
      
      private var serverPort:int = 5222;
      
      private var _country:String;
      
      private var clientName:String;
      
      private var converter:NotificationConverter;
      
      protected var registerUser:Boolean;
      
      protected var registrationData:Object;
      
      protected var keepAliveTimer:Timer;
      
      protected var _connection:XMPPTLSConnection;
      
      protected var _inviteListener:InviteListener;
      
      protected var _inbandRegister:InBandRegistrator;
      
      protected var _roster:FriendNotificationRoster;
      
      protected var _chatUserRoster:ArrayCollection;
      
      protected var _currentUser:ChatUser;
      
      private var userId:int;
      
      private var xmppStatus:XMPPStatus;
      
      private var hasLoggedInElseWhere:Boolean;
      
      private var ticket:String;
      
      private var loginReconnectTimer:Timer;
      
      private var retryCnt:int;
      
      private var isReconnecting:Boolean;
      
      private var isLoggingOut:Boolean;
      
      private var _useLocalhostInJid:Boolean;
      
      public function FriendNotificationChannel()
      {
         super();
      }
      
      public static function isValidJID(param1:UnescapedJID) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:RegExp = /(\w|[_.\-])+@(localhost$|((\w|-)+\.)+\w{2,4}$){1}/;
         var _loc4_:Object = _loc3_.exec(param1.toString());
         if(_loc4_)
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      public function connectToFriend(param1:Number) : void
      {
         var _loc2_:String = this.converter.JIDFromFriendId(param1);
         var _loc3_:Presence = this.roster.getPresence(new UnescapedJID(_loc2_)) as Presence;
         var _loc4_:String = this.getUserStatusFromPresence(_loc3_);
         this.notificationListener.onFriendOnlineStatus(param1,_loc4_);
      }
      
      public function sendNotificationToFriend(param1:Number, param2:INotification) : void
      {
         var _loc3_:EscapedJID = new EscapedJID(this.converter.JIDFromFriendId(param1));
         this._connection.send(this.converter.noteToMessage(this.currentUser.jid.escaped,_loc3_,param2));
      }
      
      public function isFriendOnline(param1:int) : Boolean
      {
         var _loc2_:String = this.converter.JIDFromFriendId(param1);
         var _loc3_:Presence = this.roster.getPresence(new UnescapedJID(_loc2_)) as Presence;
         return this.getUserStatusFromPresence(_loc3_) != "disconnected";
      }
      
      public function sendNotificationToOnlineFriends(param1:INotification) : void
      {
         var _loc4_:RosterItemVO = null;
         var _loc2_:EscapedJID = new EscapedJID("");
         var _loc3_:Message = this.converter.noteToMessage(this.currentUser.jid.escaped,null,param1);
         for each(_loc4_ in this.onlineFriends)
         {
            _loc2_ = _loc4_.jid.escaped;
            _loc3_.to = _loc2_;
            this._connection.send(_loc3_);
         }
      }
      
      private function get onlineFriends() : Array
      {
         var _loc2_:RosterItemVO = null;
         var _loc3_:Presence = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.roster.source)
         {
            _loc3_ = this.roster.getPresence(_loc2_.jid) as Presence;
            if(_loc3_ != null && this.getUserStatusFromPresence(_loc3_) != "disconnected")
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function isChannelReady() : Boolean
      {
         if(this._connection == null)
         {
            return false;
         }
         return this._connection.loggedIn;
      }
      
      public function establishServerConnection(param1:int, param2:String, param3:String, param4:int, param5:String, param6:Boolean) : void
      {
         this.userId = param1;
         this._country = this.getCountryCodeFromTicket(param2);
         this.serverName = param3;
         this.serverPort = param4;
         this.clientName = param5;
         this.ticket = param2;
         this._useLocalhostInJid = param6;
         this.setupConnection();
         this.setupInviteListener();
         this.setupInBandRegistrator();
         this.setupRoster();
         this.setupChat();
         this.setupCurrentUser();
         this.registerSASLMechanisms();
         this.setupTimer();
         this.isLoggingOut = false;
         this.converter = new NotificationConverter(this._country,param6);
         var _loc7_:String = new UnescapedJID(this.converter.JIDFromFriendId(param1)).escaped.toString();
         var _loc8_:LoginCredentials = new LoginCredentials(_loc7_,param2);
         this.connect(_loc8_);
      }
      
      private function getCountryCodeFromTicket(param1:String) : String
      {
         var _loc2_:String = Base64.decode(param1);
         return _loc2_.split(",")[0].toString().toLowerCase();
      }
      
      public function get connection() : XMPPTLSConnection
      {
         return this._connection;
      }
      
      public function get inviteListener() : InviteListener
      {
         return this._inviteListener;
      }
      
      public function get inbandRegister() : InBandRegistrator
      {
         return this._inbandRegister;
      }
      
      public function get roster() : FriendNotificationRoster
      {
         return this._roster;
      }
      
      internal function setTestStubs(param1:FriendNotificationRoster, param2:NotificationConverter) : void
      {
         this._roster = param1;
         this.converter = param2;
      }
      
      public function get chatUserRoster() : ArrayCollection
      {
         return this._chatUserRoster;
      }
      
      public function get currentUser() : ChatUser
      {
         return this._currentUser;
      }
      
      public function get conferenceServer() : String
      {
         return "conference." + this._connection.server;
      }
      
      public function get country() : String
      {
         return this._country;
      }
      
      public function setFBAuthProperties(param1:String, param2:String) : void
      {
         XFacebookPlatform.fb_app_id = param1;
         XFacebookPlatform.fb_access_token = param2;
      }
      
      public function connect(param1:LoginCredentials) : void
      {
         var _loc2_:int = int(param1.username.lastIndexOf("@"));
         var _loc3_:String = _loc2_ > -1 ? param1.username.substring(0,_loc2_) : param1.username;
         var _loc4_:String = _loc2_ > -1 ? param1.username.substring(_loc2_ + 1) : null;
         Security.loadPolicyFile("xmlsocket://" + this.serverName + ":" + this.serverPort);
         this.registerUser = false;
         this.connection.tls = this.useTls;
         this.connection.username = XFacebookPlatform.fb_app_id != null ? "u" + _loc3_ : _loc3_;
         this.connection.password = param1.password;
         this.connection.domain = _loc4_;
         this.connection.server = this.serverName;
         this.connection.port = this.serverPort;
         this.connection.connect();
      }
      
      public function disconnect() : void
      {
         if(this.connection == null)
         {
            return;
         }
         this.isLoggingOut = true;
         this.connection.send(new Presence(null,null,Presence.TYPE_UNAVAILABLE));
         this.connection.disconnect();
         this._roster.removeAll();
         this.setupCurrentUser();
         trace("XMPPCHANNEL disconnect");
      }
      
      public function register(param1:LoginCredentials) : void
      {
         this.registerUser = true;
         this.connection.username = null;
         this.connection.password = null;
         this.connection.server = this.serverName;
         this.connection.connect();
         this.registrationData = {};
         this.registrationData.username = param1.username;
         this.registrationData.password = param1.password;
      }
      
      public function addBuddy(param1:UnescapedJID) : void
      {
         this.roster.addContact(param1,param1.toString(),"Buddies",true);
      }
      
      public function updateGroup(param1:RosterItemVO, param2:String) : void
      {
         this.roster.updateContactGroups(param1,[param2]);
      }
      
      protected function setupConnection() : void
      {
         this._connection = new XMPPTLSConnection();
         this._connection.compressor = new Zlib();
         var _loc1_:TLSConfig = new TLSConfig(TLSEngine.CLIENT);
         _loc1_.ignoreCommonNameMismatch = true;
         this._connection.config = _loc1_;
         this.addConnectionListeners();
      }
      
      protected function addConnectionListeners() : void
      {
         this._connection.addEventListener(ConnectionSuccessEvent.CONNECT_SUCCESS,this.onConnectSuccess);
         this._connection.addEventListener(DisconnectionEvent.DISCONNECT,this.onDisconnect);
         this._connection.addEventListener(LoginEvent.LOGIN,this.onLogin);
         this._connection.addEventListener(XIFFErrorEvent.XIFF_ERROR,this.onXIFFError);
         this._connection.addEventListener(OutgoingDataEvent.OUTGOING_DATA,this.onOutgoingData);
         this._connection.addEventListener(IncomingDataEvent.INCOMING_DATA,this.onIncomingData);
         this._connection.addEventListener(PresenceEvent.PRESENCE,this.onPresence);
         this._connection.addEventListener(MessageEvent.MESSAGE,this.onMessage);
      }
      
      protected function removeConnectionListeners() : void
      {
         this._connection.removeEventListener(ConnectionSuccessEvent.CONNECT_SUCCESS,this.onConnectSuccess);
         this._connection.removeEventListener(DisconnectionEvent.DISCONNECT,this.onDisconnect);
         this._connection.removeEventListener(LoginEvent.LOGIN,this.onLogin);
         this._connection.removeEventListener(XIFFErrorEvent.XIFF_ERROR,this.onXIFFError);
         this._connection.removeEventListener(OutgoingDataEvent.OUTGOING_DATA,this.onOutgoingData);
         this._connection.removeEventListener(IncomingDataEvent.INCOMING_DATA,this.onIncomingData);
         this._connection.removeEventListener(PresenceEvent.PRESENCE,this.onPresence);
         this._connection.removeEventListener(MessageEvent.MESSAGE,this.onMessage);
      }
      
      protected function setupInviteListener() : void
      {
         this._inviteListener = new InviteListener();
         this._inviteListener.addEventListener(InviteEvent.INVITED,this.onInvited);
         this._inviteListener.connection = this._connection;
      }
      
      protected function setupInBandRegistrator() : void
      {
         this._inbandRegister = new InBandRegistrator();
         this._inbandRegister.addEventListener(RegistrationFieldsEvent.REG_FIELDS,this.onRegistrationFields);
         this._inbandRegister.addEventListener(RegistrationSuccessEvent.REGISTRATION_SUCCESS,this.onRegistrationSuccess);
         this._inbandRegister.connection = this._connection;
      }
      
      protected function setupRoster() : void
      {
         this._roster = new FriendNotificationRoster();
         this._roster.clientName = this.clientName;
         this._roster.addEventListener(RosterEvent.ROSTER_LOADED,this.onRosterLoaded);
         this._roster.addEventListener(RosterEvent.SUBSCRIPTION_DENIAL,this.onSubscriptionDenial);
         this._roster.addEventListener(RosterEvent.SUBSCRIPTION_REQUEST,this.onSubscriptionRequest);
         this._roster.addEventListener(RosterEvent.SUBSCRIPTION_REVOCATION,this.onSubscriptionRevocation);
         this._roster.addEventListener(RosterEvent.USER_ADDED,this.onUserAdded);
         this._roster.addEventListener(RosterEvent.USER_AVAILABLE,this.onUserAvailable);
         this._roster.addEventListener(RosterEvent.USER_PRESENCE_UPDATED,this.onUserPresenceUpdated);
         this._roster.addEventListener(RosterEvent.USER_REMOVED,this.onUserRemoved);
         this._roster.addEventListener(RosterEvent.USER_SUBSCRIPTION_UPDATED,this.onUserSubscriptionUpdated);
         this._roster.addEventListener(RosterEvent.USER_UNAVAILABLE,this.onUserUnavailable);
         this._roster.connection = this._connection;
         this._chatUserRoster = new ArrayCollection();
      }
      
      protected function setupChat() : void
      {
      }
      
      protected function setupCurrentUser() : void
      {
         this._currentUser = new ChatUser(this._connection.jid);
      }
      
      protected function registerSASLMechanisms() : void
      {
         this._connection.enableSASLMechanism(External.MECHANISM,External);
         this._connection.enableSASLMechanism(Plain.MECHANISM,Plain);
         this._connection.enableSASLMechanism(XFacebookPlatform.MECHANISM,XFacebookPlatform);
      }
      
      protected function setupTimer() : void
      {
         this.keepAliveTimer = new Timer(this.KEEP_ALIVE_TIME);
         this.keepAliveTimer.addEventListener(TimerEvent.TIMER,this.onKeepAliveTimer);
      }
      
      protected function cleanup() : void
      {
         this.removeConnectionListeners();
         this.setupCurrentUser();
         this._chatUserRoster.removeAll();
         this.keepAliveTimer.stop();
      }
      
      protected function updateChatUserRoster() : void
      {
         var _loc2_:RosterItemVO = null;
         var _loc3_:ChatUser = null;
         var _loc1_:Array = [];
         for each(_loc2_ in this._roster.source)
         {
            _loc3_ = new ChatUser(_loc2_.jid);
            _loc3_.rosterItem = _loc2_;
            _loc1_.push(_loc3_);
         }
         this._chatUserRoster.source = _loc1_;
      }
      
      protected function onConnectSuccess(param1:ConnectionSuccessEvent) : void
      {
         if(this.registerUser)
         {
            this._inbandRegister.sendRegistrationFields(this.registrationData,null);
         }
         this.isReconnecting = false;
         trace("XMPP connected.  Dispatching event: " + param1.type + "is logged in: " + this._connection.loggedIn);
         dispatchEvent(param1);
      }
      
      protected function onDisconnect(param1:DisconnectionEvent) : void
      {
         this.cleanup();
         this.setupConnection();
         this._roster.connection = this._connection;
         dispatchEvent(param1);
         trace("XMPPCHANNEL onDisconnect " + param1.type);
         this.initiateReconnectIfWanted();
      }
      
      private function initiateReconnectIfWanted() : void
      {
         if(this.hasLoggedInElseWhere || this.isLoggingOut)
         {
            return;
         }
         if(this.retryCnt < RETRY_COUNT_MAX)
         {
            this.isReconnecting = true;
            ++this.retryCnt;
            this.startReconnectTimer();
         }
         else
         {
            this.isReconnecting = false;
         }
      }
      
      private function getSecondsTilRetry() : int
      {
         return this.retryCnt * this.retryCnt;
      }
      
      private function startReconnectTimer() : void
      {
         var onTimer:Function = null;
         onTimer = function():void
         {
            loginReconnectTimer.removeEventListener(TimerEvent.TIMER,onTimer);
            reconnect();
         };
         if(this.loginReconnectTimer != null)
         {
            this.loginReconnectTimer.stop();
         }
         this.loginReconnectTimer = new Timer(1000 * this.getSecondsTilRetry(),1);
         this.loginReconnectTimer.addEventListener(TimerEvent.TIMER,onTimer);
         this.loginReconnectTimer.start();
      }
      
      private function reconnect() : void
      {
         this.establishServerConnection(this.userId,this.ticket,this.serverName,this.serverPort,this.clientName,this._useLocalhostInJid);
      }
      
      protected function onLogin(param1:LoginEvent) : void
      {
         this.setupCurrentUser();
         this.keepAliveTimer.start();
         trace("XMPP logged in.  Dispatching event: " + param1.type);
         dispatchEvent(param1);
      }
      
      protected function onXIFFError(param1:XIFFErrorEvent) : void
      {
         if(this.isConnectedFromOtherClient(param1))
         {
            this.onConnectedFromOtherClient();
         }
         else if(this.isReconnecting)
         {
            this.initiateReconnectIfWanted();
         }
         else
         {
            dispatchEvent(param1);
         }
         trace("XMPPCHANNEL onXIFFError - Type: " + param1.type + " Message: " + param1.errorMessage + " - Condition: " + param1.errorCondition + " - Code: " + param1.errorCode);
      }
      
      private function onConnectedFromOtherClient() : void
      {
         this.hasLoggedInElseWhere = true;
         dispatchEvent(new Event(LOGGED_IN_ELSEWHERE));
      }
      
      private function isConnectedFromOtherClient(param1:XIFFErrorEvent) : Boolean
      {
         return param1.errorCondition == this.XIFF_ERROR_CONFLICT;
      }
      
      protected function onOutgoingData(param1:OutgoingDataEvent) : void
      {
         dispatchEvent(param1);
      }
      
      protected function onIncomingData(param1:IncomingDataEvent) : void
      {
         dispatchEvent(param1);
      }
      
      protected function onRegistrationFields(param1:RegistrationFieldsEvent) : void
      {
         dispatchEvent(param1);
      }
      
      protected function onRegistrationSuccess(param1:RegistrationSuccessEvent) : void
      {
         this._connection.disconnect();
         dispatchEvent(param1);
      }
      
      protected function onPresence(param1:PresenceEvent) : void
      {
         var _loc2_:Presence = null;
         var _loc3_:Array = null;
         var _loc4_:Boolean = false;
         var _loc5_:XIFFErrorEvent = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         for each(_loc2_ in param1.data)
         {
            if(!_loc2_)
            {
               continue;
            }
            _loc3_ = _loc2_.getAllExtensions();
            _loc4_ = _loc3_ != null && _loc3_.length > 0;
            if(_loc4_ == true)
            {
               dispatchEvent(param1);
               continue;
            }
            switch(_loc2_.type)
            {
               case Presence.TYPE_ERROR:
                  trace("XMPPCHANNEL Presence error " + _loc2_.errorCode + " " + _loc2_.errorType);
                  _loc5_ = new XIFFErrorEvent();
                  _loc5_.errorCode = _loc2_.errorCode;
                  _loc5_.errorCondition = _loc2_.errorCondition;
                  _loc5_.errorMessage = _loc2_.errorMessage;
                  _loc5_.errorType = _loc2_.errorType;
                  this.onXIFFError(_loc5_);
                  break;
               default:
                  _loc6_ = this.converter.friendIdFromJID(_loc2_.from.bareJID);
                  if(_loc6_ != this.userId)
                  {
                     trace("onPresence for " + _loc6_);
                     _loc7_ = _loc2_.getAttribute("client");
                     if(_loc2_.getAttribute("type") == "unavailable")
                     {
                        _loc7_ = "disconnected";
                     }
                     trace("onPresence for " + _loc6_ + " status: " + _loc7_);
                     this.notificationListener.onFriendOnlineStatus(_loc6_,_loc7_);
                     dispatchEvent(param1);
                  }
            }
         }
      }
      
      private function isGroupChat(param1:Array, param2:String) : Boolean
      {
         return param1 != null && param1.length > 0 || param2 == null || param2 == Message.TYPE_GROUPCHAT;
      }
      
      protected function onMessage(param1:MessageEvent) : void
      {
         var _loc3_:XIFFErrorEvent = null;
         var _loc4_:INotification = null;
         var _loc2_:Message = param1.data as Message;
         if(this.isGroupChat(_loc2_.getAllExtensions(),_loc2_.type))
         {
            return;
         }
         _loc2_.type = _loc2_.type.toUpperCase();
         if(_loc2_.type == Message.TYPE_ERROR)
         {
            trace("XMPPCHANNEL Message error " + _loc2_.errorCode + " " + _loc2_.errorType);
            _loc3_ = new XIFFErrorEvent();
            _loc3_.errorCode = _loc2_.errorCode;
            _loc3_.errorCondition = _loc2_.errorCondition;
            _loc3_.errorMessage = _loc2_.errorMessage;
            _loc3_.errorType = _loc2_.errorType;
            this.onXIFFError(_loc3_);
         }
         else
         {
            _loc4_ = this.converter.messageToNote(param1.data);
            if(this.notificationListener != null && _loc4_ != null)
            {
               if(_loc4_.notificationObject is NotificationNudgeObject)
               {
                  this.echoMessage(_loc2_);
               }
               if(this.xmppNotificationFilter.isNotificationAllowed(_loc4_))
               {
                  this.notificationListener.onNotification(_loc4_);
               }
            }
            dispatchEvent(param1);
         }
      }
      
      private function echoMessage(param1:Message) : void
      {
         var _loc2_:Message = new Message(param1.from,null,param1.body,null,Message.TYPE_NORMAL,null);
         _loc2_.from = param1.to;
         this.connection.send(_loc2_);
      }
      
      protected function onInvited(param1:InviteEvent) : void
      {
         dispatchEvent(param1);
      }
      
      protected function onRosterLoaded(param1:RosterEvent) : void
      {
         var _loc2_:ChatUser = null;
         this.updateChatUserRoster();
         for each(_loc2_ in this._chatUserRoster.source)
         {
            if(_loc2_.rosterItem.online)
            {
               this.notificationListener.onFriendOnlineStatus(this.converter.friendIdFromJID(_loc2_.jid.bareJID),_loc2_.status);
            }
         }
         this._roster.addEventListener(CollectionEvent.COLLECTION_CHANGE,this.onRosterChange);
         dispatchEvent(param1);
         trace("roster loaded");
      }
      
      public function postPresence(param1:String) : void
      {
         this.roster.setPresence(param1,"Online",1);
      }
      
      protected function onSubscriptionDenial(param1:RosterEvent) : void
      {
         dispatchEvent(param1);
      }
      
      protected function onSubscriptionRequest(param1:RosterEvent) : void
      {
         if(this._roster.contains(RosterItemVO.get(param1.jid,false)))
         {
            this._roster.grantSubscription(param1.jid,true);
         }
         dispatchEvent(param1);
      }
      
      protected function onSubscriptionRevocation(param1:RosterEvent) : void
      {
         dispatchEvent(param1);
      }
      
      protected function onUserAdded(param1:RosterEvent) : void
      {
         dispatchEvent(param1);
      }
      
      protected function onUserAvailable(param1:RosterEvent) : void
      {
         dispatchEvent(param1);
         trace("onUserAvailable");
      }
      
      protected function onUserPresenceUpdated(param1:RosterEvent) : void
      {
         dispatchEvent(param1);
         trace("onUserPresenceUpdated");
      }
      
      protected function onUserRemoved(param1:RosterEvent) : void
      {
         dispatchEvent(param1);
      }
      
      protected function onUserSubscriptionUpdated(param1:RosterEvent) : void
      {
         dispatchEvent(param1);
      }
      
      protected function onUserUnavailable(param1:RosterEvent) : void
      {
         dispatchEvent(param1);
      }
      
      protected function onRosterChange(param1:CollectionEvent) : void
      {
         var _loc2_:RosterItemVO = null;
         var _loc3_:int = 0;
         trace("onRosterChange: " + param1.kind);
         if(param1.kind == "add")
         {
            _loc3_ = 0;
            while(_loc3_ < param1.items.length)
            {
               _loc2_ = param1.items[_loc3_];
               this._chatUserRoster.addItem(new ChatUser(_loc2_.jid));
               _loc3_++;
            }
         }
         else
         {
            this.updateChatUserRoster();
         }
      }
      
      protected function onKeepAliveTimer(param1:TimerEvent) : void
      {
         if(this.connection.loggedIn)
         {
            this.connection.sendKeepAlive();
         }
      }
      
      protected function getUserStatusFromPresence(param1:Presence) : String
      {
         if(!param1 || param1.type == "unavailable")
         {
            return "disconnected";
         }
         return param1.getAttribute("client");
      }
      
      public function disconnectFromFriend(param1:Number) : void
      {
         var _loc2_:RosterItemVO = RosterItemVO.get(new UnescapedJID(this.converter.JIDFromFriendId(param1)));
         this.roster.removeContact(_loc2_);
      }
      
      public function closeChannel() : void
      {
         this.disconnect();
      }
      
      public function sendNotificationToNonFriend(param1:int, param2:INotification) : void
      {
         var _loc3_:EscapedJID = new EscapedJID(this.converter.JIDFromFriendId(param1));
         this._connection.send(this.converter.noteToMessage(this.currentUser.jid.escaped,_loc3_,param2));
      }
   }
}

