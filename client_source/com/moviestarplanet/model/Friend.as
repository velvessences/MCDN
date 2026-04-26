package com.moviestarplanet.model
{
   import com.moviestarplanet.globalsharedutils.SnapshotUrl;
   import com.moviestarplanet.model.friends.ConstantsFriendshipStatus;
   import com.moviestarplanet.model.friends.IFriend;
   import com.moviestarplanet.platform.ApplicationId;
   
   public class Friend implements IFriend
   {
      
      public static const RANK_MIDDLE:int = 50;
      
      private var _isVip:Boolean;
      
      private var _name:String;
      
      private var _actorId:int;
      
      private var _level:int;
      
      private var _friendshipType:int;
      
      private var _friendshipStatus:int;
      
      private var _snapshotPath:String;
      
      private var _isOnline:Boolean;
      
      private var _rank:int;
      
      private var _vipTier:int;
      
      private var _money:int;
      
      private var _fame:Number;
      
      private var _fortune:int;
      
      private var _friendCount:int;
      
      private var _roomLikes:int;
      
      private var _membershipTimeoutDate:Date;
      
      private var _membershipPurchasedDate:Date;
      
      private var _isExtra:int;
      
      private var _lastLogin:Date;
      
      private var _moderator:int;
      
      private var _applicationType:String;
      
      public function Friend(param1:int, param2:String, param3:Boolean, param4:String, param5:int, param6:int, param7:int, param8:int = 50, param9:int = -1, param10:int = 0)
      {
         super();
         this._actorId = param1;
         this._name = param2;
         this._isVip = param3;
         this._level = param5;
         this._friendshipType = param6;
         this._friendshipStatus = param7;
         this._rank = param8;
         this._snapshotPath = param4;
         this._vipTier = param9;
         this._moderator = param10;
      }
      
      public function set status(param1:int) : void
      {
         this._friendshipStatus = param1;
      }
      
      public function set connectionStatus(param1:String) : void
      {
         if(param1 == null || param1 == "disconnected")
         {
            this._isOnline = false;
         }
         else
         {
            this._isOnline = true;
            this._applicationType = param1;
         }
      }
      
      public function get isVip() : Boolean
      {
         return this._isVip;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get actorId() : Number
      {
         return this._actorId as Number;
      }
      
      public function get level() : int
      {
         return this._level;
      }
      
      public function get userId() : Number
      {
         return this.actorId;
      }
      
      public function get online() : Boolean
      {
         return this._isOnline;
      }
      
      public function get applicationType() : String
      {
         return this._applicationType;
      }
      
      public function get snapshotPath() : String
      {
         if(this.online)
         {
            if(this.IsPlayingBoonieverse())
            {
               return new SnapshotUrl(this._actorId,SnapshotUrl.BOONIEVERSE,"boonieversesmall").toString();
            }
            return new SnapshotUrl(this._actorId,SnapshotUrl.MOVIESTAR,"moviestar").toString();
         }
         return this._snapshotPath;
      }
      
      public function get status() : int
      {
         return this._friendshipStatus;
      }
      
      public function get type() : int
      {
         return this._friendshipType;
      }
      
      public function set type(param1:int) : void
      {
         this._friendshipType = param1;
      }
      
      public function get rank() : int
      {
         return this._rank;
      }
      
      public function set rank(param1:int) : void
      {
         this._rank = param1;
      }
      
      public function get vipTier() : int
      {
         return this._vipTier;
      }
      
      public function get fame() : Number
      {
         return this._fame;
      }
      
      public function get fortune() : int
      {
         return this._fortune;
      }
      
      public function get friendCount() : int
      {
         return this._friendCount;
      }
      
      public function get money() : int
      {
         return this._money;
      }
      
      public function get roomLikes() : int
      {
         return this._roomLikes;
      }
      
      public function get membershipTimeoutDate() : Date
      {
         return this._membershipTimeoutDate;
      }
      
      public function get membershipPurchasedDate() : Date
      {
         return this._membershipPurchasedDate;
      }
      
      public function get isExtra() : int
      {
         return this._isExtra;
      }
      
      public function get moderator() : int
      {
         return this._moderator;
      }
      
      public function get lastLogin() : Date
      {
         return this._lastLogin;
      }
      
      public function get isFriends() : Boolean
      {
         return this._friendshipStatus == ConstantsFriendshipStatus.IN_RELATIONSHIP;
      }
      
      public function get isPendingMyResponse() : Boolean
      {
         return this._friendshipStatus == ConstantsFriendshipStatus.PENDING_MY_RESPONSE;
      }
      
      public function get isPendingFriendResponse() : Boolean
      {
         return this._friendshipStatus == ConstantsFriendshipStatus.PENDING_FRIEND_RESPONSE;
      }
      
      public function destroy() : void
      {
      }
      
      private function IsPlayingBoonieverse() : Boolean
      {
         return this._applicationType == ApplicationId.APPLICATION_BOONIEVERSE;
      }
      
      public function parseData(param1:Object) : void
      {
         this._name = param1.Name;
         this._isVip = param1.IsVip;
         this._snapshotPath = param1.SnapshotPath;
      }
      
      public function assignHighscoreValues(param1:int, param2:Number, param3:int, param4:int, param5:int, param6:Date, param7:Date, param8:int, param9:Date) : void
      {
         this._money = param1;
         this._fame = param2;
         this._fortune = param3;
         this._friendCount = param4;
         this._roomLikes = param5;
         this._membershipTimeoutDate = param6;
         this._membershipPurchasedDate = param7;
         this._isExtra = param8;
         this._lastLogin = param9;
      }
   }
}

