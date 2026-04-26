package com.moviestarplanet.utils.ui
{
   import com.greensock.TweenMax;
   import com.moviestarplanet.utils.continuum.TimerUtilities;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import mx.effects.Effect;
   import mx.effects.Glow;
   import mx.effects.Move;
   import mx.effects.Parallel;
   import mx.effects.Resize;
   import mx.effects.Sequence;
   import mx.effects.Tween;
   import mx.effects.easing.Back;
   import mx.events.EffectEvent;
   
   public class ImageTweenUtils
   {
      
      public function ImageTweenUtils()
      {
         super();
      }
      
      public static function scaleMovieClip(param1:MovieClip, param2:Rectangle, param3:Function) : void
      {
         var resizeW:Tween;
         var ease:Function = null;
         var movieClip:MovieClip = param1;
         var dimension:Rectangle = param2;
         var onDone:Function = param3;
         if(movieClip.width < dimension.width)
         {
            ease = Back.easeOut;
         }
         else
         {
            ease = Back.easeIn;
         }
         resizeW = new Tween(movieClip,[movieClip.width,movieClip.height,movieClip.x,movieClip.y],[dimension.width,dimension.height,dimension.x,dimension.y],300,-1,function(param1:Array):void
         {
            movieClip.width = param1[0];
            movieClip.height = param1[1];
            movieClip.x = param1[2];
            movieClip.y = param1[3];
         },onDone);
         resizeW.easingFunction = ease;
      }
      
      public static function glow(param1:DisplayObject, param2:int = 5, param3:Function = null) : void
      {
         var tween:Effect = null;
         var iPlay:Function = null;
         var runs:int = 0;
         var iEnd:Function = null;
         var target:DisplayObject = param1;
         var count:int = param2;
         var done:Function = param3;
         iPlay = function(param1:Boolean = false):void
         {
            tween.play([target],param1);
         };
         iEnd = function():void
         {
            if(runs < count * 2)
            {
               if(runs % 2 == 0)
               {
                  iPlay(true);
               }
               else
               {
                  TimerUtilities.timedEvent(1000,1,iPlay);
               }
               ++runs;
            }
            else
            {
               if(done != null)
               {
                  done();
               }
               tween.removeEventListener(EffectEvent.EFFECT_END,iEnd);
            }
         };
         tween = getGlowAnim();
         tween.addEventListener(EffectEvent.EFFECT_END,iEnd);
         runs = 0;
         iPlay();
      }
      
      public static function getScaleAnim(param1:Rectangle, param2:Number) : Parallel
      {
         var _loc3_:Parallel = new Parallel();
         var _loc4_:Resize = new Resize();
         _loc4_.widthFrom = param1.width;
         _loc4_.heightFrom = param1.height;
         _loc4_.heightTo = param1.height * param2;
         _loc4_.widthTo = param1.width * param2;
         var _loc5_:Move = new Move();
         _loc5_.xFrom = param1.x;
         _loc5_.yFrom = param1.y;
         _loc5_.yTo = param1.y + (param1.height - _loc4_.heightTo) / 2;
         _loc5_.xTo = param1.x + (param1.width - _loc4_.widthTo) / 2;
         if(param2 > 1)
         {
            _loc5_.easingFunction = Back.easeOut;
            _loc4_.easingFunction = Back.easeOut;
         }
         else
         {
            _loc5_.easingFunction = Back.easeIn;
            _loc4_.easingFunction = Back.easeIn;
         }
         _loc3_.duration = 300;
         _loc3_.children = [_loc5_,_loc4_];
         return _loc3_;
      }
      
      public static function removeGlow(param1:DisplayObject) : void
      {
         param1.removeEventListener(MouseEvent.ROLL_OVER,addGlowOver);
         param1.removeEventListener(MouseEvent.ROLL_OUT,addGlowOut);
         TweenMax.to(param1,0,{"glowFilter":{
            "color":16777215,
            "strength":2,
            "alpha":0,
            "blurX":20,
            "blurY":20,
            "remove":true
         }});
      }
      
      public static function addGlow(param1:DisplayObject) : void
      {
         param1.addEventListener(MouseEvent.ROLL_OVER,addGlowOver,false,0,true);
         param1.addEventListener(MouseEvent.ROLL_OUT,addGlowOut,false,0,true);
      }
      
      public static function addGlowOver(param1:MouseEvent) : void
      {
         TweenMax.to(param1.currentTarget,0.1,{"glowFilter":{
            "color":16777215,
            "strength":2,
            "alpha":1,
            "blurX":20,
            "blurY":20
         }});
      }
      
      public static function addGlowOut(param1:MouseEvent) : void
      {
         TweenMax.to(param1.currentTarget,0.1,{"glowFilter":{
            "color":16777215,
            "strength":2,
            "alpha":0,
            "blurX":20,
            "blurY":20,
            "remove":true
         }});
      }
      
      public static function addGlowPulsating(param1:DisplayObject, param2:uint = 13434828) : void
      {
         var _loc3_:Sequence = new Sequence();
         _loc3_.addChild(getGlowIn(param2));
         _loc3_.addChild(getGlowOut(param2));
         _loc3_.repeatCount = 0;
         _loc3_.play([param1]);
      }
      
      public static function addGlowTween(param1:DisplayObject) : void
      {
         param1.addEventListener(MouseEvent.MOUSE_OVER,addGlowOver,false,0,true);
         param1.addEventListener(MouseEvent.MOUSE_OUT,addGlowOut,false,0,true);
      }
      
      private static function getGlowIn(param1:uint = 13434828) : Glow
      {
         var _loc2_:Glow = new Glow();
         _loc2_.duration = 800;
         _loc2_.alphaFrom = 1;
         _loc2_.alphaTo = 0;
         _loc2_.blurXFrom = 10;
         _loc2_.blurXTo = 30;
         _loc2_.blurYFrom = 10;
         _loc2_.blurYTo = 30;
         _loc2_.strength = 2;
         _loc2_.color = param1;
         return _loc2_;
      }
      
      private static function getGlowOut(param1:uint = 13434828) : Glow
      {
         var _loc2_:Glow = new Glow();
         _loc2_.duration = 1500;
         _loc2_.alphaFrom = 0;
         _loc2_.alphaTo = 1;
         _loc2_.blurXFrom = 30;
         _loc2_.blurXTo = 10;
         _loc2_.blurYFrom = 30;
         _loc2_.blurYTo = 10;
         _loc2_.strength = 2;
         _loc2_.color = param1;
         return _loc2_;
      }
      
      public static function getGlowAnim(param1:uint = 16777215) : Effect
      {
         var _loc2_:Glow = new Glow();
         _loc2_.color = param1;
         _loc2_.duration = 400;
         _loc2_.strength = 2;
         _loc2_.blurXFrom = 20;
         _loc2_.blurYFrom = 20;
         _loc2_.blurYTo = 30;
         _loc2_.blurXTo = 30;
         return _loc2_;
      }
      
      public static function glowColor(param1:DisplayObject, param2:int = 5, param3:uint = 16777215, param4:Function = null) : void
      {
         var tween:Effect = null;
         var iPlay:Function = null;
         var runs:int = 0;
         var iEnd:Function = null;
         var target:DisplayObject = param1;
         var count:int = param2;
         var color:uint = param3;
         var done:Function = param4;
         iPlay = function(param1:Boolean = false):void
         {
            tween.play([target],param1);
         };
         iEnd = function():void
         {
            if(runs < count * 2)
            {
               if(runs % 2 == 0)
               {
                  iPlay(true);
               }
               else
               {
                  TimerUtilities.timedEvent(1000,1,iPlay);
               }
               ++runs;
            }
            else
            {
               if(done != null)
               {
                  done();
               }
               tween.removeEventListener(EffectEvent.EFFECT_END,iEnd);
            }
         };
         tween = getGlowAnim(color);
         tween.addEventListener(EffectEvent.EFFECT_END,iEnd);
         runs = 0;
         iPlay();
      }
   }
}

