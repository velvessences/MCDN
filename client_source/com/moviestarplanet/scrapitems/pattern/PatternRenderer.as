package com.moviestarplanet.scrapitems.pattern
{
   import com.moviestarplanet.utils.ColorMap;
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   
   public class PatternRenderer extends MovieClip
   {
      
      private var target:MovieClip;
      
      private var _patternScale:Number;
      
      protected var caWidth:Number;
      
      protected var caHeight:Number;
      
      protected var tiles:Array = new Array();
      
      public var diameter:Number;
      
      protected var colorInvalid:Boolean;
      
      public var colorMap:Array;
      
      public var colorscheme:Object;
      
      protected var _isResizing:Boolean = false;
      
      public function PatternRenderer(param1:MovieClip, param2:Number, param3:Number)
      {
         super();
         this.target = param1;
         this.caWidth = param2;
         this.caHeight = param3;
         this.initialize();
      }
      
      private function initialize() : void
      {
         var _loc1_:Number = Number(this.target.width);
         var _loc2_:Number = Number(this.target.height);
         this.diameter = Math.sqrt(_loc1_ * _loc1_ + _loc2_ * _loc2_);
         this.x = (_loc1_ - this.diameter) / 2;
         this.y = (_loc2_ - this.diameter) / 2;
         this.scrollRect = new Rectangle(0,0,this.diameter,this.diameter);
      }
      
      public function set patternScale(param1:Number) : void
      {
         if(!this._isResizing)
         {
            this._patternScale = param1;
            this.repaint();
         }
      }
      
      public function get patternScale() : Number
      {
         return this._patternScale;
      }
      
      public function repaint() : void
      {
      }
      
      protected function reApplyColor() : void
      {
         var _loc1_:String = null;
         if(this.colorMap != null)
         {
            this.colorInvalid = false;
            _loc1_ = ColorMap.GetColorsFromColorMap(this.colorMap).join(",");
            ColorMap.CreateColorMapOnMovieClip(this,this.colorscheme,false);
            ColorMap.SetColorsOnMovieClip(this,0,_loc1_);
         }
      }
      
      protected function invalidateColor() : void
      {
         this.colorInvalid = true;
         if(this.transform)
         {
            this.transform.colorTransform = new ColorTransform();
         }
      }
      
      public function get isResizing() : Boolean
      {
         return this._isResizing;
      }
      
      public function destroy() : void
      {
         removeChildren();
         if(this.tiles != null)
         {
            this.tiles.length = 0;
         }
         if(this.colorMap != null)
         {
            this.colorMap.length = 0;
         }
         this.colorMap = null;
         this.tiles = null;
         this.target = null;
         this.colorscheme = null;
      }
   }
}

