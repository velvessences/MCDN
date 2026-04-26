package com.moviestarplanet.moviestar.valueObjects
{
   public class ActorClothesRel2
   {
      
      private var _ActorClothesRelId:int;
      
      private var _ActorId:int;
      
      private var _ClothesId:int;
      
      private var _Color:String;
      
      private var _IsWearing:int;
      
      private var _x:int;
      
      private var _y:int;
      
      public function ActorClothesRel2()
      {
         super();
      }
      
      public static function CreateActorClothesRel2(param1:ActorClothesRel) : ActorClothesRel2
      {
         var _loc2_:ActorClothesRel2 = new ActorClothesRel2();
         _loc2_.ActorClothesRelId = param1.ActorClothesRelId;
         _loc2_.ActorId = param1.ActorId;
         _loc2_.ClothesId = param1.ClothesId;
         _loc2_.Color = param1.Color;
         _loc2_.IsWearing = param1.IsWearing;
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         if(_loc2_.Color == null)
         {
            _loc2_.Color = "";
         }
         return _loc2_;
      }
      
      public function get ActorClothesRelId() : int
      {
         return this._ActorClothesRelId;
      }
      
      public function get ActorId() : int
      {
         return this._ActorId;
      }
      
      public function get ClothesId() : int
      {
         return this._ClothesId;
      }
      
      public function get Color() : String
      {
         if(this._Color != null)
         {
            return this._Color;
         }
         return "";
      }
      
      public function get IsWearing() : int
      {
         return this._IsWearing;
      }
      
      public function get x() : int
      {
         return this._x;
      }
      
      public function get y() : int
      {
         return this._y;
      }
      
      public function set ActorClothesRelId(param1:int) : void
      {
         this._ActorClothesRelId = param1;
      }
      
      public function set ActorId(param1:int) : void
      {
         this._ActorId = param1;
      }
      
      public function set ClothesId(param1:int) : void
      {
         this._ClothesId = param1;
      }
      
      public function set Color(param1:String) : void
      {
         this._Color = param1;
      }
      
      public function set IsWearing(param1:int) : void
      {
         this._IsWearing = param1;
      }
      
      public function set x(param1:int) : void
      {
         this._x = param1;
      }
      
      public function set y(param1:int) : void
      {
         this._y = param1;
      }
   }
}

