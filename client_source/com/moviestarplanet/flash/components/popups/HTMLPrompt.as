package com.moviestarplanet.flash.components.popups
{
   import com.moviestarplanet.utils.FontManager;
   import com.moviestarplanet.utils.flash.MSP_FlashLoader;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class HTMLPrompt extends Prompt
   {
      
      public function HTMLPrompt(param1:String = "", param2:String = "", param3:uint = 4, param4:Sprite = null, param5:Function = null, param6:Class = null, param7:uint = 4)
      {
         super(param1,param2,param3,param4,param5,param6,param7);
      }
      
      public static function show(param1:String = "", param2:String = "", param3:uint = 4, param4:Sprite = null, param5:Function = null, param6:Class = null, param7:uint = 4) : void
      {
         new HTMLPrompt(param1,param2,param3,param4,param5,param6,param7);
      }
      
      override protected function loadDone(param1:MSP_FlashLoader) : void
      {
         super.loadDone(param1);
         var _loc2_:MovieClip = content as MovieClip;
         (_loc2_.SystemMessage.Body as TextField).htmlText = text;
         FontManager.remapFonts(_loc2_.SystemMessage.Body as TextField);
      }
   }
}

