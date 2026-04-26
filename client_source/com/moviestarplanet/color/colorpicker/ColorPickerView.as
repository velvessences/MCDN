package com.moviestarplanet.color.colorpicker
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   
   public class ColorPickerView extends Sprite
   {
      
      private var _columns:int;
      
      private var _rows:int;
      
      private var _model:ColorPickerModelInterface;
      
      private var _oldCursor:String;
      
      private var _brickSize:Number;
      
      private var _padding:Number;
      
      public function ColorPickerView(param1:ColorPickerModelInterface, param2:int, param3:Number = 20, param4:Number = 5)
      {
         super();
         this._model = param1;
         this._columns = param2;
         this._brickSize = param3;
         this._padding = param4;
         this._rows = Math.ceil(this._model.getNumberOfColors() / this._columns);
         this.setupGraphics();
         addEventListener(MouseEvent.ROLL_OUT,this.viewRollout,false,0,true);
      }
      
      private function setupGraphics() : void
      {
         this.setupBackground();
         this.setupColors();
      }
      
      private function setupMobileSize() : void
      {
         var _loc1_:Number = 1.49;
         width *= _loc1_;
         height *= _loc1_;
      }
      
      private function setupBackground() : void
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215);
         var _loc2_:Number = this._padding * 2 + this._columns * this._brickSize;
         var _loc3_:Number = this._padding * 2 + this._rows * this._brickSize;
         _loc1_.graphics.drawRoundRect(0,0,_loc2_,_loc3_,5,5);
         _loc1_.graphics.endFill();
         addChild(_loc1_);
      }
      
      private function setupColors() : void
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:MovieClip = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this._rows)
         {
            _loc3_ = 0;
            while(_loc3_ < this._columns)
            {
               _loc4_ = this._model.getColor(_loc1_);
               _loc5_ = new MovieClip();
               _loc5_.color = _loc4_;
               _loc5_.index = _loc1_;
               _loc5_.stop();
               _loc5_.graphics.beginFill(_loc4_);
               _loc5_.graphics.drawRect(0,0,this._brickSize,this._brickSize);
               _loc5_.graphics.endFill();
               _loc5_.x = this._padding + _loc3_ * this._brickSize;
               _loc5_.y = this._padding + _loc2_ * this._brickSize;
               addChild(_loc5_);
               _loc5_.addEventListener(MouseEvent.MOUSE_UP,this.brickClicked,false,0,true);
               _loc5_.addEventListener(MouseEvent.ROLL_OVER,this.brickRollover,false,0,true);
               _loc5_.addEventListener(MouseEvent.ROLL_OUT,this.brickRollout,false,0,true);
               _loc1_++;
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      private function brickClicked(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
         removeEventListener(MouseEvent.ROLL_OUT,this.viewRollout,false);
         var _loc2_:Object = param1.currentTarget;
         this._model.indexClicked(_loc2_.index);
      }
      
      private function brickRollover(param1:MouseEvent) : void
      {
         var _loc2_:Object = param1.currentTarget;
         this._model.indexConsidered(_loc2_.index);
         this._oldCursor = Mouse.cursor;
         Mouse.cursor = MouseCursor.BUTTON;
      }
      
      private function brickRollout(param1:MouseEvent) : void
      {
         Mouse.cursor = this._oldCursor ? this._oldCursor : MouseCursor.ARROW;
      }
      
      private function viewRollout(param1:MouseEvent) : void
      {
         this._model.indexConsidered(-1);
      }
   }
}

