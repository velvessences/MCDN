package com.moviestarplanet.Forms.world
{
   import com.moviestarplanet.Forms.world.elements.ShoppingElement;
   import com.moviestarplanet.Forms.world.elements.WorldArea;
   import com.moviestarplanet.model.ActorSession;
   import mx.core.UIComponent;
   
   public class ShoppingMap extends LocalMap
   {
      
      private var boysOnly:Array = [ShoppingElement.FASHION_BOY,ShoppingElement.BEAUTYCLINIC_BOY];
      
      private var girlsOnly:Array = [ShoppingElement.FASHION_GIRL,ShoppingElement.BEAUTYCLINIC_GIRL];
      
      public function ShoppingMap(param1:WorldArea)
      {
         super(param1);
      }
      
      override protected function registerMapElement(param1:String, param2:String, param3:Function) : UIComponent
      {
         if(ActorSession.loggedInActor.isFemale)
         {
            if(hideMapObjectContaining(this.boysOnly,param1))
            {
               return null;
            }
         }
         else if(hideMapObjectContaining(this.girlsOnly,param1))
         {
            return null;
         }
         return super.registerMapElement(param1,param2,param3);
      }
   }
}

