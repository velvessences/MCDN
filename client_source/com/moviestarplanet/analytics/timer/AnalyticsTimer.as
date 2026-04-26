package com.moviestarplanet.analytics.timer
{
   import com.moviestarplanet.analytics.IAnalytics;
   import com.moviestarplanet.constants.analytics.TimeSpentConstants;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.window.event.WindowEvent;
   import flash.display.DisplayObject;
   
   public class AnalyticsTimer
   {
      
      public static var myroomEditorWasOpened:Boolean;
      
      public static const ENTER_TIMER:int = 0;
      
      public static const EXIT_TIMER:int = 1;
      
      private static var _instance:AnalyticsTimer = null;
      
      private const DEBUG_ON:Boolean = false == true;
      
      private var _featuresHeap:Array;
      
      private var _windowString:IWindowString;
      
      public function AnalyticsTimer(param1:SingletonEnforcer)
      {
         super();
         this._featuresHeap = new Array();
         this._windowString = InjectionManager.manager().getInstance(IWindowString) as IWindowString;
      }
      
      public static function getInstance() : AnalyticsTimer
      {
         if(_instance == null)
         {
            _instance = new AnalyticsTimer(new SingletonEnforcer());
            _instance.setupEventListeners();
         }
         return _instance;
      }
      
      public static function forceSendMessages(param1:Array, param2:int, param3:Boolean = false, param4:Boolean = true) : void
      {
         if(_instance != null)
         {
            _instance.sendMessages(param1,param2,param3,param4);
         }
      }
      
      public static function forcePause(param1:Array) : void
      {
         var _loc4_:FeatureItemAnalytics = null;
         var _loc2_:Array = _instance._featuresHeap;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            if(_loc4_.hasAllElementsWithStrings(param1))
            {
               _loc4_.pause();
               return;
            }
            _loc3_++;
         }
         trace("SWRVE ERROR: Feature not found, force pause failed");
      }
      
      public static function forceResume(param1:Array) : void
      {
         var _loc4_:FeatureItemAnalytics = null;
         var _loc2_:Array = _instance._featuresHeap;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            if(_loc4_.hasAllElementsWithStrings(param1))
            {
               _loc4_.resume();
               return;
            }
            _loc3_++;
         }
         trace("SWRVE ERROR: Feature not found, force resume failed");
      }
      
      private function setupEventListeners() : void
      {
         MessageCommunicator.subscribe(WindowEvent.WINDOW_OPENING,this.eventReceived);
         MessageCommunicator.subscribe(WindowEvent.WINDOW_CLOSING,this.eventReceived);
      }
      
      private function eventReceived(param1:MsgEvent) : void
      {
         var _loc3_:Array = null;
         var _loc2_:Object = param1.data;
         if(_loc2_)
         {
            if(this._windowString.isWindowString(_loc2_))
            {
               _loc3_ = this._windowString.getAnalyticsStrings(_loc2_);
            }
            if(_loc2_ is DisplayObject && _loc3_ == null)
            {
               if(_loc2_ is IAnalytics)
               {
                  _loc3_ = (_loc2_ as IAnalytics).getAnalyticsNames();
               }
            }
            if(_loc3_ != null)
            {
               if(param1.type == WindowEvent.WINDOW_OPENING)
               {
                  this.sendMessages(_loc3_,AnalyticsTimer.ENTER_TIMER);
               }
               else if(param1.type == WindowEvent.WINDOW_CLOSING)
               {
                  this.sendMessages(_loc3_,AnalyticsTimer.EXIT_TIMER);
               }
            }
         }
      }
      
      private function checkAndRestartLast() : void
      {
         var _loc1_:FeatureItemAnalytics = this._featuresHeap[this._featuresHeap.length - 1];
         if(_loc1_)
         {
            _loc1_.resume();
         }
      }
      
      private function checkAndPauseOthers() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._featuresHeap.length)
         {
            if(this._featuresHeap[_loc1_].canBeStoppedByOtherFeatures())
            {
               this._featuresHeap[_loc1_].pause();
            }
            _loc1_++;
         }
      }
      
      private function enter(param1:Array, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            if(param1[_loc5_] == TimeSpentConstants.FEATURE_MYROOM_VIEW)
            {
               _loc4_ = true;
            }
            _loc5_++;
         }
         if(myroomEditorWasOpened && _loc4_)
         {
            myroomEditorWasOpened = false;
            return;
         }
         var _loc6_:FeatureItemAnalytics = new FeatureItemAnalytics(param1,param3);
         if(!_loc6_.isAlwaysOpen())
         {
            if(param2)
            {
               this.checkAndPauseOthers();
            }
         }
         this._featuresHeap[this._featuresHeap.length] = _loc6_;
         if(this.DEBUG_ON)
         {
            trace("AnalyticsTimer.enter(): Created enter timestamp for feature: " + param1[0]);
         }
      }
      
      private function leave(param1:Array, param2:Boolean) : void
      {
         var _loc4_:FeatureItemAnalytics = null;
         var _loc5_:int = 0;
         var _loc3_:Array = this.getElementPosition(param1);
         if(_loc3_.length <= 0)
         {
            if(this.DEBUG_ON)
            {
               trace("AnalyticsTimer.leave() -- No enter timestamp found for feature: " + param1[0]);
               trace("AnalyticsTimer.leave() -- Not sending timer event for feature: " + param1[0]);
            }
            return;
         }
         var _loc6_:* = int(_loc3_.length);
         while(_loc6_ > 0)
         {
            _loc5_ = int(_loc3_[_loc6_ - 1]);
            _loc4_ = this._featuresHeap[_loc5_];
            if(_loc4_ != null)
            {
               _loc4_.sendTimeMessage();
            }
            else
            {
               trace("SWRVE ERROR: Feature Item = null");
            }
            this._featuresHeap.splice(_loc5_,1);
            _loc6_--;
         }
         if(!_loc4_.isAlwaysOpen())
         {
            if(param2)
            {
               this.checkAndRestartLast();
            }
         }
      }
      
      private function sendMessages(param1:Array, param2:int, param3:Boolean = true, param4:Boolean = true) : void
      {
         var _loc5_:String = null;
         if(param1 == null || param1.length <= 0)
         {
            trace("Swrve, something went wrong and a null or empty string was received: " + param1);
            return;
         }
         if(param2 == ENTER_TIMER)
         {
            this.enter(param1,param3,param4);
         }
         else if(param2 == EXIT_TIMER)
         {
            this.leave(param1,param3);
         }
         else
         {
            trace("Swrve, error: sendMessage received a wrong enter-exit input");
         }
      }
      
      public function getElementPosition(param1:Array) : Array
      {
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this._featuresHeap.length)
         {
            if(this._featuresHeap[_loc3_].hasAllElementsWithStrings(param1))
            {
               _loc2_.push(_loc3_);
            }
            _loc3_++;
         }
         return _loc2_;
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
