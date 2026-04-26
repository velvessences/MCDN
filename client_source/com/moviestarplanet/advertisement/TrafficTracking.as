package com.moviestarplanet.advertisement
{
   import com.moviestarplanet.config.ISiteConfig;
   import flash.external.ExternalInterface;
   import flash.utils.Dictionary;
   
   public class TrafficTracking
   {
      
      [Inject]
      public static var siteConfig:ISiteConfig;
      
      private static var _orderIdsFrontPage:Dictionary;
      
      private static var _orderIdsCheckOut:Dictionary;
      
      public function TrafficTracking()
      {
         super();
      }
      
      public static function FrontPageOpened() : void
      {
         var _loc1_:String = siteConfig.country;
         var _loc2_:String = "Front page " + _loc1_;
         var _loc3_:String = "Buttons|Play";
         callAdformTracking(_loc2_,_loc3_,orderIdsFrontPage[_loc1_]);
         if(_loc1_ == "fr")
         {
            FloodlightAdTracking.trackActivity2(3688583,"msp2015","hp");
         }
      }
      
      public static function CreateNewUser() : void
      {
         if(siteConfig == null)
         {
            return;
         }
         var _loc1_:String = siteConfig.country;
         FloodlightAdTracking.newUserCreated(_loc1_);
         ExternalInterface.call("trackCreateNewUser");
         adformTrackCreateNewUser(_loc1_);
      }
      
      public static function PurchaseVIP(param1:String = "", param2:String = "") : void
      {
         if(siteConfig == null)
         {
            return;
         }
         var _loc3_:String = siteConfig.country;
         ExternalInterface.call("trackPurchaseVIP");
         ExternalInterface.call("f=function(){window.adf.Params.PageName = encodeURIComponent(\"Moviestarplanet| " + _loc3_ + " | InAppPurchase | ThankYou\");window.adf.Params.Divider = encodeURIComponent(\"|\"); window.adf.track(\"91147\", null, {\"productname\": \"" + param2 + "\",\"currency\": \"" + _loc3_ + "\",\"orderid\": \"" + param1 + "\"});}()");
      }
      
      public static function BuildingCharacter(param1:Boolean) : void
      {
         var floodlightTag:String = null;
         var result:Object = null;
         var isGirl:Boolean = param1;
         var country:String = siteConfig != null ? siteConfig.country : "dk";
         if(country == "com")
         {
            floodlightTag = "https://3544773.fls.doubleclick.net/activityi;" + "src=3544773;type=msp20993;cat=doneb035;" + "ord=" + Math.floor(Math.random() * 100000000) + "?";
            ExternalInterface.call("f=function(){if(document.getElementById(\"DCLK_FLDiv\")){var flDiv=document.getElementById(\"DCLK_FLDiv\");}else{var flDiv=document.body.appendChild(document.createElement(\"div\"));void(flDiv.setAttribute(\"id\",\"DCLK_FLDiv\"));void(flDiv.style.position=\"absolute\");void(flDiv.style.visibility=\"hidden\");void(flDiv.style.top=\"0px\");}void(flDiv.innerHTML=\'<iframe id=\"DCLK_FLIframe\" src=\"" + floodlightTag + "\"></iframe>\');}");
         }
         else if(country == "au")
         {
            FloodlightAdTracking.trackActivity(4827504,"msp_w0","msp-d0");
         }
         try
         {
            trace("PREADVERTISEMENT");
            result = ExternalInterface.call("trackBuildingCharacter",isGirl);
            trace("ADVERTISEMENT: " + result);
         }
         catch(e:Error)
         {
            trace(e);
         }
         adformTrackBuildingCharacter(isGirl,country);
      }
      
      public static function ClickNewUser() : void
      {
         if(siteConfig == null)
         {
            return;
         }
         var _loc1_:String = siteConfig.country;
         FloodlightAdTracking.clickNewUser(_loc1_);
         ExternalInterface.call("trackClickNewUser");
      }
      
      public static function Login() : void
      {
         var _loc2_:String = null;
         if(siteConfig == null)
         {
            return;
         }
         var _loc1_:String = siteConfig.country;
         if(_loc1_ == "com")
         {
            _loc2_ = "https://3544773.fls.doubleclick.net/activityi;src=3544773;" + "type=msp20993;cat=login734;" + "ord=" + Math.floor(Math.random() * 100000000) + "?";
            ExternalInterface.call("f=function(){if(document.getElementById(\"DCLK_FLDiv\")){var flDiv=document.getElementById(\"DCLK_FLDiv\");}else{var flDiv=document.body.appendChild(document.createElement(\"div\"));void(flDiv.setAttribute(\"id\",\"DCLK_FLDiv\"));void(flDiv.style.position=\"absolute\");void(flDiv.style.visibility=\"hidden\");void(flDiv.style.top=\"0px\");}void(flDiv.innerHTML=\'<iframe id=\"DCLK_FLIframe\" src=\"" + _loc2_ + "\"></iframe>\');}");
         }
         else if(_loc1_ == "au")
         {
            FloodlightAdTracking.trackActivity(4827504,"msp_w0","msp-l0");
         }
         ExternalInterface.call("trackLogin");
      }
      
      public static function RedeemGiftCertificate() : void
      {
         if(siteConfig == null)
         {
            return;
         }
         ExternalInterface.call("trackRedeemGiftCertificate");
      }
      
      public static function ProductOveriew() : void
      {
         if(siteConfig == null)
         {
            return;
         }
         var _loc1_:String = siteConfig.country;
         ExternalInterface.call("trackProductOverview");
         ExternalInterface.call("f=function(){window.adf.Params.PageName = encodeURIComponent(\"Moviestarplanet| " + _loc1_ + " | InAppPurchase | ProductOverview\");window.adf.Params.Divider = encodeURIComponent(\"|\"); window.adf.track(\"91147\");}()");
      }
      
      public static function PaymentOption() : void
      {
         if(siteConfig == null)
         {
            return;
         }
         var _loc1_:String = siteConfig.country;
         ExternalInterface.call("trackPaymentOption");
         ExternalInterface.call("f=function(){" + "window.adf.Params.PageName = " + "encodeURIComponent(\"Moviestarplanet| " + _loc1_ + " | InAppPurchase | PaymentOption\");" + "window.adf.Params.Divider = encodeURIComponent(\"|\"); " + "window.adf.track(\"91147\");" + "}()");
      }
      
      private static function adformTrackBuildingCharacter(param1:Boolean, param2:String) : void
      {
         var _loc3_:String = null;
         if(param1)
         {
            _loc3_ = "Female";
         }
         else
         {
            _loc3_ = "Male";
         }
         var _loc4_:String = "Create Profile " + param2;
         callAdformTracking(_loc4_,_loc3_,orderIdsCheckOut[param2]);
      }
      
      private static function adformTrackCreateNewUser(param1:String) : void
      {
         var _loc2_:String = "Create Profile " + param1;
         var _loc3_:String = "Confirmation";
         callAdformTracking(_loc2_,_loc3_,orderIdsCheckOut[param1]);
      }
      
      private static function callAdformTracking(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:String = "Movie Star Planet setup 2015-03-17";
         var _loc5_:String = "91147";
         param3 = param3 != null ? param3 : "undefined";
         var _loc6_:String = "f=function(){" + "window.adf.Params.PageName = " + "encodeURIComponent(\"" + _loc4_ + "|" + param1 + "|" + param2 + "\"); " + "window.adf.Params.Divider = encodeURIComponent(\"|\"); " + "window.adf.track(" + _loc5_ + "," + param3 + ");" + "}()";
         ExternalInterface.call(_loc6_);
      }
      
      public static function get orderIdsFrontPage() : Dictionary
      {
         if(!_orderIdsFrontPage)
         {
            _orderIdsFrontPage = new Dictionary();
            _orderIdsFrontPage["DK"] = "9095692";
            _orderIdsFrontPage["FI"] = "9095696";
            _orderIdsFrontPage["NO"] = "9095698";
            _orderIdsFrontPage["SE"] = "9095694";
         }
         return _orderIdsFrontPage;
      }
      
      public static function get orderIdsCheckOut() : Dictionary
      {
         if(!_orderIdsCheckOut)
         {
            _orderIdsCheckOut = new Dictionary();
            _orderIdsCheckOut["DK"] = "9095693";
            _orderIdsCheckOut["FI"] = "9095697";
            _orderIdsCheckOut["NO"] = "9095699";
            _orderIdsCheckOut["SE"] = "9095695";
         }
         return _orderIdsCheckOut;
      }
   }
}

