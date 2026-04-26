package com.moviestarplanet.flash.components.container.cloth
{
   import com.moviestarplanet.IDestroyable;
   import com.moviestarplanet.body.ILoadable;
   import com.moviestarplanet.clothesutils.DesignLoader;
   import com.moviestarplanet.moviestar.valueObjects.Cloth;
   import com.moviestarplanet.moviestar.valueObjects.Design;
   import com.moviestarplanet.utils.FlashUtils;
   import com.moviestarplanet.utils.color.IColorReader;
   import com.moviestarplanet.utils.displayobject.DisplayObjectUtil;
   import com.moviestarplanet.utils.flash.MSP_FlashLoader;
   import com.moviestarplanet.utils.loader.ContentUrl;
   import com.moviestarplanet.utils.loader.MSP_LoaderManager;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class FlashClothBox extends Sprite implements IDestroyable
   {
      
      public static var colorReader:IColorReader;
      
      public static const VERTICAL_ALIGNMENT_MIDDLE:int = 0;
      
      public static const VERTICAL_ALIGNMENT_BOTTOM:int = 1;
      
      private var _url:ContentUrl;
      
      private var _colors:String;
      
      protected var contentW:Number;
      
      protected var contentH:Number;
      
      private var _verticalAlignment:int;
      
      protected var _isLoaded:Boolean;
      
      protected var loadCallback:Function;
      
      private var _cloth:ILoadable;
      
      private var design:Design;
      
      private var _loader:Loader;
      
      public function FlashClothBox(param1:ILoadable, param2:String, param3:Number, param4:Number, param5:Design = null)
      {
         super();
         this._cloth = param1;
         if(param1 != null)
         {
            this._url = new ContentUrl(param1.path,ContentUrl.CLOTH,param1.LastUpdated);
         }
         this._colors = param2;
         this.contentW = param3;
         this.contentH = param4;
         this.design = param5;
      }
      
      public static function GetURL(param1:Cloth) : ContentUrl
      {
         return new ContentUrl(param1.path,ContentUrl.CLOTH,param1.LastUpdated);
      }
      
      public static function mockClothHack(param1:String, param2:int, param3:Boolean) : Cloth
      {
         var _loc4_:Cloth = new Cloth();
         _loc4_.ClothesId = 0;
         _loc4_.ClothesCategoryId = param2;
         if(param3)
         {
            _loc4_.Filename = param1;
         }
         else
         {
            _loc4_.SWF = param1;
         }
         _loc4_.ColorScheme = "";
         return _loc4_;
      }
      
      public function set verticalAlignment(param1:int) : void
      {
         this._verticalAlignment = param1;
      }
      
      public function get verticalAlignment() : int
      {
         return this._verticalAlignment;
      }
      
      public function get IsLoaded() : Boolean
      {
         return this._isLoaded;
      }
      
      public function get cloth() : ILoadable
      {
         return this._cloth;
      }
      
      public function LoadItem(param1:Function = null) : void
      {
         this.loadCallback = param1;
         if(this._isLoaded == false)
         {
            this._loader = MSP_FlashLoader.RequestLoad(this._url,this.loadDone,MSP_LoaderManager.PRIORITY_NORMAL,true,false);
         }
         else if(param1 != null)
         {
            param1();
            this.loadCallback = null;
         }
      }
      
      public function get loader() : Loader
      {
         return this._loader;
      }
      
      private function loadFail(param1:MSP_FlashLoader) : void
      {
         trace("loadFail");
      }
      
      protected function loadDone(param1:MSP_FlashLoader) : void
      {
         var mc:MovieClip;
         var that:FlashClothBox = null;
         var setColorAndAdjust:Function = null;
         var ready:Function = null;
         var loader:MSP_FlashLoader = param1;
         setColorAndAdjust = function(param1:MovieClip):void
         {
            var _loc2_:String = null;
            if(param1 != null)
            {
               _loc2_ = _cloth.ColorScheme;
               colorReader.applyColorScheme(param1,_loc2_,_colors);
               _isLoaded = true;
               constrainSizeWTrim(loader.content);
               addChild(loader);
               if(design)
               {
                  new DesignLoader(that).loadDesignToCloth(param1,design,ready);
               }
               else
               {
                  ready();
               }
            }
         };
         ready = function():void
         {
            if(loadCallback != null)
            {
               loadCallback(loader);
            }
            loadCallback = null;
         };
         trace("loadDone " + this._cloth);
         if(this._cloth == null)
         {
            return;
         }
         that = this;
         mc = loader.content as MovieClip;
         if(mc != null)
         {
            if(this._cloth.isImage)
            {
               setColorAndAdjust(mc);
            }
            else
            {
               FlashUtils.GotoAndStopAndWaitForCompletion(mc,2,setColorAndAdjust);
            }
         }
         else
         {
            this.constrainSizeWTrim(loader.content);
            addChild(loader);
            if(this.loadCallback != null)
            {
               this.loadCallback(loader);
            }
            this.loadCallback = null;
         }
      }
      
      protected function constrainSizeWTrim(param1:DisplayObject) : void
      {
         var _loc8_:Number = NaN;
         if(this.contentH <= 0 || this.contentW <= 0)
         {
            return;
         }
         var _loc2_:Rectangle = DisplayObjectUtil.getVisibleBounds(param1);
         var _loc3_:Number = Number(Math.min(this.contentH,this.contentW));
         var _loc4_:Number = Number(_loc2_.width);
         var _loc5_:Number = Number(_loc2_.height);
         var _loc6_:Number = _loc2_.height / _loc2_.width;
         var _loc7_:Number = this.contentH / this.contentW;
         if(_loc6_ > _loc7_)
         {
            _loc8_ = this.contentH / _loc2_.height;
         }
         else
         {
            _loc8_ = this.contentW / _loc2_.width;
         }
         param1.scaleX = _loc8_;
         param1.scaleY = _loc8_;
         param1.x = (this.contentW - _loc2_.width * _loc8_) / 2 - _loc2_.x * _loc8_;
         switch(this._verticalAlignment)
         {
            case VERTICAL_ALIGNMENT_MIDDLE:
               param1.y = (this.contentH - _loc2_.height * _loc8_) / 2 - _loc2_.y * _loc8_;
               break;
            case VERTICAL_ALIGNMENT_BOTTOM:
               param1.y = this.contentH - (_loc2_.height + _loc2_.y) * _loc8_;
         }
         param1.visible = true;
      }
      
      public function destroy() : void
      {
         removeChildren();
         this._cloth = null;
         this._colors = null;
         this._url = null;
         this.design = null;
         this.loadCallback = null;
      }
   }
}

