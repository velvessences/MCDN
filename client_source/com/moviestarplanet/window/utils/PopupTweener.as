package com.moviestarplanet.window.utils
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import mx.core.Container;
   import mx.core.ScrollPolicy;
   import mx.effects.AnimateProperty;
   import mx.effects.Fade;
   import mx.effects.Move;
   import mx.effects.Parallel;
   import mx.effects.Resize;
   import mx.effects.Sequence;
   import mx.effects.easing.Back;
   import mx.effects.easing.Exponential;
   import mx.events.EffectEvent;
   import mx.events.FlexEvent;
   
   public class PopupTweener extends EventDispatcher
   {
      
      private var fullSeq:Sequence = new Sequence();
      
      private var dimensionsTo:Rectangle;
      
      private var dimensionsFrom:Rectangle;
      
      private const ANIM_WIDTH_DELTA:Number = 0.7;
      
      private const ANIM_HEIGHT_DELTA:Number = 0.7;
      
      private const Y_DISPLACEMENT:int = -20;
      
      private var _targ:Container;
      
      private var scrollPolicyHor:String;
      
      private var scrollPolicyVert:String;
      
      private var created:Boolean = false;
      
      private var showDone:Function = null;
      
      private var _brightness:Number = 1;
      
      public function PopupTweener(param1:Container)
      {
         super();
         this._targ = param1;
         this.setDimensions();
         this.fullSeq.children = [this.getParallelEffectPart(),this.getChildFade()];
         this.scrollPolicyHor = param1.horizontalScrollPolicy;
         this.scrollPolicyVert = param1.horizontalScrollPolicy;
      }
      
      private function setDimensions() : void
      {
         this.dimensionsTo = new Rectangle(this._targ.x,this._targ.y,this._targ.width,this._targ.height);
         var _loc1_:int = int(Math.round(this._targ.width * this.ANIM_WIDTH_DELTA));
         var _loc2_:int = int(Math.round(this._targ.height * this.ANIM_HEIGHT_DELTA));
         this.dimensionsFrom = new Rectangle(this.dimensionsTo.x + (this.dimensionsTo.width - _loc1_) / 2,this.dimensionsTo.y + (this.dimensionsTo.height - _loc2_) / 2 - this.Y_DISPLACEMENT,_loc1_,_loc2_);
      }
      
      private function addListener(param1:Function) : void
      {
         var onEffectEnd:Function = null;
         var onDone:Function = param1;
         onEffectEnd = function(param1:EffectEvent):void
         {
            var _loc2_:DisplayObject = null;
            fullSeq.removeEventListener(EffectEvent.EFFECT_END,onEffectEnd);
            if(onDone != null)
            {
               for each(_loc2_ in _targ.getChildren())
               {
                  _loc2_.alpha = 1;
               }
               onDone();
            }
         };
         this.fullSeq.addEventListener(EffectEvent.EFFECT_END,onEffectEnd);
      }
      
      private function toggleScrollPolicies(param1:Boolean) : void
      {
         if(param1)
         {
            this._targ.horizontalScrollPolicy = ScrollPolicy.OFF;
            this._targ.verticalScrollPolicy = ScrollPolicy.OFF;
         }
         else
         {
            this._targ.horizontalScrollPolicy = this.scrollPolicyHor;
            this._targ.verticalScrollPolicy = this.scrollPolicyVert;
         }
      }
      
      public function tweenHide(param1:Function = null) : void
      {
         this.toggleScrollPolicies(false);
         this.addListener(param1);
         this.fullSeq.play(null,true);
      }
      
      private function onValid(param1:Event) : void
      {
         this.created = true;
         this.showInternal();
         this._targ.removeEventListener(FlexEvent.UPDATE_COMPLETE,this.onValid);
      }
      
      public function tweenShow(param1:Function = null) : void
      {
         this.showDone = param1;
         this._targ.addEventListener(FlexEvent.UPDATE_COMPLETE,this.onValid);
      }
      
      private function showInternal() : void
      {
         var _loc1_:DisplayObject = null;
         this.setDimensions();
         for each(_loc1_ in this._targ.getChildren())
         {
            _loc1_.alpha = 0;
         }
         this._targ.alpha = 0;
         this.toggleScrollPolicies(true);
         this.addListener(this.showDone);
         this.fullSeq.play();
         this._targ.validateNow();
      }
      
      private function getChildFade() : Fade
      {
         var _loc1_:Fade = new Fade();
         _loc1_.easingFunction = Exponential.easeOut;
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.duration = 1;
         _loc1_.targets = this._targ.getChildren();
         return _loc1_;
      }
      
      private function getParallelEffectPart() : Parallel
      {
         var _loc1_:Parallel = new Parallel();
         _loc1_.duration = 300;
         var _loc2_:Fade = new Fade(this._targ);
         _loc2_.easingFunction = Exponential.easeOut;
         _loc2_.alphaFrom = 0;
         _loc2_.alphaTo = 1;
         var _loc3_:Resize = new Resize(this._targ);
         _loc3_.easingFunction = Back.easeOut;
         _loc3_.heightFrom = this.dimensionsFrom.height;
         _loc3_.widthFrom = this.dimensionsFrom.width;
         _loc3_.heightTo = this.dimensionsTo.height;
         _loc3_.widthTo = this.dimensionsTo.width;
         var _loc4_:Move = new Move(this._targ);
         _loc4_.easingFunction = Back.easeOut;
         _loc4_.xFrom = this.dimensionsFrom.x;
         _loc4_.yFrom = this.dimensionsFrom.y;
         _loc4_.yTo = this.dimensionsTo.y;
         _loc4_.xTo = this.dimensionsTo.x;
         var _loc5_:AnimateProperty = new AnimateProperty(this);
         _loc5_.fromValue = 0.2;
         _loc5_.toValue = 1;
         _loc5_.property = "brightness";
         _loc1_.children = [_loc2_,_loc3_,_loc4_,_loc5_];
         return _loc1_;
      }
      
      public function set brightness(param1:Number) : void
      {
         this._brightness = param1;
         var _loc2_:ColorTransform = new ColorTransform(param1,param1,param1);
         this._targ.transform.colorTransform = _loc2_;
         this._targ.invalidateDisplayList();
      }
      
      public function get brightness() : Number
      {
         return this._brightness;
      }
   }
}

