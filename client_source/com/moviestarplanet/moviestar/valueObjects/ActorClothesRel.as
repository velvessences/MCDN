package com.moviestarplanet.moviestar.valueObjects
{
   import com.moviestarplanet.body.Const;
   import com.moviestarplanet.body.IAttachable;
   import com.moviestarplanet.body.IDesign;
   import com.moviestarplanet.body.IDesignable;
   import com.moviestarplanet.body.ILoadable;
   import com.moviestarplanet.clothes.IClothesRel;
   
   public class ActorClothesRel implements IAttachable, IDesignable, IClothesRel
   {
      
      private var _ActorClothesRelId:int;
      
      private var _ActorId:int;
      
      private var _ClothesId:int;
      
      private var _Color:String;
      
      private var _IsWearing:int;
      
      private var _x:int;
      
      private var _y:int;
      
      private var _DesignId:*;
      
      private var _Cloth:com.moviestarplanet.moviestar.valueObjects.Cloth;
      
      private var _Design:com.moviestarplanet.moviestar.valueObjects.Design;
      
      public function ActorClothesRel()
      {
         super();
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
         return this._Color;
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
      
      public function get DesignId() : *
      {
         if(this._DesignId == null && this._Design != null)
         {
            this._DesignId = this._Design.DesignId;
         }
         return this._DesignId;
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
      
      public function set DesignId(param1:*) : void
      {
         this._DesignId = param1;
      }
      
      public function get Loadable() : ILoadable
      {
         return this.Cloth;
      }
      
      public function get Cloth() : com.moviestarplanet.moviestar.valueObjects.Cloth
      {
         return this._Cloth;
      }
      
      public function set Cloth(param1:com.moviestarplanet.moviestar.valueObjects.Cloth) : void
      {
         this._Cloth = param1;
      }
      
      public function get Design() : com.moviestarplanet.moviestar.valueObjects.Design
      {
         return this._Design;
      }
      
      public function set Design(param1:com.moviestarplanet.moviestar.valueObjects.Design) : void
      {
         this._Design = param1;
      }
      
      public function get CategoryId() : int
      {
         return this.Cloth.ClothesCategoryId;
      }
      
      public function get isHair() : Boolean
      {
         return this._Cloth.ClothesCategoryId == 1;
      }
      
      public function get isHeadwear() : Boolean
      {
         var _loc1_:int = this.Cloth.ClothesCategoryId;
         return _loc1_ == 13 || _loc1_ == 14 || _loc1_ == 15;
      }
      
      public function get isFootwear() : Boolean
      {
         var _loc1_:int = this.Cloth.ClothesCategoryId;
         return _loc1_ == Const.CLOTHES_CATEGORY_SMALL_HIGHHEEL || _loc1_ == Const.CLOTHES_CATEGORY_LARGE_HIGHHEEL || _loc1_ == Const.CLOTHES_CATEGORY_SMALL_FOOTWEAR || _loc1_ == Const.CLOTHES_CATEGORY_LARGE_FOOTWEAR;
      }
      
      public function get isHighHeel() : Boolean
      {
         var _loc1_:int = this.Cloth.ClothesCategoryId;
         return _loc1_ == Const.CLOTHES_CATEGORY_SMALL_HIGHHEEL || _loc1_ == Const.CLOTHES_CATEGORY_LARGE_HIGHHEEL;
      }
      
      public function get isWearable() : Boolean
      {
         return !this.Cloth.isImage;
      }
      
      public function GetDesign() : IDesign
      {
         return this._Design;
      }
      
      public function hasDesign() : Boolean
      {
         return this._Design != null;
      }
      
      public function attach() : void
      {
         this.IsWearing = 1;
      }
      
      public function getClothesName() : String
      {
         if(this.hasDesign())
         {
            return this.Design.filteredName;
         }
         return this.Cloth.Name;
      }
      
      public function getCloth() : ILoadable
      {
         return this.Cloth;
      }
      
      public function getColor() : String
      {
         return this.Color;
      }
   }
}

