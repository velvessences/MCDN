package com.moviestarplanet.msg
{
   import com.moviestarplanet.events.MsgEvent;
   
   public class AreaEvent extends MsgEvent
   {
      
      public static const ANY:String = "ANY";
      
      public static const SHOPPING_CLOTHES:String = "SHOPPING_CLOTHES";
      
      public static const SHOPPING_ITEMS:String = "SHOPPING_ITEMS";
      
      public static const DRESSING_ROOM:String = "DRESSING_ROOM";
      
      public static const LOOKS:String = "LOOKS";
      
      public static const YOUTUBE_OVERVIEW:String = "YOUTUBE_OVERVIEW";
      
      public static const GAME_THE_ARCADE:String = "GAME_THE_ARCADE";
      
      public static const MY_PROFILE:String = "MY_PROFILE";
      
      public static const FRIEND_PROFILE:String = "MY_PROFILE";
      
      public static const MY_ROOM:String = "MY_ROOM";
      
      public static const SHOPPING_ANIMATIONS:String = "SHOPPING_ANIMATIONS";
      
      public static const WORLD_CHAT:String = "WORLD_CHAT";
      
      public static const WORLD_GAME:String = "WORLD_GAME";
      
      public static const WORLD_CREATIVE:String = "WORLD_CREATIVE";
      
      public static const WORLD_SHOPPING:String = "WORLD_SHOPPING";
      
      public static const WORLD_AREA_SHOWN:String = "WORLD_AREA_SHOWN";
      
      public function AreaEvent(param1:String, param2:* = null)
      {
         super(param1,param2);
      }
   }
}

