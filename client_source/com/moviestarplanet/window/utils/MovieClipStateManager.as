package com.moviestarplanet.window.utils
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class MovieClipStateManager
   {
      
      private var states:Dictionary;
      
      private var rootObject:DisplayObject;
      
      private var shouldForceStart:Boolean;
      
      public function MovieClipStateManager(param1:DisplayObject, param2:Boolean = false)
      {
         super();
         this.states = new Dictionary(true);
         this.rootObject = param1;
         this.shouldForceStart = param2;
      }
      
      public function stop() : void
      {
         var invoker:Function = null;
         invoker = function(param1:MovieClip):void
         {
            if(shouldForceStart)
            {
               param1.play();
            }
            states[param1] = {
               "frame":param1.currentFrame,
               "isplaying":param1.isPlaying
            };
            param1.stop();
         };
         this.traverseMCs(this.rootObject as DisplayObjectContainer,invoker);
      }
      
      private function traverseMCs(param1:DisplayObjectContainer, param2:Function) : void
      {
         var i:int;
         var disp:DisplayObjectContainer = param1;
         var invokeFunc:Function = param2;
         if(getQualifiedClassName(disp) == "com.moviestarplanet.body::Body")
         {
            return;
         }
         if(disp is MovieClip)
         {
            invokeFunc(disp as MovieClip);
         }
         i = 0;
         while(i < disp.numChildren)
         {
            try
            {
               if(disp.getChildAt(i) is DisplayObjectContainer)
               {
                  this.traverseMCs(disp.getChildAt(i) as DisplayObjectContainer,invokeFunc);
               }
            }
            catch(err:Error)
            {
               trace(err);
            }
            i++;
         }
      }
      
      public function reset() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         for(_loc1_ in this.states)
         {
            _loc2_ = this.states[_loc1_];
            if(_loc2_.isplaying == true)
            {
               _loc1_.play();
            }
            delete this.states[_loc1_];
         }
      }
      
      public function restart() : void
      {
         var invoker:Function = null;
         invoker = function(param1:MovieClip):void
         {
            param1.gotoAndPlay(0);
         };
         this.traverseMCs(this.rootObject as DisplayObjectContainer,invoker);
      }
   }
}

