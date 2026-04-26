package com.moviestarplanet.Components.pushcontent.utils
{
   import com.moviestarplanet.events.MsgEvent;
   
   public class FriendDisplayerEvent extends MsgEvent
   {
      
      public static const CLOSE_FRIENDDISPLAYER_YOUTUBE:String = "CLOSE_FRIENDDISPLAYER_YOUTUBE";
      
      public static const CLOSE_FRIENDDISPLAYER_MOVIE:String = "CLOSE_FRIENDDISPLAYER_MOVIE";
      
      public static const CLOSE_FRIENDDISPLAYER_SCRAPBLOG:String = "CLOSE_FRIENDDISPLAYER_SCRAPBLOG";
      
      public static const CLOSE_FRIENDDISPLAYER_LOOK:String = "CLOSE_FRIENDDISPLAYER_LOOK";
      
      public static const CLOSE_FRIENDDISPLAYER_CLUB:String = "CLOSE_FRIENDDISPLAYER_CLUB";
      
      public static const CLOSE_FRIENDDISPLAYER_EMBEDDEDGAMES:String = "CLOSE_FRIENDDISPLAYER_EMBEDDEDGAMES";
      
      public static const CLOSE_FRIENDDISPLAYER_FORUM:String = "CLOSE_FRIENDDISPLAYER_FORUM";
      
      public static const CLOSE_FRIENDDISPLAYER_SOCIALSHOPPING:String = "CLOSE_FRIENDDISPLAYER_SOCIALSHOPPING";
      
      public static const CLOSE_FRIENDDISPLAYER_IMAGE_UPLOAD:String = "CLOSE_FRIENDDISPLAYER_IMAGE_UPLOAD";
      
      public function FriendDisplayerEvent(param1:String, param2:* = null, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

