package com.moviestarplanet.assetManager
{
   public class UnionRep
   {
      
      private namespace AssetManagerNS = "AssetManager";
      
      private static const onlyHere:String = "ONLY HERE";
      
      §§namespace("AssetManager") static var instance:UnionRep = new UnionRep(onlyHere);
      
      public function UnionRep(param1:String)
      {
         super();
         if(param1 !== onlyHere)
         {
            throw new Error("UnionRep: you know what you did");
         }
      }
   }
}

