package com.moviestarplanet.services.worldthemeservice
{
   public class WorldThemeChatRoomInfo
   {
      
      public var roomName:String;
      
      public var backgroundFilePath:String;
      
      public var requiredItemType:int;
      
      public var requiredItemId:int;
      
      public var isDefaultTheme:Boolean;
      
      public function WorldThemeChatRoomInfo(param1:Object = null)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         this.roomName = param1.RoomName;
         this.backgroundFilePath = param1.BackgroundFilePath;
         this.requiredItemType = param1.RequiredItemType;
         this.requiredItemId = param1.RequiredItemId;
         this.isDefaultTheme = param1.IsDefaultTheme;
      }
   }
}

