package com.moviestarplanet.actor
{
   public interface IActor extends IActorBase
   {
      
      function get isDeleted() : Boolean;
      
      function get isJudge() : Boolean;
      
      function get isJury() : Boolean;
      
      function get isCeleb() : Boolean;
   }
}

