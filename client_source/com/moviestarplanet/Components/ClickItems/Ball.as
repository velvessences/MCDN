package com.moviestarplanet.Components.ClickItems
{
   import com.moviestarplanet.utils.MSP_SWFLoader;
   import com.moviestarplanet.utils.loader.RawUrl;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class Ball extends MSP_SWFLoader
   {
      
      private var angle:Number;
      
      private var startTime:int;
      
      private var vx:Number;
      
      private var vy:Number;
      
      private var startX:Number;
      
      private var startY:Number;
      
      private var destY:Number;
      
      private var destX:Number;
      
      private var callback:Function;
      
      private var bouncing:Boolean = false;
      
      private var duration:int;
      
      private var limitX:Boolean = false;
      
      private var g:Number = 205.8;
      
      private var _curvePoint:Number;
      
      public function Ball()
      {
         super();
         addEventListener(Event.ENTER_FRAME,this.HandleEnterFrame);
      }
      
      public function loadSource(param1:String, param2:Function) : void
      {
         var loadDone:Function = null;
         var source:String = param1;
         var loadCallback:Function = param2;
         loadDone = function(param1:Event):void
         {
            loadCallback();
            (content as MovieClip).x = -content.width / 2;
            (content as MovieClip).y = -content.height / 2;
         };
         addEventListener(Event.COMPLETE,loadDone,false,0,false);
         LoadUrl(new RawUrl(source),2,false);
      }
      
      public function get h() : Number
      {
         if(content != null)
         {
            return content.height;
         }
         return super.height;
      }
      
      public function get w() : Number
      {
         if(content != null)
         {
            return content.width;
         }
         return super.width;
      }
      
      public function moveBall(param1:Number, param2:Number) : void
      {
         move(param1,param2);
         this.x += content.width / 4;
         this.y += content.height / 4;
      }
      
      public function bounceAway(param1:int, param2:int, param3:int, param4:Function) : void
      {
         this.bouncing = false;
         this.callback = param4;
         this.duration = param3;
         this.startX = x;
         this.startY = y;
         this.destY = param2;
         this.destX = param1;
         var _loc5_:Number = param1 - x;
         var _loc6_:Number = param2 - y;
         this.vx = _loc5_ * 1000 / param3;
         this.angle = this.angleFromVxAndRange(this.vx,_loc5_);
         var _loc7_:Number = this.speedFromAngle(this.vx,this.angle);
         this.vy = Math.abs(_loc7_ * Math.sin(this.angle));
         this.limitX = false;
         this.startTime = getTimer();
         this.bouncing = true;
      }
      
      public function bounceBack(param1:Function) : void
      {
         this.callback = param1;
         this.bouncing = false;
         this.vx = -this.vx;
         var _loc2_:Number = this.destX;
         this.destX = this.startX;
         this.startX = _loc2_;
         var _loc3_:Number = this.destY;
         this.destY = this.startY;
         this.limitX = true;
         var _loc4_:Number = getTimer() - this.startTime;
         if(_loc4_ < this.duration)
         {
            this.startTime = getTimer() - (this.duration - _loc4_);
         }
         else
         {
            this.startTime = getTimer();
         }
         this.bouncing = true;
      }
      
      public function bounceAtEnd(param1:Function) : void
      {
         var _loc2_:Number = this.destX - this.startX;
         this.bounceAway(x + _loc2_ / 10,y,this.duration / 4,param1);
      }
      
      private function angleFromVxAndRange(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = Number(Math.atan(param2 * this.g / (2 * param1 * param1)));
         var _loc4_:Number = _loc3_ * 180 / Math.PI;
         return _loc3_;
      }
      
      private function speedFromAngle(param1:Number, param2:Number) : Number
      {
         return param1 / Math.cos(param2);
      }
      
      private function HandleEnterFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         if(this.bouncing)
         {
            _loc2_ = int(getTimer());
            _loc3_ = _loc2_ - this.startTime;
            _loc4_ = this.startX + this.vx * _loc3_ * 0.001;
            _loc5_ = this.g * _loc3_ * _loc3_ / 2 * 0.001 * 0.001;
            _loc6_ = this.vy * _loc3_ * 0.001;
            _loc7_ = _loc6_ - _loc5_;
            _loc8_ = this.startY - _loc7_;
            _loc9_ = (rotation + _loc4_ - x) % 360;
            rotation = _loc9_;
            x = _loc4_;
            y = _loc8_;
            if(this.limitX && Math.abs(x - this.startX) > Math.abs(this.destX - this.startX))
            {
               x = this.destX;
               y = this.destY;
               this.bouncing = false;
               this.callback();
            }
            else if(_loc8_ > this.destY)
            {
               y = this.destY;
               this.bouncing = false;
               this.callback();
            }
         }
      }
      
      public function set curvePoint(param1:Number) : void
      {
         this._curvePoint = param1;
      }
      
      public function get curvePoint() : Number
      {
         return this._curvePoint;
      }
   }
}

