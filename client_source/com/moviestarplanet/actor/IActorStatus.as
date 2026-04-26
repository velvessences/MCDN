package com.moviestarplanet.actor
{
   public interface IActorStatus
   {
      
      function get actorId() : int;
      
      function get soundMute() : Boolean;
      
      function get campaignViewed() : int;
      
      function get mobileStartAward() : int;
      
      function get fameLevelConvert() : Boolean;
      
      function get notificationActive() : Boolean;
      
      function get photoShareRulesAccepted() : Boolean;
      
      function set photoShareRulesAccepted(param1:Boolean) : void;
      
      function get logOutWhenClickingExternalAppLinkAccepted() : Boolean;
      
      function set logOutWhenClickingExternalAppLinkAccepted(param1:Boolean) : void;
   }
}

