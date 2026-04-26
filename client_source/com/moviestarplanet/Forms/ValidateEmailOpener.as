package com.moviestarplanet.Forms
{
   import com.moviestarplanet.configurations.TrusteConfig;
   
   public class ValidateEmailOpener
   {
      
      private static var _openedValidateEmailView:ValidateEmailNew;
      
      private static var _instance:ValidateEmailOpener = null;
      
      public function ValidateEmailOpener(param1:Function = null)
      {
         super();
         if(param1 != singletonBlocker)
         {
            throw new Error("ValidateEmailOpener is a singleton class, use ValidateEmailOpener.getInstance() instead!");
         }
      }
      
      private static function singletonBlocker() : void
      {
      }
      
      public static function getInstance() : ValidateEmailOpener
      {
         if(_instance == null)
         {
            _instance = new ValidateEmailOpener(singletonBlocker);
         }
         return _instance;
      }
      
      public function open(param1:Boolean = false, param2:Function = null, param3:Function = null, param4:Boolean = false) : void
      {
         if(_openedValidateEmailView != null && _openedValidateEmailView.parent != null)
         {
            _openedValidateEmailView.closePopup();
         }
         if(TrusteConfig.getInstance().isActual)
         {
            _openedValidateEmailView = new ValidateEmailNewTruste();
         }
         else
         {
            _openedValidateEmailView = new ValidateEmailNew();
         }
         _openedValidateEmailView.open(param1,param2,param3,param4);
      }
   }
}

