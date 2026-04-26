package com.moviestarplanet.core.model.actor.reload
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.configurations.AppSettings;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.usersession.service.UserSessionAMFService;
   import com.moviestarplanet.usersession.valueobjects.ActorDetails;
   import com.moviestarplanet.usersession.valueobjects.ActorDetailsExtended;
   import com.moviestarplanet.utils.chatfilter.nanny.WebNanny;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class ActorReload
   {
      
      private static var instance:ActorReload;
      
      private var reloadTimer:Timer = null;
      
      private var reloadRequest:Boolean;
      
      private var suspendTimer:Timer;
      
      private var suspendLatestTime:Number;
      
      private var listeners:Vector.<ActorReloadListenerInterface>;
      
      private var requestedReloads:Vector.<Function>;
      
      public function ActorReload()
      {
         super();
         this.listeners = new Vector.<ActorReloadListenerInterface>();
         this.requestedReloads = new Vector.<Function>();
      }
      
      public static function getInstance() : ActorReload
      {
         if(instance == null)
         {
            instance = new ActorReload();
         }
         return instance;
      }
      
      public function listenForReload() : void
      {
         MessageCommunicator.subscribe(MSPEvent.NUDGE_EVENT_UPDATE_RELOAD_ACTOR,this.reloadFromNudge);
      }
      
      private function reloadFromNudge(param1:Event = null) : void
      {
         this.reload();
      }
      
      public function startAutomaticReload() : void
      {
         var _loc1_:Number = 1000 * Number(AppSettings.getInstance().getSetting(AppSettings.ACTOR_DETAILS_CHECK_UPDATE_TIMER_SECONDS));
         this.reloadTimer = new Timer(_loc1_);
         this.reloadTimer.addEventListener(TimerEvent.TIMER,this.reload);
         this.reloadTimer.start();
      }
      
      private function reload(param1:TimerEvent = null) : void
      {
         UserSessionAMFService.instance.LoadActorDetailsExtended(ActorSession.loggedInActor.ActorId,this.reloadComplete);
      }
      
      private function reloadComplete(param1:ActorDetailsExtended) : void
      {
         var _loc5_:ActorReloadListenerInterface = null;
         var _loc6_:Function = null;
         var _loc2_:ActorDetails = ActorSession.loggedInActor;
         ActorSession.updateActorDetails(param1.Details);
         var _loc3_:int = 0;
         while(_loc3_ < this.listeners.length)
         {
            _loc5_ = this.listeners[_loc3_] as ActorReloadListenerInterface;
            _loc5_.notify(_loc2_,param1);
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < this.requestedReloads.length)
         {
            _loc6_ = this.requestedReloads[_loc4_];
            _loc6_();
            _loc4_++;
         }
         this.requestedReloads = new Vector.<Function>();
         WebNanny.getInstance().executePendingActionIfAny(null);
      }
      
      public function requestReload(param1:Function = null) : void
      {
         if(param1 != null)
         {
            this.requestedReloads.push(param1);
         }
         if(this.suspendTimer != null && this.suspendTimer.running == true)
         {
            this.reloadRequest = true;
         }
         else
         {
            this.reload();
         }
      }
      
      public function suspendReload(param1:int) : void
      {
         var timeNow:Number = NaN;
         var existingTimeoutMilliseconds:Number = NaN;
         var timeoutMillisecondsRemaining:Number = NaN;
         var timeoutMilliseconds:int = param1;
         var startTimeout:Function = function(param1:int):void
         {
            suspendTimer = new Timer(param1,1);
            suspendTimer.addEventListener(TimerEvent.TIMER_COMPLETE,suspendComplete,false,0,true);
            suspendTimer.start();
         };
         if(this.suspendTimer != null && this.suspendTimer.running == true)
         {
            timeNow = Number(new Date().time);
            existingTimeoutMilliseconds = Number(this.suspendTimer.delay);
            timeoutMillisecondsRemaining = existingTimeoutMilliseconds - (timeNow - this.suspendLatestTime);
            if(timeoutMilliseconds > timeoutMillisecondsRemaining)
            {
               this.suspendTimer.reset();
               this.suspendTimer.removeEventListener(TimerEvent.TIMER,this.suspendComplete,false);
               startTimeout(timeoutMilliseconds);
            }
         }
         else
         {
            if(this.reloadTimer)
            {
               this.reloadTimer.stop();
            }
            this.suspendLatestTime = new Date().time;
            startTimeout(timeoutMilliseconds);
         }
      }
      
      private function suspendComplete(param1:TimerEvent) : void
      {
         this.suspendTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.suspendComplete,false);
         if(this.reloadRequest == true)
         {
            this.reloadRequest = false;
            this.reload();
         }
         if(this.reloadTimer)
         {
            this.reloadTimer.start();
         }
      }
      
      public function registerListener(param1:ActorReloadListenerInterface) : void
      {
         this.listeners.push(param1);
      }
      
      public function unregisterListener(param1:ActorReloadListenerInterface) : void
      {
         var _loc2_:int = int(this.listeners.indexOf(param1));
         if(_loc2_ > -1)
         {
            this.listeners.splice(_loc2_,1);
         }
      }
      
      public function unregisterAllListeners() : void
      {
         var _loc2_:ActorReloadListenerInterface = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.listeners.length)
         {
            _loc2_ = this.listeners[_loc1_] as ActorReloadListenerInterface;
            _loc2_ = null;
            _loc1_++;
         }
         this.listeners.length = 0;
      }
   }
}

