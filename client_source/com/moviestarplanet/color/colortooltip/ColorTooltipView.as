package com.moviestarplanet.color.colortooltip
{
   import com.moviestarplanet.color.ColorController;
   import com.moviestarplanet.color.colorpicker.ColorScheme;
   import com.moviestarplanet.color.mobilecolorpicker.MobileColorPickerView;
   import com.moviestarplanet.constants.ConstantsPlatform;
   import com.moviestarplanet.controls.utils.Buttonizer;
   import com.moviestarplanet.utils.flash.MSP_FlashLoader;
   import com.moviestarplanet.utils.loader.AssetUrl;
   import com.moviestarplanet.utils.loader.MSP_LoaderManager;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   
   public class ColorTooltipView extends Sprite
   {
      
      private static const GRAPHICS_URL:String = "swf/colortooltip/ColorTooltip.swf";
      
      protected static const PADDING:Number = 5;
      
      protected static const SPACING:Number = 3;
      
      protected static const SYMBOL_BACKGROUND:String = "Background";
      
      protected static const SYMBOL_ARROW:String = "Tip";
      
      protected static const SYMBOL_RESET:String = "ResetButton";
      
      protected static const SYMBOL_COLOR:String = "ColorBlock";
      
      protected static const I_COLOR:String = "color";
      
      protected var model:ColorTooltipModelInterface;
      
      protected var arrow:DisplayObject;
      
      protected var background:DisplayObject;
      
      protected var resetbutton:DisplayObject;
      
      protected var colors:Array;
      
      protected var applicationContainer:DisplayObjectContainer;
      
      protected var centered:Boolean;
      
      protected var _scaleResetButton:Number = 1;
      
      private var domain:ApplicationDomain;
      
      private var url:String;
      
      protected var clickCallbacks:Array;
      
      private var _pickerOrigin:Point;
      
      private var _pickerMaxWidth:Number;
      
      private var colorPicker:MobileColorPickerView = null;
      
      private var viewContainer:DisplayObject;
      
      private var oldColorPicker:Boolean;
      
      public function ColorTooltipView(param1:ColorTooltipModelInterface, param2:DisplayObjectContainer, param3:Boolean = true, param4:DisplayObject = null, param5:Boolean = false, param6:String = "swf/colortooltip/ColorTooltip.swf")
      {
         super();
         this.model = param1;
         this.applicationContainer = param2;
         this.url = param6;
         this.centered = param3;
         this.oldColorPicker = param5;
         this.viewContainer = param4;
         this._pickerOrigin = null;
         this._pickerMaxWidth = -1;
         this.model.addEventListener(ColorTooltipModelEvent.COLOR_CHANGED,this.colorChanged);
         this.setupGraphics();
      }
      
      public function init() : void
      {
         throw "public function init():void of ColorTooltipView, Needs override";
      }
      
      protected function setupGraphics() : void
      {
         this.fetchGraphics(this.url);
      }
      
      protected function fetchGraphics(param1:String) : void
      {
         MSP_FlashLoader.RequestLoad(new AssetUrl(param1,AssetUrl.DEFAULT),this.graphicsLoaded,MSP_LoaderManager.PRIORITY_LOW,true,true);
      }
      
      private function graphicsLoaded(param1:MSP_FlashLoader) : void
      {
         this.domain = param1.content.loaderInfo.applicationDomain;
         this.initGraphics();
      }
      
      protected function initGraphics() : void
      {
         var _loc1_:DisplayObjectContainer = new Sprite();
         this.initControls(_loc1_);
         this.placeContainer(_loc1_);
      }
      
      private function setupMobileSize(param1:DisplayObjectContainer) : void
      {
         var _loc2_:Number = 1.7;
         param1.width *= _loc2_;
         param1.height *= _loc2_;
      }
      
      protected function initBackground(param1:DisplayObjectContainer) : void
      {
         var _loc2_:Class = this.getClassFor(SYMBOL_BACKGROUND);
         this.background = new _loc2_();
         var _loc3_:Number = PADDING * 2 + param1.width;
         this.background.width = _loc3_;
         if(this.arrow)
         {
            this.background.y = this.arrow.height;
         }
         param1.addChildAt(this.background,0);
      }
      
      protected function initResetBtn(param1:DisplayObjectContainer) : void
      {
         var _loc2_:Class = this.getClassFor(SYMBOL_RESET);
         this.resetbutton = new _loc2_();
         Buttonizer.buttonizeFrames(this.resetbutton as MovieClip,this.resetClicked,true);
         var _loc3_:DisplayObject = this.colors[0];
         this.resetbutton.x = PADDING * 2 + param1.width;
         this.resetbutton.y = PADDING;
         if(this.arrow)
         {
            this.resetbutton.y += this.arrow.height;
         }
         param1.addChild(this.resetbutton);
      }
      
      protected function initArrow(param1:DisplayObjectContainer) : void
      {
         var _loc2_:Class = this.getClassFor(SYMBOL_ARROW);
         this.arrow = new _loc2_();
         this.arrow.x = (param1.width - this.arrow.width) / 2;
         this.arrow.y = 2;
         param1.addChildAt(this.arrow,0);
      }
      
      protected function initControls(param1:DisplayObjectContainer) : void
      {
         this.initColors(param1);
         this.initResetBtn(param1);
         this.initBackground(param1);
         this.initArrow(param1);
      }
      
      protected function initColors(param1:DisplayObjectContainer) : void
      {
         var _loc4_:MovieClip = null;
         var _loc2_:Class = this.getClassFor(SYMBOL_COLOR);
         this.colors = new Array();
         this.clickCallbacks = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this.model.getNumberOfColors())
         {
            _loc4_ = new _loc2_();
            this.colors.push(_loc4_);
            this.setIndexColor(_loc3_,this.model.getCurrentColor(_loc3_));
            this.clickCallbacks.push(this.colorClickedClosure(_loc3_));
            Buttonizer.buttonizeFrames(_loc4_,this.clickCallbacks[_loc3_],true);
            _loc3_++;
         }
         this.addColors(param1);
      }
      
      protected function getClassFor(param1:String) : Class
      {
         return this.domain.getDefinition(param1) as Class;
      }
      
      protected function addColors(param1:DisplayObjectContainer) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.colors.length)
         {
            _loc3_ = this.colors[_loc2_];
            _loc3_.x = this.firstColorX + PADDING + SPACING * _loc2_ + _loc3_.width * _loc2_;
            _loc3_.y = PADDING;
            if(this.arrow)
            {
               _loc3_.y += this.arrow.height;
            }
            param1.addChild(_loc3_);
            _loc2_++;
         }
      }
      
      protected function get firstColorX() : Number
      {
         return 0;
      }
      
      protected function placeContainer(param1:DisplayObjectContainer) : void
      {
         if(this.centered)
         {
            param1.x = -param1.width / 2;
         }
         param1.y = 0;
         addChild(param1);
         var _loc2_:int = int(this.applicationContainer.localToGlobal(new Point(0,0)).x);
         var _loc3_:int = int(this.applicationContainer.localToGlobal(new Point(this.applicationContainer.width,0)).x);
         var _loc4_:int = int(param1.localToGlobal(new Point(0,0)).x);
         var _loc5_:int = int(param1.localToGlobal(new Point(param1.width,0)).x);
         var _loc6_:int = 0;
         if(_loc4_ < _loc2_)
         {
            _loc6_ = _loc2_ - _loc4_;
         }
         else if(_loc5_ > _loc3_)
         {
            _loc6_ = _loc3_ - _loc5_;
         }
         param1.x += _loc6_;
         if(this.arrow != null)
         {
            this.arrow.x -= _loc6_;
         }
      }
      
      protected function colorClickedClosure(param1:int) : Function
      {
         var thisView:Sprite = null;
         var colorClicked:Function = null;
         var colorIndex:int = param1;
         colorClicked = function(param1:MouseEvent):void
         {
            var colorClip:MovieClip;
            var update:Function = null;
            var colorChosen:Function = null;
            var stagePoint:Point = null;
            var localPoint:Point = null;
            var appHeight:int = 0;
            var offsetLocalPoint:Point = null;
            var event:MouseEvent = param1;
            update = function(param1:int):void
            {
               model.updateColor(colorIndex,param1);
            };
            colorChosen = function(param1:int):void
            {
               model.resultColor(colorIndex,param1);
               if(colorPicker != null)
               {
                  colorPicker.destroy();
                  colorPicker = null;
               }
            };
            event.stopImmediatePropagation();
            event.stopPropagation();
            colorClip = event.currentTarget as MovieClip;
            if(ConstantsPlatform.isMobile && !oldColorPicker)
            {
               if(colorPicker != null)
               {
                  colorPicker.destroy();
                  colorPicker = null;
               }
               localPoint = _pickerOrigin;
               appHeight = 500;
               colorPicker = new MobileColorPickerView(localPoint,thisView,appHeight,colorChosen,false);
            }
            else
            {
               stagePoint = new Point(event.stageX,event.stageY);
               localPoint = thisView.globalToLocal(stagePoint);
               offsetLocalPoint = applyOffset(localPoint);
               if(_pickerOrigin != null && _pickerMaxWidth != -1)
               {
                  ColorController.openColorPicker(thisView,offsetLocalPoint.x,offsetLocalPoint.y,ColorScheme.COLOR_SCHEME_DEFAULT,colorChosen,update,-1,_pickerOrigin,_pickerMaxWidth);
               }
               else
               {
                  ColorController.openColorPicker(thisView,offsetLocalPoint.x,offsetLocalPoint.y,ColorScheme.COLOR_SCHEME_DEFAULT,colorChosen,update,model.getPickerQuadrant());
               }
            }
         };
         thisView = this;
         return colorClicked;
      }
      
      private function applyOffset(param1:Point) : Point
      {
         var _loc2_:Point = this.model.getToolTipOffset();
         if(_loc2_ == null)
         {
            _loc2_ = new Point();
         }
         param1.x += _loc2_.x;
         param1.y += _loc2_.y;
         return param1;
      }
      
      protected function resetClicked(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.model.getNumberOfColors())
         {
            this.model.resetColor(_loc2_);
            _loc2_++;
         }
      }
      
      private function colorChanged(param1:ColorTooltipModelEvent) : void
      {
         var _loc2_:* = param1.data;
         var _loc3_:int = int(_loc2_.index);
         var _loc4_:uint = uint(_loc2_.color);
         this.setIndexColor(_loc3_,_loc4_);
      }
      
      protected function setIndexColor(param1:int, param2:uint) : void
      {
         var _loc3_:DisplayObject = this.colors[param1];
         var _loc4_:DisplayObject = _loc3_[I_COLOR];
         var _loc5_:ColorTransform = new ColorTransform();
         _loc5_.color = param2;
         _loc4_.transform.colorTransform = _loc5_;
      }
      
      public function set pickerOrigin(param1:Point) : void
      {
         this._pickerOrigin = param1;
      }
      
      public function set pickerMaxWidth(param1:Number) : void
      {
         this._pickerMaxWidth = param1;
      }
      
      public function setPosition(param1:Number, param2:Number) : void
      {
         this.x += param1;
         this.y += param2;
      }
      
      public function set scale(param1:Number) : void
      {
         this._scaleResetButton = param1;
      }
      
      public function destroy() : void
      {
         if(this.colorPicker != null)
         {
            this.colorPicker.destroy();
            this.colorPicker = null;
         }
      }
   }
}

