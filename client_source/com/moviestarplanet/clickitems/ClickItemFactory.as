package com.moviestarplanet.clickitems
{
   import com.moviestarplanet.pet.valueobjects.ActorClickItemRel;
   import flash.display.DisplayObject;
   
   public class ClickItemFactory
   {
      
      public static var factoryImpl:ClickItemFactoryImpl = new ClickItemFactoryImpl();
      
      public function ClickItemFactory()
      {
         super();
      }
      
      public static function create(param1:ActorClickItemRel) : DisplayObject
      {
         return factoryImpl.create(param1);
      }
   }
}

