package com.moviestarplanet.emoticon.purchase
{
   import com.moviestarplanet.emoticon.valueobjects.EmoticonPackage;
   import com.moviestarplanet.window.stack.WindowStack;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Rectangle;
   
   public class EmoticonPurchaseController
   {
      
      private static const VIEWPORT_RECT:Rectangle = new Rectangle(235,80,980,500);
      
      public function EmoticonPurchaseController()
      {
         super();
      }
      
      public static function OpenEmoticonPurchase(param1:EmoticonPackage, param2:DisplayObjectContainer) : void
      {
         var complete:Function = null;
         var popup:EmoticonPurchasePopup = null;
         var pdi:EmoticonPackage = param1;
         var parentContainer:DisplayObjectContainer = param2;
         complete = function():void
         {
            CloseEmoticonPurchase(popup);
         };
         popup = new EmoticonPurchasePopup(pdi,complete);
         var graphicsRectangle:Rectangle = new Rectangle(0,0,260,200);
         var x:Number = VIEWPORT_RECT.x + (VIEWPORT_RECT.width - graphicsRectangle.width) / 2;
         var y:Number = VIEWPORT_RECT.y + (VIEWPORT_RECT.height - graphicsRectangle.height) / 2;
         if(parentContainer == null)
         {
            WindowStack.showSpriteAsViewStackable(popup,x,y,WindowStack.Z_INFO);
         }
         else
         {
            WindowStack.showChildWindow(popup,x,y,parentContainer);
         }
      }
      
      public static function CloseEmoticonPurchase(param1:EmoticonPurchasePopup) : void
      {
         WindowStack.removeSpriteViewStackable(param1);
      }
   }
}

