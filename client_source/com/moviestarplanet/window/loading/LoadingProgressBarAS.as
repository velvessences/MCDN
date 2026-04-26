package com.moviestarplanet.window.loading
{
   import com.moviestarplanet.config.ISiteConfig;
   import com.moviestarplanet.injection.InjectionManager;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.geom.Point;
   import mx.core.FlexGlobals;
   import mx.core.UIComponent;
   
   public class LoadingProgressBarAS extends UIComponent
   {
      
      private var LoadingGraphicsType:Class = LoadingProgressBarAS_LoadingGraphicsType;
      
      public var label:String;
      
      public var fontSize:int;
      
      [Inject]
      public var siteConfig:ISiteConfig;
      
      public var graphicsObject:MovieClip;
      
      private var _stage:Stage;
      
      private var toStopArr:Array = [];
      
      public function LoadingProgressBarAS()
      {
         super();
         InjectionManager.manager().injectMe(Object(this));
         this.graphicsObject = new this.LoadingGraphicsType() as MovieClip;
         this.graphicsObject.gotoAndStop(this.siteConfig.brandName);
         this.graphicsObject.scaleX = 0.38;
         this.graphicsObject.scaleY = 0.38;
         this.calculatePosition();
         addChild(this.graphicsObject);
         this.getStoppableChildren();
      }
      
      public static function show(param1:DisplayObjectContainer) : void
      {
      }
      
      public function stop() : void
      {
         var _loc1_:MovieClip = null;
         if(this.graphicsObject)
         {
            for each(_loc1_ in this.toStopArr)
            {
               _loc1_.gotoAndStop(1);
            }
         }
      }
      
      public function play() : void
      {
         var _loc1_:MovieClip = null;
         if(this.graphicsObject)
         {
            for each(_loc1_ in this.toStopArr)
            {
               _loc1_.gotoAndPlay(1);
            }
         }
      }
      
      private function getStoppableChildren() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:DisplayObject = null;
         var _loc3_:Array = [];
         this.toStopArr.length = 0;
         _loc3_[0] = this.graphicsObject;
         while(_loc3_.length)
         {
            _loc4_ = _loc3_.pop();
            if(_loc4_ is MovieClip && _loc4_ != this.graphicsObject)
            {
               if((_loc4_ as MovieClip).totalFrames > 1)
               {
                  this.toStopArr.push(_loc4_);
               }
            }
            if(_loc4_ is DisplayObjectContainer)
            {
               _loc1_ = 0;
               while(_loc1_ < (_loc4_ as DisplayObjectContainer).numChildren)
               {
                  _loc5_ = (_loc4_ as DisplayObjectContainer).getChildAt(_loc1_);
                  _loc3_.push(_loc5_);
                  _loc1_++;
               }
            }
         }
      }
      
      protected function calculatePosition() : void
      {
         var _loc1_:Point = new Point(FlexGlobals.topLevelApplication.mainCanvas.width * 0.5,FlexGlobals.topLevelApplication.mainCanvas.height * 0.5);
         x = int(_loc1_.x);
         y = int(_loc1_.y);
      }
   }
}

