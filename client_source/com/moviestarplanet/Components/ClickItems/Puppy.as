package com.moviestarplanet.Components.ClickItems
{
   import com.moviestarplanet.pet.valueobjects.ActorClickItemRel;
   
   public class Puppy extends Pet
   {
      
      public function Puppy(param1:ActorClickItemRel)
      {
         super(param1);
         monsterGraphicsDriver.adjustConfigurationOptions(param1.ClickItemId);
      }
   }
}

