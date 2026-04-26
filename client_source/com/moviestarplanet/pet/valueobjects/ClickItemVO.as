package com.moviestarplanet.pet.valueobjects
{
   import flash.utils.ByteArray;
   
   public class ClickItemVO
   {
      
      public var ClickItemId:int;
      
      public var Name:String;
      
      public var Description:String;
      
      public var Price:int;
      
      public var SWF:String;
      
      public var Data:ByteArray;
      
      public var isNew:int;
      
      public var Discount:int;
      
      public var ThemeId:int;
      
      public var DiamondsPrice:int;
      
      public var MaxStage:int;
      
      public function ClickItemVO()
      {
         super();
      }
      
      public static function GetInstance(param1:Object) : ClickItemVO
      {
         var _loc2_:ClickItemVO = new ClickItemVO();
         _loc2_.ClickItemId = param1.ClickItemId;
         _loc2_.Name = param1.Name;
         _loc2_.Description = param1.Description;
         _loc2_.Price = param1.Price;
         _loc2_.SWF = param1.SWF;
         _loc2_.Data = param1.Data;
         _loc2_.isNew = param1.isNew;
         _loc2_.Discount = param1.Discount;
         _loc2_.DiamondsPrice = param1.DiamondsPrice;
         _loc2_.MaxStage = param1.MaxStage;
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

