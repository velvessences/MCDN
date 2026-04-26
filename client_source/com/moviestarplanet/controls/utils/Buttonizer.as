package com.moviestarplanet.controls.utils
{
   import com.moviestarplanet.managers.SoundManager;
   import com.moviestarplanet.utils.color.ColorFilterUtilities;
   import com.moviestarplanet.utils.sound.Sounds;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.FrameLabel;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class Buttonizer
   {
      
      private static const FRAME_NORMAL:String = "normal";
      
      private static const FRAME_HOVER:String = "hover";
      
      private static const FRAME_DOWN:String = "down";
      
      public static const FRAME_STATE_DOWN:uint = 1 << 0;
      
      public static const FRAME_STATE_UP:uint = 1 << 1;
      
      public static const FRAME_STATE_OVER:uint = 1 << 2;
      
      public static const FRAME_STATE_OUT:uint = 1 << 3;
      
      private static var soundObjectToScheme:Dictionary = new Dictionary(true);
      
      private static var mcToFrameStates:Dictionary = new Dictionary(true);
      
      public function Buttonizer()
      {
         super();
      }
      
      public static function buttonize(param1:DisplayObject, param2:Function, param3:Boolean = true, param4:Boolean = true, param5:String = null, param6:int = 1) : void
      {
         if(param1 == null)
         {
            return;
         }
         addCursorSettings(param1);
         param1.addEventListener(MouseEvent.CLICK,param2,false,param6,param4);
         addSoundInternal(param1,param5);
      }
      
      public static function unButtonize(param1:DisplayObject, param2:Function) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(MouseEvent.CLICK,param2);
         removeCursorSettings(param1);
         removeSoundInternal(param1);
      }
      
      public static function removeCursorSettings(param1:DisplayObject) : void
      {
         var _loc2_:Sprite = null;
         if(param1 is Sprite)
         {
            _loc2_ = param1 as Sprite;
            _loc2_.useHandCursor = false;
            _loc2_.buttonMode = false;
         }
      }
      
      public static function addSoundInternal(param1:DisplayObject, param2:String) : void
      {
         if(param2 == null)
         {
            addClickSound(param1,Sounds.BUTTON_CLICK);
         }
         else
         {
            addClickSound(param1,param2);
         }
      }
      
      public static function removeSoundInternal(param1:DisplayObject) : void
      {
         delete soundObjectToScheme[param1];
         param1.removeEventListener(MouseEvent.CLICK,clickHandler);
         param1.removeEventListener(MouseEvent.ROLL_OVER,hoverHandler);
      }
      
      public static function addClickSound(param1:IEventDispatcher, param2:String = null) : void
      {
         if(param2)
         {
            soundObjectToScheme[param1] = param2;
            param1.addEventListener(MouseEvent.CLICK,clickHandler,false,2);
         }
      }
      
      private static function clickHandler(param1:MouseEvent) : void
      {
         SoundManager.Instance().playSoundEffect(soundObjectToScheme[param1.currentTarget]);
      }
      
      public static function addHoverSound(param1:Object) : void
      {
         param1.addEventListener(MouseEvent.ROLL_OVER,hoverHandler);
      }
      
      public static function hoverHandler(param1:MouseEvent) : void
      {
         SoundManager.Instance().playSoundEffect(Sounds.BUTTON_HOVER);
      }
      
      public static function addCursorSettings(param1:DisplayObject) : void
      {
         var _loc2_:Sprite = null;
         if(param1 is Sprite)
         {
            _loc2_ = param1 as Sprite;
            _loc2_.useHandCursor = true;
            _loc2_.buttonMode = true;
            _loc2_.mouseChildren = false;
         }
      }
      
      public static function buttonizeFramesStates(param1:MovieClip, param2:Function, param3:Boolean = true, param4:String = null, param5:uint = 4369) : void
      {
         addCursorSettings(param1);
         param1.addEventListener(MouseEvent.CLICK,param2,false,0,param3);
         addFrameStates(param1,param5,param3);
         addSoundInternal(param1,param4);
      }
      
      public static function addFrameStates(param1:MovieClip, param2:uint = 15, param3:Boolean = true) : void
      {
         param1.stop();
         handleFrameStatesfor(param1);
         if(isSet(param2,FRAME_STATE_DOWN))
         {
            param1.addEventListener(MouseEvent.MOUSE_DOWN,frameDownHandler,false,0,param3);
         }
         if(isSet(param2,FRAME_STATE_UP))
         {
            param1.addEventListener(MouseEvent.MOUSE_UP,frameNormalHandler,false,0,param3);
         }
         if(isSet(param2,FRAME_STATE_OVER))
         {
            param1.addEventListener(MouseEvent.MOUSE_OVER,frameHoverHandler,false,0,param3);
         }
         if(isSet(param2,FRAME_STATE_OUT))
         {
            param1.addEventListener(MouseEvent.MOUSE_OUT,frameNormalHandler,false,0,param3);
         }
      }
      
      private static function handleFrameStatesfor(param1:MovieClip) : void
      {
         var _loc2_:FrameLabel = null;
         mcToFrameStates[param1] = 0;
         for each(_loc2_ in param1.currentLabels)
         {
            if(_loc2_.name == FRAME_NORMAL)
            {
               mcToFrameStates[param1] |= FRAME_STATE_UP;
            }
            else if(_loc2_.name == FRAME_DOWN)
            {
               mcToFrameStates[param1] |= FRAME_STATE_DOWN;
            }
            else if(_loc2_.name == FRAME_HOVER)
            {
               mcToFrameStates[param1] |= FRAME_STATE_OVER;
            }
         }
      }
      
      public static function isSet(param1:uint, param2:uint) : Boolean
      {
         return param2 == (param1 & param2);
      }
      
      public static function buttonizeFrames(param1:MovieClip, param2:Function, param3:Boolean = true, param4:String = null) : void
      {
         buttonizeFramesStates(param1,param2,param3,param4,15);
      }
      
      public static function unbuttonizeFrames(param1:MovieClip, param2:Function) : void
      {
         removeCursorSettings(param1);
         param1.removeEventListener(MouseEvent.CLICK,param2,false);
         removeFrameStates(param1);
         removeSoundInternal(param1);
      }
      
      public static function removeFrameStates(param1:MovieClip) : void
      {
         delete mcToFrameStates[param1];
         param1.removeEventListener(MouseEvent.MOUSE_DOWN,frameDownHandler);
         param1.removeEventListener(MouseEvent.MOUSE_UP,frameHoverHandler);
         param1.removeEventListener(MouseEvent.MOUSE_OVER,frameHoverHandler);
         param1.removeEventListener(MouseEvent.MOUSE_OUT,frameNormalHandler);
      }
      
      private static function frameDownHandler(param1:MouseEvent) : void
      {
         if((FRAME_STATE_DOWN & mcToFrameStates[param1.currentTarget]) == FRAME_STATE_DOWN)
         {
            handleFrame(param1.currentTarget,FRAME_DOWN);
         }
      }
      
      private static function frameHoverHandler(param1:MouseEvent) : void
      {
         if(isSet(mcToFrameStates[param1.currentTarget],FRAME_STATE_OVER))
         {
            handleFrame(param1.currentTarget,FRAME_HOVER);
         }
      }
      
      private static function frameNormalHandler(param1:MouseEvent) : void
      {
         if((FRAME_STATE_UP & mcToFrameStates[param1.currentTarget]) == FRAME_STATE_UP)
         {
            handleFrame(param1.currentTarget,FRAME_NORMAL);
         }
      }
      
      private static function handleFrame(param1:Object, param2:String) : void
      {
         var currentTarget:Object = param1;
         var frame:String = param2;
         try
         {
            currentTarget.gotoAndStop(frame);
         }
         catch(error:ArgumentError)
         {
            trace("Warning: frame " + frame + " does not exist on " + currentTarget);
         }
      }
      
      public static function setButtonizedEnabled(param1:DisplayObject, param2:Boolean, param3:Boolean = false, param4:Function = null) : void
      {
         var _loc5_:InteractiveObject = null;
         var _loc6_:DisplayObjectContainer = null;
         if(param1 is InteractiveObject)
         {
            _loc5_ = param1 as InteractiveObject;
            _loc5_.mouseEnabled = param2;
         }
         if(param3 && param1 is DisplayObjectContainer)
         {
            _loc6_ = param1 as DisplayObjectContainer;
            _loc6_.mouseChildren = param2;
         }
         if(param4 == null)
         {
            dim(param1,param2);
         }
         else
         {
            param4(param1,param2);
         }
      }
      
      public static function dim(param1:DisplayObject, param2:Boolean) : void
      {
         if(param2)
         {
            param1.filters = [];
         }
         else
         {
            ColorFilterUtilities.setColorMatrix(param1,-20,-20,-50);
         }
      }
      
      public static function dimMore(param1:DisplayObject, param2:Boolean) : void
      {
         if(param2)
         {
            param1.filters = [];
         }
         else
         {
            ColorFilterUtilities.setColorMatrix(param1,-30,-30,-60);
         }
      }
   }
}

