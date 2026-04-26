package com.moviestarplanet.frame
{
   import com.moviestarplanet.utils.displayobject.DisplayObjectUtilities;
   import com.moviestarplanet.utils.ui.ImageTweenUtils;
   import flash.events.MouseEvent;
   import mx.containers.VBox;
   import mx.effects.Effect;
   import mx.events.EffectEvent;
   
   public class GlowableVBox extends VBox
   {
      
      public static const EFFECT_PLAYS:int = 5;
      
      private var glowChildren:Array;
      
      private var tween:Effect = ImageTweenUtils.getGlowAnim();
      
      public function GlowableVBox()
      {
         super();
         this.useHandCursor = this.buttonMode = true;
         this.mouseChildren = false;
         this.setStyle("backgroundColor",16777215);
         this.setStyle("backgroundAlpha",0.01);
         this.setStyle("backgroundColor",16777215);
         this.setStyle("fontWeight","bold");
         this.setStyle("horizontalAlign","center");
         this.glowChildren = [this];
         DisplayObjectUtilities.buttonize(this,this.caller);
      }
      
      private function caller(param1:MouseEvent) : void
      {
      }
      
      public function setGlowChildren(param1:Array) : void
      {
         this.glowChildren = param1;
      }
      
      protected function applyMouseOverGlow() : void
      {
         this.addEventListener(MouseEvent.MOUSE_OVER,function(param1:MouseEvent):void
         {
            glow(true);
         });
         this.addEventListener(MouseEvent.MOUSE_OUT,function(param1:MouseEvent):void
         {
            glow(false);
         });
      }
      
      public function playEffect(param1:int = 5) : void
      {
         var playEffectInternal:Function = null;
         var effectPlays:int = param1;
         playEffectInternal = function(param1:EffectEvent = null):void
         {
            var onEnd:Function = null;
            var e:EffectEvent = param1;
            onEnd = function():void
            {
               tween.removeEventListener(EffectEvent.EFFECT_END,onEnd);
               glow(false);
               if(curEffectNum++ < effectPlays)
               {
                  tween.addEventListener(EffectEvent.EFFECT_END,playEffectInternal);
               }
            };
            tween.removeEventListener(EffectEvent.EFFECT_END,playEffectInternal);
            glow(true);
            tween.addEventListener(EffectEvent.EFFECT_END,onEnd);
         };
         var curEffectNum:int = 0;
         playEffectInternal();
      }
      
      private function glow(param1:Boolean) : void
      {
         this.tween.play(this.glowChildren,!param1);
         this.tween.stop();
         this.tween.play(this.glowChildren,param1);
      }
   }
}

