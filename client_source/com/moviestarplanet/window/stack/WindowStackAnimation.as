package com.moviestarplanet.window.stack
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import mx.containers.Canvas;
   import mx.core.Container;
   import mx.core.IContainer;
   import mx.core.UIComponent;
   import mx.effects.Fade;
   import mx.effects.Pause;
   import mx.effects.Resize;
   import mx.effects.Sequence;
   import mx.effects.easing.Circular;
   import mx.effects.easing.Exponential;
   import mx.events.EffectEvent;
   import mx.events.FlexEvent;
   
   public class WindowStackAnimation
   {
      
      private static const HORIZONTAL_EXPAND_TIME:int = 300;
      
      private static const VERTICAL_EXPAND_TIME:int = 50;
      
      private static const CONTRACT_TIME:int = 100;
      
      private static const FADE_OUT_TIME:int = 1000;
      
      private static const START_HEIGHT:int = 10;
      
      private static const START_WIDTH:int = 0;
      
      private var openingEffect:Sequence;
      
      private var shutdownEffect:Sequence;
      
      private var expandWidth:Resize;
      
      private var expandHeight:Resize;
      
      private var contractWidth:Resize;
      
      private var contractHeight:Resize;
      
      private var removingComponent:DisplayObject;
      
      private var addingComponent:UIComponent;
      
      private var container:IContainer;
      
      private var openCallback:Function;
      
      private var closeCallback:Function;
      
      private var animatingWindow:Canvas;
      
      private var fadeOut:Fade;
      
      public function WindowStackAnimation()
      {
         super();
         this.animatingWindow = new Canvas();
         this.fadeOut = new Fade();
         this.fadeOut.alphaFrom = 1;
         this.fadeOut.alphaTo = 0;
         this.fadeOut.duration = FADE_OUT_TIME;
         this.fadeOut.easingFunction = Exponential.easeInOut;
         this.fadeOut.addEventListener(EffectEvent.EFFECT_END,this.fadeComplete);
         this.openingEffect = new Sequence();
         var _loc1_:Pause = new Pause();
         _loc1_.duration = 400;
         this.expandWidth = new Resize();
         this.expandWidth.widthFrom = START_WIDTH;
         this.expandWidth.duration = HORIZONTAL_EXPAND_TIME;
         this.expandWidth.easingFunction = Circular.easeOut;
         var _loc2_:Pause = new Pause();
         _loc2_.duration = 300;
         this.expandHeight = new Resize();
         this.expandHeight.heightFrom = START_HEIGHT;
         this.expandHeight.duration = VERTICAL_EXPAND_TIME;
         this.expandHeight.easingFunction = Circular.easeInOut;
         this.openingEffect.addChild(_loc1_);
         this.openingEffect.addChild(this.expandWidth);
         this.openingEffect.addChild(_loc2_);
         this.openingEffect.addChild(this.expandHeight);
         this.openingEffect.addEventListener(EffectEvent.EFFECT_END,this.startFade);
         this.shutdownEffect = new Sequence();
         var _loc3_:Pause = new Pause();
         _loc3_.duration = 400;
         this.contractHeight = new Resize();
         this.contractHeight.heightTo = 1;
         this.contractHeight.duration = CONTRACT_TIME;
         this.contractHeight.easingFunction = Circular.easeInOut;
         var _loc4_:Pause = new Pause();
         _loc4_.duration = 300;
         this.contractWidth = new Resize();
         this.contractWidth.widthTo = 0;
         this.contractWidth.duration = CONTRACT_TIME;
         this.contractWidth.easingFunction = Circular.easeOut;
         this.shutdownEffect.addChild(_loc3_);
         this.shutdownEffect.addChild(this.contractHeight);
         this.shutdownEffect.addChild(_loc4_);
         this.shutdownEffect.addChild(this.contractWidth);
         this.shutdownEffect.addEventListener(EffectEvent.EFFECT_END,this.removeComponent);
      }
      
      public function setContainer(param1:IContainer) : void
      {
         this.container = param1;
      }
      
      public function open(param1:DisplayObject, param2:int, param3:int, param4:Function = null) : void
      {
         var iComplete:Function = null;
         var container:Container = null;
         var component:DisplayObject = param1;
         var x:int = param2;
         var y:int = param3;
         var done:Function = param4;
         iComplete = function(param1:Event):void
         {
            component.x = x;
            component.y = y;
            component.alpha = 1;
            if(done != null)
            {
               done.apply(this);
            }
         };
         component.alpha = 0;
         this.container.addChild(component);
         if(component is Container)
         {
            container = component as Container;
            if(container.initialized == false)
            {
               container.addEventListener(FlexEvent.CREATION_COMPLETE,iComplete);
            }
            else
            {
               iComplete(null);
            }
         }
         else
         {
            iComplete(null);
         }
      }
      
      public function close(param1:DisplayObject, param2:Function = null) : void
      {
         this.closeCallback = param2;
         this.removingComponent = param1;
         this.contractWidth.widthFrom = param1.width;
         this.contractHeight.heightFrom = param1.height;
         this.shutdownEffect.play([param1]);
      }
      
      private function removeComponent(param1:Event = null) : void
      {
         if(this.container.contains(this.removingComponent) == true)
         {
            this.container.removeChild(this.removingComponent);
            if(this.closeCallback != null)
            {
               this.closeCallback();
            }
         }
      }
      
      private function startFade(param1:Event) : void
      {
         this.addingComponent.alpha = 1;
         this.fadeOut.play([this.animatingWindow]);
      }
      
      private function fadeComplete(param1:Event) : void
      {
         this.container.removeChild(this.animatingWindow);
         if(this.openCallback != null)
         {
            this.openCallback();
         }
      }
   }
}

