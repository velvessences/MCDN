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
   import mx.containers.Canvas;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.effects.Glow;
   import mx.events.EffectEvent;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class MSP_ClickCanvas extends Canvas
   {
      
      private var _207684226glowEffect:Glow;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "events":{
            "rollOver":"___MSP_ClickCanvas_Canvas1_rollOver",
            "rollOut":"___MSP_ClickCanvas_Canvas1_rollOut",
            "creationComplete":"___MSP_ClickCanvas_Canvas1_creationComplete"
         }
      });
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var originalAlpha:Number = -1;
      
      public var CanvasBackGroundColor:String = "0x444444";
      
      public var CanvasBackGroundAlpha:Number = 0.5;
      
      public var highlightEnabled:Boolean = true;
      
      private var isFirstRollOver:Boolean = true;
      
      private var isInRollOver:Boolean;
      
      private var restorefiltersNotCopied:Boolean = true;
      
      private var restorefilters:Array = null;
      
      public function MSP_ClickCanvas()
      {
         super();
         mx_internal::_document = this;
         this._MSP_ClickCanvas_Glow1_i();
         this.addEventListener("rollOver",this.___MSP_ClickCanvas_Canvas1_rollOver);
         this.addEventListener("rollOut",this.___MSP_ClickCanvas_Canvas1_rollOut);
         this.addEventListener("creationComplete",this.___MSP_ClickCanvas_Canvas1_creationComplete);
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
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function onCreationComplete() : void
      {
         this.originalAlpha = alpha;
         this.SetEnabledState();
         setStyle("backgroundColor",this.CanvasBackGroundColor);
         setStyle("backgroundAlpha",this.CanvasBackGroundAlpha);
         mouseEnabled = enabled;
         cacheAsBitmap = true;
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
      
      private function onRollOver() : void
      {
         if(enabled)
         {
            if(this.isFirstRollOver)
            {
               this.restorefilters = this.CloneFilters(filters);
               this.isFirstRollOver = false;
            }
            if(this.highlightEnabled == true)
            {
               this.glowEffect.play([this]);
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
      
      private function onRollOut(param1:MouseEvent) : void
      {
         if(this.isInRollOver)
         {
            if(this.highlightEnabled == true)
            {
               this.glowEffect.play([this],true);
            }
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
      
      private function _MSP_ClickCanvas_Glow1_i() : Glow
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
      
      public function ___MSP_ClickCanvas_Canvas1_rollOver(param1:MouseEvent) : void
      {
         this.onRollOver();
      }
      
      public function ___MSP_ClickCanvas_Canvas1_rollOut(param1:MouseEvent) : void
      {
         this.onRollOut(param1);
      }
      
      public function ___MSP_ClickCanvas_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
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

