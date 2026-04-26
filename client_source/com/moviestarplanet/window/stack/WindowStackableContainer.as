package com.moviestarplanet.window.stack
{
   import flash.display.Sprite;
   import flash.events.Event;
   import mx.containers.Canvas;
   import mx.core.UIComponent;
   
   public class WindowStackableContainer extends Canvas implements WindowStackableInterface
   {
      
      private var _window:Sprite;
      
      private var _uiComp:UIComponent;
      
      public function WindowStackableContainer(param1:Sprite)
      {
         super();
         this._window = param1;
         this._uiComp = new UIComponent();
         addChild(this._uiComp);
         this._uiComp.addChild(param1);
         param1.addEventListener(Event.CLOSE,this.closeHandler);
      }
      
      public function closeHandler(param1:Event) : void
      {
         this.window.removeEventListener(Event.CLOSE,this.closeHandler);
         if(this._window.parent)
         {
            this._window.parent.removeChild(this._window);
         }
         WindowStack.removeViewStackable(this);
         while(this._uiComp.numChildren > 0)
         {
            this._uiComp.removeChildAt(0);
         }
         this._uiComp = null;
         this._window = null;
      }
      
      public function get window() : Sprite
      {
         return this._window;
      }
   }
}

