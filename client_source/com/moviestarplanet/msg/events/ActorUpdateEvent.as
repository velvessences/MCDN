package com.moviestarplanet.msg.events
{
   import com.moviestarplanet.events.MsgEvent;
   
   public class ActorUpdateEvent extends MsgEvent
   {
      
      public static const UPDATE:String = "ActorUpdateEvent";
      
      public function ActorUpdateEvent(param1:String, param2:* = null, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

