package com.moviestarplanet.Forms.world
{
   import com.moviestarplanet.Forms.world.elements.PetElement;
   import com.moviestarplanet.Forms.world.elements.WorldArea;
   import com.moviestarplanet.services.wrappers.SessionService;
   import mx.core.UIComponent;
   
   public class PetMap extends LocalMap
   {
      
      private var showPetRedeem:Boolean;
      
      public function PetMap(param1:WorldArea)
      {
         super(param1);
         SessionService.GetAppSetting("worldpetmagazine",this.setShowPetRedeem);
      }
      
      override protected function registerMapElement(param1:String, param2:String, param3:Function) : UIComponent
      {
         if(this.showPetRedeem == false)
         {
            if(hideMapObjectContaining([PetElement.PETREDEEM],param1))
            {
               return null;
            }
         }
         return super.registerMapElement(param1,param2,param3);
      }
      
      private function setShowPetRedeem(param1:String) : void
      {
         this.showPetRedeem = param1 == "true";
      }
   }
}

