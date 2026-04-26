package com.moviestarplanet.model
{
   import com.moviestarplanet.actor.IGenderSpecific;
   
   public interface IActorModel extends IGenderSpecific
   {
      
      function get isLoggedIn() : Boolean;
      
      function get actorId() : int;
      
      function get actorName() : String;
      
      function get actorPassword() : String;
      
      function get isVip() : Boolean;
      
      function get isCeleb() : Boolean;
      
      function get isJudge() : Boolean;
      
      function get isJury() : Boolean;
      
      function get age() : Number;
      
      function get money() : int;
      
      function get diamonds() : int;
      
      function get isAgeRestrictions() : Boolean;
      
      function get isModerator() : Boolean;
      
      function get isModeratorHidden() : Boolean;
      
      function get lastLogin() : Date;
      
      function get actorPersonalInfo() : IActorPersonalInfo;
      
      function get VipTier() : int;
      
      function get actorRelationships() : Array;
      
      function get level() : int;
      
      function get membershipTimeOutDate() : Date;
      
      function get membershipPurchasedDate() : Date;
      
      function get skinColor() : String;
      
      function get eyeColors() : String;
      
      function get eyeId() : int;
      
      function get eyeShadowColors() : String;
      
      function get eyeShadowId() : int;
      
      function get mouthColors() : String;
      
      function isBoyfriend(param1:int) : Boolean;
      
      function isBestfriend(param1:int) : Boolean;
      
      function isBlockedOrBlocking(param1:int) : Boolean;
      
      function isBlocking(param1:int) : Boolean;
      
      function isBlocked(param1:int) : Boolean;
      
      function get fortune() : Number;
      
      function get roomLikes() : int;
      
      function get fame() : Number;
      
      function get friendCount() : int;
      
      function get isExtra() : int;
   }
}

