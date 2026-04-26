package com.moviestarplanet.utils.sound
{
   import com.moviestarplanet.events.MsgEvent;
   
   public class SoundManagerEvent extends MsgEvent
   {
      
      public static const MUTE_CHANGED:String = "MUTE_CHANGED";
      
      public function SoundManagerEvent(param1:String, param2:* = null, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

