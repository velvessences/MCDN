package com.moviestarplanet.userbehavior.valueObjects
{
   public class FilteredResponse
   {
      
      public var FilteredString:String;
      
      public var EvaluateType:int;
      
      public var MaxResult:int;
      
      private var _Parts:Array;
      
      public var Result:int;
      
      public function FilteredResponse()
      {
         super();
      }
      
      public function set Parts(param1:*) : void
      {
         if(param1 is Array)
         {
            this._Parts = param1;
         }
         else if((param1 as Object).hasOwnProperty("toArray"))
         {
            this._Parts = (param1 as Object)["toArray"]();
         }
      }
      
      public function get Parts() : Array
      {
         return this._Parts;
      }
   }
}

