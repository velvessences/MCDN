package com.moviestarplanet.friends.notifications
{
   import com.adobe.rtc.util.Base64Encoder;
   import com.moviestarplanet.amf.TicketGenerator;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.configurations.AppSettings;
   import com.moviestarplanet.events.ComChannelEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.platform.ApplicationId;
   import com.moviestarplanet.utils.PaperTrailLogoutLogger;
   import com.moviestarplanet.xmppConnection.channel.FriendNotificationChannel;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class XMPPLifeHandler
   {
      
      public static var instance:XMPPLifeHandler;
      
      private static const CONNECT_SUCCESS:String = "connection";
      
      private static const XMPP_LOGIN_SUCCESS:String = "login";
      
      public var channel:FriendNotificationChannel;
      
      [Inject]
      public var webEventDispatcher:IEventDispatcher;
      
      public var country:String;
      
      public function XMPPLifeHandler()
      {
         super();
         InjectionManager.manager().injectMe(this);
      }
      
      public static function getInstance() : XMPPLifeHandler
      {
         if(!instance)
         {
            instance = new XMPPLifeHandler();
         }
         return instance;
      }
      
      internal function hookup() : void
      {
         MessageCommunicator.subscribe(MSPEvent.LOGIN_SUCCESS,this.turnOnXMPP);
      }
      
      private function turnOnXMPP(param1:Event) : void
      {
         var _loc2_:String = "ec2-54-196-220-138.compute-1.amazonaws.com";
         var _loc3_:int = 5222;
         var _loc4_:String = AppSettings.getInstance().getSetting(AppSettings.XMPP_SERVER);
         var _loc5_:Boolean = AppSettings.getInstance().getSetting(AppSettings.XMPP_USE_LOCALHOST) != "false";
         var _loc6_:Array = [];
         if(_loc4_ != null)
         {
            _loc6_ = _loc4_.split(":");
         }
         if(_loc6_.length == 2)
         {
            _loc2_ = _loc6_[0];
            _loc3_ = int(parseInt(_loc6_[1]));
         }
         else if(_loc4_ != null && _loc4_.length > 0)
         {
            _loc2_ = _loc4_;
         }
         this.channel.addEventListener(CONNECT_SUCCESS,this.onConnectSuccess);
         this.channel.addEventListener(FriendNotificationChannel.LOGGED_IN_ELSEWHERE,this.onLoggedInElsewhere);
         this.channel.establishServerConnection(ActorSession.getActorId(),this.ticket,_loc2_,_loc3_,ApplicationId.APPLICATION_WEB,_loc5_);
      }
      
      protected function onLoggedInElsewhere(param1:Event) : void
      {
         PaperTrailLogoutLogger.getInstance().log("XMPP says, LOGGED_IN_ELSEWHERE");
         this.webEventDispatcher.dispatchEvent(new ComChannelEvent(ComChannelEvent.COMCONNECTION_DISCONNECTED));
         MessageCommunicator.send(new MsgEvent(MSPEvent.DO_LOGOUT,"LOGGED_IN_ELSEWHERE"));
      }
      
      private function onConnectSuccess(param1:Event) : void
      {
         this.channel.removeEventListener(CONNECT_SUCCESS,this.onConnectSuccess);
         if(this.channel.isChannelReady())
         {
            this.webEventDispatcher.dispatchEvent(new ComChannelEvent(ComChannelEvent.COMCONNECTION_SUCCESS));
         }
         else
         {
            this.channel.addEventListener(XMPP_LOGIN_SUCCESS,this.onLoginSuccess);
         }
      }
      
      protected function onLoginSuccess(param1:Event) : void
      {
         if(this.channel.isChannelReady())
         {
            this.channel.removeEventListener(XMPP_LOGIN_SUCCESS,this.onLoginSuccess);
            this.webEventDispatcher.dispatchEvent(new ComChannelEvent(ComChannelEvent.COMCONNECTION_SUCCESS));
         }
      }
      
      public function get ticket() : String
      {
         var _loc1_:Base64Encoder = new Base64Encoder();
         _loc1_.encodeUTFBytes(TicketGenerator.createTicketHeaderNoMarking().Ticket);
         return _loc1_.toString().split("\n").join("");
      }
      
      public function setPresence() : void
      {
         this.channel.postPresence(null);
      }
   }
}

