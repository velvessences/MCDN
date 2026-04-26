package com.moviestarplanet.chatCommunicator.chatHelpers.model.valueobjects
{
   import flash.utils.ByteArray;
   
   public class ActorCommunicationVO
   {
      
      public var soGUID:String;
      
      public var actorId:Number;
      
      public var actorName:String;
      
      public var actorAction:String;
      
      public var posX:Number;
      
      public var posY:Number;
      
      public var animation:String;
      
      public var message:String;
      
      public var faceExpresion:String;
      
      public var facing:String;
      
      public var cacheId:int;
      
      public var clickItemIdString:String;
      
      public var effect:String;
      
      public var trickIdx:int = -1;
      
      public var blacklistedMessage:String;
      
      public var whitelistedMessage:String;
      
      public var client:int = -1;
      
      public var bonsterAnimation:String;
      
      public var petId:int;
      
      public var petType:int;
      
      public var compressedActorData:ByteArray;
      
      public function ActorCommunicationVO(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            this.soGUID = param1.soGUID;
            this.actorId = param1.actorId;
            this.actorAction = param1.actorAction;
            this.posX = param1.posX;
            this.posY = param1.posY;
            this.animation = param1.animation;
            this.message = param1.message;
            this.faceExpresion = param1.faceExpresion;
            this.facing = param1.facing;
            this.cacheId = param1.cacheId;
            this.clickItemIdString = param1.clickItemIdString;
            this.effect = param1.effect;
            this.trickIdx = param1.trickIdx;
            this.blacklistedMessage = param1.blacklistedMessage;
            this.whitelistedMessage = param1.whitelistedMessage;
            this.bonsterAnimation = param1.bonsterAnimation;
            this.petId = param1.petId;
            this.petType = param1.petType;
            this.actorName = param1.actorName;
            this.compressedActorData = param1.compressedActorData;
            if(param1.hasOwnProperty("client"))
            {
               this.client = param1.client;
            }
            else
            {
               this.client = 0;
            }
         }
      }
   }
}

