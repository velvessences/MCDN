package com.moviestarplanet.usersession.valueobjects
{
   import com.moviestarplanet.actor.IActorStatus;
   
   public class ActorStatus implements IActorStatus
   {
      
      public var ActorId:int;
      
      public var SoundMute:Boolean;
      
      public var CampaignViewed:int;
      
      public var MobileStartAward:int;
      
      public var FameLevelConvert:Boolean;
      
      public var NotificationActive:Boolean;
      
      public var PhotoShareRulesAccepted:Boolean;
      
      public var ArtbookShareRulesAccepted:Boolean;
      
      public var LogOutWhenClickingExternalAppLinkAccepted:Boolean;
      
      public var AnchorFriendshipAccepted:Boolean;
      
      public var AnchorGiftsGiven:int;
      
      public var ThirdPartyCreation:Boolean;
      
      public var PreviousLoginDate:Date;
      
      public function ActorStatus()
      {
         super();
      }
      
      public function get actorId() : int
      {
         return this.ActorId;
      }
      
      public function get soundMute() : Boolean
      {
         return this.SoundMute;
      }
      
      public function get campaignViewed() : int
      {
         return this.CampaignViewed;
      }
      
      public function get mobileStartAward() : int
      {
         return this.MobileStartAward;
      }
      
      public function get fameLevelConvert() : Boolean
      {
         return this.FameLevelConvert;
      }
      
      public function get notificationActive() : Boolean
      {
         return this.NotificationActive;
      }
      
      public function get photoShareRulesAccepted() : Boolean
      {
         return this.PhotoShareRulesAccepted;
      }
      
      public function set photoShareRulesAccepted(param1:Boolean) : void
      {
         this.PhotoShareRulesAccepted = param1;
      }
      
      public function get artbookShareRulesAccepted() : Boolean
      {
         return this.ArtbookShareRulesAccepted;
      }
      
      public function set artbookShareRulesAccepted(param1:Boolean) : void
      {
         this.ArtbookShareRulesAccepted = param1;
      }
      
      public function get logOutWhenClickingExternalAppLinkAccepted() : Boolean
      {
         return this.LogOutWhenClickingExternalAppLinkAccepted;
      }
      
      public function set logOutWhenClickingExternalAppLinkAccepted(param1:Boolean) : void
      {
         this.LogOutWhenClickingExternalAppLinkAccepted = param1;
      }
   }
}

