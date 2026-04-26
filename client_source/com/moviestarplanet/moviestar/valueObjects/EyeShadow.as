package com.moviestarplanet.moviestar.valueObjects
{
   public class EyeShadow extends FacePart
   {
      
      public static const TYPE:String = "eyeshadow";
      
      public var EyeShadowId:int;
      
      public function EyeShadow()
      {
         super();
         this.DragonBone = true;
      }
      
      override public function get type() : String
      {
         return TYPE;
      }
      
      override public function get SWFLocation() : String
      {
         return "eyeshadow/" + SWF;
      }
   }
}

