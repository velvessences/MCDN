package com.moviestarplanet.friendship.valueobjects
{
   import com.moviestarplanet.model.friends.IParsableFriend;
   
   public class FriendData implements IParsableFriend
   {
      
      private var _actorId:int;
      
      private var _score:int;
      
      private var _lastInteractionDate:Date;
      
      private var _VipTier:int;
      
      private var _name:String;
      
      private var _level:int;
      
      private var _status:int;
      
      private var _recentlyLoggedIn:Boolean;
      
      private var _membershipTimeoutDate:Date;
      
      private var _money:int;
      
      private var _fame:Number;
      
      private var _fortune:int;
      
      private var _friendCount:int;
      
      private var _roomLikes:int;
      
      private var _membershipPurchasedDate:Date;
      
      private var _isExtra:int;
      
      private var _lastLogin:Date;
      
      private var _moderator:int;
      
      public function FriendData()
      {
         super();
      }
      
      public function set actorId(param1:int) : void
      {
         this._actorId = param1;
      }
      
      public function get actorId() : int
      {
         return this._actorId;
      }
      
      public function set VipTier(param1:int) : void
      {
         this._VipTier = param1;
      }
      
      public function get VipTier() : int
      {
         return this._VipTier;
      }
      
      public function set userId(param1:int) : void
      {
         this.actorId = param1;
      }
      
      public function get userId() : int
      {
         return this.actorId;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set level(param1:int) : void
      {
         this._level = param1;
      }
      
      public function get level() : int
      {
         return this._level;
      }
      
      public function set status(param1:int) : void
      {
         this._status = param1;
      }
      
      public function get status() : int
      {
         return this._status;
      }
      
      public function set recentlyLoggedIn(param1:Boolean) : void
      {
         this._recentlyLoggedIn = param1;
      }
      
      public function get recentlyLoggedIn() : Boolean
      {
         return this._recentlyLoggedIn;
      }
      
      public function set membershipTimeoutDate(param1:Date) : void
      {
         this._membershipTimeoutDate = param1;
      }
      
      public function get membershipTimeoutDate() : Date
      {
         return this._membershipTimeoutDate;
      }
      
      public function set vipTier(param1:int) : void
      {
         this._VipTier = param1;
      }
      
      public function get vipTier() : int
      {
         return this._VipTier;
      }
      
      public function set score(param1:int) : void
      {
         this._score = param1;
      }
      
      public function get score() : int
      {
         return this._score;
      }
      
      public function set lastInteractionDate(param1:Date) : void
      {
         this._lastInteractionDate = param1;
      }
      
      public function get lastInteractionDate() : Date
      {
         return this._lastInteractionDate;
      }
      
      public function set money(param1:int) : void
      {
         this._money = param1;
      }
      
      public function get money() : int
      {
         return this._money;
      }
      
      public function set fame(param1:Number) : void
      {
         this._fame = param1;
      }
      
      public function get fame() : Number
      {
         return this._fame;
      }
      
      public function set fortune(param1:int) : void
      {
         this._fortune = param1;
      }
      
      public function get fortune() : int
      {
         return this._fortune;
      }
      
      public function set friendCount(param1:int) : void
      {
         this._friendCount = param1;
      }
      
      public function get friendCount() : int
      {
         return this._friendCount;
      }
      
      public function set roomLikes(param1:int) : void
      {
         this._roomLikes = param1;
      }
      
      public function get roomLikes() : int
      {
         return this._roomLikes;
      }
      
      public function set membershipPurchasedDate(param1:Date) : void
      {
         this._membershipPurchasedDate = param1;
      }
      
      public function get membershipPurchasedDate() : Date
      {
         return this._membershipPurchasedDate;
      }
      
      public function set isExtra(param1:int) : void
      {
         this._isExtra = param1;
      }
      
      public function get isExtra() : int
      {
         return this._isExtra;
      }
      
      public function set lastLogin(param1:Date) : void
      {
         this._lastLogin = param1;
      }
      
      public function get lastLogin() : Date
      {
         return this._lastLogin;
      }
      
      public function get moderator() : int
      {
         return this._moderator;
      }
      
      public function set moderator(param1:int) : void
      {
         this._moderator = param1;
      }
   }
}

