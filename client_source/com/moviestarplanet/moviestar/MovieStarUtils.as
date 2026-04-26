package com.moviestarplanet.moviestar
{
   import com.moviestarplanet.moviestar.valueObjects.*;
   
   public class MovieStarUtils
   {
      
      public function MovieStarUtils()
      {
         super();
      }
      
      public static function getDataAsClothes(param1:Object) : Array
      {
         if(param1 == null)
         {
            return new Array();
         }
         if(param1.ClothesMin)
         {
            return dataToClothes(param1.ClothesMin,param1.actorId);
         }
         if(param1.ActorClothesRel)
         {
            return param1.ActorClothesRel;
         }
         return new Array();
      }
      
      internal static function dataToClothes(param1:Array, param2:int) : Array
      {
         var _loc4_:Object = null;
         var _loc5_:ActorClothesRel = null;
         var _loc3_:Array = new Array();
         for each(_loc4_ in param1)
         {
            _loc5_ = new ActorClothesRel();
            _loc5_.ActorClothesRelId = _loc4_.ActorClothesRelId;
            _loc5_.ClothesId = _loc4_.ClothesId;
            _loc5_.Color = _loc4_.Color;
            _loc5_.ActorId = param2;
            _loc5_.IsWearing = 0;
            _loc5_.x = 0;
            _loc5_.y = 0;
            _loc5_.Cloth = new Cloth();
            _loc5_.Cloth.ClothesId = _loc5_.ClothesId;
            _loc5_.Cloth.SWF = _loc4_.SWF;
            _loc5_.Cloth.Filename = _loc4_.Filename;
            _loc5_.Cloth.SkinId = _loc4_.SkinId;
            _loc5_.Cloth.Scale = _loc4_.Scale;
            _loc5_.Cloth.Discount = 0;
            _loc5_.Cloth.isNew = 0;
            _loc5_.Cloth.Price = 0;
            _loc5_.Cloth.RegNewUser = 0;
            _loc5_.Cloth.ShopId = 0;
            _loc5_.Cloth.sortorder = 0;
            _loc5_.Cloth.Vip = 0;
            _loc5_.Cloth.Name = "";
            _loc5_.Cloth.ClothesCategoryId = _loc4_.ClothesCategoryId;
            _loc5_.Cloth.ClothesCategory = ClothingCategories.categories[_loc5_.Cloth.ClothesCategoryId];
            if(_loc4_.LastUpdated)
            {
               _loc5_.Cloth.LastUpdated = _loc4_.LastUpdated;
            }
            if(_loc4_.designData)
            {
               _loc5_.Design = new Design();
               _loc5_.Design.DesignId = _loc4_.designId;
               _loc5_.DesignId = _loc4_.designId;
               _loc5_.Design.Data = _loc4_.designData;
            }
            _loc3_.push(_loc5_);
         }
         return _loc3_;
      }
   }
}

