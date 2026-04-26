package com.moviestarplanet.chatCommunicator.chatHelpers.model.valueobjects
{
   public class SharedActorBase
   {
      
      public var actorId:Number;
      
      public var actorName:String;
      
      public var message:String;
      
      public var blacklistedMessage:String;
      
      public var whitelistedMessage:String;
      
      public var lastSharedObjectGUID:String;
      
      public var lastSharedObjectAction:String;
      
      public var petId:int;
      
      public var petType:int;
      
      public var x:Number;
      
      public var y:Number;
      
      public var animation:String;
      
      public var faceAnimation:String;
      
      public var facingDirection:String;
      
      public var actor:IActorMinimal;
      
      public function SharedActorBase()
      {
         super();
      }
   }
}

