package com.moviestarplanet.payment.valueobject
{
   import mx.utils.StringUtil;
   
   public class PropertyPair
   {
      
      public var property:String;
      
      public var value:String;
      
      public function PropertyPair()
      {
         super();
      }
      
      public function parseObject(param1:Object) : void
      {
         this.property = StringUtil.trim(param1.property as String);
         this.value = StringUtil.trim(param1.value as String);
      }
   }
}

