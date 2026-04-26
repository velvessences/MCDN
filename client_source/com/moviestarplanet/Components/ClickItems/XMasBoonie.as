package com.moviestarplanet.Components.ClickItems
{
   import com.moviestarplanet.pet.valueobjects.ActorClickItemRel;
   
   public class XMasBoonie extends Pet
   {
      
      public function XMasBoonie(param1:ActorClickItemRel)
      {
         super(param1);
         monsterGraphicsDriver.adjustConfigurationOptions(param1.ClickItemId);
      }
   }
}

