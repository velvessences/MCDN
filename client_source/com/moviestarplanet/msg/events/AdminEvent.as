package com.moviestarplanet.msg.events
{
   import com.moviestarplanet.events.MsgEvent;
   
   public class AdminEvent extends MsgEvent
   {
      
      public static const REPORT_ENTITY:String = "AdminEvent.REPORT_ENTITY";
      
      public static const AUTO_WARNING:String = "AdminEvent.AUTO_WARNING";
      
      public function AdminEvent(param1:String, param2:* = null, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

