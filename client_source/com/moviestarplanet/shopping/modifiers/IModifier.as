package com.moviestarplanet.shopping.modifiers
{
   public interface IModifier
   {
      
      function getResourceId() : String;
      
      function getIconUrl() : String;
      
      function getColorChange() : uint;
      
      function getPriceMultiplier() : Number;
   }
}

