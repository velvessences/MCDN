package com.moviestarplanet.scrapitems.pattern
{
   import com.moviestarplanet.scrapitems.IClipArtInfo;
   import com.moviestarplanet.scrapitems.msg.ScrapItemEvent;
   import com.moviestarplanet.scrapitems.utils.ClipArtUtils;
   import com.moviestarplanet.utils.ColorMap;
   import com.moviestarplanet.utils.color.IColorReader;
   import com.moviestarplanet.utils.flash.MSP_FlashLoader;
   import com.moviestarplanet.utils.loader.ContentUrl;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Matrix;
   
   public class PatternLoader extends EventDispatcher
   {
      
      public static var colorReader:IColorReader;
      
      public static var rendererFactoryClass:Class;
      
      public var renderers:Array = new Array();
      
      public var parts:Array;
      
      public var colorArray:Array;
      
      public var rendererFactory:IPatternRendererFactory;
      
      private var template:MovieClip;
      
      private var _clipArt:IClipArtInfo;
      
      private var _rotation:Number = 0;
      
      private var _patternScale:Number = 1;
      
      private var _colors:String;
      
      private var colorSchemeObj:Object;
      
      private var pendingColors:String;
      
      private var numRenderersLoading:int = 0;
      
      public function PatternLoader(param1:MovieClip, param2:IPatternRendererFactory = null)
      {
         super();
         this.template = param1;
         if(param2 == null)
         {
            this.rendererFactory = new rendererFactoryClass();
         }
         this.initParts();
      }
      
      private function initParts() : void
      {
         var _loc2_:MovieClip = null;
         this.parts = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < this.template.numChildren)
         {
            _loc2_ = this.template.getChildAt(_loc1_) as MovieClip;
            if(_loc2_ != null)
            {
               if(_loc2_.Pattern)
               {
                  this.parts.push(_loc2_);
               }
            }
            _loc1_++;
         }
      }
      
      public function get clipArt() : IClipArtInfo
      {
         return this._clipArt;
      }
      
      public function set clipArt(param1:IClipArtInfo) : void
      {
         if(param1 != null)
         {
            this._clipArt = param1;
            MSP_FlashLoader.RequestLoad(new ContentUrl(this.clipArt.path,ContentUrl.CLIPART),this.patternReady);
         }
      }
      
      private function patternReady(param1:Loader) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:PatternRenderer = null;
         if(this.clipArt.ColorScheme == null && Boolean(this.pendingColors))
         {
            this.colorSchemeObj = ColorMap.createMobileColorScheme(this.pendingColors.split(","));
         }
         else
         {
            this.colorSchemeObj = colorReader.extractColorScheme(param1.content as MovieClip,this.clipArt.ColorScheme);
         }
         this.rendererFactory.prepareFactoryForLoader(param1);
         var _loc2_:int = 0;
         while(_loc2_ < this.parts.length)
         {
            _loc3_ = this.parts[_loc2_] as MovieClip;
            if(_loc3_ != null)
            {
               if(_loc3_.Pattern)
               {
                  _loc4_ = this.rendererFactory.createRenderer(_loc3_,param1.content.loaderInfo.width,param1.content.loaderInfo.height);
                  _loc3_.Pattern.addChild(_loc4_);
                  this.waitForRenderer(_loc4_);
                  this.renderers.push(_loc4_);
                  this.initColors(_loc4_);
                  this.rotateRenderer(_loc4_,this.rotation);
               }
            }
            _loc2_++;
         }
         if(this.pendingColors)
         {
            this.colors = this.pendingColors;
         }
         for each(_loc4_ in this.renderers)
         {
            _loc4_.patternScale = this.patternScale;
         }
      }
      
      private function waitForRenderer(param1:PatternRenderer) : void
      {
         param1.addEventListener(ScrapItemEvent.RENDERER_COMPLETE,this.onRendererComplete);
         ++this.numRenderersLoading;
      }
      
      protected function onRendererComplete(param1:Event) : void
      {
         param1.currentTarget.removeEventListener(ScrapItemEvent.RENDERER_COMPLETE,this.onRendererComplete);
         trace("renderers Loading =:",this.numRenderersLoading - 1);
         --this.numRenderersLoading;
         if(this.numRenderersLoading <= 0)
         {
            dispatchEvent(new ScrapItemEvent(ScrapItemEvent.ITEM_COMPLETE));
         }
      }
      
      public function get rotation() : Number
      {
         return this._rotation;
      }
      
      public function set rotation(param1:Number) : void
      {
         var _loc2_:PatternRenderer = null;
         for each(_loc2_ in this.renderers)
         {
            this.rotateRenderer(_loc2_,param1 - this.rotation);
         }
         this._rotation = param1;
      }
      
      private function rotateRenderer(param1:PatternRenderer, param2:Number) : void
      {
         var _loc3_:Matrix = new Matrix();
         _loc3_.translate(-param1.diameter / 2,-param1.diameter / 2);
         _loc3_.rotate(param2);
         _loc3_.translate(param1.diameter / 2,param1.diameter / 2);
         _loc3_.concat(param1.transform.matrix);
         param1.transform.matrix = _loc3_;
      }
      
      public function get patternScale() : Number
      {
         return this._patternScale;
      }
      
      public function set patternScale(param1:Number) : void
      {
         this._patternScale = param1;
         var _loc2_:int = 0;
         while(_loc2_ < this.renderers.length)
         {
            this.renderers[_loc2_].patternScale = param1;
            _loc2_++;
         }
      }
      
      public function set colors(param1:String) : void
      {
         var _loc2_:MovieClip = null;
         this._colors = param1;
         for each(_loc2_ in this.renderers)
         {
            ColorMap.SetColorsOnMovieClip(_loc2_,0,this._colors);
         }
      }
      
      private function initColors(param1:PatternRenderer) : void
      {
         if(this.colorSchemeObj != null)
         {
            param1.colorscheme = this.colorSchemeObj;
            ColorMap.CreateColorMapOnMovieClip(param1,this.colorSchemeObj,false);
            if(this.colorArray == null)
            {
               this.colorArray = ColorMap.GetColorsFromColorMap(param1.colorMap);
            }
         }
      }
      
      public function get dataObject() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.clipArt = ClipArtUtils.clipArtToData(this.clipArt);
         _loc1_.patternScale = this.patternScale;
         _loc1_.rotation = this.rotation;
         _loc1_.colors = this._colors;
         return _loc1_;
      }
      
      public function set dataObject(param1:Object) : void
      {
         this.patternScale = param1.patternScale;
         this.rotation = param1.rotation;
         this.pendingColors = param1.colors;
         this.clipArt = ClipArtUtils.dataToClipArt(param1.clipArt);
      }
      
      public function hasPatternParts() : Boolean
      {
         return this.parts.length > 0;
      }
      
      public function destroy() : void
      {
         var _loc1_:PatternRenderer = null;
         this.template = null;
         if(this.renderers != null)
         {
            for each(_loc1_ in this.renderers)
            {
               if(_loc1_.parent)
               {
                  _loc1_.parent.removeChild(_loc1_);
               }
               _loc1_.removeEventListener(ScrapItemEvent.RENDERER_COMPLETE,this.onRendererComplete);
               _loc1_.destroy();
            }
            this.renderers.length = 0;
         }
         if(this.parts != null)
         {
            this.parts.length = 0;
         }
         if(this.colorArray != null)
         {
            this.colorArray.length = 0;
         }
         this.rendererFactory.dispose();
         this.parts = null;
         this.renderers = null;
         this.colorArray = null;
      }
   }
}

