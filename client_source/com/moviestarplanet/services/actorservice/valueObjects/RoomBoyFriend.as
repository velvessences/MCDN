package com.moviestarplanet.services.actorservice.valueObjects
{
   public class RoomBoyFriend
   {
      
      public var ActorId:int;
      
      public var Name:String;
      
      public var SkinSWF:String;
      
      public function RoomBoyFriend()
      {
         super();
      }
      
      public function parseObject(param1:Object) : void
      {
         this.ActorId = param1.ActorId as int;
         this.Name = param1.Name as String;
         this.SkinSWF = param1.SkinSWF as String;
      }
   }
}

