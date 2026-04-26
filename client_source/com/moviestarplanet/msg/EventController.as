package com.moviestarplanet.msg
{
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   
   public class EventController implements EventControllerInterface
   {
      
      private var eventDispatchers:Array;
      
      private var waitingEventObjects:Dictionary;
      
      private var notificationFunction:Function;
      
      private var notificationParameters:Array;
      
      private var eventsExpected:int;
      
      private var eventsCompleted:int;
      
      public function EventController()
      {
         super();
         this.eventsCompleted = 0;
         this.eventsExpected = 0;
         this.waitingEventObjects = new Dictionary(true);
         this.eventDispatchers = new Array();
      }
      
      public function listenForEvent(param1:IEventDispatcher, param2:String, param3:int = 0) : void
      {
         ++this.eventsExpected;
         var _loc4_:Dictionary = this.waitingEventObjects[param1];
         if(_loc4_ == null)
         {
            _loc4_ = new Dictionary(true);
         }
         _loc4_[param2] = false;
         this.waitingEventObjects[param1] = _loc4_;
         param1.addEventListener(param2,this.eventFired,false,param3,false);
         this.eventDispatchers.push({
            "dispatcher":param1,
            "eventString":param2
         });
      }
      
      private function eventFired(param1:Event) : void
      {
         var _loc2_:IEventDispatcher = IEventDispatcher(param1.target);
         _loc2_.removeEventListener(param1.type,this.eventFired,false);
         var _loc3_:Dictionary = this.waitingEventObjects[_loc2_];
         if(_loc3_[param1.type] == false)
         {
            _loc3_[param1.type] = true;
            ++this.eventsCompleted;
            this.checkNotify();
         }
      }
      
      public function notifyMe(param1:Function, ... rest) : void
      {
         this.notificationFunction = param1;
         this.notificationParameters = rest;
         this.checkNotify();
      }
      
      public function removeNotify() : void
      {
         this.notificationFunction = null;
      }
      
      private function checkNotify() : void
      {
         if(this.eventsCompleted >= this.eventsExpected)
         {
            if(this.notificationFunction != null)
            {
               this.notificationFunction.apply(null,this.notificationParameters);
            }
            this.destroy();
         }
      }
      
      public function hasCompleted() : Boolean
      {
         return this.eventsCompleted >= this.eventsExpected;
      }
      
      public function destroy() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         var _loc3_:Dictionary = null;
         var _loc4_:Object = null;
         for(_loc1_ in this.waitingEventObjects)
         {
            _loc3_ = this.waitingEventObjects[_loc1_] as Dictionary;
            for(_loc4_ in _loc3_)
            {
               delete _loc3_[_loc4_];
            }
            delete this.waitingEventObjects[_loc1_];
         }
         for each(_loc2_ in this.eventDispatchers)
         {
            _loc2_.dispatcher.removeEventListener(_loc2_.eventString,this.eventFired);
            _loc2_ = null;
         }
         if(this.eventDispatchers)
         {
            this.eventDispatchers.length = 0;
            this.eventDispatchers = null;
         }
         this.waitingEventObjects = null;
         this.notificationFunction = null;
         this.notificationParameters = null;
      }
   }
}

