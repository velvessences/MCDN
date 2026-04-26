package com.moviestarplanet.Forms.world.elements
{
   import com.moviestarplanet.locale.ILocaleManager;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   
   public class BaseWorldElement
   {
      
      protected var mspLocaleManager:ILocaleManager = MSPLocaleManagerWeb.getInstance();
      
      private var _localizedStr:String;
      
      private var _swfVarName:String;
      
      public function BaseWorldElement(param1:String, param2:String, param3:Boolean = true)
      {
         super();
         this._swfVarName = param2;
         if(param3)
         {
            this._localizedStr = this.mspLocaleManager.getString(param1);
         }
         else
         {
            this._localizedStr = param1;
         }
      }
      
      public function get localizedStr() : String
      {
         if(this._localizedStr == null)
         {
            return "locale" + this.swfVarName;
         }
         return this._localizedStr;
      }
      
      public function get swfVarName() : String
      {
         return this._swfVarName;
      }
      
      public function enter() : void
      {
         throw new Error("Override me !");
      }
   }
}

