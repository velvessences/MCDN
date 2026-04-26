package com.moviestarplanet.anchorCharacters.valueobjects
{
   public class AnchorCharacterInfoVO
   {
      
      public static const TYPE_ANCHOR:int = 1;
      
      public static const TYPE_SPONSORED:int = 2;
      
      public static const TYPE_MSP_CHARACTER:int = 3;
      
      public var ActorId:int;
      
      public var Name:String;
      
      public var IsSponsored:Boolean;
      
      public var CanUseInContent:Boolean;
      
      public var IsOnline:Boolean;
      
      public var LastUpdated:Date;
      
      public var ReactivationMessage:String;
      
      public var WelcomeMessage:String;
      
      public var CharacterType:int;
      
      public function AnchorCharacterInfoVO()
      {
         super();
      }
   }
}

