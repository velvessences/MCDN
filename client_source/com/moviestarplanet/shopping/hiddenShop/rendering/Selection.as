package com.moviestarplanet.shopping.hiddenShop.rendering
{
   import com.moviestarplanet.IDestroyable;
   import com.moviestarplanet.controls.utils.Buttonizer;
   import com.moviestarplanet.utils.FontManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   
   public dynamic class Selection extends MovieClip implements IDestroyable
   {
      
      public var field:TextField;
      
      public var overlay:Sprite;
      
      private var callback:Function;
      
      private var data:Object;
      
      private var preSelections:Array;
      
      private var selected:Boolean;
      
      private var type:int;
      
      public function Selection()
      {
         super();
      }
      
      public function init(param1:Object, param2:Function, param3:Array, param4:int) : void
      {
         var _loc5_:ColorTransform = null;
         var _loc6_:ColorTransform = null;
         this.callback = param2;
         this.data = param1;
         this.preSelections = param3;
         this.type = param4;
         this.selected = param3.indexOf(param1.key) != -1;
         this.field.text = param1.label;
         Buttonizer.buttonizeFrames(this,this.click);
         if(param4 == SelectionWindow.THEMES)
         {
            if(param1.label.indexOf("Gift/VIP") > -1)
            {
               _loc5_ = new ColorTransform(0.5);
               _loc6_ = new ColorTransform(1,1,1,1,0,-10,-200);
               transform.colorTransform = _loc5_;
               this.overlay.transform.colorTransform = _loc6_;
            }
         }
         FontManager.remapFonts(this.field);
         this.colorize();
      }
      
      private function colorize() : void
      {
         this.overlay.visible = this.selected;
      }
      
      private function click(param1:MouseEvent) : void
      {
         this.selected = !this.selected;
         this.colorize();
         this.callback(this.data);
      }
      
      public function destroy() : void
      {
         Buttonizer.unbuttonizeFrames(this,this.click);
      }
      
      public function unselect() : void
      {
         this.selected = false;
         this.colorize();
      }
   }
}

