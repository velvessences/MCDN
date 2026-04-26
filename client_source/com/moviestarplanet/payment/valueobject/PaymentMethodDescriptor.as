package com.moviestarplanet.payment.valueobject
{
   import mx.collections.ArrayCollection;
   import mx.utils.StringUtil;
   
   public class PaymentMethodDescriptor
   {
      
      public var id:String;
      
      public var name:String;
      
      public var category:String;
      
      public var description:String;
      
      public var logo:String;
      
      public var showToolTip:Boolean;
      
      public var provider:String;
      
      public var providerArguments:ArrayCollection;
      
      public var keys:ArrayCollection;
      
      public var tdSecure:Boolean;
      
      public var recurring:Boolean;
      
      public var recurringPreChecked:Boolean;
      
      public var upgrade:Boolean;
      
      public var hiddenInFrontPage:Boolean;
      
      public function PaymentMethodDescriptor()
      {
         super();
      }
      
      public function parseObject(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:PropertyPair = null;
         this.id = StringUtil.trim(param1.id as String);
         this.name = StringUtil.trim(param1.name as String);
         this.category = StringUtil.trim(param1.category as String);
         this.description = StringUtil.trim(param1.description as String);
         this.logo = StringUtil.trim(param1.logo as String);
         this.showToolTip = param1.showToolTip as Boolean;
         this.provider = StringUtil.trim(param1.provider as String);
         this.tdSecure = param1.tdSecure as Boolean;
         this.recurring = param1.recurring as Boolean;
         this.recurringPreChecked = param1.recurringPreChecked as Boolean;
         this.upgrade = param1.upgrade as Boolean;
         this.hiddenInFrontPage = param1.hiddenInFrontPage as Boolean;
         this.keys = param1.keys as ArrayCollection;
         this.providerArguments = new ArrayCollection();
         for each(_loc2_ in param1.providerArguments)
         {
            _loc3_ = new PropertyPair();
            _loc3_.parseObject(_loc2_);
            this.providerArguments.addItem(_loc3_);
         }
      }
   }
}

