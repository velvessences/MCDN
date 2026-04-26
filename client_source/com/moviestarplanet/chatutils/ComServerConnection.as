package com.moviestarplanet.chatutils
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.configurations.ApplicationConfig;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.connection.FMSConstants;
   import com.moviestarplanet.connection.IComServerConnection;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import flash.events.AsyncErrorEvent;
   import flash.events.IOErrorEvent;
   import flash.events.NetStatusEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.NetConnection;
   import flash.utils.Timer;
   
   public class ComServerConnection implements IComServerConnection
   {
      
      private static const RTMPT:String = "rtmpt://";
      
      private static const RTMP:String = "rtmp://";
      
      public static var curProtocol:String = RTMP;
      
      public static var timeoutMinutes:Number = 5;
      
      public static var RETRY_COUNT_MAX:int = 10;
      
      private var url:String;
      
      private var curCon:NetConnection = new NetConnection();
      
      private var connectedHandler:Function;
      
      private var _actorId:int;
      
      private var timeoutTimer:Timer = new Timer(1000 * 60 * timeoutMinutes,1);
      
      private var _callback:Function;
      
      private var isConnected:Boolean = false;
      
      private var isTunnelingFirstLogin:Boolean = false;
      
      private var clientClosedConnection:Boolean = false;
      
      private var loginReconnectTimer:Timer;
      
      private var retryCnt:int = 0;
      
      public function ComServerConnection(param1:String, param2:Function, param3:int)
      {
         super();
         this.url = param1;
         this.connectedHandler = param2;
         this._actorId = param3;
         this.connect(param3);
      }
      
      public function get uri() : String
      {
         if(this.curCon != null)
         {
            return this.curCon.uri;
         }
         return "";
      }
      
      public function closeConnection() : void
      {
         this.clientClosedConnection = true;
         if(this.netConnection != null)
         {
            this.netConnection.close();
         }
      }
      
      public function connect(param1:int, param2:Function = null) : void
      {
         this._callback = param2;
         if(this.curCon != null && Boolean(this.curCon.connected))
         {
            this.clientClosedConnection = true;
            this.curCon.close();
         }
         this.clientClosedConnection = false;
         this.curCon.addEventListener(NetStatusEvent.NET_STATUS,this.netStatusHandler);
         this.curCon.addEventListener(IOErrorEvent.IO_ERROR,this.onioError);
         this.curCon.addEventListener(AsyncErrorEvent.ASYNC_ERROR,this.onAsycErorr);
         this.curCon.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         this.curCon.connect(curProtocol + this.url + "/" + Config.GetLanguage + "_ComServ",param1,ApplicationConfig.applicationType);
         this.curCon.client = new Object();
         this.timeoutTimer.addEventListener(TimerEvent.TIMER,this.onTimeout);
         this.timeoutTimer.start();
         this.curCon.client.logOut = this.curConClientLogOut;
         this.curCon.client.reload = this.curConClientReload;
      }
      
      private function curConClientLogOut() : void
      {
         MessageCommunicator.send(new MsgEvent(MSPEvent.DO_LOGOUT,"LOGGED_IN_ELSEWHERE"));
      }
      
      private function curConClientReload() : void
      {
         MessageCommunicator.send(new MsgEvent(FMSConstants.DO_COMSERV_RESET));
      }
      
      protected function onTimeout(param1:TimerEvent) : void
      {
         this.conFailed("Connection timed out!");
      }
      
      protected function onSecurityError(param1:SecurityErrorEvent) : void
      {
         this.conFailed(param1.text);
      }
      
      private function onAsycErorr(param1:AsyncErrorEvent) : void
      {
         this.conFailed(param1.text);
      }
      
      private function onioError(param1:IOErrorEvent) : void
      {
         this.conFailed(param1.text);
      }
      
      private function netStatusHandler(param1:NetStatusEvent) : void
      {
         this.timeoutTimer.removeEventListener(TimerEvent.TIMER,this.onTimeout);
         this.timeoutTimer.stop();
         if(this.clientClosedConnection)
         {
            return;
         }
         if(param1.info.code == "NetConnection.Connect.Success")
         {
            this.isTunnelingFirstLogin = false;
            this.isConnected = true;
            this.retryCnt = 0;
            this.connectedHandler(this);
            if(this._callback != null)
            {
               this._callback();
               this._callback = null;
            }
         }
         else if(this.retryCnt < RETRY_COUNT_MAX && !this.isTunnelingFirstLogin)
         {
            if(!this.isConnected && this.retryCnt == 0)
            {
               if(curProtocol == RTMPT)
               {
                  this.failConnection(param1);
                  return;
               }
               this.isTunnelingFirstLogin = true;
               curProtocol = RTMPT;
               this.doInstantReconnect();
               return;
            }
            ++this.retryCnt;
            this.isConnected = false;
            MessageCommunicator.send(new MsgEvent(MSPEvent.COMSERV_RECONNECTING,this.getSecondsTilRetry()));
            this.startReconnectTimer();
         }
         else
         {
            this.failConnection(param1);
         }
      }
      
      private function doInstantReconnect() : void
      {
         var onTimer:Function = null;
         onTimer = function():void
         {
            loginReconnectTimer.removeEventListener(TimerEvent.TIMER,onTimer);
            connect(_actorId);
         };
         this.loginReconnectTimer = new Timer(1,1);
         this.loginReconnectTimer.addEventListener(TimerEvent.TIMER,onTimer);
      }
      
      private function failConnection(param1:NetStatusEvent) : void
      {
         this.conFailed(param1.info);
      }
      
      private function conFailed(param1:Object) : void
      {
         this.isConnected = false;
         this.doInstantReconnect();
         MessageCommunicator.send(new MsgEvent(FMSConstants.UNRECOVERABLE_ERROR,param1));
      }
      
      public function get netConnection() : NetConnection
      {
         return this.curCon;
      }
      
      public function get connected() : Boolean
      {
         return this.isConnected;
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
            connect(_actorId);
         };
         if(this.loginReconnectTimer != null)
         {
            this.loginReconnectTimer.stop();
         }
         this.loginReconnectTimer = new Timer(1000,1);
         this.loginReconnectTimer.addEventListener(TimerEvent.TIMER,onTimer);
         this.loginReconnectTimer.start();
      }
   }
}

