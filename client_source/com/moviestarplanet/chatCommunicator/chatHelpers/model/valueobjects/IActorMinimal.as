package com.moviestarplanet.chatCommunicator.chatHelpers.model.valueobjects
{
   public interface IActorMinimal
   {
      
      function getAppearanceData() : Object;
      
      function getName() : String;
      
      function getPetId() : int;
      
      function getPetType() : int;
      
      function getFaceExpression() : String;
      
      function getAnimation() : String;
      
      function getActorId() : int;
      
      function getLevel() : int;
      
      function getPosX() : int;
      
      function getPosY() : int;
      
      function setPosition(param1:int, param2:int) : void;
      
      function setAnimation(param1:String) : void;
      
      function setPetId(param1:int) : void;
      
      function setPetType(param1:int) : void;
      
      function setFaceExpression(param1:String) : void;
      
      function setAppearanceData(param1:Object) : void;
      
      function setName(param1:String) : void;
      
      function setLevel(param1:int) : void;
      
      function setSWF(param1:String) : void;
      
      function destroy() : void;
   }
}

