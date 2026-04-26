package com.moviestarplanet.clothes
{
   import com.moviestarplanet.body.ILoadable;
   
   public interface IClothesRel
   {
      
      function getCloth() : ILoadable;
      
      function getColor() : String;
   }
}

