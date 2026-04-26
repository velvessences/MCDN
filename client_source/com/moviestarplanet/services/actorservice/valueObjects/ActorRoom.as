package com.moviestarplanet.services.actorservice.valueObjects
{
   public class ActorRoom
   {
      
      public var ActorId:int;
      
      public var Name:String;
      
      public var Level:int;
      
      public var SkinSWF:String;
      
      public var Money:int;
      
      public var Fortune:int;
      
      public var FriendCount:int;
      
      public var ProfileText:String;
      
      public var Created:Date;
      
      public var LastLogin:Date;
      
      public var ProfileDisplays:int;
      
      public var FavoriteMovie:String;
      
      public var FavoriteActor:String;
      
      public var FavoriteActress:String;
      
      public var FavoriteSinger:String;
      
      public var FavoriteSong:String;
      
      public var Wallpaper:String;
      
      public var Floor:String;
      
      public var ValueOfGiftsGiven:int;
      
      public var ValueOfGiftsReceived:int;
      
      public var NumberOfGiftsReceived:int;
      
      public var NumberOfGiftsGiven:int;
      
      public var NumberOfAutographsGiven:int;
      
      public var NumberOfAutographsReceived:int;
      
      public var BoyfriendId:int;
      
      public var BoyfriendStatus:int;
      
      public var MembershipTimeoutDate:Date;
      
      public var TotalVipDays:int;
      
      public var RoomLikes:int;
      
      public var FriendCountVIP:int;
      
      public var BoyFriend:RoomBoyFriend;
      
      public function ActorRoom()
      {
         super();
      }
      
      public function parseObject(param1:Object) : void
      {
         this.ActorId = param1.ActorId as int;
         this.Name = param1.Name as String;
         this.Level = param1.Level as int;
         this.SkinSWF = param1.SkinSWF as String;
         this.Money = param1.Money as int;
         this.Fortune = param1.Fortune as int;
         this.FriendCount = param1.FriendCount as int;
         this.ProfileText = param1.ProfileText as String;
         this.Created = param1.Created as Date;
         this.LastLogin = param1.LastLogin as Date;
         this.ProfileDisplays = param1.ProfileDisplays as int;
         this.FavoriteMovie = param1.FavoriteMovie as String;
         this.FavoriteActor = param1.FavoriteActor as String;
         this.FavoriteActress = param1.FavoriteActress as String;
         this.FavoriteSinger = param1.FavoriteSinger as String;
         this.FavoriteSong = param1.FavoriteSong as String;
         this.Wallpaper = param1.Wallpaper as String;
         this.Floor = param1.Floor as String;
         this.ValueOfGiftsGiven = param1.ValueOfGiftsGiven as int;
         this.ValueOfGiftsReceived = param1.ValueOfGiftsReceived as int;
         this.NumberOfGiftsReceived = param1.NumberOfGiftsReceived as int;
         this.NumberOfGiftsGiven = param1.NumberOfGiftsGiven as int;
         this.NumberOfAutographsGiven = param1.NumberOfAutographsGiven as int;
         this.NumberOfAutographsReceived = param1.NumberOfAutographsReceived as int;
         this.BoyfriendId = param1.BoyfriendId as int;
         this.BoyfriendStatus = param1.BoyfriendStatus as int;
         this.MembershipTimeoutDate = param1.MembershipTimeoutDate as Date;
         this.TotalVipDays = param1.TotalVipDays as int;
         this.RoomLikes = param1.RoomLikes as int;
         this.FriendCountVIP = param1.FriendCountVIP as int;
         if(param1.BoyFriend != null)
         {
            this.BoyFriend = new RoomBoyFriend();
            this.BoyFriend.parseObject(param1.BoyFriend);
         }
      }
   }
}

