package com.moviestarplanet.chatCommunicator.chatHelpers.chatpermission
{
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   import com.moviestarplanet.service.ISessionAmfServiceForWeb;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class ChatPermissionManager extends EventDispatcher
   {
      
      private static var _instance:ChatPermissionManager;
      
      public static const WARNING_BEFORE_SECONDS:int = 300;
      
      [Inject]
      public var sessionService:ISessionAmfServiceForWeb;
      
      public var country:String;
      
      public var isModerator:Boolean = false;
      
      private const STATUS_UNPERMITTED:String = "unpermitted";
      
      private const SALT:String = "t0ps3cr3t";
      
      private const TIMEOUT_SECONDS:int = 60;
      
      private var _isPermitted:Boolean = true;
      
      private var _keepTrackDate:Date;
      
      private var _timer:Timer;
      
      private var _warningTimer:Timer;
      
      private var _timeoutTimer:Timer;
      
      public function ChatPermissionManager(param1:SingletonEnforcer)
      {
         super();
         if(param1 == null)
         {
            throw new Error("ChatPermissionManager is a singleton class, use getInstance() instead.");
         }
      }
      
      public static function get instance() : ChatPermissionManager
      {
         if(_instance == null)
         {
            _instance = new ChatPermissionManager(new SingletonEnforcer());
         }
         return _instance;
      }
      
      public function get isPermitted() : Boolean
      {
         return this._isPermitted || this.isModerator;
      }
      
      public function setupChatPermissionInfo(param1:Function = null) : void
      {
         var iChatPermissionInfoLoaded:Function = null;
         var callback:Function = param1;
         iChatPermissionInfoLoaded = function(param1:ChatPermissionInfo):void
         {
            setChatPermissionInfo(param1);
            if(callback != null)
            {
               callback();
            }
         };
         this.sessionService.GetChatPermissionInfo(iChatPermissionInfoLoaded);
      }
      
      public function overrideSetupChatPermissionInfo(param1:ChatPermissionInfo) : void
      {
         this.setChatPermissionInfo(param1);
      }
      
      private function setChatPermissionInfo(param1:ChatPermissionInfo) : void
      {
         if(param1 != null && SerializeUtils.checkHash(param1.status + this.SALT,param1.statusHash))
         {
            this._isPermitted = param1.status != this.STATUS_UNPERMITTED;
            this._keepTrackDate = new Date();
            this._keepTrackDate.setSeconds(this._keepTrackDate.getSeconds() + param1.secondsRemaining);
            this.createTimer(param1.secondsRemaining);
            if(param1.secondsRemaining - WARNING_BEFORE_SECONDS > 0 && Boolean(ChatPermissionManager.instance.isPermitted))
            {
               this.createWarningTimer(param1.secondsRemaining - WARNING_BEFORE_SECONDS);
            }
         }
         else
         {
            this._isPermitted = false;
         }
      }
      
      public function getSecondsRemaining() : int
      {
         var _loc1_:Date = new Date();
         return int((this._keepTrackDate.valueOf() - _loc1_.valueOf()) / 1000);
      }
      
      private function createTimer(param1:int) : void
      {
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
            this._timer = null;
         }
         this._timer = new Timer(param1 * 1000,1);
         this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         this._timer.start();
      }
      
      private function createWarningTimer(param1:int) : void
      {
         if(this._warningTimer)
         {
            this._warningTimer.stop();
            this._warningTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onWarningTimerComplete);
            this._warningTimer = null;
         }
         this._warningTimer = new Timer(param1 * 1000,1);
         this._warningTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onWarningTimerComplete);
         this._warningTimer.start();
      }
      
      private function removeTimeout() : void
      {
         if(this._timeoutTimer)
         {
            this._timeoutTimer.stop();
            this._timeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeoutComplete);
            this._timeoutTimer = null;
         }
      }
      
      private function startTimeout() : void
      {
         this._timeoutTimer = new Timer(this.TIMEOUT_SECONDS * 1000,1);
         this._timeoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeoutComplete);
         this._timeoutTimer.start();
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         var done:Function = null;
         var e:TimerEvent = param1;
         done = function():void
         {
            removeTimeout();
            dispatchEvent(new ChatPermissionEvent(ChatPermissionEvent.CHAT_PERMISSION_UPDATE));
         };
         this.removeTimeout();
         this.startTimeout();
         this.setupChatPermissionInfo(done);
      }
      
      private function onWarningTimerComplete(param1:TimerEvent) : void
      {
         dispatchEvent(new ChatPermissionEvent(ChatPermissionEvent.TIME_RUNNING_OUT));
      }
      
      private function onTimeoutComplete(param1:TimerEvent) : void
      {
         this._isPermitted = false;
         dispatchEvent(new ChatPermissionEvent(ChatPermissionEvent.CHAT_PERMISSION_UPDATE));
         this.removeTimeout();
      }
   }
}

class SingletonEnforcer
{
   
   public function SingletonEnforcer()
   {
      super();
   }
}
