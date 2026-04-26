package com.moviestarplanet.Components
{
   import com.moviestarplanet.flash.icons.ScreenIcons;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mx.core.UIComponent;
   
   public class CloseButton extends UIComponent
   {
      
      private var closeBtn:MovieClip;
      
      public function CloseButton()
      {
         super();
         this.width = 20;
         this.height = 20;
         this.closeBtn = new ScreenIcons.CloseIcon();
         this.addChild(this.closeBtn);
         this.closeBtn.stop();
         this.closeBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown,false,0,true);
         this.closeBtn.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut,false,0,true);
         this.closeBtn.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver,false,0,true);
         this.closeBtn.buttonMode = true;
      }
      
      private function onMouseOver(param1:Event) : void
      {
         this.closeBtn.gotoAndStop("hover");
      }
      
      private function onMouseOut(param1:Event) : void
      {
         this.closeBtn.gotoAndStop("normal");
      }
      
      private function onMouseDown(param1:Event) : void
      {
         this.closeBtn.gotoAndStop("down");
      }
   }
}

