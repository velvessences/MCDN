package com.moviestarplanet.moviestar.valueObjects
{
   import com.moviestarplanet.actor.IClothInfo;
   import com.moviestarplanet.actorutils.ClothInfoUtils;
   import com.moviestarplanet.body.ILoadable;
   import com.moviestarplanet.color.IColorable;
   import com.moviestarplanet.utils.DateUtils;
   
   public class Cloth implements IClothInfo, ILoadable, IColorable
   {
      
      private var _ClothesId:int;
      
      private var _Name:String;
      
      private var _SWF:String;
      
      private var _ClothesCategoryId:int;
      
      private var _Price:int;
      
      private var _ShopId:int;
      
      private var _SkinId:int;
      
      private var _Filename:String;
      
      private var _Scale:Number;
      
      private var _Vip:int;
      
      private var _RegNewUser:int;
      
      private var _sortorder:int;
      
      private var _isNew:int;
      
      private var _Discount:int;
      
      private var _MouseAction:int;
      
      private var _DiamondsPrice:int;
      
      private var _AvailableUntil:Date;
      
      private var _LastUpdated:Date;
      
      private var _ColorScheme:String;
      
      private var _ClothesCategory:com.moviestarplanet.moviestar.valueObjects.ClothesCategory;
      
      private var _ThemeId:int;
      
      private var _currentColorString:String;
      
      public function Cloth()
      {
         super();
      }
      
      public function get ClothesId() : int
      {
         return this._ClothesId;
      }
      
      public function get Name() : String
      {
         return this._Name;
      }
      
      public function get SWF() : String
      {
         return this._SWF;
      }
      
      public function get ClothesCategoryId() : int
      {
         return this._ClothesCategoryId;
      }
      
      public function get Price() : int
      {
         return this._Price;
      }
      
      public function get ShopId() : int
      {
         return this._ShopId;
      }
      
      public function get SkinId() : int
      {
         return this._SkinId;
      }
      
      public function get Filename() : String
      {
         return this._Filename;
      }
      
      public function get Scale() : Number
      {
         return this._Scale;
      }
      
      public function get Vip() : int
      {
         return this._Vip;
      }
      
      public function get RegNewUser() : int
      {
         return this._RegNewUser;
      }
      
      public function get sortorder() : int
      {
         return this._sortorder;
      }
      
      public function get isNew() : int
      {
         return this._isNew;
      }
      
      public function get Discount() : int
      {
         return this._Discount;
      }
      
      public function get MouseAction() : int
      {
         return this._MouseAction;
      }
      
      public function get DiamondsPrice() : int
      {
         return this._DiamondsPrice;
      }
      
      public function get AvailableUntil() : Date
      {
         return this._AvailableUntil;
      }
      
      public function get LastUpdated() : Date
      {
         return this._LastUpdated;
      }
      
      public function get ColorScheme() : String
      {
         return this._ColorScheme;
      }
      
      public function get ClothesCategory() : com.moviestarplanet.moviestar.valueObjects.ClothesCategory
      {
         return this._ClothesCategory;
      }
      
      public function get ThemeId() : int
      {
         return this._ThemeId;
      }
      
      public function set ClothesId(param1:int) : void
      {
         this._ClothesId = param1;
      }
      
      public function set Name(param1:String) : void
      {
         this._Name = param1;
      }
      
      public function set SWF(param1:String) : void
      {
         this._SWF = param1;
      }
      
      public function set ClothesCategoryId(param1:int) : void
      {
         this._ClothesCategoryId = param1;
      }
      
      public function set Price(param1:int) : void
      {
         this._Price = param1;
      }
      
      public function set ShopId(param1:int) : void
      {
         this._ShopId = param1;
      }
      
      public function set SkinId(param1:int) : void
      {
         this._SkinId = param1;
      }
      
      public function set Filename(param1:String) : void
      {
         this._Filename = param1;
      }
      
      public function set Scale(param1:Number) : void
      {
         this._Scale = param1;
      }
      
      public function set Vip(param1:int) : void
      {
         this._Vip = param1;
      }
      
      public function set RegNewUser(param1:int) : void
      {
         this._RegNewUser = param1;
      }
      
      public function set sortorder(param1:int) : void
      {
         this._sortorder = param1;
      }
      
      public function set isNew(param1:int) : void
      {
         this._isNew = param1;
      }
      
      public function set Discount(param1:int) : void
      {
         this._Discount = param1;
      }
      
      public function set MouseAction(param1:int) : void
      {
         this._MouseAction = param1;
      }
      
      public function set DiamondsPrice(param1:int) : void
      {
         this._DiamondsPrice = param1;
      }
      
      public function set AvailableUntil(param1:Date) : void
      {
         this._AvailableUntil = param1;
      }
      
      public function set LastUpdated(param1:Date) : void
      {
         this._LastUpdated = param1;
      }
      
      public function set ColorScheme(param1:String) : void
      {
         this._ColorScheme = param1;
      }
      
      public function set ClothesCategory(param1:com.moviestarplanet.moviestar.valueObjects.ClothesCategory) : void
      {
         this._ClothesCategory = param1;
      }
      
      public function set ThemeId(param1:int) : void
      {
         this._ThemeId = param1;
      }
      
      public function get isVip() : Boolean
      {
         return this.Vip == 2;
      }
      
      public function get isLastChance() : Boolean
      {
         if(this.AvailableUntil == null)
         {
            return false;
         }
         var _loc1_:Date = new Date(this.AvailableUntil.getTime() - DateUtils.serverNow.getTime());
         var _loc2_:int = _loc1_.getTime() / 86400000 + 1;
         return 0 < _loc2_ && _loc2_ <= 7;
      }
      
      public function get isImage() : Boolean
      {
         return ClothInfoUtils.isImage(this);
      }
      
      public function get realSwfNameInner() : String
      {
         return ClothInfoUtils.getRealSwfName(this);
      }
      
      public function get path() : String
      {
         return ClothInfoUtils.getPath(this);
      }
      
      public function set MembershipPurchaseDate(param1:Object) : void
      {
      }
      
      public function set BoyfriendId(param1:Object) : void
      {
      }
      
      public function set BoyfriendStatus(param1:Object) : void
      {
      }
      
      public function set ThemeItem(param1:Object) : void
      {
      }
      
      public function set ThemeID(param1:Object) : void
      {
      }
      
      public function set colorString(param1:String) : void
      {
         this._currentColorString = param1;
      }
      
      public function get colorString() : String
      {
         return this._currentColorString;
      }
   }
}

