package com.moviestarplanet.version
{
   public class CheckVersion
   {
      
      public var version:String;
      
      public var forceUpdate:Boolean;
      
      public function CheckVersion(param1:String, param2:Boolean = false)
      {
         super();
         this.version = param1;
         this.forceUpdate = param2;
      }
   }
}

