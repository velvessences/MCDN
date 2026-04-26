package com.moviestarplanet.userbehavior.valueObjects
{
   public class UserGeneratedContentField
   {
      
      public var Name:String;
      
      public var Value:String;
      
      public var ContentType:String;
      
      public function UserGeneratedContentField(param1:String, param2:String, param3:String)
      {
         super();
         this.Name = param1;
         this.Value = param2;
         this.ContentType = param3;
      }
      
      public static function generateWithArray(param1:Array, param2:String, param3:String) : Array
      {
         var _loc4_:Array = new Array();
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc4_.push(new UserGeneratedContentField(param2,param1[_loc5_],param3));
            _loc5_++;
         }
         return _loc4_;
      }
   }
}

