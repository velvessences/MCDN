package com.moviestarplanet.ecoSystem.initializer
{
   import com.moviestarplanet.amf.ServiceUrlUtil;
   
   public class EcoVariables
   {
      
      public static var countryCode:String;
      
      public static var url:String = null;
      
      public function EcoVariables()
      {
         super();
      }
      
      public static function init(param1:String, param2:String) : void
      {
         EcoVariables.url = ServiceUrlUtil.addUrlPrefix(param2);
         EcoVariables.countryCode = param1;
      }
   }
}

