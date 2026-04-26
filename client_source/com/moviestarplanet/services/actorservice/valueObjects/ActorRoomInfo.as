package com.moviestarplanet.services.actorservice.valueObjects
{
   public class ActorRoomInfo
   {
      
      public var actorRoom:ActorRoom;
      
      public var hasLiked:int;
      
      public function ActorRoomInfo()
      {
         super();
      }
      
      public function parseObject(param1:Object) : void
      {
         this.hasLiked = param1.hasLiked as int;
         if(param1.actorRoom != null)
         {
            this.actorRoom = new ActorRoom();
            this.actorRoom.parseObject(param1.actorRoom);
         }
      }
   }
}

