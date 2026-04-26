package com.moviestarplanet.amf
{
   public class AmfCaller
   {
      
      public static var defaultFailHandler:Function;
      
      public static var responseFilter:IAmfResponseFilter;
      
      public static const LOG_CLIENT:String = "LOG_CLIENT";
      
      public static const UNAUTHORIZED_WEB_SERVICE_CALL:String = "MSPEvent.UNAUTHORIZED_WEB_SERVICE_CALL";
      
      private static const DEBUG_TYPE:String = "debug";
      
      public static var maxConcurrentCalls:int = 10;
      
      private static var callQueue:Array = [];
      
      private static var availableListeners:Array = [];
      
      private static var busyListeners:Array = [];
      
      private var _webServiceName:String;
      
      public function AmfCaller(param1:String)
      {
         super();
         this._webServiceName = param1;
      }
      
      public static function doCleanup() : void
      {
         callQueue = [];
      }
      
      public static function set callTimeoutMillis(param1:Number) : void
      {
         AmfListener.TIMEOUT_MILLIS = param1;
      }
      
      internal static function retryCall(param1:AmfCall) : void
      {
         callQueue.unshift(param1.clone());
         callQueued();
      }
      
      internal static function callQueued() : void
      {
         if(callQueue.length < 1)
         {
            return;
         }
         var _loc1_:AmfListener = getListener();
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:AmfCall = callQueue.shift();
         var _loc3_:FluorineNetConnection = new FluorineNetConnection();
         var _loc4_:String = getGatewayForCall(_loc2_);
         var _loc5_:String = _loc4_ + "?method=" + _loc2_.callFunc;
         _loc1_.endListening();
         _loc1_.isCalling = true;
         _loc1_.call = _loc2_;
         _loc1_.startListening(_loc3_);
         _loc3_.connect(_loc5_);
         _loc2_.isActive = true;
         _loc2_.execute(_loc3_);
      }
      
      private static function getListener() : AmfListener
      {
         var _loc1_:AmfListener = null;
         if(availableListeners.length > 0)
         {
            _loc1_ = availableListeners.pop();
            busyListeners.push(_loc1_);
            return _loc1_;
         }
         if(busyListeners.length < maxConcurrentCalls)
         {
            _loc1_ = new AmfListener();
            busyListeners.push(_loc1_);
            return _loc1_;
         }
         return null;
      }
      
      internal static function listenerAvailable(param1:AmfListener) : void
      {
         busyListeners.splice(busyListeners.indexOf(param1),1);
         availableListeners.push(param1);
      }
      
      private static function getGatewayForCall(param1:AmfCall) : String
      {
         if(param1.serviceHost != null)
         {
            return param1.serviceHost + "Gateway.aspx";
         }
         return ServiceUrlUtil.getServiceUrlBase() + "Gateway.aspx";
      }
      
      public function callFunction(param1:String, param2:Array, param3:Boolean, param4:Function, param5:Function = null, param6:String = null) : void
      {
         if(param5 == null && defaultFailHandler != null)
         {
            param5 = defaultFailHandler;
         }
         if(param3)
         {
            param2.splice(0,0,TicketGenerator.createTicketHeader());
         }
         var _loc7_:AmfCall = new AmfCall(this._webServiceName + "." + param1,param2,param4,param5,param6);
         callQueue.push(_loc7_);
         callQueued();
      }
   }
}

