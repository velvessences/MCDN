package com.moviestarplanet.gift
{
   import flash.net.SharedObject;
   
   public class GetIpAddressesCommand
   {
      
      public function GetIpAddressesCommand()
      {
         super();
      }
      
      public function execute() : Array
      {
         var _loc6_:int = 0;
         var _loc1_:SharedObject = SharedObject.getLocal("MSPUserIPList");
         var _loc2_:String = _loc1_.data.userIpList;
         var _loc3_:Array = new Array();
         if(_loc2_ == null || _loc2_.length == 0)
         {
            return _loc3_;
         }
         var _loc4_:Array = _loc2_.split("|");
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = int(int(_loc4_[_loc5_]));
            if(_loc6_ != 0)
            {
               _loc3_.push(_loc6_);
            }
            _loc5_++;
         }
         return _loc3_;
      }
   }
}

