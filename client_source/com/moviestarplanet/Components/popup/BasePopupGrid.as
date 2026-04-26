package com.moviestarplanet.Components.popup
{
   import com.moviestarplanet.Components.CloseButton;
   import com.moviestarplanet.popup.OldPopupHandler;
   import com.moviestarplanet.window.stack.WindowStackableInterface;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import mx.containers.Canvas;
   import mx.containers.Grid;
   import mx.containers.GridItem;
   import mx.containers.GridRow;
   import mx.controls.Text;
   import mx.core.ScrollPolicy;
   import mx.events.FlexEvent;
   import mx.events.ResizeEvent;
   
   public class BasePopupGrid extends Canvas implements WindowStackableInterface
   {
      
      protected var grid:Grid;
      
      protected var titleLabel:Text = new Text();
      
      protected var columns:int;
      
      public function BasePopupGrid(param1:int, param2:String, param3:int = 1)
      {
         super();
         this.minWidth = param1;
         this.columns = param3;
         verticalScrollPolicy = ScrollPolicy.OFF;
         horizontalScrollPolicy = ScrollPolicy.OFF;
         styleName = "settingsPopup";
         filters = [this.getDropShadow()];
         var _loc4_:CloseButton = new CloseButton();
         _loc4_.addEventListener(MouseEvent.CLICK,this.close);
         _loc4_.x = 540;
         _loc4_.y = 5;
         addChild(_loc4_);
         this.grid = new Grid();
         this.grid.setStyle("left",20);
         this.grid.setStyle("right",20);
         this.grid.setStyle("top",20);
         this.grid.setStyle("bottom",20);
         this.titleLabel.styleName = "settingsTitle";
         this.titleLabel.percentWidth = 100;
         this.titleLabel.maxWidth = param1;
         this.titleLabel.text = param2;
         this.titleLabel.selectable = false;
         this.titleLabel.setStyle("fontSize",24);
         var _loc5_:GridItem = new GridItem();
         _loc5_.percentWidth = 100;
         _loc5_.colSpan = param3;
         _loc5_.addChild(this.titleLabel);
         var _loc6_:GridRow = new GridRow();
         _loc6_.percentWidth = 100;
         _loc6_.addChild(_loc5_);
         this.grid.addChild(_loc6_);
         this.placeElementsInGrid();
         addChild(this.grid);
         addEventListener(FlexEvent.CREATION_COMPLETE,this.creationComplete);
         addEventListener(ResizeEvent.RESIZE,this.positionAndShow,false,0,true);
      }
      
      public static function show(param1:BasePopupGrid) : void
      {
         param1.visible = false;
         OldPopupHandler.getInstance().showFakePopup(param1,0,0);
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
      
      public function close(param1:Event = null) : void
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      protected function placeElementsInGrid() : void
      {
         throw new Error("Override this!!");
      }
      
      private function creationComplete(param1:Event) : void
      {
         removeEventListener(FlexEvent.CREATION_COMPLETE,this.creationComplete);
         this.positionAndShow();
      }
      
      private function positionAndShow(param1:Event = null) : void
      {
         x = this.centeredX;
         y = this.centeredY;
         visible = true;
      }
      
      protected function get centeredX() : Number
      {
         var _loc1_:int = 235;
         var _loc2_:int = 980;
         return _loc1_ + _loc2_ / 2 - this.measuredWidth / 2;
      }
      
      protected function get centeredY() : Number
      {
         var _loc1_:int = 80;
         var _loc2_:int = 500;
         return _loc1_ + _loc2_ / 2 - this.measuredHeight / 2;
      }
   }
}

