package com.moviestarplanet.Components.popup
{
   import mx.containers.GridItem;
   import mx.containers.GridRow;
   import mx.controls.Text;
   
   public class ErrorPopup extends BasePopupGrid
   {
      
      private var body:String;
      
      public function ErrorPopup(param1:String, param2:String)
      {
         this.body = param2;
         super(400,param1);
      }
      
      override protected function placeElementsInGrid() : void
      {
         var _loc1_:Text = new Text();
         _loc1_.text = this.body;
         _loc1_.selectable = false;
         _loc1_.setStyle("color","0x000000");
         _loc1_.width = minWidth;
         var _loc2_:GridItem = new GridItem();
         _loc2_.addChild(_loc1_);
         var _loc3_:GridRow = new GridRow();
         _loc3_.addChild(_loc2_);
         grid.addChild(_loc3_);
         invalidateDisplayList();
         invalidateProperties();
         invalidateSize();
      }
      
      public function show() : void
      {
         BasePopupGrid.show(this);
      }
   }
}

