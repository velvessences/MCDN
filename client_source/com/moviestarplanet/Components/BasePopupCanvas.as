package com.moviestarplanet.Components
{
   import com.moviestarplanet.window.stack.WindowStack;
   import com.moviestarplanet.window.stack.WindowStackableInterface;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import mx.containers.Canvas;
   import mx.controls.Text;
   import mx.core.ScrollPolicy;
   
   public class BasePopupCanvas extends Canvas implements WindowStackableInterface
   {
      
      protected var titleLabel:Text = new Text();
      
      public function BasePopupCanvas()
      {
         super();
         verticalScrollPolicy = ScrollPolicy.OFF;
         horizontalScrollPolicy = ScrollPolicy.OFF;
         this.initWindow();
         this.initTitle();
         this.initCloseButton();
      }
      
      protected function set title(param1:String) : void
      {
         this.titleLabel.text = param1;
      }
      
      protected function set leftTitle(param1:int) : void
      {
         this.titleLabel.setStyle("left",param1);
      }
      
      protected function set topTitle(param1:int) : void
      {
         this.titleLabel.setStyle("top",param1);
      }
      
      private function initWindow() : void
      {
         styleName = "settingsPopup";
         filters = [this.getDropShadow()];
      }
      
      private function initTitle() : void
      {
         this.titleLabel.styleName = "settingsTitle";
         this.titleLabel.setStyle("top",20);
         this.titleLabel.setStyle("left",20);
         this.titleLabel.percentWidth = 100;
         this.titleLabel.selectable = false;
         addChild(this.titleLabel);
      }
      
      private function getDropShadow() : DropShadowFilter
      {
         var _loc1_:DropShadowFilter = new DropShadowFilter();
         _loc1_.blurX = 15;
         _loc1_.blurY = 15;
         _loc1_.distance = 0;
         _loc1_.angle = 0;
         _loc1_.strength = 0.75;
         return _loc1_;
      }
      
      private function initCloseButton() : void
      {
         var _loc1_:CloseButton = new CloseButton();
         _loc1_.setStyle("top",5);
         _loc1_.setStyle("right",5);
         _loc1_.addEventListener(MouseEvent.CLICK,this.close);
         addChild(_loc1_);
      }
      
      protected function close(param1:Event = null) : void
      {
         WindowStack.removeViewStackable(this);
      }
   }
}

