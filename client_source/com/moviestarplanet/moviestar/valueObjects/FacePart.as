package com.moviestarplanet.moviestar.valueObjects
{
   public class FacePart
   {
      
      public var SWF:String;
      
      public var DiamondsPrice:int;
      
      public var Name:String;
      
      public var Price:int;
      
      public var Vip:int;
      
      public var DragonBone:Boolean;
      
      public var Discount:int;
      
      public var isNew:int;
      
      public var sortorder:int;
      
      public var RegNewUser:int;
      
      public var SkinId:int;
      
      public var DefaultColors:String;
      
      public var hidden:Boolean;
      
      public var lastNewTagDate:Date;
      
      public function FacePart()
      {
         super();
      }
      
      public function get type() : String
      {
         throw new Error("Override in subclass");
      }
      
      public function get SWFLocation() : String
      {
         throw new Error("Override in subclass");
      }
      
      public function get initialAnimation() : String
      {
         return null;
      }
   }
}

