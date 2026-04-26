package com.moviestarplanet.usersession.valueobjects
{
   import com.moviestarplanet.model.IActorPersonalInfo;
   
   public class ActorPersonalInfo implements IActorPersonalInfo
   {
      
      public var ActorId:int;
      
      public var BirthDate:Date;
      
      public var ParentEmail:String;
      
      public var ChatAllowed:int;
      
      public var ActorEmailAllowed:int;
      
      public var BirthMonth:int;
      
      public var BirthYear:int;
      
      public var ParentConsentEmailSent:Boolean;
      
      public var UserEmailParentOptOut:Boolean;
      
      public var ParentEmailConfirmed:Boolean;
      
      public var RealBirthdayCollected:Boolean;
      
      public var YoutubeAllowed:Boolean;
      
      public function ActorPersonalInfo()
      {
         super();
      }
      
      public function get birthDate() : Date
      {
         return this.BirthDate;
      }
      
      public function get parentEmail() : String
      {
         return this.ParentEmail;
      }
      
      public function get chatAllowed() : int
      {
         return this.ChatAllowed;
      }
      
      public function get youtubeAllowed() : Boolean
      {
         return this.YoutubeAllowed;
      }
      
      public function get emailAllowed() : int
      {
         return this.ActorEmailAllowed;
      }
   }
}

