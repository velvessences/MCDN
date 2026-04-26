package com.moviestarplanet.advertisement
{
   import flash.external.ExternalInterface;
   
   internal class FloodlightAdTracking
   {
      
      public function FloodlightAdTracking()
      {
         super();
      }
      
      internal static function trackActivity(param1:int, param2:String, param3:String) : void
      {
         var _loc4_:String = Math.floor(Math.random() * 100000000) + "?";
         var _loc5_:String = "https://" + param1 + ".fls.doubleclick.net/activityi;src=" + param1 + ";type=" + param2 + ";cat=" + param3 + ";tag_for_child_directed_treatment=1;ord=";
         var _loc6_:String = _loc5_ + _loc4_;
         var _loc7_:String = "f = function() { if (document.getElementById(\"DCLK_FLDiv\")) { var flDiv = document.getElementById(\"DCLK_FLDiv\"); }";
         _loc7_ = _loc7_ + "else { var flDiv = document.body.appendChild(document.createElement(\"div\"));";
         _loc7_ = _loc7_ + "void(flDiv.id=\"DCLK_FLDiv\"); void(flDiv.style.display = \"none\"); }";
         _loc7_ = _loc7_ + ("var DCLK_FLIframe = document.createElement(\"iframe\"); void(DCLK_FLIframe.id = \"DCLK_FLIframe_" + Math.floor(Math.random() * 10000) + "\");");
         _loc7_ = _loc7_ + ("void(DCLK_FLIframe.src = \"" + _loc6_ + "\"); void(flDiv.appendChild(DCLK_FLIframe)); }");
         if(ExternalInterface.available)
         {
            ExternalInterface.call(_loc7_);
         }
      }
      
      internal static function trackActivity2(param1:int, param2:String, param3:String) : void
      {
         var _loc4_:String = Math.floor(Math.random() * 100000000) + "?";
         var _loc5_:String = "https://fls.doubleclick.net/activityi;src=" + param1 + ";type=" + param2 + ";cat=" + param3 + ";tag_for_child_directed_treatment=1;ord=";
         var _loc6_:String = _loc5_ + _loc4_;
         var _loc7_:String = "f=function() { if(document.getElementById(\"DCLK_FLDiv\")) { var flDiv=document.getElementById(\"DCLK_FLDiv\"); }";
         _loc7_ = _loc7_ + "else { var flDiv = document.body.appendChild(document.createElement(\"div\"));";
         _loc7_ = _loc7_ + "void(flDiv.setAttribute(\"id\",\"DCLK_FLDiv\"));void(flDiv.style.position=\"absolute\");void(flDiv.style.visibility=\"hidden\");void(flDiv.style.top=\"0px\");}";
         _loc7_ = _loc7_ + ("void(flDiv.innerHTML=\'<iframe id=\"DCLK_FLIframe\" src=\"" + _loc6_ + "\"></iframe>\');}");
         if(ExternalInterface.available)
         {
            ExternalInterface.call(_loc7_);
         }
      }
      
      internal static function newUserCreated(param1:String) : void
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case "uk":
               trackActivity(3861378,"movie387","regis157");
               break;
            case "com":
               _loc2_ = "https://3544773.fls.doubleclick.net/activityi;" + "src=3544773;type=msp20993;cat=creat158;" + "ord=" + Math.floor(Math.random() * 100000000) + "?";
               ExternalInterface.call("f=function(){if(document.getElementById(\"DCLK_FLDiv\")){var flDiv=document.getElementById(\"DCLK_FLDiv\");}else{var flDiv=document.body.appendChild(document.createElement(\"div\"));void(flDiv.setAttribute(\"id\",\"DCLK_FLDiv\"));void(flDiv.style.position=\"absolute\");void(flDiv.style.visibility=\"hidden\");void(flDiv.style.top=\"0px\");}void(flDiv.innerHTML=\'<iframe id=\"DCLK_FLIframe\" src=\"" + _loc2_ + "\"></iframe>\');}");
               break;
            case "fr":
               trackActivity2(3688583,"msp","2012_824");
               trackActivity2(3688583,"msp2015","validsub");
               break;
            case "pl":
               break;
            case "au":
               trackActivity(4827504,"msp_w0","msp-c0");
         }
      }
      
      internal static function clickNewUser(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(param1 == "uk")
         {
            trackActivity(3861378,"movie387","newus613");
         }
         else if(param1 == "com")
         {
            _loc2_ = "https://3544773.fls.doubleclick.net/activityi;" + "src=3544773;type=msp20993;cat=newus043;" + "ord=" + Math.floor(Math.random() * 100000000) + "?";
            ExternalInterface.call("f=function(){if(document.getElementById(\"DCLK_FLDiv\")){var flDiv=document.getElementById(\"DCLK_FLDiv\");}else{var flDiv=document.body.appendChild(document.createElement(\"div\"));void(flDiv.setAttribute(\"id\",\"DCLK_FLDiv\"));void(flDiv.style.position=\"absolute\");void(flDiv.style.visibility=\"hidden\");void(flDiv.style.top=\"0px\");}void(flDiv.innerHTML=\'<iframe id=\"DCLK_FLIframe\" src=\"" + _loc2_ + "\"></iframe>\');}");
         }
         else if(param1 == "fr")
         {
            _loc3_ = "https://fls.doubleclick.net/activityi;src=3688583;type=msp;cat=2012_900;ord=" + Math.floor(Math.random() * 100000000) + "?";
            ExternalInterface.call("f=function(){if(document.getElementById(\"DCLK_FLDiv\")){var flDiv=document.getElementById(\"DCLK_FLDiv\");}else{var flDiv=document.body.appendChild(document.createElement(\"div\"));void(flDiv.setAttribute(\"id\",\"DCLK_FLDiv\"));void(flDiv.style.position=\"absolute\");void(flDiv.style.visibility=\"hidden\");void(flDiv.style.top=\"0px\");}void(flDiv.innerHTML=\'<iframe id=\"DCLK_FLIframe\" src=\"" + _loc3_ + "\"></iframe>\');}");
            trackActivity2(3688583,"msp2015","newuser");
         }
         else if(param1 == "au")
         {
            trackActivity(4827504,"msp_w0","msp-n0");
         }
      }
   }
}

