package com.moviestarplanet.utils
{
   import avmplus.getQualifiedClassName;
   import flash.display.Stage;
   
   public class StageReference
   {
      
      private static var stage:Stage;
      
      public function StageReference()
      {
         super();
         throw new Error("Do not instantiate " + getQualifiedClassName(this));
      }
      
      public static function setStage(param1:Stage) : void
      {
         StageReference.stage = param1;
      }
      
      public static function getStage() : Stage
      {
         return StageReference.stage;
      }
   }
}

