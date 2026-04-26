package com.moviestarplanet.amf
{
   import mx.collections.ArrayCollection;
   
   public class PagerResultObject
   {
      
      public var totalRecords:int;
      
      public var isFullPage:Boolean;
      
      public var pageData:Object;
      
      public var pageIndex:int;
      
      public function PagerResultObject(param1:int = -1, param2:Boolean = false, param3:Object = null, param4:int = -1)
      {
         super();
         this.totalRecords = param1;
         this.isFullPage = param2;
         this.pageData = param3;
         this.pageIndex = param4;
      }
      
      public static function GetPagerResultObject(param1:*, param2:int, param3:int) : PagerResultObject
      {
         var _loc4_:ArrayCollection = param1 as ArrayCollection;
         if(param1 is Array)
         {
            _loc4_ = new ArrayCollection(param1);
         }
         var _loc5_:Array = new Array();
         var _loc6_:int = param2 * param3;
         var _loc7_:int = 0;
         while(_loc7_ < param3 && _loc6_ + _loc7_ < _loc4_.length)
         {
            _loc5_[_loc7_] = _loc4_[_loc6_ + _loc7_];
            _loc7_++;
         }
         var _loc8_:Boolean = _loc5_.length == param3;
         return new PagerResultObject(_loc4_.length,_loc8_,_loc5_,param2);
      }
   }
}

