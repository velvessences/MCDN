package com.moviestarplanet.pet.valueobjects
{
   public class PetLocation
   {
      
      public var actorClickItemRelId:int;
      
      public var x:int;
      
      public var y:int;
      
      public function PetLocation(param1:int, param2:int, param3:int)
      {
         super();
         this.actorClickItemRelId = param1;
         this.x = param2;
         this.y = param3;
      }
   }
}

