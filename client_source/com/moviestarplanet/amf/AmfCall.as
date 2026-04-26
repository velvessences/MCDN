package com.moviestarplanet.amf
{
   import com.moviestarplanet.amf.valueobjects.TicketHeader;
   import flash.net.Responder;
   
   public class AmfCall
   {
      
      public var serviceHost:String;
      
      public var listener:AmfListener;
      
      internal var failCount:int = 0;
      
      private var _isActive:Boolean = false;
      
      private var _args:Array;
      
      private var _callFunc:String;
      
      private var _onSuccess:Function;
      
      private var _onFail:Function;
      
      public function AmfCall(param1:String, param2:Array, param3:Function, param4:Function, param5:String = null)
      {
         super();
         this._args = param2;
         this._callFunc = param1;
         this._onSuccess = param3;
         this._onFail = param4;
         this.serviceHost = param5;
      }
      
      private function onCallFailed(param1:Object) : void
      {
         trace("AmfCall.onCallFailed(obj)");
         if(this.isActive)
         {
            if(this.listener != null)
            {
               this.listener.callDone();
            }
            this.callFailedIfExistsAndDisposeCallbacks(param1);
            AmfCaller.callQueued();
         }
      }
      
      public function generateAndAddNewTicketMarking() : void
      {
         if(this._args != null && this._args.length > 0)
         {
            if(this._args[0] is TicketHeader)
            {
               this._args[0] = TicketGenerator.createTicketHeader();
            }
         }
      }
      
      public function callFailedIfExistsAndDisposeCallbacks(param1:Object) : void
      {
         if(this._onFail != null)
         {
            this._onFail(param1);
         }
         this.disposeCallbacks();
      }
      
      internal function getTicket() : TicketHeader
      {
         if(this._args != null && this._args.length > 0)
         {
            if(this._args[0] is TicketHeader)
            {
               return this._args[0] as TicketHeader;
            }
         }
         return null;
      }
      
      private function disposeCallbacks() : void
      {
         this._onSuccess = null;
         this._onFail = null;
      }
      
      private function onCallSuccess(param1:Object) : void
      {
         if(this.isActive)
         {
            if(this.listener != null)
            {
               this.listener.callDone();
            }
            if(this._onSuccess != null)
            {
               this._onSuccess(AmfCaller.responseFilter.filterResponse(param1));
            }
            this.disposeCallbacks();
            AmfCaller.callQueued();
         }
      }
      
      public function set isActive(param1:Boolean) : void
      {
         this._isActive = param1;
      }
      
      public function get isActive() : Boolean
      {
         return this._isActive;
      }
      
      public function execute(param1:FluorineNetConnection) : void
      {
         var _loc2_:Array = [this._callFunc,new Responder(this.onCallSuccess,this.onCallFailed)];
         _loc2_ = _loc2_.concat(this._args);
         param1.call.apply(this,_loc2_);
      }
      
      public function clone() : AmfCall
      {
         var _loc1_:AmfCall = new AmfCall(this._callFunc,this._args,this._onSuccess,this._onFail,this.serviceHost);
         _loc1_.failCount = this.failCount;
         return _loc1_;
      }
      
      public function get callFunc() : String
      {
         return this._callFunc;
      }
   }
}

