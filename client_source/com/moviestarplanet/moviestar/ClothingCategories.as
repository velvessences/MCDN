package com.moviestarplanet.moviestar
{
   import com.moviestarplanet.actorutils.ICategoryInfo;
   import com.moviestarplanet.body.Const;
   import com.moviestarplanet.moviestar.valueObjects.Cloth;
   import com.moviestarplanet.moviestar.valueObjects.ClothesCategory;
   import com.moviestarplanet.moviestar.valueObjects.SlotType;
   
   public class ClothingCategories implements ICategoryInfo
   {
      
      private static var _categories:Array;
      
      public static const CATEGORY_ID_MOBILE_COMPATIBLE_ANIMATED_PROP:int = 47;
      
      public static var Accessories:ClothingType = new ClothingType([13,14,15,25,26,27,28,29,30,31,32,34,35,36,37,38,39,40,41,42,43,44,45,Const.CLOTHES_CATEGORY_DIAMOND_EFFECT],"Accessories");
      
      public static var Footwear:ClothingType = new ClothingType([Const.CLOTHES_CATEGORY_SMALL_FOOTWEAR,11,Const.CLOTHES_CATEGORY_LARGE_FOOTWEAR,Const.CLOTHES_CATEGORY_SMALL_HIGHHEEL,Const.CLOTHES_CATEGORY_LARGE_HIGHHEEL],"Footwear");
      
      public static var Hair:ClothingType = new ClothingType([Const.CLOTHES_CATEGORY_HAIR],"Hair");
      
      public static var Tops:ClothingType = new ClothingType([Const.CLOTHES_CATEGORY_SHIRTS,6,7],"Tops");
      
      public static var Bottoms:ClothingType = new ClothingType([Const.CLOTHES_CATEGORY_REGULAR_PANTS,8,9,Const.CLOTHES_CATEGORY_TIGHT_PANTS,Const.CLOTHES_CATEGORY_BAGGY_PANTS],"Bottoms");
      
      public static var AllClothesCategories:ClothingType = new ClothingType([1,2,6,7,3,8,9,10,11,12,13,14,15,25,26,27,28,29,30,31,32,34,35,36,37,38,39,40,41,42,43,44,45,Const.CLOTHES_CATEGORY_DIAMOND_EFFECT,Const.CLOTHES_CATEGORY_TIGHT_PANTS,Const.CLOTHES_CATEGORY_BAGGY_PANTS,Const.CLOTHES_CATEGORY_SMALL_HIGHHEEL,Const.CLOTHES_CATEGORY_LARGE_HIGHHEEL],"Clothes");
      
      private static const CATEGORY_VALUES:Array = [{
         "ClothesCategoryId":1,
         "Name":"Hair",
         "SlotTypeId":1
      },{
         "ClothesCategoryId":2,
         "Name":"Shirts",
         "SlotTypeId":2
      },{
         "ClothesCategoryId":3,
         "Name":"Trousers",
         "SlotTypeId":3
      },{
         "ClothesCategoryId":5,
         "Name":"Beard",
         "SlotTypeId":4
      },{
         "ClothesCategoryId":6,
         "Name":"Sweaters",
         "SlotTypeId":2
      },{
         "ClothesCategoryId":7,
         "Name":"T-shirts",
         "SlotTypeId":2
      },{
         "ClothesCategoryId":8,
         "Name":"Shorts",
         "SlotTypeId":3
      },{
         "ClothesCategoryId":9,
         "Name":"Skirts",
         "SlotTypeId":3
      },{
         "ClothesCategoryId":10,
         "Name":"Shoes",
         "SlotTypeId":5
      },{
         "ClothesCategoryId":11,
         "Name":"Sneakers",
         "SlotTypeId":5
      },{
         "ClothesCategoryId":12,
         "Name":"Boots",
         "SlotTypeId":5
      },{
         "ClothesCategoryId":13,
         "Name":"Hats",
         "SlotTypeId":6
      },{
         "ClothesCategoryId":14,
         "Name":"Caps",
         "SlotTypeId":6
      },{
         "ClothesCategoryId":15,
         "Name":"Helmets",
         "SlotTypeId":6
      },{
         "ClothesCategoryId":19,
         "Name":"Vehicles",
         "SlotTypeId":8
      },{
         "ClothesCategoryId":20,
         "Name":"Animals",
         "SlotTypeId":8
      },{
         "ClothesCategoryId":21,
         "Name":"Food",
         "SlotTypeId":8
      },{
         "ClothesCategoryId":22,
         "Name":"Instruments",
         "SlotTypeId":8
      },{
         "ClothesCategoryId":23,
         "Name":"Gadgets",
         "SlotTypeId":8
      },{
         "ClothesCategoryId":24,
         "Name":"Stuff",
         "SlotTypeId":8
      },{
         "ClothesCategoryId":25,
         "Name":"Accessories",
         "SlotTypeId":8
      },{
         "ClothesCategoryId":26,
         "Name":"Earrings",
         "SlotTypeId":9
      },{
         "ClothesCategoryId":27,
         "Name":"Glasses",
         "SlotTypeId":7
      },{
         "ClothesCategoryId":28,
         "Name":"Nosering",
         "SlotTypeId":10
      },{
         "ClothesCategoryId":29,
         "Name":"Hairthingright",
         "SlotTypeId":11
      },{
         "ClothesCategoryId":30,
         "Name":"Hairthingleft",
         "SlotTypeId":12
      },{
         "ClothesCategoryId":31,
         "Name":"Tatoo",
         "SlotTypeId":13
      },{
         "ClothesCategoryId":32,
         "Name":"Cigaret",
         "SlotTypeId":14
      },{
         "ClothesCategoryId":33,
         "Name":"Furniture",
         "SlotTypeId":8
      },{
         "ClothesCategoryId":34,
         "Name":"UPPER_RIGHT_ARM_TATOO",
         "SlotTypeId":16
      },{
         "ClothesCategoryId":35,
         "Name":"LOWER_RIGHT_ARM_TATOO",
         "SlotTypeId":17
      },{
         "ClothesCategoryId":36,
         "Name":"UPPER_LEFT_ARM_TATOO",
         "SlotTypeId":18
      },{
         "ClothesCategoryId":37,
         "Name":"LOWER_LEFT_ARM_TATOO",
         "SlotTypeId":19
      },{
         "ClothesCategoryId":38,
         "Name":"UPPER_RIGHT_LEG_TATOO",
         "SlotTypeId":20
      },{
         "ClothesCategoryId":39,
         "Name":"LOWER_RIGHT_LEG_TATOO",
         "SlotTypeId":21
      },{
         "ClothesCategoryId":40,
         "Name":"UPPER_LEFT_LEG_TATOO",
         "SlotTypeId":22
      },{
         "ClothesCategoryId":41,
         "Name":"LOWER_LEFT_LEG_TATOO",
         "SlotTypeId":23
      },{
         "ClothesCategoryId":42,
         "Name":"TORSO_TATOO",
         "SlotTypeId":24
      },{
         "ClothesCategoryId":43,
         "Name":"HIPS_TATOO",
         "SlotTypeId":25
      },{
         "ClothesCategoryId":44,
         "Name":"NECK_TATOO",
         "SlotTypeId":26
      },{
         "ClothesCategoryId":45,
         "Name":"SCARF",
         "SlotTypeId":27
      },{
         "ClothesCategoryId":46,
         "Name":"ANIMATED",
         "SlotTypeId":8
      },{
         "ClothesCategoryId":Const.CLOTHES_CATEGORY_DIAMOND_EFFECT,
         "Name":"DIAMOND_CHARACTER_EFFECT",
         "SlotTypeId":8
      },{
         "ClothesCategoryId":Const.CLOTHES_CATEGORY_TIGHT_PANTS,
         "Name":"TIGHT_PANTS",
         "SlotTypeId":3
      },{
         "ClothesCategoryId":Const.CLOTHES_CATEGORY_BAGGY_PANTS,
         "Name":"BAGGY_PANTS",
         "SlotTypeId":3
      },{
         "ClothesCategoryId":Const.CLOTHES_CATEGORY_SMALL_HIGHHEEL,
         "Name":"SMALL_HIGHHEEL",
         "SlotTypeId":5
      },{
         "ClothesCategoryId":Const.CLOTHES_CATEGORY_LARGE_HIGHHEEL,
         "Name":"LARGE_HIGHHEEL",
         "SlotTypeId":5
      }];
      
      private static const SLOTTYPE_NAMES:Array = ["HAIR","TOPS","BOTTOMS","BEARD","FOOTWEAR","HEADWEAR","GLASSES","STUFF","EARRINGS","NOSERING","HAIRTHINGLEFT","HAIRTHINGRIGHT","TATOO","CIGARET","UPPER_RIGHT_ARM_TATOO","LOWER_RIGHT_ARM_TATOO","UPPER_LEFT_ARM_TATOO","LOWER_LEFT_ARM_TATOO","UPPER_RIGHT_LEG_TATOO","LOWER_RIGHT_LEG_TATOO","UPPER_LEFT_LEG_TATOO","LOWER_LEFT_LEG_TATOO","TORSO_TATOO","HIPS_TATOO","NECK_TATOO","SCARF"];
      
      public function ClothingCategories()
      {
         super();
      }
      
      public static function isHair(param1:int) : Boolean
      {
         return categories[param1].SlotTypeId == 1;
      }
      
      public static function isTop(param1:int) : Boolean
      {
         return categories[param1].SlotTypeId == 2;
      }
      
      public static function isBottom(param1:int) : Boolean
      {
         return categories[param1].SlotTypeId == 3;
      }
      
      public static function isClothing(param1:int) : Boolean
      {
         switch(param1)
         {
            case 2:
            case 3:
            case 6:
            case 7:
            case 8:
            case 9:
            case Const.CLOTHES_CATEGORY_TIGHT_PANTS:
            case Const.CLOTHES_CATEGORY_BAGGY_PANTS:
               return true;
            default:
               return false;
         }
      }
      
      public static function isWearable(param1:int) : Boolean
      {
         return param1 < 16 || param1 > 24 && param1 != 33 && param1 != 46;
      }
      
      public static function IsClothsConflicting(param1:Cloth, param2:Cloth) : Boolean
      {
         return IsSlotTypesConflicting(param1.ClothesCategory.SlotTypeId,param2.ClothesCategory.SlotTypeId);
      }
      
      private static function IsSlotTypesConflicting(param1:int, param2:int) : Boolean
      {
         if(param1 == param2)
         {
            return true;
         }
         return false;
      }
      
      public static function get categories() : Array
      {
         var _loc1_:Object = null;
         var _loc2_:ClothesCategory = null;
         if(!_categories)
         {
            _categories = new Array();
            for each(_loc1_ in CATEGORY_VALUES)
            {
               _loc2_ = new ClothesCategory();
               _loc2_.ClothesCategoryId = _loc1_.ClothesCategoryId;
               _loc2_.Name = _loc1_.Name;
               _loc2_.SlotTypeId = _loc1_.SlotTypeId;
               _loc2_.SlotType = new SlotType();
               _loc2_.SlotType.SlotTypeId = _loc1_.SlotTypeId;
               _loc2_.SlotType.Name = SLOTTYPE_NAMES[_loc1_.SlotTypeId - 1];
               _categories[_loc2_.ClothesCategoryId] = _loc2_;
            }
         }
         return _categories;
      }
      
      public function GetCategorySubPath(param1:int) : String
      {
         switch(param1)
         {
            case 1:
               return "hair/";
            case 2:
            case 6:
            case 7:
               return "tops/";
            case 3:
            case 8:
            case 9:
            case Const.CLOTHES_CATEGORY_TIGHT_PANTS:
            case Const.CLOTHES_CATEGORY_BAGGY_PANTS:
               return "bottoms/";
            case 5:
               return "beard/";
            case 10:
            case 11:
            case 12:
            case Const.CLOTHES_CATEGORY_SMALL_HIGHHEEL:
            case Const.CLOTHES_CATEGORY_LARGE_HIGHHEEL:
               return "footwear/";
            case 13:
            case 14:
            case 15:
               return "headwear/";
            case 19:
            case 20:
            case 21:
            case 22:
            case 23:
            case 24:
            case 33:
            case 46:
               return "stuff/";
            case 25:
            case 26:
            case 27:
            case 28:
            case 29:
            case 30:
            case 31:
            case 32:
            case 34:
            case 35:
            case 36:
            case 37:
            case 38:
            case 39:
            case 40:
            case 41:
            case 42:
            case 43:
            case 44:
            case 45:
            case 47:
               return "accessories/";
            default:
               trace("ERROR: Unknown category: " + param1);
               return null;
         }
      }
   }
}

