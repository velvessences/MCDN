package com.moviestarplanet.model.friends
{
   public interface IFriend
   {
      
      function get userId() : Number;
      
      function get isVip() : Boolean;
      
      function get name() : String;
      
      function get level() : int;
      
      function get snapshotPath() : String;
      
      function get online() : Boolean;
      
      function get isFriends() : Boolean;
      
      function get status() : int;
      
      function set status(param1:int) : void;
      
      function get rank() : int;
      
      function set rank(param1:int) : void;
      
      function get applicationType() : String;
      
      function get vipTier() : int;
      
      function get money() : int;
      
      function get fame() : Number;
      
      function get fortune() : int;
      
      function get friendCount() : int;
      
      function get roomLikes() : int;
      
      function get membershipTimeoutDate() : Date;
      
      function get membershipPurchasedDate() : Date;
      
      function get isExtra() : int;
      
      function get lastLogin() : Date;
      
      function get moderator() : int;
      
      function assignHighscoreValues(param1:int, param2:Number, param3:int, param4:int, param5:int, param6:Date, param7:Date, param8:int, param9:Date) : void;
   }
}

