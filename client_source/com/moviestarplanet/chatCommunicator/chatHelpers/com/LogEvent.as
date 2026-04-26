package com.moviestarplanet.chatCommunicator.chatHelpers.com
{
   import com.moviestarplanet.events.MsgEvent;
   
   public class LogEvent extends MsgEvent
   {
      
      public static const FATAL:String = "FATAL";
      
      public static const ERROR:String = "ERROR";
      
      public static const WARNING:String = "WARNING";
      
      public static const INFO:String = "INFO";
      
      public static const ASSET_CANNOT_BE_LOADED:String = "ASSET_CANNOT_BE_LOADED";
      
      private var level:String;
      
      private var errorType:String;
      
      public function LogEvent(param1:String, param2:String, param3:* = null, param4:Boolean = false)
      {
         super(MSPEvent.LOGGLY_EVENT,param3,param4);
         this.level = param1;
         this.errorType = param2;
      }
      
      public function getLevel() : String
      {
         return this.level;
      }
      
      public function getErrorType() : String
      {
         return this.errorType;
      }
   }
}

