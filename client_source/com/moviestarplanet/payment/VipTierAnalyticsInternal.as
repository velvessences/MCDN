package com.moviestarplanet.payment
{
   import com.moviestarplanet.services.wrappers.SessionService;
   
   public class VipTierAnalyticsInternal
   {
      
      private static var _purchaseFlowSwitch:int;
      
      public function VipTierAnalyticsInternal()
      {
         super();
      }
      
      public static function dispatchStartFlow() : void
      {
         var dispatch:Function = null;
         dispatch = function(param1:Boolean):void
         {
            if(param1)
            {
               VipTierAnalytics.dispatchStartFlow();
            }
         };
         usingNewVipTiers(dispatch);
      }
      
      public static function dispatchEvent(param1:String, param2:int, param3:int) : void
      {
         var dispatch:Function = null;
         var eventType:String = param1;
         var packageTier:int = param2;
         var packageDuration:int = param3;
         dispatch = function(param1:Boolean):void
         {
            if(param1)
            {
               VipTierAnalytics.dispatchSwrveEvent(eventType,packageTier,packageDuration);
            }
         };
         usingNewVipTiers(dispatch);
      }
      
      private static function usingNewVipTiers(param1:Function) : void
      {
         var purchaseFlowSwitchFetched:Function;
         var callback:Function = param1;
         var returnCall:Function = function():void
         {
            if(_purchaseFlowSwitch == PaymentModuleExternalManager.USE_NEW_VIP_TIERS)
            {
               callback(true);
            }
            else
            {
               callback(false);
            }
         };
         if(_purchaseFlowSwitch == 0)
         {
            purchaseFlowSwitchFetched = function(param1:int):void
            {
               _purchaseFlowSwitch = param1;
               returnCall();
            };
            SessionService.GetAppSetting("PurchaseFlow",purchaseFlowSwitchFetched);
         }
         else
         {
            returnCall();
         }
      }
   }
}

