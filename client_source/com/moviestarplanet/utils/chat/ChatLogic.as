package com.moviestarplanet.utils.chat
{
   import com.moviestarplanet.chat.ChatRoomType;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.configurations.SiteConfig;
   import com.moviestarplanet.earningutils.service.FameSwitch;
   
   public class ChatLogic
   {
      
      public function ChatLogic()
      {
         super();
      }
      
      public static function getAppInstNameForRoomType(param1:String) : String
      {
         var _loc2_:SiteConfig = Config.getCurrentSiteConfig();
         var _loc3_:String = "local";
         if(_loc2_ != null)
         {
            _loc3_ = Config.getCurrentSiteConfig().country;
         }
         return _loc3_ + "_" + Config.GetLanguage + "_" + param1;
      }
      
      public static function GetRequiredLevelForChatRoom(param1:String) : Number
      {
         if(param1 != null && ChatRoomType.MALL == ChatRoomType.getChatType(param1))
         {
            if(FameSwitch.IsFameOverhaulSwitchOn)
            {
               return 8;
            }
            return 5;
         }
         return 0;
      }
      
      public static function GetVipRequiredForChatRoom(param1:String) : Boolean
      {
         return ChatRoomType.getChatType(param1) == ChatRoomType.CLUB;
      }
      
      public static function GetItemRequiredForChatRoom(param1:String) : Boolean
      {
         return ChatRoomType.getChatType(param1) == ChatRoomType.THEMEROOM;
      }
      
      public static function extractData(param1:String) : Array
      {
         return param1.split(":");
      }
   }
}

