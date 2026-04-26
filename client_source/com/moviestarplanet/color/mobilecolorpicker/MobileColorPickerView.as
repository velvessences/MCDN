package com.moviestarplanet.color.mobilecolorpicker
{
   import com.moviestarplanet.color.colorpicker.ColorScheme;
   import com.moviestarplanet.color.mobilecolorpicker.assets.AssetManager;
   import com.moviestarplanet.color.mobilecolorpicker.display.GraphicContainer;
   import com.moviestarplanet.color.mobilecolorpicker.display.GraphicHolder;
   import com.moviestarplanet.color.mobilecolorpicker.display.GraphicInteractive;
   import com.moviestarplanet.color.mobilecolorpicker.events.DualEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filesystem.File;
   import flash.geom.Point;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Quad;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.events.TouchPhase;
   
   public class MobileColorPickerView extends GraphicContainer
   {
      
      public static const COLOR_TABS:Array = ["Red","Yellow","Green","Blue","Pink","Mono"];
      
      protected var _starling:Boolean;
      
      protected var _bg:GraphicHolder;
      
      protected var _tabsArray:Array;
      
      protected var _tabsClickedArray:Array;
      
      protected var _blocksArray:Array;
      
      protected var _callback:Function;
      
      protected var _container:Object;
      
      protected var currentTab:int;
      
      protected var _availableHeight:Number;
      
      protected var _alwaysOnTop:Boolean;
      
      protected var _assetManager:AssetManager;
      
      protected var _coords:Object;
      
      private var _flashClickBlocker:Sprite;
      
      private var _invisibleOverlay:GraphicContainer;
      
      private const PADDING:int = 0;
      
      protected var _columnsNumber:Number;
      
      protected var _rowsNumber:Number;
      
      protected var _colorOffsetX:Number;
      
      protected var _colorOffsetY:Number;
      
      protected const TAB_OFFSET_X:Number = 11.35;
      
      protected const TAB_OFFSET_Y:Number = 8.1;
      
      protected const PICKERS_OFFSETS:Number = 8;
      
      public function MobileColorPickerView(param1:Object, param2:Object, param3:Number, param4:Function, param5:Boolean, param6:Boolean = true, param7:Boolean = false)
      {
         this._starling = param5;
         this._callback = param4;
         this._container = param2;
         this._availableHeight = param3;
         this._coords = param1;
         this._alwaysOnTop = param7;
         this.setupMagicNumbers();
         super(param5);
         this.setupAsset();
         this._tabsArray = new Array();
         this._blocksArray = new Array();
         this._tabsClickedArray = new Array();
         this.currentTab = -1;
         if(!this._starling)
         {
            this.createOverlay();
         }
         if(!param6)
         {
            this.visible = false;
         }
      }
      
      protected function setupMagicNumbers() : void
      {
         this._columnsNumber = 6;
         this._rowsNumber = 5;
         this._colorOffsetX = 8.25;
         this._colorOffsetY = 47;
      }
      
      protected function setupAsset() : void
      {
         this._assetManager = new AssetManager();
         this._assetManager.loadSWF("assets" + File.separator + "colorpicker" + File.separator + "colorpicker.swf",this.onAssetsLoaded);
      }
      
      public function showPicker() : void
      {
         this.visible = true;
         if(this._starling)
         {
            this.createOverlay();
         }
         if(this._starling && this._flashClickBlocker == null)
         {
            this.addFlashClickBlocker();
         }
      }
      
      public function hidePicker() : void
      {
         this.visible = false;
         if(this._starling)
         {
            this.removeOverlay();
         }
         if(this._flashClickBlocker)
         {
            this._flashClickBlocker.parent.removeChild(this._flashClickBlocker);
            this._flashClickBlocker = null;
         }
      }
      
      private function createOverlay() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Point = null;
         var _loc3_:Quad = null;
         this._invisibleOverlay = new GraphicContainer(this._starling);
         if(this._starling)
         {
            _loc1_ = Starling.current.stage;
            _loc2_ = this._container.globalToLocal(new Point(_loc1_.x,_loc1_.y));
            _loc3_ = new Quad(_loc1_.stageWidth,_loc1_.stageHeight);
            _loc3_.alpha = 0;
            this._invisibleOverlay.displayObject = _loc3_;
            _loc1_.addEventListener(TouchEvent.TOUCH,this.onMouseOutStage);
            this._invisibleOverlay.displayObject.addEventListener(TouchEvent.TOUCH,this.onMouseOutOverlay);
         }
         else
         {
            _loc1_ = Starling.current.nativeStage;
            _loc2_ = this._container.globalToLocal(new Point(_loc1_.x,_loc1_.y));
            this._invisibleOverlay.displayObject.graphics.beginFill(0,0);
            this._invisibleOverlay.displayObject.graphics.drawRect(_loc2_.x,_loc2_.y,_loc1_.stageWidth,_loc1_.stageHeight);
            _loc1_.addEventListener(MouseEvent.CLICK,this.onMouseOutStage);
            this._invisibleOverlay.displayObject.addEventListener(MouseEvent.CLICK,this.onMouseOutOverlay);
         }
         this._container.addChildAt(this._invisibleOverlay.displayObject,this._container.numChildren - 2);
      }
      
      private function removeOverlay() : void
      {
         if(this._invisibleOverlay)
         {
            if(Boolean(this._container) && Boolean(this._container.contains(this._invisibleOverlay.displayObject)))
            {
               this._container.removeChild(this._invisibleOverlay.displayObject);
            }
            if(this._starling)
            {
               this._invisibleOverlay.displayObject.removeEventListener(TouchEvent.TOUCH,this.onMouseOutOverlay);
            }
            else
            {
               this._invisibleOverlay.displayObject.removeEventListener(MouseEvent.CLICK,this.onMouseOutOverlay);
            }
            this._invisibleOverlay = null;
         }
         if(this._starling)
         {
            Starling.current.stage.removeEventListener(TouchEvent.TOUCH,this.onMouseOutStage);
         }
         else
         {
            Starling.current.nativeStage.removeEventListener(MouseEvent.CLICK,this.onMouseOutStage);
         }
      }
      
      private function onMouseOutOverlay(param1:Object) : void
      {
         var _loc2_:Touch = null;
         if(this._starling)
         {
            _loc2_ = param1.getTouch(Starling.current.stage);
            if(Boolean(_loc2_) && param1.target == this._invisibleOverlay.displayObject)
            {
               if(_loc2_.phase == TouchPhase.BEGAN)
               {
                  this.hidePicker();
               }
            }
         }
         else if(param1.target == this._invisibleOverlay.displayObject)
         {
            this.destroy();
         }
      }
      
      private function onMouseOutStage(param1:Object) : void
      {
         var _loc2_:Touch = null;
         if(this._starling)
         {
            _loc2_ = param1.getTouch(Starling.current.stage);
            if(Boolean(_loc2_) && param1.target == this._invisibleOverlay.displayObject)
            {
               if(_loc2_.phase == TouchPhase.BEGAN)
               {
                  this.hidePicker();
               }
            }
         }
         else if(!this._container.contains(param1.target))
         {
            this.destroy();
         }
      }
      
      public function onAssetsLoaded() : void
      {
         this._assetManager.setScale(this._availableHeight);
         this._bg = new GraphicHolder("Background",this._starling,this._assetManager);
         addChild(this._bg);
         this.initTabClicked();
         this.initTabs();
         this.currentTab = 0;
         addChild(this._tabsClickedArray[this.currentTab]);
         this.initColorTab(this.currentTab);
         this.addPicker();
      }
      
      private function addFlashClickBlocker() : void
      {
         this._flashClickBlocker = new Sprite();
         Starling.current.nativeStage.addChild(this._flashClickBlocker);
         this._flashClickBlocker.graphics.beginFill(0);
         this._flashClickBlocker.graphics.drawRect(0,0,(this._bg.displayObject as starling.display.DisplayObject).width,(this._bg.displayObject as starling.display.DisplayObject).height);
         this._flashClickBlocker.graphics.endFill();
         this._flashClickBlocker.alpha = 0;
         this._flashClickBlocker.x = this.x;
         this._flashClickBlocker.y = this.y;
      }
      
      protected function addPicker() : void
      {
         if(!this._alwaysOnTop)
         {
            this._container.addChild(this.displayObject);
         }
         else if(this._starling)
         {
            Starling.current.stage.addChildAt(this.displayObject as starling.display.DisplayObject,Starling.current.stage.numChildren);
            this._container = Starling.current.stage;
         }
         else
         {
            Starling.current.nativeStage.addChildAt(this.displayObject as flash.display.DisplayObject,Starling.current.nativeStage.numChildren);
            this._container = Starling.current.nativeStage;
         }
         this.setColorPickerCoords(this._coords);
      }
      
      protected function setColorPickerCoords(param1:Object) : void
      {
         var _loc2_:Point = null;
         if(param1 == null)
         {
            x = 0;
            y = 0;
         }
         else if(param1 is Point)
         {
            x = (param1 as Point).x;
            y = (param1 as Point).y;
         }
         else if(param1 is String)
         {
            if(param1 == "top-right")
            {
               _loc2_ = new Point(Starling.current.viewPort.width,0);
               _loc2_ = this._container.globalToLocal(_loc2_);
               x = _loc2_.x - this.width - this.PICKERS_OFFSETS;
               y = _loc2_.y + this.PICKERS_OFFSETS;
            }
            else if(param1 == "center-right")
            {
               _loc2_ = new Point(Starling.current.viewPort.width,Starling.current.viewPort.height / 2);
               _loc2_ = this._container.globalToLocal(_loc2_);
               x = _loc2_.x - this.width;
               y = _loc2_.y - this.height / 2;
            }
            else if(param1 == "center-left")
            {
               _loc2_ = new Point(Starling.current.viewPort.width,Starling.current.viewPort.height / 2);
               _loc2_ = this._container.globalToLocal(_loc2_);
               y = _loc2_.y - this.height / 2;
            }
         }
      }
      
      protected function initTabs() : void
      {
         var _loc2_:GraphicInteractive = null;
         var _loc3_:Number = NaN;
         var _loc1_:int = 0;
         while(_loc1_ < this._columnsNumber)
         {
            _loc2_ = new GraphicInteractive(COLOR_TABS[_loc1_] + "Tab",this._starling,this._assetManager);
            _loc3_ = (_loc1_ + 1) * (this.TAB_OFFSET_X * this._assetManager.scale);
            _loc2_.x = _loc2_.width * _loc1_ + _loc3_;
            _loc2_.y = this.TAB_OFFSET_Y * this._assetManager.scale;
            _loc2_.addListener(DualEvent.CLICK,this.onTabClick);
            _loc2_.customData.tabId = _loc1_;
            this._tabsArray.push(_loc2_);
            addChild(_loc2_);
            _loc1_++;
         }
      }
      
      private function initTabClicked() : void
      {
         var _loc2_:GraphicInteractive = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._columnsNumber)
         {
            _loc2_ = new GraphicInteractive(COLOR_TABS[_loc1_] + "TabClick",this._starling,this._assetManager);
            _loc2_.mouseEnabled = false;
            this._tabsClickedArray.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function initColorTab(param1:int = 0) : void
      {
         var _loc2_:Array = ColorScheme.MOBILE_COLOR_PICKER_SCHEME[param1];
         this.addColorBlocks(_loc2_);
      }
      
      protected function addColorBlocks(param1:Array) : void
      {
         var _loc4_:GraphicInteractive = null;
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         if(this._blocksArray.length == 0)
         {
            _loc6_ = true;
         }
         while(_loc3_ < this._rowsNumber)
         {
            _loc2_ = 0;
            while(_loc2_ < this._columnsNumber)
            {
               if(_loc6_)
               {
                  _loc4_ = new GraphicInteractive("ColorBlock",this._starling,this._assetManager);
                  _loc4_.y = _loc4_.height * _loc3_ + this._colorOffsetY * this._assetManager.scale;
                  _loc4_.x = _loc4_.width * _loc2_ + this._colorOffsetX * this._assetManager.scale;
                  _loc4_.addListener(DualEvent.CLICK,this.onBlockClick);
                  _loc4_.customData.id = "color" + _loc2_ + _loc3_;
                  this._blocksArray.push(_loc4_);
                  addChild(_loc4_);
               }
               else
               {
                  _loc4_ = this._blocksArray[_loc5_];
                  setChildIndex(_loc4_.displayObject,numChildren - 1);
               }
               _loc7_ = int(param1[_loc5_]);
               _loc4_.tint(_loc7_);
               _loc4_.customData.color = _loc7_;
               _loc5_++;
               _loc2_++;
            }
            _loc3_++;
         }
      }
      
      protected function onBlockClick(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         if(this._callback != null)
         {
            this._callback(param1.target.customData.color);
         }
      }
      
      private function onTabClick(param1:Event) : void
      {
         trace("tab clicked");
         if(param1.target.customData.tabId == this.currentTab)
         {
            return;
         }
         if(this.currentTab != -1)
         {
            removeChild(this._tabsClickedArray[this.currentTab]);
         }
         this.currentTab = param1.target.customData.tabId;
         this.initColorTab(this.currentTab);
         addChild(this._tabsClickedArray[this.currentTab]);
      }
      
      private function destroyColorBlocks() : void
      {
         var _loc3_:GraphicInteractive = null;
         var _loc1_:int = 0;
         var _loc2_:int = int(this._blocksArray.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this._blocksArray[_loc1_];
            removeChild(_loc3_);
            _loc3_.removeListener(DualEvent.CLICK,this.onBlockClick);
            _loc3_.destroy();
            _loc1_++;
         }
         this._blocksArray.length = 0;
      }
      
      private function destroyColorTabs() : void
      {
         var _loc3_:GraphicInteractive = null;
         var _loc1_:int = 0;
         var _loc2_:int = int(this._tabsArray.length);
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this._tabsArray[_loc1_];
            removeChild(_loc3_);
            _loc3_.removeListener(DualEvent.CLICK,this.onTabClick);
            _loc3_.destroy();
            _loc1_++;
         }
         this._tabsArray.length = 0;
      }
      
      public function destroy() : void
      {
         trace("destroy colorpicker");
         if(this.currentTab != -1)
         {
            removeChild(this._tabsClickedArray[this.currentTab]);
            this.currentTab = -1;
            this._tabsClickedArray.length = 0;
         }
         this.destroyColorBlocks();
         this.destroyColorTabs();
         this.removeOverlay();
         if(this._assetManager)
         {
            this._assetManager.destroy();
            this._assetManager = null;
         }
         if(this._container)
         {
            this._container.removeChild(this.displayObject);
            this._container = null;
         }
      }
   }
}

