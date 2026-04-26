package com.moviestarplanet.userbehavior.valueObjects
{
   public class EvaluateResponse
   {
      
      private var _FilteredResponses:Array;
      
      public var ServiceStatus:int;
      
      public var MessageId:int;
      
      public var Timestamp:Number;
      
      public function EvaluateResponse()
      {
         super();
      }
      
      public function set FilteredResponses(param1:*) : void
      {
         if(param1 == null)
         {
            this._FilteredResponses = null;
         }
         else if(param1 is Array)
         {
            this._FilteredResponses = param1;
         }
         else if((param1 as Object).hasOwnProperty("toArray"))
         {
            this._FilteredResponses = (param1 as Object)["toArray"]();
         }
      }
      
      public function get FilteredResponses() : Array
      {
         return this._FilteredResponses;
      }
   }
}

