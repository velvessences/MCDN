package com.moviestarplanet.alert
{
   import flash.display.Sprite;
   import mx.controls.Alert;
   import mx.core.mx_internal;
   
   public class HTMLAlert extends Alert
   {
      
      public function HTMLAlert()
      {
         super();
      }
      
      public static function show(param1:String = "", param2:String = "", param3:uint = 4, param4:Sprite = null, param5:Function = null, param6:Class = null, param7:uint = 4) : Alert
      {
         var _loc8_:Alert = Alert.show(param1,param2,param3,param4,param5,param6,param7);
         _loc8_.mx_internal::alertForm.mx_internal::textField.htmlText = param1;
         return _loc8_;
      }
   }
}

