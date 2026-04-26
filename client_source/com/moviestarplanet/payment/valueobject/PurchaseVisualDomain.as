package com.moviestarplanet.payment.valueobject
{
   import com.moviestarplanet.utils.StringUtilities;
   
   public class PurchaseVisualDomain
   {
      
      public var Identifier:String;
      
      public var Filename:String;
      
      public function PurchaseVisualDomain()
      {
         super();
      }
      
      public function parseObject(param1:Object) : void
      {
         this.Identifier = StringUtilities.trim(param1.Identifier as String);
         this.Filename = StringUtilities.trim(param1.Filename as String);
      }
   }
}

