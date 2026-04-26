package com.moviestarplanet.core.controller.listeners
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.payment.PaymentModuleExternalManager;
   
   public class VIPStoreOperator
   {
      
      public function VIPStoreOperator()
      {
         super();
      }
      
      public static function wireup() : void
      {
         MessageCommunicator.subscribe(MSPEvent.OPEN_PURCHASE_FLOW,requestOpenPurchaseFlow);
      }
      
      public static function requestOpenPurchaseFlow(param1:MsgEvent) : void
      {
         PaymentModuleExternalManager.getInstance().openPurchaseFlow();
      }
   }
}

