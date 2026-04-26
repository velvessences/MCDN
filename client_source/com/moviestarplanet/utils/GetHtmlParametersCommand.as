package com.moviestarplanet.utils
{
   import flash.external.ExternalInterface;
   
   public class GetHtmlParametersCommand
   {
      
      public function GetHtmlParametersCommand()
      {
         super();
      }
      
      public function execute(param1:String = null) : Object
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         if(param1 == null)
         {
            param1 = ExternalInterface.call("eval","document.location.href");
         }
         var _loc2_:Object = new Object();
         var _loc3_:Array = param1.split("?");
         if(_loc3_.length >= 2)
         {
            _loc4_ = _loc3_[1].split("&");
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc6_ = _loc4_[_loc5_].split("=");
               _loc7_ = _loc6_[0];
               _loc8_ = _loc6_[1];
               _loc2_[_loc7_] = _loc8_;
               _loc5_++;
            }
         }
         return _loc2_;
      }
   }
}

