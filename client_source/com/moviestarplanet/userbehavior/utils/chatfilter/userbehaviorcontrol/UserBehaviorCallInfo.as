package com.moviestarplanet.userbehavior.utils.chatfilter.userbehaviorcontrol
{
   import com.moviestarplanet.userbehavior.IRedifyableTextInputComponent;
   
   public class UserBehaviorCallInfo
   {
      
      private static var callIndexId:int = 0;
      
      private var _callId:int;
      
      private var _textInputField:IRedifyableTextInputComponent;
      
      private var _callback:Function;
      
      private var _failCallback:Function;
      
      private var _sentMessage:String;
      
      public function UserBehaviorCallInfo(param1:IRedifyableTextInputComponent, param2:Function, param3:Function)
      {
         super();
         this._callId = callIndexId;
         ++callIndexId;
         this._textInputField = param1;
         this._sentMessage = param1.text;
         this._callback = param2;
         this._failCallback = param3;
      }
      
      public function get callId() : int
      {
         return this._callId;
      }
      
      public function get sentMessage() : String
      {
         return this._sentMessage;
      }
      
      public function get callback() : Function
      {
         return this._callback;
      }
      
      public function get failCallback() : Function
      {
         return this._failCallback;
      }
      
      public function get textInputField() : IRedifyableTextInputComponent
      {
         return this._textInputField;
      }
      
      public function clear() : void
      {
         this._callback = null;
         this._failCallback = null;
         this._sentMessage = null;
         this._textInputField = null;
         this._sentMessage = null;
      }
   }
}

