package com.moviestarplanet.scrapitems.valueobjects
{
   import com.moviestarplanet.scrapitems.IClipArtInfo;
   
   public class ClipArt implements IClipArtInfo
   {
      
      private var _ClipArtId:int;
      
      private var _Filename:String;
      
      private var _ClipArtCategoryId:int;
      
      private var _Vip:int;
      
      private var _Price:int;
      
      private var _ColorScheme:String;
      
      private var _DiamondsPrice:int;
      
      public var Type:int;
      
      public var Deleted:int;
      
      public var SortOrder:int;
      
      public var isNew:int;
      
      public function ClipArt()
      {
         super();
      }
      
      public function get path() : String
      {
         return ClipArtCategory.clipArtCategorySubPaths[this._ClipArtCategoryId] + "/" + this.Filename;
      }
      
      public function get colorArray() : Array
      {
         return ["0xffffff"];
      }
      
      public function get ClipArtId() : int
      {
         return this._ClipArtId;
      }
      
      public function set ClipArtId(param1:int) : void
      {
         this._ClipArtId = param1;
      }
      
      public function get Filename() : String
      {
         return this._Filename;
      }
      
      public function set Filename(param1:String) : void
      {
         this._Filename = param1;
      }
      
      public function get ClipArtCategoryId() : int
      {
         return this._ClipArtCategoryId;
      }
      
      public function set ClipArtCategoryId(param1:int) : void
      {
         this._ClipArtCategoryId = param1;
      }
      
      public function get Vip() : int
      {
         return this._Vip;
      }
      
      public function set Vip(param1:int) : void
      {
         this._Vip = param1;
      }
      
      public function get Price() : int
      {
         return this._Price;
      }
      
      public function set Price(param1:int) : void
      {
         this._Price = param1;
      }
      
      public function get ColorScheme() : String
      {
         return this._ColorScheme;
      }
      
      public function set ColorScheme(param1:String) : void
      {
         this._ColorScheme = param1;
      }
      
      public function get DiamondsPrice() : int
      {
         return this._DiamondsPrice;
      }
      
      public function set DiamondsPrice(param1:int) : void
      {
         this._DiamondsPrice = param1;
      }
   }
}

