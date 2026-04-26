package com.moviestarplanet.moviestar.valueObjects
{
   public class Eye extends FacePart
   {
      
      public static const TYPE:String = "eyes";
      
      public var EyeId:int;
      
      public function Eye()
      {
         super();
      }
      
      override public function get type() : String
      {
         return TYPE;
      }
      
      override public function get SWFLocation() : String
      {
         return "eyes/" + SWF;
      }
      
      override public function get initialAnimation() : String
      {
         return "EyesStatic";
      }
      
      public function set ThemeID(param1:Object) : void
      {
      }
   }
}

