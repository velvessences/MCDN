package com.moviestarplanet.connections
{
   import com.moviestarplanet.Components.ReconnectMessage;
   import com.moviestarplanet.alert.DebugAlert;
   import com.moviestarplanet.amf.TicketGenerator;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.chatutils.ComServerCommands;
   import com.moviestarplanet.chatutils.ComServerConnection;
   import com.moviestarplanet.chatutils.ComServerConnector;
   import com.moviestarplanet.connection.FMSConstants;
   import com.moviestarplanet.core.controller.commands.SetupGroupChatCommand;
   import com.moviestarplanet.core.controller.commands.SetupMessagesCommand;
   import com.moviestarplanet.core.model.actor.reload.ActorReload;
   import com.moviestarplanet.events.ComChannelEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.friends.notifications.SetupNotificationsCommand;
   import com.moviestarplanet.logging.services.loggingservice.LoggingAmfService;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.msg.MSP_Event;
   import com.moviestarplanet.popup.OldPopupHandler;
   import com.moviestarplanet.services.wrappers.SessionService;
   import com.moviestarplanet.utils.Utils;
   import com.moviestarplanet.utils.net.ComServerMessenger;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.net.Responder;
   import flash.utils.Timer;
   
   public class ConnectionManager
   {
      
      public static const FMS_RECONNECTED:String = "FMS_RECONNECTED";
      
      private var secondsToRetryAttempt:Number = 0;
      
      private var reconnectAlert:ReconnectMessage;
      
      private var _reconnectTimer:Timer;
      
      private var isFirstLogin:Boolean;
      
      public function ConnectionManager()
      {
         super();
         this.isFirstLogin = true;
         MessageCommunicator.subscribe(SetupNotificationsCommand.FMS_INITIALIZED,this.onFMSInitialized);
         MessageCommunicator.subscribe(ComChannelEvent.COMCHANNEL_INITIALIZED,this.onComChannelInitialized);
      }
      
      private function onFMSInitialized(param1:MsgEvent) : void
      {
         ComServerConnector.registerListeners(SessionService.GetAppSetting);
         MessageCommunicator.subscribe(MSPEvent.COMSERV_RECONNECTING,this.onFMSReconnect);
         MessageCommunicator.subscribe(MSPEvent.COMSERV_SUCCESS,this.onFMSConnected);
         MessageCommunicator.subscribe(FMSConstants.UNRECOVERABLE_ERROR,this.onFMSError);
         MessageCommunicator.subscribe(FMSConstants.DO_COMSERV_RESET,this.onComServReload);
      }
      
      private function onComChannelInitialized(param1:ComChannelEvent) : void
      {
         Main.Instance.webEventDispatcher.addEventListener(ComChannelEvent.COMCONNECTION_SUCCESS,this.onComConnectionSuccess);
      }
      
      private function onComConnectionSuccess(param1:ComChannelEvent) : void
      {
         Main.Instance.mainCanvas.showMainView();
         new SetupMessagesCommand().execute();
         new SetupGroupChatCommand().execute();
      }
      
      private function onFMSReconnect(param1:MsgEvent) : void
      {
         var _loc2_:int = 10;
         this.secondsToRetryAttempt = param1.data;
         if(this.secondsToRetryAttempt < _loc2_)
         {
            return;
         }
         if(this.reconnectAlert == null)
         {
            this.reconnectAlert = new ReconnectMessage();
            OldPopupHandler.getInstance().showFakePopup(this.reconnectAlert,400,400);
            Utils.CenterInParent(this.reconnectAlert);
         }
         this.reconnectAlert.Message = this.createReconnectAlertText();
         this.reconnectTimer.reset();
         this.reconnectTimer.start();
      }
      
      private function createReconnectAlertText() : String
      {
         var _loc1_:String = this.secondsToRetryAttempt > 0 ? "in " + this.secondsToRetryAttempt + " seconds." : "now.";
         return "Cannot connect to MovieStarPlanet. Retrying " + _loc1_;
      }
      
      public function get reconnectTimer() : Timer
      {
         if(this._reconnectTimer == null)
         {
            this._reconnectTimer = new Timer(1000);
            this._reconnectTimer.addEventListener(TimerEvent.TIMER,this.reconnectTimerTick,false,0,true);
            this._reconnectTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.reconnectTimerComplete,false,0,true);
         }
         return this._reconnectTimer;
      }
      
      private function reconnectTimerTick(param1:Event) : void
      {
         --this.secondsToRetryAttempt;
         this.reconnectAlert.Message = this.createReconnectAlertText();
      }
      
      private function reconnectTimerComplete(param1:Event) : void
      {
         if(this.reconnectAlert != null)
         {
            this.reconnectAlert.close();
         }
         this.reconnectAlert = null;
      }
      
      private function onFMSConnected(param1:MsgEvent) : void
      {
         if(this.isFirstLogin)
         {
            this.isFirstLogin = false;
            this.initNonce();
         }
         else
         {
            Main.Instance.dispatchEvent(new MSP_Event(FMS_RECONNECTED));
            if(this._reconnectTimer != null)
            {
               this._reconnectTimer.stop();
               this.reconnectTimerComplete(null);
            }
         }
         ComServerMessenger.onComServConnect(param1);
      }
      
      private function onFMSError(param1:MsgEvent) : void
      {
         var infoCode:String = null;
         var infoApp:String = null;
         var e:MsgEvent = param1;
         var infoObj:Object = e.data as Object;
         infoCode = infoObj.hasOwnProperty("code") ? infoObj.code as String : infoObj as String;
         infoApp = infoObj.hasOwnProperty("application") ? infoObj.application as String : "";
         LoggingAmfService.log("Unrecoverable Error",infoCode + ". actor:" + ActorSession.getActorId() + ". protocol:" + ComServerConnection.curProtocol,function():void
         {
            displayFMSConnectionError(infoCode,infoApp,"2");
         });
      }
      
      private function initNonce() : void
      {
         var nonceReturned:Function = null;
         var respStatusFunction:Function = null;
         nonceReturned = function(param1:String):void
         {
            TicketGenerator.salt = param1;
            Main.Instance.mainCanvas.showMainView();
         };
         respStatusFunction = function(param1:Object):void
         {
            var o:Object = param1;
            LoggingAmfService.log("Unrecoverable Error","Could not retrieve the salt. actor:" + ActorSession.getActorId(),function():void
            {
               MessageCommunicator.send(new MsgEvent(FMSConstants.UNRECOVERABLE_ERROR,""));
            });
         };
         var responder:Responder = new Responder(nonceReturned,respStatusFunction);
         ComServerConnector.getNetCon(ActorSession.getActorId()).call(ComServerCommands.GET_SALT,responder);
      }
      
      private function displayFMSConnectionError(param1:String, param2:String, param3:String) : void
      {
         new DebugAlert().show(MSPLocaleManagerWeb.getInstance().getString("CONNECTION_FAIL_DESC") + "\n" + param3 + "\n");
         LogoutHandler.getInstance().shutDown();
         switch(param1)
         {
            case "NetConnection.Connect.Rejected":
               if(param2 != null && param2 == "AlreadyLoggedIn")
               {
                  Prompt.show(MSPLocaleManagerWeb.getInstance().getString("NC_ALREADY_LOGGED_IN_MSG"),MSPLocaleManagerWeb.getInstance().getString("NC_ALREADY_LOGGED_IN"),4,null,this.displayFMSConnectionErrorClosed);
                  break;
               }
               if(param2 != null && param2 == "WrongDomain")
               {
                  Prompt.show(MSPLocaleManagerWeb.getInstance().getString("NC_UNAUTHORIZED_DOMAIN_MSG"),MSPLocaleManagerWeb.getInstance().getString("NC_UNAUTHORIZED_DOMAIN"),4,null,this.displayFMSConnectionErrorClosed);
                  break;
               }
               Prompt.show(MSPLocaleManagerWeb.getInstance().getString("NC_TOO_MANY_USERS_MSG"),MSPLocaleManagerWeb.getInstance().getString("NC_TOO_MANY_USERS"),4,null,this.displayFMSConnectionErrorClosed);
               break;
            case "NetConnection.Connect.Failed":
               Prompt.show(MSPLocaleManagerWeb.getInstance().getString("CONNECTION_FAIL_DESC"),MSPLocaleManagerWeb.getInstance().getString("CONNECTION_FAIL"),4,null,this.displayFMSConnectionErrorClosed);
               break;
            case "NetConnection.Connect.AppShutdown":
               Prompt.show(MSPLocaleManagerWeb.getInstance().getString("NC_APP_FAILED_MSG"),MSPLocaleManagerWeb.getInstance().getString("NC_APP_FAILED"),4,null,this.displayFMSConnectionErrorClosed);
               break;
            default:
               Prompt.show(MSPLocaleManagerWeb.getInstance().getString("CONNECTION_FAIL_DESC"),MSPLocaleManagerWeb.getInstance().getString("CONNECTION_ERROR"),4,null,this.displayFMSConnectionErrorClosed);
         }
         LogoutHandler.getInstance().isLoggingOut = true;
      }
      
      private function displayFMSConnectionErrorClosed(param1:Event) : void
      {
         LogoutHandler.getInstance().logout();
      }
      
      private function onComServReload(param1:MsgEvent) : void
      {
         ActorReload.getInstance().requestReload();
      }
   }
}

