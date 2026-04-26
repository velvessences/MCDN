package com.moviestarplanet.model
{
   import com.moviestarplanet.model.friends.VipTierConstants;
   
   public class ActorModel implements IActorModel
   {
      
      private static var actorModel:ActorModel;
      
      public function ActorModel()
      {
         super();
      }
      
      public static function getInstance() : ActorModel
      {
         if(actorModel == null)
         {
            actorModel = new ActorModel();
         }
         return actorModel;
      }
      
      public function get isLoggedIn() : Boolean
      {
         return ActorSession.loggedInActor != null;
      }
      
      public function get actorId() : int
      {
         return ActorSession.getActorId();
      }
      
      public function get actorName() : String
      {
         return ActorSession.actorName;
      }
      
      public function get actorPassword() : String
      {
         return ActorSession.actorPassword;
      }
      
      public function get isVip() : Boolean
      {
         return ActorSession.loggedInActor.isVip;
      }
      
      public function get isCeleb() : Boolean
      {
         return ActorSession.loggedInActor.isCeleb;
      }
      
      public function get isJudge() : Boolean
      {
         return ActorSession.loggedInActor.isJudge;
      }
      
      public function get isJury() : Boolean
      {
         return ActorSession.loggedInActor.isJury;
      }
      
      public function get VipTier() : int
      {
         if(this.isVip)
         {
            return ActorSession.loggedInActor.vipTier;
         }
         return VipTierConstants.NON_VIP;
      }
      
      public function get age() : Number
      {
         return ActorSession.age;
      }
      
      public function get money() : int
      {
         return ActorSession.loggedInActor.Money;
      }
      
      public function get diamonds() : int
      {
         return ActorSession.loggedInActor.Diamonds;
      }
      
      public function get isAgeRestrictions() : Boolean
      {
         return ActorSession.isAgeRestrictions;
      }
      
      public function get isModerator() : Boolean
      {
         return ActorSession.isModerator();
      }
      
      public function get isModeratorHidden() : Boolean
      {
         return ActorSession.isModeratorHidden();
      }
      
      public function get lastLogin() : Date
      {
         return ActorSession.loggedInActor.LastLogin;
      }
      
      public function get isFemale() : Boolean
      {
         return ActorSession.loggedInActor.isFemale;
      }
      
      public function get SkinSWF() : String
      {
         return ActorSession.loggedInActor.SkinSWF;
      }
      
      public function get actorPersonalInfo() : IActorPersonalInfo
      {
         return ActorSession.loggedInActor.ActorPersonalInfo as IActorPersonalInfo;
      }
      
      public function get level() : int
      {
         return ActorSession.loggedInActor.Level;
      }
      
      public function get actorRelationships() : Array
      {
         return ActorSession.loggedInActor.ActorRelationships.toArray();
      }
      
      public function get membershipTimeOutDate() : Date
      {
         if(ActorSession.loggedInActor != null)
         {
            return ActorSession.loggedInActor.MembershipTimeoutDate;
         }
         return null;
      }
      
      public function get membershipPurchasedDate() : Date
      {
         return ActorSession.loggedInActor.MembershipPurchasedDate;
      }
      
      public function get skinColor() : String
      {
         return ActorSession.loggedInActor.SkinColor;
      }
      
      public function get eyeColors() : String
      {
         return ActorSession.loggedInActor.EyeColors;
      }
      
      public function get eyeId() : int
      {
         return ActorSession.loggedInActor.EyeId;
      }
      
      public function get eyeShadowColors() : String
      {
         return ActorSession.loggedInActor.EyeShadowColors;
      }
      
      public function get eyeShadowId() : int
      {
         return ActorSession.loggedInActor.EyeShadowId;
      }
      
      public function get mouthColors() : String
      {
         return ActorSession.loggedInActor.MouthColors;
      }
      
      public function isBoyfriend(param1:int) : Boolean
      {
         return ActorSession.loggedInActor.IsBoyFriend(param1);
      }
      
      public function isBestfriend(param1:int) : Boolean
      {
         return ActorSession.loggedInActor.IsBestFriend(param1);
      }
      
      public function isBlockedOrBlocking(param1:int) : Boolean
      {
         return ActorSession.isBlockedOrBlocking(param1);
      }
      
      public function isBlocked(param1:int) : Boolean
      {
         return ActorSession.isBlocked(param1);
      }
      
      public function isBlocking(param1:int) : Boolean
      {
         return ActorSession.isBlocking(param1);
      }
      
      public function get fortune() : Number
      {
         return ActorSession.loggedInActor.Fortune;
      }
      
      public function get roomLikes() : int
      {
         return ActorSession.loggedInActor.RoomLikes;
      }
      
      public function get fame() : Number
      {
         return ActorSession.loggedInActor.Fame;
      }
      
      public function get friendCount() : int
      {
         return ActorSession.loggedInActor.FriendCount;
      }
      
      public function get isExtra() : int
      {
         return ActorSession.loggedInActor.IsExtra;
      }
   }
}

