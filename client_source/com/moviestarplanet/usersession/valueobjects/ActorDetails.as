package com.moviestarplanet.usersession.valueobjects
{
   import com.moviestarplanet.actor.IActorDetails;
   import com.moviestarplanet.actor.IActorStatus;
   import com.moviestarplanet.actor.IGenderSpecific;
   import com.moviestarplanet.actorutils.ActorUtils;
   import com.moviestarplanet.combat.valueobject.CombatCategorisation;
   import com.moviestarplanet.constants.friendship.ConstantsRelationshipStatus;
   import com.moviestarplanet.friendship.valueobjects.ActorRelationship;
   import com.moviestarplanet.friendship.valueobjects.ActorRelationshipType;
   import com.moviestarplanet.friendship.valueobjects.BoyFriend;
   import com.moviestarplanet.model.friends.ConstantsFriendshipStatus;
   import com.moviestarplanet.model.friends.ConstantsFriendshipType;
   import com.moviestarplanet.model.friends.VipTierConstants;
   import com.moviestarplanet.moviestar.valueObjects.Actor;
   import mx.collections.ArrayCollection;
   
   public class ActorDetails implements IActorDetails, IGenderSpecific
   {
      
      public var ActorId:int;
      
      public var Name:String;
      
      public var Level:int;
      
      public var _SkinSWF:String;
      
      public var SkinColor:String;
      
      public var NoseId:int;
      
      public var EyeId:int;
      
      public var MouthId:int;
      
      public var Money:int;
      
      public var EyeColors:String;
      
      public var MouthColors:String;
      
      public var Fame:Number;
      
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
      
      public var IsExtra:int;
      
      public var HasUnreadMessages:int;
      
      public var InvitedByActorId:int;
      
      public var PollTaken:int;
      
      public var ValueOfGiftsReceived:int;
      
      public var ValueOfGiftsGiven:int;
      
      public var NumberOfGiftsGiven:int;
      
      public var NumberOfGiftsReceived:int;
      
      public var NumberOfAutographsReceived:int;
      
      public var NumberOfAutographsGiven:int;
      
      public var TimeOfLastAutographGiven:Date;
      
      public var FacebookId:String;
      
      public var MembershipPurchasedDate:Date;
      
      public var MembershipTimeoutDate:Date;
      
      public var MembershipGiftRecievedDate:Date;
      
      public var BehaviourStatus:int;
      
      public var LockedUntil:Date;
      
      public var LockedText:String;
      
      public var BadWordCount:int;
      
      public var PurchaseTimeoutDate:Date;
      
      public var EmailValidated:int;
      
      public var RetentionStatus:int;
      
      public var GiftStatus:int;
      
      public var MarketingNextStepLogins:int;
      
      public var MarketingStep:int;
      
      public var TotalVipDays:int;
      
      public var RecyclePoints:int;
      
      public var EmailSettings:int;
      
      public var TimeOfLastAutographGivenStr:String;
      
      public var BestFriendId:int;
      
      public var BestFriendStatus:int;
      
      public var FriendCountVIP:int;
      
      public var ForceNameChange:int;
      
      public var CreationRewardStep:int;
      
      public var CreationRewardLastAwardDate:Date;
      
      public var NameBeforeDeleted:String;
      
      public var LastTransactionId:int;
      
      public var AllowCommunication:int;
      
      public var Diamonds:int;
      
      public var PopUpStyleId:int;
      
      public var VipTier:int;
      
      public var EyeShadowId:int;
      
      public var EyeShadowColors:String;
      
      public var BoyFriend:com.moviestarplanet.friendship.valueobjects.BoyFriend;
      
      public var ActorPersonalInfo:com.moviestarplanet.usersession.valueobjects.ActorPersonalInfo;
      
      public var ActorRelationships:ArrayCollection;
      
      public var ActorStatus:com.moviestarplanet.usersession.valueobjects.ActorStatus;
      
      public var CombatCategorisation:com.moviestarplanet.combat.valueobject.CombatCategorisation;
      
      public var RoomLikes:int;
      
      private var _loginModeratorCheckOnLogin:int;
      
      private var amsHash:String;
      
      public function ActorDetails()
      {
         super();
      }
      
      public static function newFromActor(param1:Actor, param2:String, param3:int) : ActorDetails
      {
         var _loc4_:ActorDetails = new ActorDetails();
         _loc4_.ActorId = 0;
         _loc4_.Name = param2;
         _loc4_.Level = param1.Level;
         _loc4_.SkinSWF = param1.SkinSWF;
         _loc4_.SkinColor = param1.SkinColor;
         _loc4_.NoseId = param1.Nose.NoseId;
         _loc4_.EyeId = param1.Eye.EyeId;
         _loc4_.MouthId = param1.Mouth.MouthId;
         _loc4_.Money = 0;
         _loc4_.EyeColors = param1.EyeColors;
         _loc4_.MouthColors = param1.MouthColors;
         _loc4_.Fame = param1.Fame;
         _loc4_.Fortune = 0;
         _loc4_.FriendCount = param1.FriendCount;
         _loc4_.FriendCountVIP = 0;
         _loc4_.ForceNameChange = 0;
         _loc4_.ProfileText = "";
         _loc4_.Created = null;
         _loc4_.LastLogin = null;
         _loc4_.EmailValidated = 0;
         _loc4_.EmailSettings = 0;
         _loc4_.ProfileDisplays = 0;
         _loc4_.FavoriteMovie = null;
         _loc4_.FavoriteActor = null;
         _loc4_.FavoriteActress = null;
         _loc4_.FavoriteSinger = null;
         _loc4_.FavoriteSong = null;
         _loc4_.IsExtra = 0;
         _loc4_.HasUnreadMessages = 0;
         _loc4_.InvitedByActorId = param3;
         _loc4_.PollTaken = 0;
         _loc4_.NumberOfAutographsGiven = 0;
         _loc4_.NumberOfAutographsReceived = 0;
         _loc4_.NumberOfGiftsGiven = 0;
         _loc4_.NumberOfGiftsReceived = 0;
         _loc4_.ValueOfGiftsGiven = 0;
         _loc4_.ValueOfGiftsReceived = 0;
         _loc4_.TimeOfLastAutographGiven = null;
         _loc4_.FacebookId = "";
         _loc4_.BoyFriend = null;
         _loc4_.BestFriendId = 0;
         _loc4_.BestFriendStatus = 0;
         _loc4_.MembershipGiftRecievedDate = new Date(2000,1,1);
         _loc4_.MembershipPurchasedDate = new Date(2000,1,1);
         _loc4_.MembershipTimeoutDate = new Date(2000,1,1);
         _loc4_.VipTier = 0;
         _loc4_.PurchaseTimeoutDate = new Date(2000,1,1);
         _loc4_.BehaviourStatus = 0;
         _loc4_.LockedUntil = new Date(2000,1,1);
         _loc4_.BadWordCount = 0;
         _loc4_.RetentionStatus = 0;
         _loc4_.GiftStatus = 0;
         _loc4_.TotalVipDays = 0;
         _loc4_.MarketingNextStepLogins = 2;
         _loc4_.MarketingStep = 0;
         _loc4_.RecyclePoints = 0;
         _loc4_.CreationRewardStep = 0;
         _loc4_.CreationRewardLastAwardDate = new Date(2000,1,1);
         _loc4_.ActorPersonalInfo = null;
         _loc4_.AllowCommunication = 1;
         _loc4_.RoomLikes = param1.RoomLikes;
         return _loc4_;
      }
      
      public static function GetInstance(param1:Object) : ActorDetails
      {
         var _loc3_:String = null;
         var _loc2_:ActorDetails = new ActorDetails();
         for(_loc3_ in param1)
         {
            if(Boolean(param1.hasOwnProperty(_loc3_)) && Boolean(_loc2_.hasOwnProperty(_loc3_)))
            {
               _loc2_[_loc3_] = param1[_loc3_];
            }
         }
         return _loc2_;
      }
      
      public static function IsRelationshipBestFriend(param1:ActorRelationship) : Boolean
      {
         if(param1.RelationshipTypeId == ActorRelationshipType.BestFriend && param1.Status == ConstantsFriendshipStatus.IN_RELATIONSHIP)
         {
            return true;
         }
         return false;
      }
      
      public static function IsRelationshipBoyFriend(param1:ActorRelationship) : Boolean
      {
         if(param1.RelationshipTypeId == ActorRelationshipType.Boyfriend && param1.Status == ConstantsFriendshipStatus.IN_RELATIONSHIP)
         {
            return true;
         }
         return false;
      }
      
      public function getAmsSecurityHash() : String
      {
         return this.amsHash;
      }
      
      public function setAmsSecurityHash(param1:String) : void
      {
         this.amsHash = param1;
      }
      
      public function getLoginModeratorStatusForCheckOnLogin() : int
      {
         return this._loginModeratorCheckOnLogin;
      }
      
      public function set Moderator(param1:int) : void
      {
         this._loginModeratorCheckOnLogin = param1;
      }
      
      public function get actorStatus() : IActorStatus
      {
         return this.ActorStatus;
      }
      
      public function get isFemale() : Boolean
      {
         return ActorUtils.isFemaleSkinSwf(this.SkinSWF);
      }
      
      public function get isVip() : Boolean
      {
         return ActorUtils.isVip(this.MembershipTimeoutDate);
      }
      
      public function get vipTier() : int
      {
         if(this.isVip)
         {
            return this.VipTier;
         }
         return VipTierConstants.NON_VIP;
      }
      
      public function get isCeleb() : Boolean
      {
         return ActorUtils.isCeleb(this.FriendCountVIP);
      }
      
      public function get isDeleted() : Boolean
      {
         return ActorUtils.isDeleted(this.IsExtra);
      }
      
      public function get isJudge() : Boolean
      {
         return ActorUtils.isJudge(this.TotalVipDays);
      }
      
      public function get isJury() : Boolean
      {
         return ActorUtils.isJury(this.TotalVipDays);
      }
      
      public function HasBoyfriend() : Boolean
      {
         var _loc1_:ActorRelationship = null;
         for each(_loc1_ in this.ActorRelationships)
         {
            if(_loc1_.RelationshipTypeId == ConstantsFriendshipType.BOYFRIEND)
            {
               if(_loc1_.Status != ConstantsFriendshipStatus.NONE)
               {
                  return true;
               }
               return false;
            }
         }
         return false;
      }
      
      public function GetBoyfriendStatusById(param1:int) : int
      {
         var _loc2_:ActorRelationship = this.GetBoyfriendByBoyfriendId(param1);
         if(_loc2_)
         {
            return _loc2_.Status;
         }
         return ConstantsFriendshipStatus.NONE;
      }
      
      public function GetNumBestFriends() : int
      {
         var _loc2_:ActorRelationship = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.ActorRelationships)
         {
            if(_loc2_.RelationshipTypeId == ActorRelationshipType.BestFriend && _loc2_.Status == ConstantsFriendshipStatus.IN_RELATIONSHIP)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function GetNumBestFriendsAndRequests() : int
      {
         var _loc2_:ActorRelationship = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.ActorRelationships)
         {
            if(_loc2_.RelationshipTypeId == ActorRelationshipType.BestFriend)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function IsBestFriend(param1:int) : Boolean
      {
         var _loc3_:ActorRelationship = null;
         var _loc2_:Boolean = false;
         for each(_loc3_ in this.ActorRelationships)
         {
            if(_loc3_.FriendId == param1)
            {
               _loc2_ ||= IsRelationshipBestFriend(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function IsBoyFriend(param1:int) : Boolean
      {
         var _loc3_:ActorRelationship = null;
         var _loc2_:Boolean = false;
         for each(_loc3_ in this.ActorRelationships)
         {
            if(_loc3_.FriendId == param1)
            {
               _loc2_ ||= IsRelationshipBoyFriend(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function BreakUpBestFriendLocally(param1:int) : void
      {
         var _loc2_:ActorRelationship = null;
         for each(_loc2_ in this.ActorRelationships)
         {
            if(_loc2_.RelationshipTypeId == ActorRelationshipType.BestFriend && _loc2_.FriendId == param1)
            {
               _loc2_.Status = ConstantsFriendshipStatus.NONE;
               break;
            }
         }
      }
      
      public function RemoveRelationship(param1:int, param2:int) : void
      {
         var _loc3_:ActorRelationship = null;
         var _loc4_:* = int(this.ActorRelationships.length - 1);
         while(_loc4_ >= 0)
         {
            _loc3_ = this.ActorRelationships.getItemAt(_loc4_) as ActorRelationship;
            if(_loc3_.RelationshipTypeId == param2 && _loc3_.FriendId == param1)
            {
               this.ActorRelationships.removeItemAt(_loc4_);
            }
            _loc4_--;
         }
      }
      
      public function RemoveAllRelationshipsWithActor(param1:int) : void
      {
         var _loc2_:ActorRelationship = null;
         var _loc3_:* = int(this.ActorRelationships.length - 1);
         while(_loc3_ >= 0)
         {
            _loc2_ = this.ActorRelationships.getItemAt(_loc3_) as ActorRelationship;
            if(_loc2_.FriendId == param1)
            {
               this.ActorRelationships.removeItemAt(_loc3_);
            }
            _loc3_--;
         }
      }
      
      public function GetBestFriendStatus(param1:int) : int
      {
         var _loc2_:ActorRelationship = null;
         for each(_loc2_ in this.ActorRelationships)
         {
            if(_loc2_.RelationshipTypeId == ActorRelationshipType.BestFriend && _loc2_.FriendId == param1)
            {
               return _loc2_.Status;
            }
         }
         return ConstantsFriendshipStatus.NONE;
      }
      
      public function AddBoyfriendRequest(param1:int) : void
      {
         this.DeleteBoyfriendRelationship(param1);
         var _loc2_:ActorRelationship = new ActorRelationship();
         _loc2_.ActorId = this.ActorId;
         _loc2_.FriendId = param1;
         _loc2_.OrderBy = 0;
         _loc2_.RelationshipTypeId = ConstantsFriendshipType.BOYFRIEND;
         _loc2_.Status = ConstantsRelationshipStatus.WAITINGFORANSWER;
         this.ActorRelationships.addItem(_loc2_);
      }
      
      public function AddRelationship(param1:int, param2:int, param3:int) : ActorRelationship
      {
         var _loc4_:ActorRelationship = this.GetRelationship(param1,param2);
         if(!_loc4_)
         {
            _loc4_ = new ActorRelationship();
            _loc4_.ActorId = this.ActorId;
            _loc4_.FriendId = param1;
            _loc4_.OrderBy = 0;
            _loc4_.RelationshipTypeId = param2;
            this.ActorRelationships.addItem(_loc4_);
         }
         _loc4_.Status = param3;
         return _loc4_;
      }
      
      public function DeleteRelationship(param1:int, param2:int) : Boolean
      {
         var _loc3_:ActorRelationship = null;
         var _loc4_:int = 0;
         while(_loc4_ < this.ActorRelationships.length)
         {
            _loc3_ = this.ActorRelationships.getItemAt(_loc4_) as ActorRelationship;
            if(_loc3_.RelationshipTypeId == param2 && _loc3_.FriendId == param1)
            {
               this.ActorRelationships.removeItemAt(_loc4_);
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function GetRelationship(param1:int, param2:int) : ActorRelationship
      {
         var _loc3_:ActorRelationship = null;
         var _loc4_:ActorRelationship = null;
         var _loc5_:int = 0;
         while(_loc5_ < this.ActorRelationships.length)
         {
            _loc3_ = this.ActorRelationships.getItemAt(_loc5_) as ActorRelationship;
            if(_loc3_.RelationshipTypeId == param2 && _loc3_.FriendId == param1)
            {
               _loc4_ = _loc3_;
               if(_loc4_.Status == ConstantsRelationshipStatus.WAITINGMYANSWER)
               {
                  return _loc4_;
               }
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function AddBoyfriendRelationship(param1:int) : void
      {
         this.DeleteBoyfriendRelationship(param1);
         var _loc2_:ActorRelationship = new ActorRelationship();
         _loc2_.ActorId = this.ActorId;
         _loc2_.FriendId = param1;
         _loc2_.OrderBy = 0;
         _loc2_.RelationshipTypeId = ConstantsFriendshipType.BOYFRIEND;
         _loc2_.Status = ConstantsRelationshipStatus.INRELATIONSHIP;
         this.ActorRelationships.addItem(_loc2_);
      }
      
      public function DeleteBoyfriendRelationship(param1:int) : void
      {
         var _loc2_:ActorRelationship = this.GetBoyfriendByBoyfriendId(param1);
         if(_loc2_)
         {
            this.ActorRelationships.removeItemAt(this.ActorRelationships.source.indexOf(_loc2_));
         }
      }
      
      public function GetBoyfriendByBoyfriendId(param1:int) : ActorRelationship
      {
         var _loc2_:ActorRelationship = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.ActorRelationships.length)
         {
            _loc2_ = this.ActorRelationships.getItemAt(_loc3_) as ActorRelationship;
            if(_loc2_.RelationshipTypeId == ConstantsFriendshipType.BOYFRIEND)
            {
               if(_loc2_.ActorId == this.ActorId && _loc2_.FriendId == param1 || _loc2_.FriendId == this.ActorId && _loc2_.ActorId == param1)
               {
                  return _loc2_;
               }
            }
            _loc3_++;
         }
         return null;
      }
      
      public function SetBoyfriendStatus(param1:int, param2:int) : void
      {
         this.DeleteBoyfriendRelationship(param1);
         var _loc3_:ActorRelationship = new ActorRelationship();
         _loc3_.ActorId = this.ActorId;
         _loc3_.FriendId = param1;
         _loc3_.OrderBy = 0;
         _loc3_.RelationshipTypeId = ConstantsFriendshipType.BOYFRIEND;
         _loc3_.Status = param2;
         this.ActorRelationships.addItem(_loc3_);
      }
      
      public function GetBoyfriendInRelationship() : ActorRelationship
      {
         var _loc1_:ActorRelationship = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.ActorRelationships.length)
         {
            _loc1_ = this.ActorRelationships.getItemAt(_loc2_) as ActorRelationship;
            if(_loc1_.RelationshipTypeId == ConstantsFriendshipType.BOYFRIEND && _loc1_.Status == ConstantsRelationshipStatus.INRELATIONSHIP)
            {
               return _loc1_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function SetBestFriendStatus(param1:int, param2:int) : void
      {
         var _loc3_:ActorRelationship = null;
         var _loc4_:ActorRelationship = null;
         for each(_loc3_ in this.ActorRelationships)
         {
            if(_loc3_.RelationshipTypeId == ActorRelationshipType.BestFriend && _loc3_.FriendId == param1)
            {
               _loc3_.Status = param2;
               return;
            }
         }
         _loc4_ = new ActorRelationship();
         _loc4_.ActorId = this.ActorId;
         _loc4_.FriendId = param1;
         _loc4_.ActorRelationshipId = 0;
         _loc4_.RelationshipTypeId = ActorRelationshipType.BestFriend;
         _loc4_.Status = param2;
         this.ActorRelationships.addItem(_loc4_);
      }
      
      public function get GetBehaviourStatus() : int
      {
         return this.BehaviourStatus;
      }
      
      public function get GetLockedText() : String
      {
         return this.LockedText;
      }
      
      public function get GetLockedUntil() : Date
      {
         return this.LockedUntil;
      }
      
      public function get actorId() : int
      {
         return this.ActorId;
      }
      
      public function getMoney() : int
      {
         return this.Money;
      }
      
      public function getFame() : Number
      {
         return this.Fame;
      }
      
      public function getDiamonds() : int
      {
         return this.Diamonds;
      }
      
      public function canFriendActor(param1:int) : Boolean
      {
         var _loc2_:Boolean = true;
         var _loc3_:Boolean = this._loginModeratorCheckOnLogin > 0;
         var _loc4_:Boolean = param1 > 0;
         if(_loc3_ == false && _loc4_ == true)
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      public function get SkinSWF() : String
      {
         return this._SkinSWF;
      }
      
      public function set SkinSWF(param1:String) : void
      {
         this._SkinSWF = param1;
      }
      
      public function get created() : Date
      {
         return this.Created;
      }
      
      public function updateWithNewActorDetails(param1:ActorDetails) : void
      {
         this.Name = param1.Name;
         this.Level = param1.Level;
         this._SkinSWF = param1._SkinSWF;
         this.SkinColor = param1.SkinColor;
         this.NoseId = param1.NoseId;
         this.EyeId = param1.EyeId;
         this.MouthId = param1.MouthId;
         this.Money = param1.Money;
         this.EyeColors = param1.EyeColors;
         this.MouthColors = param1.MouthColors;
         this.Fame = param1.Fame;
         this.Fortune = param1.Fortune;
         this.FriendCount = param1.FriendCount;
         this.ProfileText = param1.ProfileText;
         this.Created = param1.Created;
         this.LastLogin = param1.LastLogin;
         this.ProfileDisplays = param1.ProfileDisplays;
         this.FavoriteMovie = param1.FavoriteMovie;
         this.FavoriteActor = param1.FavoriteActor;
         this.FavoriteActress = param1.FavoriteActress;
         this.FavoriteSinger = param1.FavoriteSinger;
         this.FavoriteSong = param1.FavoriteSong;
         this.IsExtra = param1.IsExtra;
         this.HasUnreadMessages = param1.HasUnreadMessages;
         this.InvitedByActorId = param1.InvitedByActorId;
         this.PollTaken = param1.PollTaken;
         this.ValueOfGiftsReceived = param1.ValueOfGiftsReceived;
         this.ValueOfGiftsGiven = param1.ValueOfGiftsGiven;
         this.NumberOfGiftsGiven = param1.NumberOfGiftsGiven;
         this.NumberOfGiftsReceived = param1.NumberOfGiftsReceived;
         this.NumberOfAutographsReceived = param1.NumberOfAutographsReceived;
         this.NumberOfAutographsGiven = param1.NumberOfAutographsGiven;
         this.TimeOfLastAutographGiven = param1.TimeOfLastAutographGiven;
         this.FacebookId = param1.FacebookId;
         this.MembershipPurchasedDate = param1.MembershipPurchasedDate;
         this.MembershipTimeoutDate = param1.MembershipTimeoutDate;
         this.MembershipGiftRecievedDate = param1.MembershipGiftRecievedDate;
         this.BehaviourStatus = param1.BehaviourStatus;
         this.LockedUntil = param1.LockedUntil;
         this.LockedText = param1.LockedText;
         this.BadWordCount = param1.BadWordCount;
         this.PurchaseTimeoutDate = param1.PurchaseTimeoutDate;
         this.EmailValidated = param1.EmailValidated;
         this.RetentionStatus = param1.RetentionStatus;
         this.GiftStatus = param1.GiftStatus;
         this.MarketingNextStepLogins = param1.MarketingNextStepLogins;
         this.MarketingStep = param1.MarketingStep;
         this.TotalVipDays = param1.TotalVipDays;
         this.RecyclePoints = param1.RecyclePoints;
         this.EmailSettings = param1.EmailSettings;
         this.TimeOfLastAutographGivenStr = param1.TimeOfLastAutographGivenStr;
         this.BestFriendId = param1.BestFriendId;
         this.BestFriendStatus = param1.BestFriendStatus;
         this.FriendCountVIP = param1.FriendCountVIP;
         this.ForceNameChange = param1.ForceNameChange;
         this.CreationRewardStep = param1.CreationRewardStep;
         this.CreationRewardLastAwardDate = param1.CreationRewardLastAwardDate;
         this.NameBeforeDeleted = param1.NameBeforeDeleted;
         this.LastTransactionId = param1.LastTransactionId;
         this.AllowCommunication = param1.AllowCommunication;
         this.Diamonds = param1.Diamonds;
         this.PopUpStyleId = param1.PopUpStyleId;
         this.VipTier = param1.VipTier;
         this.EyeShadowId = param1.EyeShadowId;
         this.EyeShadowColors = param1.EyeShadowColors;
         this.BoyFriend = param1.BoyFriend;
         this.ActorPersonalInfo = param1.ActorPersonalInfo;
         this.ActorRelationships = param1.ActorRelationships;
         this.RoomLikes = param1.RoomLikes;
      }
   }
}

