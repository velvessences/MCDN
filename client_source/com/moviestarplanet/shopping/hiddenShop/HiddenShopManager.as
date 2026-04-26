package com.moviestarplanet.shopping.hiddenShop
{
   import com.moviestarplanet.flash.graphics.GraphicsProviderEvent;
   import com.moviestarplanet.shopping.hiddenShop.rendering.Selection;
   import com.moviestarplanet.window.stack.WindowStack;
   import flash.display.Sprite;
   
   public class HiddenShopManager
   {
      
      public static var graphicsProvider:HiddenShopGraphicsProvider;
      
      public static var isLoaded:Boolean = false;
      
      public function HiddenShopManager()
      {
         super();
      }
      
      public static function open() : void
      {
         var _loc1_:Sprite = null;
         if(isLoaded)
         {
            _loc1_ = graphicsProvider.mainScreen;
            WindowStack.showSpriteAsViewStackable(_loc1_,237,80,WindowStack.Z_BROWSER);
         }
         else
         {
            load(open);
         }
      }
      
      public static function load(param1:Function) : void
      {
         var onComplete:Function = null;
         var callback:Function = param1;
         onComplete = function(param1:GraphicsProviderEvent):void
         {
            isLoaded = true;
            graphicsProvider.removeEventListener(GraphicsProviderEvent.GRAPHICS_LOADED,onComplete);
            callback();
         };
         if(graphicsProvider != null)
         {
            callback();
            return;
         }
         graphicsProvider = new HiddenShopGraphicsProvider();
         graphicsProvider.addEventListener(GraphicsProviderEvent.GRAPHICS_LOADED,onComplete);
         graphicsProvider.load();
      }
      
      public static function newSelection() : Selection
      {
         return graphicsProvider.selection;
      }
   }
}

