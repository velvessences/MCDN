package com.moviestarplanet.moviestar.valueObjects
{
   public class Mouth extends FacePart
   {
      
      public static const TYPE:String = "mouth";
      
      public var MouthId:int;
      
      public function Mouth()
      {
         super();
      }
      
      override public function get type() : String
      {
         return TYPE;
      }
      
      override public function get SWFLocation() : String
      {
         return "mouths/" + SWF;
      }
      
      override public function get initialAnimation() : String
      {
         return "MouthStatic";
      }
   }
}

