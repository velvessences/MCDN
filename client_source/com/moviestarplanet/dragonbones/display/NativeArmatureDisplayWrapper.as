package com.moviestarplanet.dragonbones.display
{
   import dragonBones.Armature;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   
   public class NativeArmatureDisplayWrapper extends MovieClip implements IArmatureDisplayWrapper
   {
      
      private var display:DisplayObject;
      
      public function NativeArmatureDisplayWrapper()
      {
         super();
      }
      
      public function set armature(param1:Armature) : void
      {
         if(param1 != null && param1.display is DisplayObject && param1.display != this.display)
         {
            if(this.display != null && Boolean(contains(this.display)))
            {
               removeChild(this.display);
            }
            display = param1.display as DisplayObject;
            addChild(display);
         }
         else if(param1 == null)
         {
            if(this.display != null && Boolean(contains(this.display)))
            {
               removeChild(this.display);
            }
            display = null;
         }
      }
   }
}

