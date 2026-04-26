package com.moviestarplanet.services.worldthemeservice
{
   public class WorldThemeChatRoom
   {
      
      public var roomName:String;
      
      public var backgroundFileName:String;
      
      public var requiredItemType:int;
      
      public var requiredItemId:int;
      
      public function WorldThemeChatRoom(param1:Object = null)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         this.roomName = param1.RoomName;
         this.backgroundFileName = param1.BackgroundFileName;
         this.requiredItemType = param1.RequiredItemType;
         this.requiredItemId = param1.RequiredItemId;
      }
   }
}

