package com.moviestarplanet.frame.congratspopups
{
   import com.moviestarplanet.Components.ClickItems.Monster;
   import com.moviestarplanet.clickitems.ClickItem;
   import com.moviestarplanet.clickitems.ClickItemFactory;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.pet.valueobjects.ActorClickItemRel;
   import com.moviestarplanet.utils.swfmapping.PathSelector;
   import com.moviestarplanet.utils.swfmapping.PropertyMappingValue;
   import com.moviestarplanet.utils.ui.FlashInstanceUtils;
   import flash.display.MovieClip;
   
   public class InstantPetGrowAnimation extends DiamondPetPopupAnimation
   {
      
      private var pet:ClickItem;
      
      private var grownPet:ClickItem;
      
      public function InstantPetGrowAnimation(param1:ClickItem)
      {
         this.pet = ClickItemFactory.factoryImpl.create(Monster.cloneActorClickItemRel(param1.clickItemData)) as ClickItem;
         this.pet.update();
         this.pet.loadClickItemSwf(this.petLoadedHandler);
         this.grownPet = ClickItemFactory.factoryImpl.create(Monster.cloneActorClickItemRel(param1.clickItemData,true)) as ClickItem;
         this.grownPet.update();
         this.grownPet.loadClickItemSwf(this.grownPetLoadedHandler);
         super("");
         animation.addPropertyMapping(new PropertyMappingValue(new PathSelector("TextArea2"),"visible",false));
      }
      
      private function petLoadedHandler() : void
      {
         if(animation.content != null && !(animation.content.CongratsPopup.TransformationAnimation.PetContainer as MovieClip).contains(this.pet.content))
         {
            this.addPet();
         }
      }
      
      private function grownPetLoadedHandler() : void
      {
         if(animation.content != null && !(animation.content.CongratsPopup.TransformationAnimation.ChangedPetContainer as MovieClip).contains(this.grownPet.content))
         {
            this.addGrownPet();
         }
      }
      
      private function addPet() : void
      {
         FlashInstanceUtils.addContentToInstance(this.pet,animation.content.CongratsPopup.TransformationAnimation.PetContainer,true,true);
         FlashInstanceUtils.centerItem(this.pet.content,animation.content.CongratsPopup.TransformationAnimation.PetContainer);
      }
      
      private function addGrownPet() : void
      {
         FlashInstanceUtils.addContentToInstance(this.grownPet,animation.content.CongratsPopup.TransformationAnimation.ChangedPetContainer,true,true);
         FlashInstanceUtils.centerItem(this.grownPet.content,animation.content.CongratsPopup.TransformationAnimation.ChangedPetContainer);
      }
      
      override protected function animationLoaded(param1:MsgEvent) : void
      {
         super.animationLoaded(param1);
         if(this.pet.content != null && !(animation.content.CongratsPopup.TransformationAnimation.PetContainer as MovieClip).contains(this.pet.content))
         {
            this.addPet();
         }
         if(this.grownPet.content != null && !(animation.content.CongratsPopup.TransformationAnimation.ChangedPetContainer as MovieClip).contains(this.grownPet.content))
         {
            this.addGrownPet();
         }
      }
      
      override protected function get finalPetClickItemData() : ActorClickItemRel
      {
         return this.grownPet.clickItemData;
      }
   }
}

