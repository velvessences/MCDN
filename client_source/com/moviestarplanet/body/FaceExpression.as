package com.moviestarplanet.body
{
   public class FaceExpression
   {
      
      public var key:String;
      
      public var label:String;
      
      public var eyes:String;
      
      public var mouth:String;
      
      public function FaceExpression(param1:String, param2:String, param3:String, param4:String)
      {
         super();
         this.key = param1;
         this.label = param2;
         this.eyes = param3;
         this.mouth = param4;
      }
   }
}

