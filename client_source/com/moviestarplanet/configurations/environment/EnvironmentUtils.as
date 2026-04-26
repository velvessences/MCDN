package com.moviestarplanet.configurations.environment
{
   import flash.utils.Dictionary;
   
   public class EnvironmentUtils
   {
      
      public function EnvironmentUtils()
      {
         super();
      }
      
      public static function countryNameToCountryCode(param1:String) : String
      {
         if(param1 == null)
         {
            return null;
         }
         param1 = param1.toLowerCase();
         var _loc2_:Dictionary = new Dictionary();
         _loc2_["denmark"] = "dk";
         _loc2_["germany"] = "de";
         _loc2_["unitedstates"] = "us";
         _loc2_["england"] = "gb";
         _loc2_["france"] = "fr";
         _loc2_["australia"] = "au";
         _loc2_["finland"] = "fi";
         _loc2_["norway"] = "no";
         _loc2_["newzealand"] = "nz";
         _loc2_["netherland"] = "nl";
         _loc2_["sweden"] = "se";
         _loc2_["canada"] = "ca";
         _loc2_["poland"] = "pl";
         _loc2_["turkey"] = "tr";
         _loc2_["ireland"] = "ie";
         _loc2_["spain"] = "es";
         _loc2_["italy"] = "it";
         if(!(param1 in _loc2_))
         {
            return param1;
         }
         return _loc2_[param1];
      }
      
      public static function countryCodeFromContinent(param1:String) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case "AF":
               _loc2_ = "GB";
               break;
            case "AN":
               _loc2_ = "GB";
               break;
            case "AS":
               _loc2_ = "US";
               break;
            case "EU":
               _loc2_ = "GB";
               break;
            case "NA":
               _loc2_ = "US";
               break;
            case "OC":
               _loc2_ = "AU";
               break;
            case "SA":
               _loc2_ = "US";
               break;
            default:
               _loc2_ = null;
         }
         return _loc2_;
      }
      
      public static function localeFromCountryCode(param1:String) : String
      {
         param1 = param1.toLowerCase();
         var _loc2_:Dictionary = new Dictionary();
         _loc2_["dk"] = "da_DK";
         _loc2_["de"] = "de_DE";
         _loc2_["us"] = "en_US";
         _loc2_["gb"] = "en_US";
         _loc2_["fr"] = "fr_FR";
         _loc2_["au"] = "au_AU";
         _loc2_["fi"] = "fi_FI";
         _loc2_["no"] = "no_NO";
         _loc2_["nz"] = "en_US";
         _loc2_["nl"] = "nl_NL";
         _loc2_["se"] = "sv_SE";
         _loc2_["ca"] = "en_US";
         _loc2_["pl"] = "pl_PL";
         _loc2_["tr"] = "tr_TR";
         _loc2_["ie"] = "en_US";
         _loc2_["es"] = "es_ES";
         _loc2_["it"] = "it_IT";
         if(!(param1 in _loc2_))
         {
            return "en_US";
         }
         return _loc2_[param1];
      }
      
      public static function countryCodeToCountryName(param1:String) : String
      {
         param1 = param1.toUpperCase();
         var _loc2_:Dictionary = new Dictionary();
         _loc2_["DK"] = "Denmark";
         _loc2_["DE"] = "Germany";
         _loc2_["US"] = "UnitedStates";
         _loc2_["GB"] = "England";
         _loc2_["FR"] = "France";
         _loc2_["AU"] = "Australia";
         _loc2_["FI"] = "Finland";
         _loc2_["NO"] = "Norway";
         _loc2_["NZ"] = "NewZealand";
         _loc2_["NL"] = "Netherland";
         _loc2_["SE"] = "Sweden";
         _loc2_["CA"] = "Canada";
         _loc2_["PL"] = "Poland";
         _loc2_["TR"] = "Turkey";
         _loc2_["IE"] = "Ireland";
         _loc2_["ES"] = "Spain";
         _loc2_["IT"] = "Italy";
         _loc2_["LOCAL"] = "LOCAL";
         _loc2_["LOCAL_CHARLES"] = "LOCAL_CHARLES";
         _loc2_["TEST"] = "TEST";
         _loc2_["DEV"] = "DEV";
         _loc2_["RC"] = "RC";
         _loc2_["UPLOAD"] = "UPLOAD";
         _loc2_["MSTARTEST"] = "MYSTARTEST";
         _loc2_["MYSTARDEV"] = "MYSTARDEV";
         _loc2_["ALPHA"] = "ALPHA";
         _loc2_["BETA"] = "BETA";
         _loc2_["A-BRANCH"] = "A-BRANCH";
         _loc2_["C-BRANCH"] = "C-BRANCH";
         _loc2_["D-BRANCH"] = "D-BRANCH";
         _loc2_["{0}"] = "{0}";
         return _loc2_[param1];
      }
   }
}

