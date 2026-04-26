package com.moviestarplanet.utils.loader
{
   import com.moviestarplanet.utils.MSP_SWFLoader;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class FlippableLoader extends MSP_SWFLoader
   {
      
      private var isFacingLeft:Boolean = true;
      
      public var animation:Object;
      
      public var data:Object;
      
      public var dragXoffSet:Number = 0;
      
      public var dragYoffSet:Number = 0;
      
      public var originalScale:Number;
      
      public function FlippableLoader(param1:Boolean = true)
      {
         super(param1);
      }
      
      public static function RequestLoad(param1:Object, param2:Function, param3:int = 2, param4:Boolean = true, param5:Boolean = true) : FlippableLoader
      {
         if(param1 == null)
         {
            trace("RequestLoad: url == null");
         }
         var _loc6_:FlippableLoader = new FlippableLoader(param5);
         _loc6_.source = param1;
         _loc6_.LoadCallBack = param2;
         MSP_LoaderManager.RequestLoadForLoader(_loc6_,param3,param4);
         return _loc6_;
      }
      
      public function FaceLeft() : void
      {
         if(!this.isFacingLeft)
         {
            this.FlipHorizontally();
         }
      }
      
      public function FaceRight() : void
      {
         if(this.isFacingLeft)
         {
            this.FlipHorizontally();
         }
      }
      
      public function FlipHorizontally() : void
      {
         this.FlipContentHorizontally();
         this.isFacingLeft = !this.isFacingLeft;
      }
      
      private function FlipContentHorizontally() : void
      {
         var _loc1_:Matrix = null;
         if(content)
         {
            _loc1_ = content.transform.matrix;
            _loc1_.a *= -1;
            if(this.isFacingLeft)
            {
               _loc1_.translate(content.width,0);
            }
            else
            {
               _loc1_.translate(-content.width,0);
            }
            content.transform.matrix = _loc1_;
         }
      }
      
      override protected function OnLoadComplete(param1:Event) : void
      {
         if(!this.isFacingLeft)
         {
            this.FlipContentHorizontally();
         }
         super.OnLoadComplete(param1);
      }
      
      public function trim() : void
      {
         var _loc1_:Rectangle = (content as DisplayObject).getRect(this);
         this.width = _loc1_.width;
         this.height = _loc1_.height;
         content.x -= _loc1_.x / content.scaleX;
         content.y -= _loc1_.y / content.scaleY;
         content.scaleX = 1;
         content.scaleY = 1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

