package com.moviestarplanet.activespecials
{
   import com.moviestarplanet.commonvalueobjects.login.PostLoginData;
   import com.moviestarplanet.constants.events.EventsConstants;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.services.spendingservice.valueObjects.ActiveSpecialsResultType;
   import com.moviestarplanet.spending.SpendingProvider;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   
   public class ActiveSpecialsHandler
   {
      
      private static var _activeSpecials:Array;
      
      private static var _timers:Array;
      
      public static var dateNow:Date;
      
      private static var dispatcher:EventDispatcher = new EventDispatcher();
      
      private static const TIMER_INTERVAL_MILLIS:Number = 5000;
      
      public function ActiveSpecialsHandler()
      {
         super();
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public static function dispatchEvent(param1:Event) : Boolean
      {
         return dispatcher.dispatchEvent(param1);
      }
      
      public static function getActiveSpecialsItems(param1:int) : void
      {
         SpendingProvider.getActiveSpecialsItems(param1,activeSpecialsGotten);
      }
      
      private static function activeSpecialsGotten(param1:Array) : void
      {
         activeSpecials = param1;
      }
      
      public static function getActiveSpecialsItemsFromBundle() : void
      {
         MessageCommunicator.subscribe(EventsConstants.POST_LOGIN_BUNDLE_RECEIVED,onDataReceived);
      }
      
      private static function onDataReceived(param1:MsgEvent) : void
      {
         MessageCommunicator.unscribe(EventsConstants.POST_LOGIN_BUNDLE_RECEIVED,onDataReceived);
         var _loc2_:PostLoginData = param1.data as PostLoginData;
         activeSpecialsGotten(_loc2_.ActiveSpecialsItems.source);
      }
      
      public static function set activeSpecials(param1:Array) : void
      {
         var _loc2_:Object = null;
         var _loc3_:DataTimer = null;
         var _loc4_:ActiveSpecialsResultType = null;
         var _loc5_:ActiveSpecial = null;
         var _loc6_:DataTimer = null;
         if(_timers == null)
         {
            _timers = new Array();
         }
         if(_activeSpecials == null)
         {
            _activeSpecials = new Array();
         }
         while(_timers.length > 0)
         {
            _loc3_ = _timers.pop();
            _loc3_.stop();
            _loc3_.removeEventListener(TimerEvent.TIMER,timerHandler);
         }
         _activeSpecials.length = 0;
         for each(_loc2_ in param1)
         {
            if(_loc2_ is ActiveSpecialsResultType)
            {
               _loc4_ = _loc2_ as ActiveSpecialsResultType;
            }
            else
            {
               _loc4_ = new ActiveSpecialsResultType(_loc2_);
            }
            _loc5_ = new ActiveSpecial();
            _loc5_.type = _loc4_.type;
            _loc5_.duration = _loc4_.duration;
            _loc5_.expirationDate = new Date();
            _loc5_.expirationDate.setSeconds(_loc5_.expirationDate.getSeconds() + _loc4_.seconds);
            _activeSpecials.push(_loc5_);
            _loc6_ = new DataTimer(_loc5_,TIMER_INTERVAL_MILLIS);
            _loc6_.addEventListener(TimerEvent.TIMER,timerHandler);
            _loc6_.start();
            _timers.push(_loc6_);
            sendActiveSpecialsMessage(_loc5_.type);
         }
      }
      
      private static function timerHandler(param1:TimerEvent) : void
      {
         var _loc2_:DataTimer = param1.target as DataTimer;
         var _loc3_:int = getSecondsForActiveSpecial(_loc2_.data.type);
         if(_loc3_ <= 0)
         {
            _loc2_.stop();
            _loc2_.removeEventListener(TimerEvent.TIMER,timerHandler);
            _activeSpecials.splice(_activeSpecials.indexOf(_loc2_.data),1);
         }
         sendActiveSpecialsMessage(_loc2_.data.type);
      }
      
      private static function sendActiveSpecialsMessage(param1:String) : void
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case ActiveSpecialsType.FAMEBOOSTER:
               _loc2_ = ActiveSpecialsEvent.FAMEBOOSTER_ACTIVE;
               break;
            case ActiveSpecialsType.SHOPPINGSPREE:
               _loc2_ = ActiveSpecialsEvent.SHOPPINGSPREE_ACTIVE;
               break;
            case ActiveSpecialsType.DIAMONDCHARACTEREFFECT:
               _loc2_ = ActiveSpecialsEvent.SHOPPINGSPREE_ACTIVE;
         }
         dispatchEvent(new ActiveSpecialsEvent(_loc2_,param1));
      }
      
      public static function get activeSpecials() : Array
      {
         return _activeSpecials;
      }
      
      public static function getActiveSpecial(param1:String) : ActiveSpecial
      {
         var _loc2_:ActiveSpecial = null;
         for each(_loc2_ in _activeSpecials)
         {
            if(_loc2_.type == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function hasActiveSpecial(param1:String) : Boolean
      {
         if(getActiveSpecial(param1) != null)
         {
            return true;
         }
         return false;
      }
      
      public static function getSecondsForActiveSpecial(param1:String) : int
      {
         var _loc3_:int = 0;
         dateNow = new Date();
         var _loc2_:ActiveSpecial = getActiveSpecial(param1);
         if(_loc2_ != null)
         {
            return int(Math.floor((_loc2_.expirationDate.valueOf() - dateNow.valueOf()) / 1000));
         }
         return 0;
      }
      
      public static function getMinutesForActiveSpecial(param1:String) : int
      {
         var _loc2_:int = getSecondsForActiveSpecial(param1);
         var _loc3_:int = 0;
         if(_loc2_ > 0)
         {
            _loc3_ = toDisplayableMinutes(_loc2_);
         }
         return _loc3_;
      }
      
      public static function toDisplayableMinutes(param1:int) : int
      {
         param1--;
         return Math.floor((param1 + 60) / 60);
      }
      
      public static function getDurationForActiveSpecial(param1:String) : int
      {
         var _loc2_:ActiveSpecial = getActiveSpecial(param1);
         if(_loc2_ != null)
         {
            return _loc2_.duration;
         }
         return 0;
      }
   }
}

