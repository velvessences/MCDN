package com.moviestarplanet.clientcensor
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.configuration.InputLocations;
   import com.moviestarplanet.model.IActorModel;
   import com.moviestarplanet.utils.DateUtils;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class NannyBase extends EventDispatcher
   {
      
      public static var instance:NannyBase;
      
      public static var actorModel:IActorModel;
      
      public static var UpdateBehaviourStatusFunction:Function;
      
      public static var LockOutUserFunction:Function;
      
      private var _mutedUntil:Date;
      
      private var _currentlyMuted:Boolean;
      
      private var _warningStatus:int = 0;
      
      private var _timer:Timer;
      
      public function NannyBase()
      {
         super();
      }
      
      private static function uniqeArray(param1:Array) : Array
      {
         var _loc3_:Object = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in param1)
         {
            if(_loc2_.indexOf(_loc3_) < 0)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function updateModerationStatus(param1:int, param2:Date, param3:String, param4:Date = null, param5:Function = null, param6:Function = null, param7:Function = null) : void
      {
         if(this.isUserLocked(param2))
         {
            this.showUserLockedAndLogout(param3,param2,param7);
            if(param6 != null)
            {
               param6();
            }
         }
         else
         {
            if(param4 != null)
            {
               this._mutedUntil = param4;
            }
            if(Boolean(!this._currentlyMuted) && Boolean(this._mutedUntil) && DateUtils.nowUTC.getTime() < this._mutedUntil.getTime())
            {
               this.isMuted(false);
            }
            if(param1 == 1)
            {
               this.showWarning(param3);
            }
            else if(param1 == 3)
            {
               this.showHelpLink();
            }
            if(param5 != null)
            {
               param5();
            }
         }
      }
      
      public function isUserLocked(param1:Date) : Boolean
      {
         if(DateUtils.nowUTC.getTime() < param1.getTime())
         {
            return true;
         }
         return false;
      }
      
      protected function showWarning(param1:String) : void
      {
      }
      
      public function showHelpLink() : void
      {
      }
      
      public function showUserLockedAndLogout(param1:String, param2:Date, param3:Function = null) : void
      {
      }
      
      public function doLogoutImmediately() : void
      {
      }
      
      public function scheduleLogOut() : void
      {
         var onTimeUp:Function = null;
         onTimeUp = function(param1:TimerEvent):void
         {
            _timer = null;
            doLogoutImmediately();
         };
         if(this._timer == null)
         {
            this._timer = new Timer(1000,1);
         }
         this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimeUp);
         this._timer.start();
      }
      
      public function lockOutUser(param1:int, param2:String) : void
      {
         var done:Function = null;
         var numberOfDays:int = param1;
         var lockedText:String = param2;
         done = function(param1:int):void
         {
            if(param1 == 0)
            {
            }
            if(param1 == 2)
            {
            }
            if(param1 == 3)
            {
            }
         };
         LockOutUserFunction(actorModel.actorId,numberOfDays,lockedText,-InputLocations.LOC_AUTO_NANNY,0,done);
      }
      
      public function isMuted(param1:Boolean = true) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc2_:Date = DateUtils.nowUTC;
         if(this._mutedUntil)
         {
            this._currentlyMuted = this._mutedUntil.getTime() > _loc2_.getTime();
         }
         if(this._currentlyMuted)
         {
            _loc3_ = this._mutedUntil.getTime() - _loc2_.getTime();
            _loc4_ = int(Math.floor(_loc3_ / 60000) as int);
            if(param1)
            {
               dispatchEvent(new NannyEvent(NannyEvent.NEED_SHOW_MUTE_POPUP,_loc4_));
            }
         }
         return this._currentlyMuted;
      }
      
      public function setMuteFor(param1:Number) : void
      {
         this._mutedUntil = new Date(DateUtils.nowUTC.getTime() + param1 * 60 * 1000);
         this._currentlyMuted = true;
      }
   }
}

