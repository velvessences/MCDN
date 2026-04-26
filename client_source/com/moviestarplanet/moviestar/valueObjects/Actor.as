package com.moviestarplanet.moviestar.valueObjects
{
   import com.moviestarplanet.actor.IActor;
   import com.moviestarplanet.actor.IGenderSpecific;
   import com.moviestarplanet.actorutils.ActorUtils;
   import com.moviestarplanet.model.friends.VipTierConstants;
   import com.moviestarplanet.moviestar.utils.AppearanceData;
   import com.moviestarplanet.moviestar.utils.AppearanceUtil;
   
   public class Actor implements IActor, IGenderSpecific
   {
      
      private var _SkinSWF:String;
      
      private var _ActorId:int;
      
      private var _Name:String;
      
      private var _Level:int;
      
      private var _SkinColor:String;
      
      private var _NoseId:int;
      
      private var _EyeId:int;
      
      private var _EyeShadowId:int;
      
      private var _MouthId:int;
      
      private var _Money:int;
      
      private var _EyeColors:String;
      
      private var _MouthColors:String;
      
      private var _EyeShadowColors:String;
      
      private var _Fame:int;
      
      private var _FriendCount:int;
      
      private var _IsExtra:int;
      
      private var _MembershipTimeoutDate:Date;
      
      private var _VipTier:int;
      
      private var _TotalVipDays:int;
      
      private var _FriendCountVip:int;
      
      private var _Diamonds:int;
      
      private var _PopUpStyleId:int;
      
      private var _Moderator:int;
      
      private var _ActorClothesRels:Array;
      
      private var _ActorRelationships:Array;
      
      private var _Eye:com.moviestarplanet.moviestar.valueObjects.Eye;
      
      private var _Nose:com.moviestarplanet.moviestar.valueObjects.Nose;
      
      private var _Mouth:com.moviestarplanet.moviestar.valueObjects.Mouth;
      
      private var _EyeShadow:com.moviestarplanet.moviestar.valueObjects.EyeShadow;
      
      private var _RoomLikes:int;
      
      private var _Fortune:int;
      
      private var _LastLogin:Date;
      
      public function Actor()
      {
         super();
      }
      
      public static function CreateEmptyActor(param1:int) : Actor
      {
         if(param1 == 2)
         {
            return CreateEmptyActorBoy();
         }
         return CreateEmptyActorGirl();
      }
      
      public static function CreateEmptyActorGirl() : Actor
      {
         var _loc1_:com.moviestarplanet.moviestar.valueObjects.Eye = new com.moviestarplanet.moviestar.valueObjects.Eye();
         _loc1_.EyeId = 1;
         _loc1_.Name = "Eyes";
         _loc1_.SWF = "eyes_1";
         var _loc2_:com.moviestarplanet.moviestar.valueObjects.Nose = new com.moviestarplanet.moviestar.valueObjects.Nose();
         _loc2_.NoseId = 1;
         _loc2_.Name = "Standard Nose";
         _loc2_.SWF = "nose_1";
         var _loc3_:com.moviestarplanet.moviestar.valueObjects.Mouth = new com.moviestarplanet.moviestar.valueObjects.Mouth();
         _loc3_.MouthId = 1;
         _loc3_.Name = "mouth";
         _loc3_.SWF = "female_mouth_1";
         var _loc4_:Actor = new Actor();
         _loc4_.ActorId = -1;
         _loc4_.Name = "";
         _loc4_.Level = 1;
         _loc4_._SkinSWF = "femaleskin";
         _loc4_.SkinColor = "0xFEC289";
         _loc4_.NoseId = 1;
         _loc4_.Nose = _loc2_;
         _loc4_.MouthId = 1;
         _loc4_.Mouth = _loc3_;
         _loc4_.EyeId = 1;
         _loc4_.Eye = _loc1_;
         _loc4_.Fame = 0;
         _loc4_.FriendCount = 0;
         _loc4_.RoomLikes = 0;
         _loc4_.EyeColors = "0x0000ff";
         _loc4_.MouthColors = "0xff0000";
         _loc4_.ActorClothesRels = new Array();
         return _loc4_;
      }
      
      public static function CreateEmptyActorBoy() : Actor
      {
         var _loc1_:com.moviestarplanet.moviestar.valueObjects.Eye = new com.moviestarplanet.moviestar.valueObjects.Eye();
         _loc1_.EyeId = 12;
         _loc1_.Name = "The Man";
         _loc1_.SWF = "Honey_male_eyes_2_2009";
         var _loc2_:com.moviestarplanet.moviestar.valueObjects.Nose = new com.moviestarplanet.moviestar.valueObjects.Nose();
         _loc2_.NoseId = 4;
         _loc2_.Name = "Regular";
         _loc2_.SWF = "nose_3";
         var _loc3_:com.moviestarplanet.moviestar.valueObjects.Mouth = new com.moviestarplanet.moviestar.valueObjects.Mouth();
         _loc3_.MouthId = 4;
         _loc3_.Name = "Basic Boy";
         _loc3_.SWF = "male_mouth_1";
         var _loc4_:Actor = new Actor();
         _loc4_.ActorId = -1;
         _loc4_.Name = "";
         _loc4_.Level = 1;
         _loc4_._SkinSWF = "maleskin";
         _loc4_.SkinColor = "0xFEC289";
         _loc4_.NoseId = 1;
         _loc4_.Nose = _loc2_;
         _loc4_.MouthId = 1;
         _loc4_.Mouth = _loc3_;
         _loc4_.EyeId = 1;
         _loc4_.Eye = _loc1_;
         _loc4_.Fame = 0;
         _loc4_.FriendCount = 0;
         _loc4_.RoomLikes = 0;
         _loc4_.EyeColors = "26163,0x000000,skincolor";
         _loc4_.MouthColors = "skincolor,13382502";
         _loc4_.ActorClothesRels = new Array();
         return _loc4_;
      }
      
      public function get ActorId() : int
      {
         return this._ActorId;
      }
      
      public function get Name() : String
      {
         return this._Name;
      }
      
      public function get Level() : int
      {
         return this._Level;
      }
      
      public function get SkinSWF() : String
      {
         return this._SkinSWF;
      }
      
      public function get SkinColor() : String
      {
         return this._SkinColor;
      }
      
      public function get NoseId() : int
      {
         return this._NoseId;
      }
      
      public function get EyeId() : int
      {
         return this._EyeId;
      }
      
      public function get MouthId() : int
      {
         return this._MouthId;
      }
      
      public function get EyeShadowId() : int
      {
         return this._EyeShadowId;
      }
      
      public function get Money() : int
      {
         return this._Money;
      }
      
      public function get EyeColors() : String
      {
         return this._EyeColors;
      }
      
      public function get MouthColors() : String
      {
         return this._MouthColors;
      }
      
      public function get EyeShadowColors() : String
      {
         return this._EyeShadowColors;
      }
      
      public function get Fame() : int
      {
         return this._Fame;
      }
      
      public function get FriendCount() : int
      {
         return this._FriendCount;
      }
      
      public function get IsExtra() : int
      {
         return this._IsExtra;
      }
      
      public function get MembershipTimeoutDate() : Date
      {
         return this._MembershipTimeoutDate;
      }
      
      public function get VipTier() : int
      {
         if(this.isVip)
         {
            return this._VipTier;
         }
         return VipTierConstants.NON_VIP;
      }
      
      public function get TotalVipDays() : int
      {
         return this._TotalVipDays;
      }
      
      public function get FriendCountVip() : int
      {
         return this._FriendCountVip;
      }
      
      public function get Diamonds() : int
      {
         return this._Diamonds;
      }
      
      public function get PopUpStyleId() : int
      {
         return this._PopUpStyleId;
      }
      
      public function get Moderator() : int
      {
         return this._Moderator;
      }
      
      public function get ActorClothesRels() : Array
      {
         return this._ActorClothesRels;
      }
      
      public function get ActorClothesRels2() : Array
      {
         var _loc2_:ActorClothesRel = null;
         var _loc3_:ActorClothesRel2 = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this._ActorClothesRels)
         {
            _loc3_ = ActorClothesRel2.CreateActorClothesRel2(_loc2_);
            _loc1_.push(_loc3_);
         }
         return _loc1_;
      }
      
      public function get ActorRelationships() : Array
      {
         return this._ActorRelationships;
      }
      
      public function get Eye() : com.moviestarplanet.moviestar.valueObjects.Eye
      {
         return this._Eye;
      }
      
      public function get Nose() : com.moviestarplanet.moviestar.valueObjects.Nose
      {
         return this._Nose;
      }
      
      public function get Mouth() : com.moviestarplanet.moviestar.valueObjects.Mouth
      {
         return this._Mouth;
      }
      
      public function get EyeShadow() : com.moviestarplanet.moviestar.valueObjects.EyeShadow
      {
         return this._EyeShadow;
      }
      
      public function get RoomLikes() : int
      {
         return this._RoomLikes;
      }
      
      public function get Fortune() : int
      {
         return this._Fortune;
      }
      
      public function get LastLogin() : Date
      {
         return this._LastLogin;
      }
      
      public function set ActorId(param1:int) : void
      {
         this._ActorId = param1;
      }
      
      public function set Name(param1:String) : void
      {
         this._Name = param1;
      }
      
      public function set Level(param1:int) : void
      {
         this._Level = param1;
      }
      
      public function set SkinSWF(param1:String) : void
      {
         this._SkinSWF = param1;
      }
      
      public function set SkinColor(param1:String) : void
      {
         this._SkinColor = param1;
      }
      
      public function set NoseId(param1:int) : void
      {
         this._NoseId = param1;
      }
      
      public function set EyeId(param1:int) : void
      {
         this._EyeId = param1;
      }
      
      public function set MouthId(param1:int) : void
      {
         this._MouthId = param1;
      }
      
      public function set EyeShadowId(param1:int) : void
      {
         this._EyeShadowId = param1;
      }
      
      public function set Money(param1:int) : void
      {
         this._Money = param1;
      }
      
      public function set EyeColors(param1:String) : void
      {
         this._EyeColors = param1;
      }
      
      public function set MouthColors(param1:String) : void
      {
         this._MouthColors = param1;
      }
      
      public function set EyeShadowColors(param1:String) : void
      {
         this._EyeShadowColors = param1;
      }
      
      public function set Fame(param1:int) : void
      {
         this._Fame = param1;
      }
      
      public function set FriendCount(param1:int) : void
      {
         this._FriendCount = param1;
      }
      
      public function set IsExtra(param1:int) : void
      {
         this._IsExtra = param1;
      }
      
      public function set MembershipTimeoutDate(param1:Date) : void
      {
         this._MembershipTimeoutDate = param1;
      }
      
      public function set VipTier(param1:int) : void
      {
         this._VipTier = param1;
      }
      
      public function set TotalVipDays(param1:int) : void
      {
         this._TotalVipDays = param1;
      }
      
      public function set FriendCountVip(param1:int) : void
      {
         this._FriendCountVip = param1;
      }
      
      public function set FriendCountVIP(param1:int) : void
      {
         this._FriendCountVip = param1;
      }
      
      public function set Diamonds(param1:int) : void
      {
         this._Diamonds = param1;
      }
      
      public function set PopUpStyleId(param1:int) : void
      {
         this._PopUpStyleId = param1;
      }
      
      public function set Moderator(param1:int) : void
      {
         this._Moderator = param1;
      }
      
      public function set ActorClothesRels(param1:*) : void
      {
         if(param1 is Array || param1 == null)
         {
            this._ActorClothesRels = param1;
         }
         else if((param1 as Object).hasOwnProperty("toArray"))
         {
            this._ActorClothesRels = (param1 as Object)["toArray"]();
         }
      }
      
      public function set ActorRelationships(param1:*) : void
      {
         if(param1 is Array || param1 == null)
         {
            this._ActorRelationships = param1;
         }
         else if((param1 as Object).hasOwnProperty("toArray"))
         {
            this._ActorRelationships = (param1 as Object)["toArray"]();
         }
      }
      
      public function set Eye(param1:com.moviestarplanet.moviestar.valueObjects.Eye) : void
      {
         this._Eye = param1;
      }
      
      public function set Nose(param1:com.moviestarplanet.moviestar.valueObjects.Nose) : void
      {
         this._Nose = param1;
      }
      
      public function set Mouth(param1:com.moviestarplanet.moviestar.valueObjects.Mouth) : void
      {
         this._Mouth = param1;
      }
      
      public function set EyeShadow(param1:com.moviestarplanet.moviestar.valueObjects.EyeShadow) : void
      {
         this._EyeShadow = param1;
      }
      
      public function set RoomLikes(param1:int) : void
      {
         this._RoomLikes = param1;
      }
      
      public function set Fortune(param1:int) : void
      {
         this._Fortune = param1;
      }
      
      public function set LastLogin(param1:Date) : void
      {
         this._LastLogin = param1;
      }
      
      public function get isFemale() : Boolean
      {
         return ActorUtils.isFemaleSkinSwf(this.SkinSWF);
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
      
      public function get isCeleb() : Boolean
      {
         return ActorUtils.isCeleb(this.FriendCountVip);
      }
      
      public function get isVip() : Boolean
      {
         return ActorUtils.isVip(this.MembershipTimeoutDate);
      }
      
      public function set MembershipPurchasedDate(param1:Object) : void
      {
      }
      
      public function set BoyfriendId(param1:Object) : void
      {
      }
      
      public function set BoyfriendStatus(param1:Object) : void
      {
      }
      
      public function set ThemeID(param1:Object) : void
      {
      }
      
      public function createActorMinimalFromActor() : ActorMinimal
      {
         var _loc1_:AppearanceData = new AppearanceData();
         _loc1_.createFromObject(AppearanceUtil.getAppearanceData(this,this.ActorClothesRels));
         _loc1_.ActorClothesRel = this.ActorClothesRels;
         var _loc2_:ActorMinimal = new ActorMinimal();
         _loc2_.setMembershipTimeoutDate(this.MembershipTimeoutDate);
         _loc2_.setAppearanceData(_loc1_);
         _loc2_.setName(this.Name);
         _loc2_.setLevel(this.Level);
         _loc2_.setSWF(this.SkinSWF);
         _loc2_.setModerator(this.Moderator);
         return _loc2_;
      }
   }
}

