package com.moviestarplanet.events
{
   public class ComChannelEvent extends MsgEvent
   {
      
      public static const COMCONNECTION_SUCCESS:String = "COMCONNECTION_SUCCESS";
      
      public static const COMCONNECTION_RECONNECTING:String = "COMCONNECTION_RECONNECTING";
      
      public static const COMCONNECTION_DISCONNECTED:String = "COMCONNECTION_DISCONNECTED";
      
      public static const COMCHANNEL_INITIALIZED:String = "COMCHANNEL_INITIALIZED";
      
      public function ComChannelEvent(param1:String, param2:* = null, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

