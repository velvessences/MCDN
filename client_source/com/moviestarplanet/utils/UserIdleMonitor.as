package com.moviestarplanet.utils
{
   import com.moviestarplanet.analytics.AnalyticsSendEventCommand;
   import com.moviestarplanet.analytics.constants.AnalyticsConstants;
   import com.moviestarplanet.logging.Log;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.utils.Timer;
   
   public class UserIdleMonitor
   {
      
      public static var IDLE_LOGOUT_PARAM:String = "idlelogout";
      
      private static var _instance:UserIdleMonitor = null;
      
      private var timer:Timer;
      
      public function UserIdleMonitor(param1:Function = null)
      {
         super();
         if(param1 != singletonBlocker)
         {
            throw new Error("UserIdleMonitor is a singleton class, use UserIdleMonitor.getInstance() instead!");
         }
      }
      
      public static function getInstance() : UserIdleMonitor
      {
         if(_instance == null)
         {
            _instance = new UserIdleMonitor(singletonBlocker);
         }
         return _instance;
      }
      
      private static function singletonBlocker() : void
      {
      }
      
      public function start(param1:Stage, param2:int) : void
      {
         if(param2 <= 0)
         {
            return;
         }
         this.timer = new Timer(param2 * 60 * 1000,1);
         param1.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.timer.addEventListener(TimerEvent.TIMER,this.onTimer);
         this.timer.start();
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         this.timer.reset();
         this.timer.start();
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         var _loc4_:String = null;
         AnalyticsSendEventCommand.execute(AnalyticsConstants.SESSION + AnalyticsConstants.AUTO_LOGOUT_INACTIVITY);
         Log.getInstance().log(Log.INFO,"IDLE_LOGOUT");
         var _loc2_:String = ExternalInterface.call("window.location.href.toString");
         var _loc3_:Array = _loc2_.split("?");
         if(_loc3_.length > 1)
         {
            _loc2_ = _loc3_[0];
            _loc4_ = _loc3_[1];
         }
         else
         {
            _loc2_ = _loc3_[0];
            _loc4_ = null;
         }
         var _loc5_:URLRequest = new URLRequest(_loc2_);
         _loc5_.method = URLRequestMethod.GET;
         var _loc6_:URLVariables = new URLVariables(_loc4_);
         _loc6_[IDLE_LOGOUT_PARAM] = "true";
         _loc5_.data = _loc6_;
         navigateToURL(_loc5_,"_self");
      }
   }
}

