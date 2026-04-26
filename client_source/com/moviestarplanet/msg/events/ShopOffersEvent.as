package com.moviestarplanet.msg.events
{
   import com.moviestarplanet.events.MsgEvent;
   
   public class ShopOffersEvent extends MsgEvent
   {
      
      public static const PAYMENT_OFFERS:String = "ShopOffersEvent.PAYMENT_OFFERS";
      
      public static const VIP:String = "ShopOffersEvent.VIP";
      
      public static const STARTCOINS:String = "ShopOffersEvent.STARTCOINS";
      
      public static const DIAMONDS:String = "ShopOffersEvent.DIAMONDS";
      
      public static const CAMPAIGN:String = "ShopOffersEvent.CAMPAIGN";
      
      public static const OPEN_PAYMENT_SCREEN:String = "ShopOffersEvent.OPEN_PAYMENT_SCREEN";
      
      public static const OPEN_SHOPPING_MODULE_WITH_LOOK:String = "ShopOffersEvent.OPEN_SHOPPING_MODULE_WITH_LOOK";
      
      public static const PIGGYBANK_VIP:String = "ShopOffersEvent.PIGGYBANK_VIP";
      
      public static const NEED_VIP_TO_SPIN_WHEEL:String = "ShopOffersEvent.NEED_VIP_TO_SPIN_WHEEL";
      
      public static const EMOTICON_PURCHASE_REQUIRED:String = "ShopOffersEvent.EMOTICON_PURCHASE_REQUIRED";
      
      public function ShopOffersEvent(param1:String, param2:* = null, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

