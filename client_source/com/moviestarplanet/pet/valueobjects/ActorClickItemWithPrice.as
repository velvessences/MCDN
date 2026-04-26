package com.moviestarplanet.pet.valueobjects
{
   public class ActorClickItemWithPrice
   {
      
      public var ActorClickItem:ActorClickItemRel;
      
      public var Price:int;
      
      public function ActorClickItemWithPrice()
      {
         super();
      }
      
      public static function GetInstance(param1:Object) : ActorClickItemWithPrice
      {
         var _loc2_:ActorClickItemWithPrice = new ActorClickItemWithPrice();
         _loc2_.ActorClickItem = ActorClickItemRel.GetInstance(param1.ActorClickItem);
         _loc2_.Price = param1.Price;
         return _loc2_;
      }
      
      public static function GetInstanceArray(param1:Object) : Array
      {
         var _loc4_:Object = null;
         var _loc2_:Array = param1 as Array;
         var _loc3_:Array = new Array();
         for each(_loc4_ in _loc2_)
         {
            _loc3_.push(GetInstance(_loc4_));
         }
         return _loc3_;
      }
   }
}

