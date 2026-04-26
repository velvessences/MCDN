package com.moviestarplanet.moviestar.valueObjects
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.model.valueobjects.IActorMinimal;
   import com.moviestarplanet.moviestar.utils.AppearanceData;
   
   public class ActorMinimal implements IActorMinimal
   {
      
      public var petId:int;
      
      public var petType:int;
      
      public var skinSWF:String;
      
      public var actorName:String;
      
      public var level:int;
      
      public var posX:int;
      
      public var posY:int;
      
      public var animation:String;
      
      public var faceExpression:String;
      
      public var membershipTimeoutDate:Date;
      
      public var appearanceData:AppearanceData;
      
      public var moderator:int;
      
      public function ActorMinimal(param1:String = "stand", param2:String = "neutral")
      {
         super();
         this.animation = param1;
         this.faceExpression = param2;
      }
      
      public function getAppearanceData() : Object
      {
         return this.appearanceData;
      }
      
      public function getName() : String
      {
         return this.actorName;
      }
      
      public function getPetId() : int
      {
         return this.petId;
      }
      
      public function getPetType() : int
      {
         return this.petType;
      }
      
      public function getFaceExpression() : String
      {
         return this.faceExpression;
      }
      
      public function getAnimation() : String
      {
         return this.animation;
      }
      
      public function getActorId() : int
      {
         return this.appearanceData.actorId;
      }
      
      public function getLevel() : int
      {
         return this.level;
      }
      
      public function getPosX() : int
      {
         return this.posX;
      }
      
      public function getPosY() : int
      {
         return this.posY;
      }
      
      public function getSkinSWF() : String
      {
         return this.skinSWF;
      }
      
      public function getMembershipTimeoutDate() : Date
      {
         return this.membershipTimeoutDate;
      }
      
      public function getModerator() : int
      {
         return this.moderator;
      }
      
      public function setMembershipTimeoutDate(param1:Date) : void
      {
         this.membershipTimeoutDate = param1;
      }
      
      public function setAnimation(param1:String) : void
      {
         this.animation = param1;
      }
      
      public function setPetId(param1:int) : void
      {
         this.petId = param1;
      }
      
      public function setPetType(param1:int) : void
      {
         this.petType = param1;
      }
      
      public function setFaceExpression(param1:String) : void
      {
         this.faceExpression = param1;
      }
      
      public function setPosition(param1:int, param2:int) : void
      {
         this.posX = param1;
         this.posY = param2;
      }
      
      public function setPetInfo(param1:int, param2:int) : void
      {
         this.petId = param1;
         this.petType = param2;
      }
      
      public function setAppearanceData(param1:Object) : void
      {
         this.appearanceData = param1 as AppearanceData;
      }
      
      public function setName(param1:String) : void
      {
         this.actorName = param1;
      }
      
      public function setLevel(param1:int) : void
      {
         this.level = param1;
      }
      
      public function setSWF(param1:String) : void
      {
         this.skinSWF = param1;
      }
      
      public function setModerator(param1:int) : void
      {
         this.moderator = param1;
      }
      
      public function destroy() : void
      {
         if(this.appearanceData != null)
         {
            this.appearanceData.destroy();
         }
      }
   }
}

