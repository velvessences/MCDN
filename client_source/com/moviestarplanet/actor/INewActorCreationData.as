package com.moviestarplanet.actor
{
   public interface INewActorCreationData
   {
      
      function getChosenActorName() : String;
      
      function getChosenPassword() : String;
      
      function getSkinIsMale() : Boolean;
      
      function getSkinColor() : String;
      
      function getEyeId() : int;
      
      function getEyeColors() : String;
      
      function getMouthId() : int;
      
      function getMouthColors() : String;
      
      function getNoseId() : int;
      
      function getInvitedByActorId() : int;
      
      function getClothes() : Array;
   }
}

