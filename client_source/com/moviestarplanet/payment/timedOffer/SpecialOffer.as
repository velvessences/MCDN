package com.moviestarplanet.payment.timedOffer
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class SpecialOffer extends EventDispatcher
   {
      
      private static var offer:SpecialOffer;
      
      public static const FIRST_TIME:int = 1;
      
      public static const RESALE:int = 2;
      
      public static const TOP_UP:int = 3;
      
      public static const EVENT_RESET_CORNER:String = "SpecialOffer.RESET_CORNER";
      
      public static const EVENT_OFFER_USED:String = "SpecialOffer.OFFER_USED";
      
      public static const EVENT_TIMES_UP:String = "SpecialOffer.TIMES_UP";
      
      public static const EVENT_GRACE_PERIOD_UP:String = "SpecialOffer.GRACE_PERIOD_UP";
      
      public var OfferId:int;
      
      public var PurchaseType:String;
      
      private var TimeRemaining:int;
      
      public var Multiplier:Number;
      
      private var msOnLoad:int;
      
      public function SpecialOffer()
      {
         super();
         this.msOnLoad = getTimer();
      }
      
      public static function get activeOffer() : SpecialOffer
      {
         return offer;
      }
      
      public static function useOffer() : void
      {
         var _loc1_:SpecialOffer = offer;
         offer = null;
         if(_loc1_ != null)
         {
            _loc1_.dispatchEvent(new Event(EVENT_OFFER_USED));
            _loc1_.dispatchEvent(new Event(EVENT_RESET_CORNER));
         }
      }
      
      public static function clear() : void
      {
         offer = null;
      }
      
      public static function setOfferFromObject(param1:Object) : void
      {
         if(param1 == null)
         {
            offer = null;
            return;
         }
         offer = new SpecialOffer();
         offer.Multiplier = param1.Multiplier;
         offer.OfferId = param1.OfferId;
         offer.PurchaseType = param1.PurchaseType;
         offer.TimeRemaining = param1.SecondsRemaining;
      }
      
      public static function specialFirstTimeOfferCheck() : Boolean
      {
         if(Boolean(SpecialOffer.activeOffer) && Boolean(SpecialOffer.activeOffer.OfferId == SpecialOffer.FIRST_TIME) && SpecialOffer.activeOffer.SecondsRemaining > 85800)
         {
            return true;
         }
         return false;
      }
      
      public function timesUp() : void
      {
         var time:int;
         var timer:Timer = null;
         var onTimerEnd:Function = null;
         onTimerEnd = function(param1:TimerEvent):void
         {
            timer.removeEventListener(TimerEvent.TIMER,onTimerEnd);
            dispatchEvent(new Event(EVENT_GRACE_PERIOD_UP));
         };
         dispatchEvent(new Event(EVENT_TIMES_UP));
         dispatchEvent(new Event(EVENT_RESET_CORNER));
         time = 60 * 60 * 1000;
         timer = new Timer(time,1);
         timer.addEventListener(TimerEvent.TIMER,onTimerEnd);
         timer.start();
      }
      
      public function get SecondsRemaining() : int
      {
         var _loc1_:int = (getTimer() - this.msOnLoad) / 1000;
         return this.TimeRemaining - _loc1_;
      }
   }
}

