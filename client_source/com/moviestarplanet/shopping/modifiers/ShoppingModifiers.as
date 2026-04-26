package com.moviestarplanet.shopping.modifiers
{
   import flash.utils.Dictionary;
   
   public class ShoppingModifiers
   {
      
      private static var self:ShoppingModifiers;
      
      public static const MODIFIER_LAST_CHANCE:int = 1;
      
      public static const MODIFIER_SHOPPING_SPREE:int = 2;
      
      private var typeToModifier:Dictionary;
      
      public function ShoppingModifiers()
      {
         super();
         this.typeToModifier = new Dictionary(true);
         this.typeToModifier[MODIFIER_LAST_CHANCE] = new ModifierLastChance();
         this.typeToModifier[MODIFIER_SHOPPING_SPREE] = new ModifierShoppingSpree();
      }
      
      public static function getModifier(param1:int) : IModifier
      {
         if(self == null)
         {
            self = new ShoppingModifiers();
         }
         return self.typeToModifier[param1];
      }
   }
}

