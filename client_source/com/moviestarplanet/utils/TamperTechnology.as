package com.moviestarplanet.utils
{
   public class TamperTechnology
   {
      
      private static var z:int;
      
      private static var r:int;
      
      private static var i:TamperTechnology = new TamperTechnology();
      
      private var x:Object = {"Code":"Code"};
      
      public function TamperTechnology()
      {
         super();
         if(i != null)
         {
            throw new Error("use the static function");
         }
      }
      
      public static function isSafe() : Boolean
      {
         return i.s();
      }
      
      public static function createHashedActorId(param1:int) : void
      {
         r = int(7 + Math.random() * 9999);
         z = (param1 - r) * 2;
      }
      
      public static function hasActorIdBeenModified(param1:int) : Boolean
      {
         return z != (param1 - r) * 2;
      }
      
      private function s() : Boolean
      {
         if(this.x == null)
         {
            return false;
         }
         var _loc1_:Boolean = this.checkInnerWord("Co","de");
         if(_loc1_ == false)
         {
            return false;
         }
         return true;
      }
      
      private function checkInnerWord(param1:String, param2:String) : Boolean
      {
         var _loc3_:String = param1 + param2;
         var _loc4_:Boolean = Boolean(this.x.hasOwnProperty(_loc3_));
         var _loc5_:Object = this.x[_loc3_];
         var _loc6_:Boolean = _loc3_ == _loc5_;
         return _loc4_ && Boolean(_loc5_) && _loc6_;
      }
   }
}

