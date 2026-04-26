package com.moviestarplanet.amf
{
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import flash.events.AsyncErrorEvent;
   import flash.events.IOErrorEvent;
   import flash.events.NetStatusEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class AmfListener
   {
      
      internal static var TIMEOUT_MILLIS:int = 20000;
      
      private static const MAX_FAILS:int = 2;
      
      private static const ERROR_TYPE:String = "error";
      
      private const HttpCodeUnauthorized:String = "401";
      
      private const RETRY_MILLIS:int = 5000;
      
      internal var callingCall:AmfCall = null;
      
      internal var isCalling:Boolean = false;
      
      private var _connection:FluorineNetConnection;
      
      private var _callTimeOut:Timer;
      
      private var _retryTimer:Timer;
      
      public function AmfListener()
      {
         super();
         this._callTimeOut = new Timer(TIMEOUT_MILLIS);
         this._retryTimer = new Timer(this.RETRY_MILLIS);
      }
      
      internal function endListening() : void
      {
         if(this._connection != null)
         {
            this._connection.removeEventListener(NetStatusEvent.NET_STATUS,this.onNetStatus);
            this._connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onConError);
            this._connection.removeEventListener(AsyncErrorEvent.ASYNC_ERROR,this.onConError);
            this._connection.removeEventListener(IOErrorEvent.IO_ERROR,this.onConError);
            this._connection.close();
            this._connection = null;
         }
      }
      
      internal function startListening(param1:FluorineNetConnection) : void
      {
         this.endListening();
         this._connection = param1;
         this._connection.addEventListener(NetStatusEvent.NET_STATUS,this.onNetStatus);
         this._connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onConError);
         this._connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR,this.onConError);
         this._connection.addEventListener(IOErrorEvent.IO_ERROR,this.onConError);
         this._callTimeOut.addEventListener(TimerEvent.TIMER,this.onTimeOut);
         this._callTimeOut.start();
      }
      
      internal function set call(param1:AmfCall) : void
      {
         if(this.callingCall != null)
         {
            this.cleanupCall(this.callingCall);
         }
         this.callingCall = param1;
         this.callingCall.listener = this;
      }
      
      protected function onTimeOut(param1:TimerEvent) : void
      {
         this._callTimeOut.stop();
         this.onConError("connection timed out");
      }
      
      protected function onConError(param1:Object) : void
      {
         this._callTimeOut.stop();
         if(this.callingCall != null && this.isCalling)
         {
            this.callFailed(param1);
         }
         else
         {
            this.cleanupListener();
            AmfCaller.doCleanup();
            trace(param1.toString());
         }
      }
      
      protected function onNetStatus(param1:NetStatusEvent) : void
      {
         this._callTimeOut.stop();
         if(param1.info.level == "error")
         {
            if(param1.info.description != null && param1.info.description.indexOf(this.HttpCodeUnauthorized) >= 0)
            {
               MessageCommunicator.send(new MsgEvent(AmfCaller.UNAUTHORIZED_WEB_SERVICE_CALL));
               this.callFailed(param1.info.code);
            }
            else if(Boolean(this.callingCall) && this.callingCall.failCount < MAX_FAILS)
            {
               ++this.callingCall.failCount;
               this._retryTimer.addEventListener(TimerEvent.TIMER,this.onRetry);
               this._retryTimer.start();
            }
            else
            {
               this.callFailed(param1.info.code);
            }
         }
      }
      
      private function callFailed(param1:Object) : void
      {
         this.cleanupListener();
         if(this.callingCall)
         {
            this.callingCall.callFailedIfExistsAndDisposeCallbacks(param1);
            this.cleanupCall(this.callingCall);
            this.callingCall = null;
         }
      }
      
      private function retryCall() : void
      {
         var _loc1_:AmfCall = this.callingCall;
         this.callingCall = null;
         this.cleanupListener();
         _loc1_.generateAndAddNewTicketMarking();
         AmfCaller.retryCall(_loc1_);
         this.cleanupCall(_loc1_);
      }
      
      protected function onRetry(param1:TimerEvent) : void
      {
         this._retryTimer.stop();
         this.retryCall();
      }
      
      internal function callDone() : void
      {
         this.cleanupCall(this.callingCall);
         this.callingCall = null;
         this.cleanupListener();
      }
      
      private function cleanupCall(param1:AmfCall) : void
      {
         if(param1 != null)
         {
            param1.isActive = false;
            param1.listener = null;
            param1.failCount = 0;
         }
      }
      
      private function cleanupListener() : void
      {
         this.isCalling = false;
         this._retryTimer.stop();
         this._callTimeOut.stop();
         this.endListening();
         AmfCaller.listenerAvailable(this);
      }
   }
}

