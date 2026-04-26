package com.moviestarplanet.version
{
   import com.moviestarplanet.window.base.WindowLayers;
   import com.moviestarplanet.window.stack.WindowStack;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   import flash.display.Shape;
   import flash.geom.Rectangle;
   import mx.core.UIComponent;
   
   public class UpdateVersionPopup
   {
      
      private static var backView:UIComponent;
      
      private static var bgRect:Rectangle = new Rectangle(0,0,1240,720);
      
      public function UpdateVersionPopup()
      {
         super();
      }
      
      public static function show(param1:String = "", param2:String = "", param3:Function = null) : void
      {
         createLightBox();
         Prompt.show(param1,param2,uint(4),null,param3);
      }
      
      private static function createLightBox() : void
      {
         var _loc1_:uint = 4473924;
         var _loc2_:Shape = new Shape();
         _loc2_.alpha = 0.5;
         _loc2_.graphics.beginFill(_loc1_);
         _loc2_.graphics.drawRect(bgRect.x,bgRect.y,bgRect.width,bgRect.height);
         _loc2_.graphics.endFill();
         backView = new UIComponent();
         backView.addChild(_loc2_);
         backView.name = "backView";
         WindowStack.showSpriteAsViewStackable(backView,0,0,WindowLayers.ARCADE);
      }
   }
}

