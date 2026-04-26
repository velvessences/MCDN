package com.moviestarplanet.utils.flash
{
   import com.moviestarplanet.loader.ILoaderUrl;
   import com.moviestarplanet.utils.loader.IMSP_Loader;
   import flash.display.DisplayObject;
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class FlippableFlashLoader extends Sprite
   {
      
      public static var LoaderClass:Class;
      
      public var loaderImpl:IMSP_Loader;
      
      public var animation:Object;
      
      private var _loadCallBack:Function;
      
      private var _failLoadCallBack:Function;
      
      private var _doContentsManage:Boolean;
      
      public function FlippableFlashLoader(param1:Boolean = true)
      {
         super();
         this._doContentsManage = param1;
         this.loaderImpl = new LoaderClass(this._doContentsManage);
         this.loaderImpl.LoadCallBack = this.implLoadCallback;
         addChild(this.loaderImpl as DisplayObject);
      }
      
      public function LoadUrl(param1:ILoaderUrl, param2:int = 2, param3:Boolean = true) : void
      {
         if(this._failLoadCallBack != null)
         {
            this.loaderImpl.LoadFailCallBack = this._failLoadCallBack;
         }
         this.loaderImpl.LoadUrl(param1,param2,param3);
      }
      
      public function trim() : void
      {
         var _loc1_:DisplayObject = this.loaderImpl.loadedContents;
         var _loc2_:DisplayObject = this.loaderImpl as DisplayObject;
         var _loc3_:Rectangle = _loc1_.getRect(this);
         _loc2_.width = _loc3_.width;
         _loc2_.height = _loc3_.height;
         _loc1_.x -= _loc3_.x / _loc1_.scaleX;
         _loc1_.y -= _loc3_.y / _loc1_.scaleY;
         _loc1_.scaleX = 1;
         _loc1_.scaleY = 1;
      }
      
      public function calcContentScaleAdjustments(param1:Number, param2:Number) : Number
      {
         var infoWidth:Number = NaN;
         var infoHeight:Number = NaN;
         var newXScale:Number = NaN;
         var newYScale:Number = NaN;
         var scale:Number = NaN;
         var interiorWidth:Number = param1;
         var interiorHeight:Number = param2;
         var _loc4_:IMSP_Loader = this.loaderImpl;
         with(_loc4_)
         {
            if(content.width == interiorWidth && content.height == interiorHeight)
            {
               return 1;
            }
            infoWidth = contentLoaderInfo.width;
            infoHeight = contentLoaderInfo.height;
            newXScale = interiorWidth / infoWidth;
            newYScale = interiorHeight / infoHeight;
            if(newXScale > newYScale)
            {
               scale = newYScale;
            }
            else
            {
               scale = newXScale;
            }
            return scale;
         }
         
         public function set LoadCallBack(param1:Function) : void
         {
            this._loadCallBack = param1;
         }
         
         public function get LoadCallBack() : Function
         {
            return this._loadCallBack;
         }
         
         public function set FailLoadCallBack(param1:Function) : void
         {
            this._failLoadCallBack = param1;
         }
         
         public function get FailLoadCallBack() : Function
         {
            return this._failLoadCallBack;
         }
         
         private function implLoadCallback(param1:IMSP_Loader) : void
         {
            if(this._loadCallBack != null)
            {
               this._loadCallBack(this);
            }
         }
         
         public function get sourceUrl() : String
         {
            return this.loaderImpl.sourceUrl;
         }
         
         public function set sourceUrl(param1:String) : void
         {
            this.loaderImpl.sourceUrl = param1;
         }
         
         public function get content() : DisplayObject
         {
            return this.loaderImpl.loadedContents as DisplayObject;
         }
         
         public function get contentLoaderInfo() : LoaderInfo
         {
            return this.loaderImpl.contentLoaderInfo;
         }
      }
   }
   
   