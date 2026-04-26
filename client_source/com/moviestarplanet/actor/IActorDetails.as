package com.moviestarplanet.actor
{
   public interface IActorDetails extends IActor
   {
      
      function get GetLockedUntil() : Date;
      
      function get GetBehaviourStatus() : int;
      
      function get GetLockedText() : String;
      
      function get actorId() : int;
      
      function get vipTier() : int;
      
      function get actorStatus() : IActorStatus;
      
      function get created() : Date;
      
      function getMoney() : int;
      
      function getFame() : Number;
      
      function getDiamonds() : int;
   }
}

