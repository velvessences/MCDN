package com.moviestarplanet.moviestar.valueObjects
{
   public class Nose extends FacePart
   {
      
      public static const TYPE:String = "nose";
      
      public var NoseId:int;
      
      public function Nose()
      {
         super();
      }
      
      override public function get type() : String
      {
         return TYPE;
      }
      
      override public function get SWFLocation() : String
      {
         return "noses/" + SWF;
      }
   }
}

