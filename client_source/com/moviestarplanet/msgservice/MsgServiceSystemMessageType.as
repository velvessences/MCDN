package com.moviestarplanet.msgservice
{
   public class MsgServiceSystemMessageType
   {
      
      public static const GROUP_CHAT_USER_ADDED:int = 0;
      
      public static const GROUP_CHAT_USER_LEFT:int = 1;
      
      public static const GROUP_CHAT_CONVERSATION_RENAMED:int = 2;
      
      public static const MSP_AUTOGRAPH:int = 100;
      
      public static const MSP_COMPETITION:int = 101;
      
      public static const MSP_WARNING:int = 102;
      
      public static const MSP_GAME_INVITE:int = 103;
      
      public static const MSP_GAME_GIFT:int = 104;
      
      public static const MSP_GAME_HELP:int = 105;
      
      public static const BP_HUG:int = 200;
      
      public static const RBP_XP_GIFT:int = 300;
      
      public static const CONTENT_SUB_TYPE_CONTEST_ARTBOOK:int = 0;
      
      public static const CONTENT_SUB_TYPE_CONTEST_LOOK:int = 1;
      
      public static const CONTENT_SUB_TYPE_CONTEST_MOVIE:int = 2;
      
      public static const CONTENT_SUB_TYPE_CONTEST_ROOM:int = 3;
      
      public function MsgServiceSystemMessageType()
      {
         super();
      }
   }
}

