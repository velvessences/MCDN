package com.moviestarplanet.services.worldthemeservice
{
   public class WorldThemeInfo
   {
      
      public var worldAreaSwfs:Array;
      
      public var worldThemeChatRoomInfo:WorldThemeChatRoomInfo;
      
      public function WorldThemeInfo(param1:Object = null)
      {
         var _loc2_:Object = null;
         super();
         if(param1 == null)
         {
            return;
         }
         this.worldAreaSwfs = new Array();
         for each(_loc2_ in param1.WorldAreaSwfs)
         {
            this.worldAreaSwfs.push(new WorldAreaSwf(_loc2_));
         }
         this.worldThemeChatRoomInfo = new WorldThemeChatRoomInfo(param1.WorldThemeChatRoomInfo);
      }
   }
}

