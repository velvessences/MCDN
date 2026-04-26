package com.moviestarplanet.moviestar.utils
{
   import com.moviestarplanet.commoninterfaces.IRegistrator;
   import com.moviestarplanet.moviestar.valueObjects.Actor;
   import com.moviestarplanet.moviestar.valueObjects.ActorClothesRel;
   import com.moviestarplanet.moviestar.valueObjects.Cloth;
   import com.moviestarplanet.moviestar.valueObjects.ClothesCategory;
   import com.moviestarplanet.moviestar.valueObjects.Design;
   import com.moviestarplanet.moviestar.valueObjects.Eye;
   import com.moviestarplanet.moviestar.valueObjects.EyeShadow;
   import com.moviestarplanet.moviestar.valueObjects.Mouth;
   import com.moviestarplanet.moviestar.valueObjects.Nose;
   import com.moviestarplanet.moviestar.valueObjects.RegisterNewUserData;
   import com.moviestarplanet.moviestar.valueObjects.SlotType;
   import flash.net.registerClassAlias;
   
   public class MovieStarRegistrator implements IRegistrator
   {
      
      private static var hasRegistered:Boolean;
      
      public function MovieStarRegistrator()
      {
         super();
      }
      
      public function registerClassAliases() : void
      {
         if(!hasRegistered)
         {
            registerClassAlias("MovieStarPlanet.DBML.ActorClothesContextRel",ActorClothesRel);
            registerClassAlias("ActorClothesRel",ActorClothesRel);
            registerClassAlias("Cloth",Cloth);
            registerClassAlias("ClothesCategory",ClothesCategory);
            registerClassAlias("SlotType",SlotType);
            registerClassAlias("Actor",Actor);
            registerClassAlias("Eye",Eye);
            registerClassAlias("EyeShadow",EyeShadow);
            registerClassAlias("Nose",Nose);
            registerClassAlias("Mouth",Mouth);
            registerClassAlias("Date",Date);
            registerClassAlias("Design",Design);
            registerClassAlias("RegisterNewUserData",RegisterNewUserData);
            hasRegistered = true;
         }
      }
   }
}

