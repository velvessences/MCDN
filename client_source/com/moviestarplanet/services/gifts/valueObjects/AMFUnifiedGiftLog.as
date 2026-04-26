package com.moviestarplanet.services.gifts.valueObjects
{
   import com.moviestarplanet.media.valueobjects.ActorAnimationRel;
   import com.moviestarplanet.media.valueobjects.ActorBackgroundRel;
   import com.moviestarplanet.moviestar.valueObjects.ActorClothesRel;
   
   public class AMFUnifiedGiftLog
   {
      
      public var ActorAnimationRelation:ActorAnimationRel;
      
      public var ActorBackgroundRelation:ActorBackgroundRel;
      
      public var ActorClothesAndItemRelation:ActorClothesRel;
      
      public var GiftCategory:int;
      
      public var GiftLogId:int;
      
      public function AMFUnifiedGiftLog()
      {
         super();
      }
   }
}

