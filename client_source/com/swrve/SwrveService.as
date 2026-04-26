package com.swrve
{
   import flash.utils.Dictionary;
   
   public class SwrveService
   {
      
      private static var instance:SwrveService;
      
      private var _api:SwrveApi;
      
      private var _pendingEvents:Object;
      
      public function SwrveService(param1:SingletonEnforcer)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Singleton Error. Use SwrveService.getInstance() instead.");
         }
      }
      
      public static function getInstance() : SwrveService
      {
         if(instance == null)
         {
            instance = new SwrveService(new SingletonEnforcer());
         }
         return instance;
      }
      
      public static function isInitialized() : Boolean
      {
         if(instance != null && instance._api != null)
         {
            return true;
         }
         return false;
      }
      
      public function init(param1:String, param2:String, param3:int, param4:String, param5:String) : void
      {
         this._api = new SwrveApi(param1,param2,param3,param4,param5);
      }
      
      public function sessionStart() : void
      {
         if(this._api != null)
         {
            this._api.sessionStart();
         }
         else
         {
            trace("Swrve Debug: sessionStart()");
         }
      }
      
      public function sessionEnd() : void
      {
         if(this._api != null)
         {
            this._api.sessionEnd();
         }
         else
         {
            trace("Swrve Debug: sessionEnd()");
         }
      }
      
      public function getSessionCloseData() : String
      {
         if(this._api != null)
         {
            return this._api.getSessionCloseData();
         }
         trace("Swrve Debug: getSessionCloseData()");
         return "";
      }
      
      public function event(param1:String, param2:Object) : void
      {
         if(this._api != null)
         {
            this._api.event(param1,param2);
         }
         else
         {
            trace("Swrve Debug: event(" + param1 + ", " + param2 + ")");
         }
      }
      
      public function purchase(param1:String, param2:String, param3:int, param4:int = 1) : void
      {
         if(this._api != null)
         {
            this._api.purchase(param1,param2,param3,param4);
         }
         else
         {
            trace("Swrve Debug: purchase(" + param1 + ", " + param2 + ", " + param3 + ", " + param4 + ")");
         }
      }
      
      public function receiveCurrency(param1:int, param2:String) : void
      {
         if(this._api != null)
         {
            this._api.currencyGiven(param1,param2);
         }
         else
         {
            trace("Swrve Debug: receiveCurrency(" + param1 + ", " + param2 + ")");
         }
      }
      
      public function user(param1:Object) : void
      {
         if(this._api != null)
         {
            this._api.user(param1);
         }
         else
         {
            trace("Swrve Debug: user(" + param1 + ")");
         }
      }
      
      public function buyIn(param1:Number, param2:String, param3:int, param4:String, param5:String = null) : void
      {
         if(this._api != null)
         {
            this._api.buyIn(param1,param2,param3,param4,param5);
         }
         else
         {
            trace("Swrve Debug: buyIn(" + param1 + ", " + param2 + ", " + param3 + ", " + param5 + ")");
         }
      }
      
      public function createItemsBulk(param1:String, param2:Object) : void
      {
         if(this._api != null)
         {
            this._api.itemsBulk(param1,param2);
         }
         else
         {
            trace("Swrve Debug: createItemsBulk(" + param1 + ", " + param2 + ")");
         }
      }
      
      public function addPendingEvent(param1:String, param2:Object) : void
      {
         if(this._pendingEvents == null)
         {
            this._pendingEvents = new Dictionary();
         }
         this._pendingEvents[param1] = param2;
      }
      
      public function flushPendingEvents() : void
      {
         var _loc1_:String = null;
         if(this._pendingEvents == null)
         {
            return;
         }
         for(_loc1_ in this._pendingEvents)
         {
            this.event(_loc1_,this._pendingEvents[_loc1_]);
            this._pendingEvents[_loc1_] = null;
            delete this._pendingEvents[_loc1_];
         }
         this._pendingEvents = null;
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
