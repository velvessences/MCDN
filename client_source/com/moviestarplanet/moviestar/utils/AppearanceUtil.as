package com.moviestarplanet.moviestar.utils
{
   import com.moviestarplanet.moviestar.ClothingCategories;
   import com.moviestarplanet.moviestar.valueObjects.*;
   
   public class AppearanceUtil
   {
      
      public function AppearanceUtil()
      {
         super();
      }
      
      public static function getAppearanceData(param1:Actor, param2:Array) : Object
      {
         var _loc3_:Object = {};
         _loc3_.actorId = param1.ActorId;
         _loc3_.ClothesMin = clothesToData(param2);
         _loc3_.SkinColor = param1.SkinColor;
         _loc3_.Eye = param1.Eye;
         _loc3_.EyeColors = param1.EyeColors;
         _loc3_.EyeShadow = param1.EyeShadow;
         _loc3_.EyeShadowColors = param1.EyeShadowColors;
         _loc3_.Nose = param1.Nose;
         _loc3_.Mouth = param1.Mouth;
         _loc3_.MouthColors = param1.MouthColors;
         return _loc3_;
      }
      
      public static function applyAppearanceData(param1:Actor, param2:Object, param3:Boolean = false) : void
      {
         param1.ActorId = param2.actorId;
         param1.SkinColor = param2.SkinColor;
         param1.Eye = eyeFromData(param2.Eye);
         param1.EyeColors = param2.EyeColors;
         param1.EyeShadow = eyeShadowFromData(param2.EyeShadow);
         param1.EyeShadowColors = param2.EyeShadowColors;
         param1.Nose = noseFromData(param2.Nose);
         param1.Mouth = mouthFromData(param2.Mouth);
         param1.MouthColors = param2.MouthColors;
         var _loc4_:Array = dataToClothes(param2.ClothesMin,param1.ActorId,param3);
         param1.ActorClothesRels = _loc4_;
      }
      
      public static function clothesToData(param1:Array) : Array
      {
         var _loc3_:ActorClothesRel = null;
         var _loc4_:Object = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in param1)
         {
            _loc4_ = new Object();
            _loc4_.ActorClothesRelId = _loc3_.ActorClothesRelId;
            _loc4_.ClothesId = _loc3_.ClothesId;
            _loc4_.Color = _loc3_.Color;
            _loc4_.SWF = _loc3_.Cloth.SWF;
            _loc4_.Filename = _loc3_.Cloth.Filename;
            _loc4_.Scale = _loc3_.Cloth.Scale;
            _loc4_.SkinId = _loc3_.Cloth.SkinId;
            _loc4_.ClothesCategoryId = _loc3_.Cloth.ClothesCategoryId;
            _loc4_.ColorScheme = _loc3_.Cloth.ColorScheme;
            _loc4_.isWearing = _loc3_.IsWearing;
            if("hasDesign" in _loc3_ && _loc3_.hasDesign())
            {
               _loc4_.designId = _loc3_.DesignId;
               _loc4_.designData = _loc3_.Design.Data;
            }
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public static function dataToClothes(param1:Array, param2:int, param3:Boolean = false) : Array
      {
         var _loc5_:Object = null;
         var _loc6_:ActorClothesRel = null;
         var _loc4_:Array = new Array();
         for each(_loc5_ in param1)
         {
            _loc6_ = new ActorClothesRel();
            _loc6_.ActorClothesRelId = _loc5_.ActorClothesRelId;
            _loc6_.ClothesId = _loc5_.ClothesId;
            _loc6_.Color = _loc5_.Color;
            _loc6_.ActorId = param2;
            if(param3)
            {
               _loc6_.IsWearing = 1;
            }
            else
            {
               _loc6_.IsWearing = _loc5_.isWearing;
            }
            _loc6_.x = 0;
            _loc6_.y = 0;
            _loc6_.Cloth = new Cloth();
            _loc6_.Cloth.ClothesId = _loc6_.ClothesId;
            _loc6_.Cloth.SWF = _loc5_.SWF;
            _loc6_.Cloth.Filename = _loc5_.Filename;
            _loc6_.Cloth.SkinId = _loc5_.SkinId;
            _loc6_.Cloth.Scale = _loc5_.Scale;
            _loc6_.Cloth.ColorScheme = _loc5_.ColorScheme;
            _loc6_.Cloth.Discount = 0;
            _loc6_.Cloth.isNew = 0;
            _loc6_.Cloth.Price = 0;
            _loc6_.Cloth.RegNewUser = 0;
            _loc6_.Cloth.ShopId = 0;
            _loc6_.Cloth.sortorder = 0;
            _loc6_.Cloth.Vip = 0;
            _loc6_.Cloth.Name = "";
            _loc6_.Cloth.LastUpdated = _loc5_.LastUpdated;
            _loc6_.Cloth.ClothesCategoryId = _loc5_.ClothesCategoryId;
            _loc6_.Cloth.ClothesCategory = ClothingCategories.categories[_loc6_.Cloth.ClothesCategoryId];
            if(_loc5_.designData)
            {
               _loc6_.Design = new Design();
               _loc6_.Design.DesignId = _loc5_.designId;
               _loc6_.DesignId = _loc5_.designId;
               _loc6_.Design.Data = _loc5_.designData;
            }
            _loc4_.push(_loc6_);
         }
         return _loc4_;
      }
      
      public static function eyeFromData(param1:Object) : Eye
      {
         var _loc2_:Eye = new Eye();
         _loc2_.EyeId = param1.EyeId;
         _loc2_.SWF = param1.SWF;
         if(param1.hasOwnProperty("DragonBone"))
         {
            _loc2_.DragonBone = param1.DragonBone;
         }
         else
         {
            _loc2_.DragonBone = false;
         }
         return _loc2_;
      }
      
      public static function noseFromData(param1:Object) : Nose
      {
         var _loc2_:Nose = new Nose();
         _loc2_.SWF = param1.SWF;
         _loc2_.NoseId = param1.NoseId;
         if(param1.hasOwnProperty("DragonBone"))
         {
            _loc2_.DragonBone = param1.DragonBone;
         }
         else
         {
            _loc2_.DragonBone = false;
         }
         return _loc2_;
      }
      
      public static function mouthFromData(param1:Object) : Mouth
      {
         var _loc2_:Mouth = new Mouth();
         _loc2_.MouthId = param1.MouthId;
         _loc2_.SWF = param1.SWF;
         if(param1.hasOwnProperty("DragonBone"))
         {
            _loc2_.DragonBone = param1.DragonBone;
         }
         else
         {
            _loc2_.DragonBone = false;
         }
         return _loc2_;
      }
      
      public static function eyeShadowFromData(param1:Object) : EyeShadow
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:EyeShadow = new EyeShadow();
         _loc2_.EyeShadowId = param1.EyeShadowId;
         _loc2_.SWF = param1.SWF;
         return _loc2_;
      }
   }
}

