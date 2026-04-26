package com.moviestarplanet.clickitems
{
   import com.moviestarplanet.pet.valueobjects.ActorClickItemRel;
   import flash.display.DisplayObject;
   
   public class ClickItemFactoryImpl
   {
      
      public function ClickItemFactoryImpl()
      {
         super();
      }
      
      public static function isClickItemPlant(param1:ActorClickItemRel) : Boolean
      {
         if(param1.ClickItemId == 6 || param1.ClickItemId == 8)
         {
            return true;
         }
         return false;
      }
      
      public function create(param1:ActorClickItemRel) : DisplayObject
      {
         throw new Error("Unknown ClickItemId = " + param1.ClickItemId.toString());
      }
   }
}

