package com.moviestarplanet.clientcensor
{
   import com.moviestarplanet.events.MsgEvent;
   
   public class NannyEvent extends MsgEvent
   {
      
      public static const NEED_SHOW_MUTE_POPUP:String = "NEED_SHOW_MUTE_POPUP";
      
      public function NannyEvent(param1:String, param2:* = null, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

