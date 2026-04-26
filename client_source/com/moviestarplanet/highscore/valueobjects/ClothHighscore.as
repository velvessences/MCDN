package com.moviestarplanet.highscore.valueobjects
{
   import com.moviestarplanet.actor.IClothInfo;
   import com.moviestarplanet.actorutils.ClothInfoUtils;
   import com.moviestarplanet.body.ILoadable;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.model.IActorModel;
   
   public class ClothHighscore implements ILoadable, IClothInfo
   {
      
      public var count:int;
      
      public var clothesName:String;
      
      public var categoryName:String;
      
      public var _SWF:String;
      
      public var filename:String;
      
      public var Vip:int;
      
      public var Price:int;
      
      public var clothesCategoryId:int;
      
      public var ShopId:int;
      
      public var clothesId:int;
      
      public var skinId:int;
      
      public var DiamondsPrice:int;
      
      public var AvailableUntil:Date;
      
      private var lastUpdated:Date;
      
      private var colorScheme:String;
      
      public function ClothHighscore()
      {
         super();
      }
      
      public function get isImage() : Boolean
      {
         return ClothInfoUtils.isImage(this);
      }
      
      public function get realSwfName() : String
      {
         return ClothInfoUtils.getRealSwfName(this);
      }
      
      public function get path() : String
      {
         return ClothInfoUtils.getPath(this);
      }
      
      public function get Filename() : String
      {
         return this.filename;
      }
      
      public function set Filename(param1:String) : void
      {
         this.filename = param1;
      }
      
      public function get SWF() : String
      {
         return this._SWF;
      }
      
      public function set SWF(param1:String) : void
      {
         this._SWF = param1;
      }
      
      public function get ClothesCategoryId() : int
      {
         return this.clothesCategoryId;
      }
      
      public function set ClothesCategoryId(param1:int) : void
      {
         this.clothesCategoryId = param1;
      }
      
      public function get LastUpdated() : Date
      {
         return this.lastUpdated;
      }
      
      public function set LastUpdated(param1:Date) : void
      {
         this.lastUpdated = param1;
      }
      
      public function get ColorScheme() : String
      {
         return this.colorScheme;
      }
      
      public function set ColorScheme(param1:String) : void
      {
         this.colorScheme = param1;
      }
      
      public function getAllowedToBuyType() : int
      {
         var _loc1_:IActorModel = InjectionManager.manager().getInstance(IActorModel);
         if(Boolean(_loc1_.isFemale) && this.skinId == 2)
         {
            return ClothBuyAllowedType.GENDER_MISMATCH_MALE_ITEM;
         }
         if(!_loc1_.isFemale && this.skinId == 1)
         {
            return ClothBuyAllowedType.GENDER_MISMATCH_FEMALE_ITEM;
         }
         if(this.AvailableUntil != null && this.AvailableUntil < new Date())
         {
            return ClothBuyAllowedType.EXPIRED;
         }
         return ClothBuyAllowedType.ALLOWED;
      }
   }
}

