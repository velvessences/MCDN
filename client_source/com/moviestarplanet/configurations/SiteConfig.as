package com.moviestarplanet.configurations
{
   import com.moviestarplanet.config.ISiteConfig;
   import com.moviestarplanet.constants.ConstantsBrand;
   
   public class SiteConfig implements ISiteConfig
   {
      
      public var Domains:Array;
      
      public var Language:String;
      
      public var CartoonNetworkLink:String;
      
      public var IsFlagSite:Boolean;
      
      public var IsProductionSite:Boolean;
      
      public var SpecialConfig:String;
      
      public var SupportMail:String;
      
      public var NameToDisplay:String;
      
      public var Address:String;
      
      public var CVR:String;
      
      public var PhoneNumber:String;
      
      private var _country:String;
      
      private var _brand:int;
      
      private var _lowerCaseDomains:Vector.<String>;
      
      public function SiteConfig(param1:Array, param2:String, param3:String, param4:Boolean, param5:String, param6:Boolean, param7:String, param8:String, param9:String, param10:String, param11:String, param12:String, param13:int = 0)
      {
         var _loc14_:int = 0;
         super();
         this.Domains = param1;
         this.Language = param2;
         this.CartoonNetworkLink = param3;
         this.IsFlagSite = param4;
         this.SpecialConfig = param5;
         this.IsProductionSite = param6;
         this.SupportMail = param7;
         this.NameToDisplay = param9;
         this.Address = param10;
         this.CVR = param11;
         this.PhoneNumber = param12;
         this._country = param8;
         this._brand = param13;
         this._lowerCaseDomains = new Vector.<String>();
         _loc14_ = 0;
         while(_loc14_ < param1.length)
         {
            this._lowerCaseDomains[_loc14_] = param1[_loc14_].toLowerCase();
            _loc14_++;
         }
      }
      
      public function isRestricted() : Boolean
      {
         return Config.IsServerRestricted();
      }
      
      public function ageCutoff() : int
      {
         return 13;
      }
      
      public function IsCurrentSiteDomain(param1:String) : Boolean
      {
         var _loc2_:String = param1.toLowerCase();
         var _loc3_:int = 0;
         while(_loc3_ < this._lowerCaseDomains.length)
         {
            if(this._lowerCaseDomains[_loc3_] == _loc2_)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function get country() : String
      {
         return this._country;
      }
      
      public function get brandEnum() : int
      {
         return this._brand;
      }
      
      public function set brandEnum(param1:int) : void
      {
         this._brand = param1;
      }
      
      public function get brandName() : String
      {
         return ConstantsBrand.ConstToName[this._brand];
      }
      
      public function set brandName(param1:String) : void
      {
         this._brand = ConstantsBrand.NameToConst[param1];
      }
      
      public function get language() : String
      {
         return this.Language;
      }
   }
}

