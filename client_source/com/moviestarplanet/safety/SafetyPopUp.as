package com.moviestarplanet.safety
{
   import com.moviestarplanet.utils.loader.RawUrl;
   import com.moviestarplanet.utils.translation.TranslationUtilities;
   import com.moviestarplanet.utils.ui.FlashInstanceUtils;
   import com.moviestarplanet.window.stack.WindowStack;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   import mx.controls.SWFLoader;
   
   public class SafetyPopUp extends Sprite
   {
      
      private static var isOpen:Boolean = false;
      
      private var safetyScreen:SWFLoader;
      
      public function SafetyPopUp(param1:String)
      {
         super();
         isOpen = true;
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoved);
         FlashInstanceUtils.loadFlashInstance(ApplicationDomain.currentDomain,new RawUrl(param1),this.loadScreenDone);
      }
      
      public static function show(param1:String) : void
      {
         if(isOpen)
         {
            return;
         }
         var _loc2_:SafetyPopUp = new SafetyPopUp(param1);
         WindowStack.showSpriteAsViewStackableWithCloseButton(_loc2_,235,80,980,500,WindowStack.Z_INFO);
      }
      
      private function onRemoved(param1:Event) : void
      {
         isOpen = false;
      }
      
      private function loadScreenDone(param1:SWFLoader) : void
      {
         this.safetyScreen = param1;
         this.addChild(this.safetyScreen.content);
         TranslationUtilities.translateDisplayObject(this.safetyScreen.content,true);
      }
   }
}

