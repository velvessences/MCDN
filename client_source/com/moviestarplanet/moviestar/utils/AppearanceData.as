package com.moviestarplanet.moviestar.utils
{
   import com.moviestarplanet.moviestar.valueObjects.*;
   
   public class AppearanceData
   {
      
      public var actorId:int;
      
      public var SkinColor:String;
      
      public var EyeColors:String;
      
      public var MouthColors:String;
      
      public var EyeShadowColors:String;
      
      public var ActorClothesRel:Array;
      
      public var ClothesMin:Array;
      
      public var Eye:com.moviestarplanet.moviestar.valueObjects.Eye;
      
      public var Nose:com.moviestarplanet.moviestar.valueObjects.Nose;
      
      public var Mouth:com.moviestarplanet.moviestar.valueObjects.Mouth;
      
      public var EyeShadow:com.moviestarplanet.moviestar.valueObjects.EyeShadow;
      
      public function AppearanceData()
      {
         super();
      }
      
      public function createFromObject(param1:Object) : void
      {
         this.actorId = param1.actorId;
         this.SkinColor = param1.SkinColor;
         this.EyeColors = param1.EyeColors;
         this.MouthColors = param1.MouthColors;
         this.EyeShadowColors = param1.EyeShadowColors;
         this.ClothesMin = param1.ClothesMin;
         this.Eye = param1.Eye;
         this.Nose = param1.Nose;
         this.Mouth = param1.Mouth;
         this.EyeShadow = param1.EyeShadow;
      }
      
      public function destroy() : void
      {
         if(this.ActorClothesRel != null)
         {
            this.ActorClothesRel.length = 0;
            this.ActorClothesRel = null;
         }
         if(this.ClothesMin != null)
         {
            this.ClothesMin.length = 0;
            this.ClothesMin = null;
         }
         this.Eye = null;
         this.Nose = null;
         this.Mouth = null;
         this.EyeShadow = null;
      }
   }
}

