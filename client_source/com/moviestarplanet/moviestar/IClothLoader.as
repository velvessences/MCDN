package com.moviestarplanet.moviestar
{
   import com.moviestarplanet.moviestar.valueObjects.ActorClothesRel;
   
   public interface IClothLoader
   {
      
      function isWearing(param1:ActorClothesRel) : Boolean;
      
      function wearCloth(param1:ActorClothesRel, param2:Function, param3:Function) : void;
   }
}

