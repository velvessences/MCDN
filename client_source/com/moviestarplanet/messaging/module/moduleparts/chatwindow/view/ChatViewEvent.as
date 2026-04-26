package com.moviestarplanet.messaging.module.moduleparts.chatwindow.view
{
   import com.moviestarplanet.events.MsgEvent;
   
   public class ChatViewEvent extends MsgEvent
   {
      
      public static const MESSAGE_READ:String = "MESSAGE_READ";
      
      public static const CLOSE:String = "ChatViewEvent.CLOSE";
      
      public function ChatViewEvent(param1:String, param2:* = null, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

