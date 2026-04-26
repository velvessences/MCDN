package com.moviestarplanet.Components
{
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import mx.binding.*;
   import mx.core.IFlexModuleFactory;
   import mx.effects.Glow;
   import mx.events.EffectEvent;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class MSP_ClickImage extends MSP_Image
   {
      
      private var _207684226glowEffect:Glow;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var originalAlpha:Number = -1;
      
      public var alwaysGlow:Boolean = false;
      
      public var isRectangularHitbox:Boolean = false;
      
      private var isFirstRollOver:Boolean = true;
      
      private var isInRollOver:Boolean;
      
      private var restorefiltersNotCopied:Boolean = true;
      
      private var restorefilters:Array = null;
      
      public function MSP_ClickImage()
      {
         super();
         this.buttonMode = true;
         this._MSP_ClickImage_Glow1_i();
         this.addEventListener("creationComplete",this.___MSP_ClickImage_MSP_Image1_creationComplete);
         this.addEventListener("rollOut",this.___MSP_ClickImage_MSP_Image1_rollOut);
         this.addEventListener("rollOver",this.___MSP_ClickImage_MSP_Image1_rollOver);
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
      }
      
      override public function initialize() : void
      {
         super.initialize();
      }
      
      private function onCreationComplete() : void
      {
         this.originalAlpha = alpha;
         this.SetEnabledState();
         mouseEnabled = enabled;
         cacheAsBitmap = true;
         if(this.alwaysGlow)
         {
            this.onRollOver();
         }
         if(this.isRectangularHitbox)
         {
            this.graphics.beginFill(16711680,0);
            this.graphics.drawRect(0,0,this.width,this.height);
            this.graphics.endFill();
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 != enabled)
         {
            mouseEnabled = param1;
            super.enabled = param1;
            this.SetEnabledState();
         }
      }
      
      private function SetEnabledState() : void
      {
         if(initialized)
         {
            if(enabled && this.originalAlpha != -1)
            {
               alpha = this.originalAlpha;
            }
            else
            {
               this.originalAlpha = alpha;
               alpha *= 0.35;
            }
         }
      }
      
      public function onRollOver() : void
      {
         if(enabled)
         {
            if(this.isFirstRollOver)
            {
               this.restorefilters = this.CloneFilters(filters);
               this.isFirstRollOver = false;
            }
            this.isInRollOver = true;
         }
      }
      
      private function CloneFilters(param1:Array) : Array
      {
         var _loc2_:Array = new Array(param1.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc2_[_loc3_] = BitmapFilter(param1[_loc3_]).clone();
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function onRollOut(param1:MouseEvent) : void
      {
         if(this.alwaysGlow)
         {
            return;
         }
         if(this.isInRollOver)
         {
            this.isInRollOver = false;
         }
      }
      
      private function effectEnd() : void
      {
         if(!this.isInRollOver)
         {
            filters = this.CloneFilters(this.restorefilters);
         }
      }
      
      private function _MSP_ClickImage_Glow1_i() : Glow
      {
         var _loc1_:Glow = new Glow();
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.blurXTo = 8;
         _loc1_.blurYTo = 8;
         _loc1_.color = 16777215;
         _loc1_.duration = 1;
         _loc1_.addEventListener("effectEnd",this.__glowEffect_effectEnd);
         this.glowEffect = _loc1_;
         BindingManager.executeBindings(this,"glowEffect",this.glowEffect);
         return _loc1_;
      }
      
      public function __glowEffect_effectEnd(param1:EffectEvent) : void
      {
         this.effectEnd();
      }
      
      public function ___MSP_ClickImage_MSP_Image1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      public function ___MSP_ClickImage_MSP_Image1_rollOut(param1:MouseEvent) : void
      {
         this.onRollOut(param1);
      }
      
      public function ___MSP_ClickImage_MSP_Image1_rollOver(param1:MouseEvent) : void
      {
         this.onRollOver();
      }
      
      [Bindable(event="propertyChange")]
      public function get glowEffect() : Glow
      {
         return this._207684226glowEffect;
      }
      
      public function set glowEffect(param1:Glow) : void
      {
         var _loc2_:Object = this._207684226glowEffect;
         if(_loc2_ !== param1)
         {
            this._207684226glowEffect = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"glowEffect",_loc2_,param1));
            }
         }
      }
   }
}

