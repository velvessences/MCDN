package com.moviestarplanet.constants
{
   public class ConstantsBrand
   {
      
      public static const MOVIE_STAR_PLANET:int = 0;
      
      public static const MY_STAR_PLANET:int = 1;
      
      public static const MOVIE_STAR_PLANET_S:String = "MovieStarPlanet";
      
      public static const MY_STAR_PLANET_S:String = "MyStarPlanet";
      
      public static const ConstToName:Array = ["MovieStarPlanet","MyStarPlanet"];
      
      public static const NameToConst:Object = {
         "MovieStarPlanet":MOVIE_STAR_PLANET,
         "MyStarPlanet":MY_STAR_PLANET
      };
      
      public function ConstantsBrand()
      {
         super();
      }
      
      public static function constToName(param1:int) : String
      {
         if(param1 == 0)
         {
            return MOVIE_STAR_PLANET_S;
         }
         return MY_STAR_PLANET_S;
      }
      
      public static function nameToConst(param1:String) : int
      {
         if(param1 == MOVIE_STAR_PLANET_S)
         {
            return 0;
         }
         return 1;
      }
   }
}

