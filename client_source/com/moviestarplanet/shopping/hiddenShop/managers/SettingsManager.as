package com.moviestarplanet.shopping.hiddenShop.managers
{
   import com.moviestarplanet.services.shopcontentservice.valueObjects.Tag;
   import com.moviestarplanet.services.spendingservice.TagAMFManager;
   import com.moviestarplanet.services.wrappers.ThemeManagerService;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import flash.text.TextField;
   import mx.collections.ArrayCollection;
   
   public class SettingsManager
   {
      
      private static var themeDataInternal:Array;
      
      private static var tagDataInternal:Array;
      
      public static const ANY_KEY:int = 1 << 30;
      
      public static const HAVE_NO_TAGS:int = 1 << 29;
      
      public static const HAVE_TAGS:int = 1 << 27;
      
      public static const CANCEL_KEY:int = 1 << 26;
      
      public static const OKAY_KEY:int = 1 << 25;
      
      public static const clothesCategoryData:Array = [{
         "label":"FLAGS",
         "key":ANY_KEY | OKAY_KEY | CANCEL_KEY
      },{
         "label":"Hair",
         "key":1
      },{
         "label":"Tops",
         "key":2
      },{
         "label":"Bottoms",
         "key":3
      },{
         "label":"Footwear",
         "key":10
      },{
         "label":"Headwear",
         "key":13
      },{
         "label":"default",
         "key":25
      },{
         "label":"Ears",
         "key":26
      },{
         "label":"Glasses",
         "key":27
      },{
         "label":"Nose",
         "key":28
      },{
         "label":"Hair thing right",
         "key":29
      },{
         "label":"Hair thing left",
         "key":30
      },{
         "label":"Mouth",
         "key":32
      },{
         "label":"Scarf",
         "key":45
      },{
         "label":"Upper right arm tatoo",
         "key":34
      },{
         "label":"Lower right arm tatoo\t",
         "key":35
      },{
         "label":"Upper left arm tatoo",
         "key":36
      },{
         "label":"Lower left arm tatoo",
         "key":37
      },{
         "label":"Upper right leg tatoo",
         "key":38
      },{
         "label":"Lower right leg tatoo",
         "key":39
      },{
         "label":"Upper left leg tatoo",
         "key":40
      },{
         "label":"Lower left leg tatoo",
         "key":41
      },{
         "label":"Torso tatoo",
         "key":42
      },{
         "label":"Hips tatoo",
         "key":43
      },{
         "label":"Neck tatoo",
         "key":44
      },{
         "label":"Diamond Effect",
         "key":47
      },{
         "label":"Not Animated",
         "key":24
      },{
         "label":"Animated",
         "key":46
      }];
      
      public static var genderData:Array = [{
         "label":"FLAGS",
         "key":ANY_KEY | OKAY_KEY | CANCEL_KEY
      },{
         "label":"Female",
         "key":1
      },{
         "label":"Male",
         "key":2
      },{
         "label":"Unisex",
         "key":0
      }];
      
      public static var vipData:Array = [{
         "label":"FLAGS",
         "key":ANY_KEY | CANCEL_KEY
      },{
         "label":"Normal",
         "key":0
      },{
         "label":"VIP",
         "key":2
      }];
      
      public static var currencyData:Array = [{
         "label":"FLAGS",
         "key":ANY_KEY | CANCEL_KEY
      },{
         "label":"Starcoins",
         "key":0
      },{
         "label":"Diamonds",
         "key":1
      }];
      
      public static var shopData:Array = [{
         "label":"FLAGS",
         "key":ANY_KEY | OKAY_KEY | CANCEL_KEY
      },{
         "label":"Hidden shop",
         "key":-100
      },{
         "label":"Expired shop",
         "key":-101
      },{
         "label":"Girl",
         "key":1
      },{
         "label":"Boy",
         "key":2
      },{
         "label":"Shoes",
         "key":3
      },{
         "label":"Hair",
         "key":4
      },{
         "label":"Accessories",
         "key":700
      },{
         "label":"Pet Accesories",
         "key":800
      },{
         "label":"Garden Accesories",
         "key":900
      },{
         "label":"Costumes",
         "key":1000
      },{
         "label":"Pet Shop",
         "key":2000
      },{
         "label":"Instrument Shop",
         "key":2001
      },{
         "label":"Food Shop",
         "key":2002
      },{
         "label":"Vehicle Shop",
         "key":2003
      },{
         "label":"Gadget Shop",
         "key":2004
      },{
         "label":"Furniture Shop",
         "key":2005
      },{
         "label":"Props Shop",
         "key":2006
      },{
         "label":"Clothes Template Shop",
         "key":3000
      }];
      
      public static var shopSetDataCloth:Array = [{
         "label":"FLAGS",
         "key":CANCEL_KEY
      },{
         "label":"No shop - hidden",
         "key":-100
      },{
         "label":"Shop",
         "key":0
      },{
         "label":"Design Template Shop",
         "key":3000
      }];
      
      public static var shopSetDataProps:Array = [{
         "label":"FLAGS",
         "key":CANCEL_KEY
      },{
         "label":"No shop - hidden",
         "key":-100
      },{
         "label":"Zoo Shop",
         "key":2000
      },{
         "label":"Food Shop",
         "key":2002
      },{
         "label":"Vehicle Shop",
         "key":2003
      },{
         "label":"Gadget Shop",
         "key":2004
      },{
         "label":"Furniture Shop",
         "key":2005
      },{
         "label":"Props Shop",
         "key":2006
      },{
         "label":"Pet accessories Shop",
         "key":800
      },{
         "label":"Garden accessories Shop",
         "key":900
      }];
      
      public static var tagsToUse:Array = [ANY_KEY];
      
      public static var themesToUse:Array = [ANY_KEY];
      
      public static var categoriesToUse:Array = [ANY_KEY];
      
      public static var gendersToUse:Array = [ANY_KEY];
      
      public static var shopsToUse:Array = [ANY_KEY];
      
      public static var vipToUse:int = ANY_KEY;
      
      public static var currencyToUse:int = ANY_KEY;
      
      public static var searchString:String = "";
      
      public function SettingsManager()
      {
         super();
      }
      
      public static function GetShopBySelection(param1:int, param2:int) : int
      {
         if(param1 >= 13)
         {
            return 700;
         }
         if(!(param1 == 2 || param1 == 3 || param1 == 60 || param1 == 61))
         {
            if(param1 >= 10 && param1 <= 12)
            {
               return 3;
            }
            if(param1 == 1)
            {
               return 4;
            }
            return -1;
         }
         switch(param2)
         {
            case 1:
               return 1;
            case 2:
               return 2;
            case 0:
               return 0;
            default:
               return -1;
         }
      }
      
      public static function reset() : void
      {
         tagsToUse = [ANY_KEY];
         themesToUse = [ANY_KEY];
         categoriesToUse = [ANY_KEY];
         gendersToUse = [ANY_KEY];
         shopsToUse = [ANY_KEY];
         currencyToUse = ANY_KEY;
         vipToUse = ANY_KEY;
         searchString = "";
      }
      
      public static function set tagToUse(param1:int) : void
      {
         checkIfContains(param1,tagsToUse);
      }
      
      public static function set themeToUse(param1:int) : void
      {
         checkIfContains(param1,themesToUse);
      }
      
      public static function set categoryToUse(param1:int) : void
      {
         checkIfContains(param1,categoriesToUse);
      }
      
      public static function set genderToUse(param1:int) : void
      {
         checkIfContains(param1,gendersToUse);
      }
      
      public static function set shopToUse(param1:int) : void
      {
         checkIfContains(param1,shopsToUse);
      }
      
      private static function checkIfContains(param1:int, param2:Array) : void
      {
         if(param1 == ANY_KEY)
         {
            while(param2.length > 0)
            {
               param2.pop();
            }
            param2.push(ANY_KEY);
            return;
         }
         if(param2[0] == ANY_KEY)
         {
            param2.pop();
         }
         var _loc3_:int = int(param2.indexOf(param1));
         if(_loc3_ == -1)
         {
            param2.push(param1);
         }
         else
         {
            param2.splice(_loc3_,1);
            if(param2.length == 0)
            {
               while(param2.length > 0)
               {
                  param2.pop();
               }
               param2.push(ANY_KEY);
            }
         }
      }
      
      public static function getTags(param1:Function, param2:Boolean = true) : void
      {
         var recievedTags:Function = null;
         var callback:Function = param1;
         var anyAble:Boolean = param2;
         recievedTags = function(param1:Array):void
         {
            var _loc3_:Tag = null;
            var _loc4_:String = null;
            tagDataInternal = new Array();
            var _loc2_:int = 0;
            while(_loc2_ < param1.length)
            {
               _loc3_ = param1[_loc2_];
               _loc4_ = MSPLocaleManagerWeb.getInstance().getString(_loc3_.TagName);
               tagDataInternal.push({
                  "label":_loc3_.TagGroup + " - " + _loc4_,
                  "key":_loc3_.TagId,
                  "shortLabel":_loc4_
               });
               _loc2_++;
            }
            callback(toResult());
         };
         var toResult:Function = function():Array
         {
            var _loc1_:Array = null;
            var _loc2_:Array = null;
            if(anyAble)
            {
               _loc1_ = [{
                  "label":"FLAGS",
                  "key":ANY_KEY | OKAY_KEY | HAVE_NO_TAGS | HAVE_TAGS | CANCEL_KEY
               }];
               return _loc1_.concat(tagDataInternal);
            }
            _loc2_ = [{
               "label":"FLAGS",
               "key":CANCEL_KEY
            }];
            return _loc2_.concat(tagDataInternal);
         };
         if(tagDataInternal != null)
         {
            callback(toResult());
            return;
         }
         TagAMFManager.getAllTags(recievedTags);
      }
      
      public static function getThemes(param1:Function, param2:Boolean = true) : void
      {
         var populateThemes:Function = null;
         var callback:Function = param1;
         var anyAble:Boolean = param2;
         populateThemes = function(param1:ArrayCollection):void
         {
            var _loc3_:String = null;
            var _loc4_:Number = NaN;
            themeDataInternal = new Array();
            var _loc2_:int = 0;
            while(_loc2_ < param1.length)
            {
               _loc3_ = param1[_loc2_].Name + " (";
               _loc4_ = Number(param1[_loc2_].ThemeID);
               if(param1[_loc2_].Type == 0)
               {
                  _loc3_ += "Normal";
               }
               else if(param1[_loc2_].Type == 1)
               {
                  _loc3_ += "Gift/VIP";
               }
               _loc3_ += ")";
               themeDataInternal.push({
                  "label":_loc3_,
                  "key":_loc4_,
                  "shortLabel":param1[_loc2_].Name,
                  "year":param1[_loc2_].CreatedDate.fullYear
               });
               _loc2_++;
            }
            callback(toResult());
         };
         var toResult:Function = function():Array
         {
            var _loc1_:Array = null;
            var _loc2_:Array = null;
            if(anyAble)
            {
               _loc1_ = [{
                  "label":"FLAGS",
                  "key":ANY_KEY | OKAY_KEY | CANCEL_KEY
               }];
               return _loc1_.concat(themeDataInternal);
            }
            _loc2_ = [{
               "label":"FLAGS",
               "key":CANCEL_KEY
            }];
            return _loc2_.concat(themeDataInternal);
         };
         if(themeDataInternal != null)
         {
            callback(toResult());
            return;
         }
         ThemeManagerService.GetAllThemes(populateThemes);
      }
      
      public static function get params() : Object
      {
         return {
            "shopId":shopsToUse,
            "themeId":themesToUse,
            "categoryId":categoriesToUse,
            "genderId":gendersToUse,
            "tagToUse":tagsToUse,
            "vipToUse":vipToUse,
            "currencyToUse":currencyToUse,
            "search":searchString
         };
      }
      
      public static function getFlagText(param1:int, param2:String) : String
      {
         if(param1 == ANY_KEY)
         {
            return "Any " + param2;
         }
         if(param1 == HAVE_TAGS)
         {
            return "Have tags";
         }
         if(param1 == HAVE_NO_TAGS)
         {
            return "No tags";
         }
         return "";
      }
      
      public static function updateGenderText(param1:TextField) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc2_:String = getFlagText(gendersToUse[0],"gender");
         for each(_loc3_ in gendersToUse)
         {
            for each(_loc4_ in genderData)
            {
               if(_loc4_.key == _loc3_)
               {
                  _loc2_ = _loc2_ + _loc4_.label + ", ";
               }
            }
         }
         param1.text = _loc2_;
      }
      
      public static function updateShopText(param1:TextField) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc2_:String = getFlagText(shopsToUse[0],"shop");
         for each(_loc3_ in shopsToUse)
         {
            for each(_loc4_ in shopData)
            {
               if(_loc4_.key == _loc3_)
               {
                  _loc2_ = _loc2_ + _loc4_.label + ", ";
               }
            }
         }
         param1.text = _loc2_;
      }
      
      public static function updateTagText(param1:TextField) : void
      {
         var gotTags:Function = null;
         var tagField:TextField = param1;
         gotTags = function(param1:Array):void
         {
            var _loc3_:int = 0;
            var _loc4_:Object = null;
            var _loc2_:String = getFlagText(tagsToUse[0],"tags");
            for each(_loc3_ in tagsToUse)
            {
               for each(_loc4_ in param1)
               {
                  if(_loc4_.key == _loc3_)
                  {
                     _loc2_ = _loc2_ + _loc4_.shortLabel + ", ";
                  }
               }
            }
            tagField.text = _loc2_;
         };
         getTags(gotTags);
      }
      
      public static function updateThemeText(param1:TextField) : void
      {
         var gotThemes:Function = null;
         var themeField:TextField = param1;
         gotThemes = function(param1:Array):void
         {
            var _loc3_:int = 0;
            var _loc4_:Object = null;
            var _loc2_:String = getFlagText(themesToUse[0],"theme");
            for each(_loc3_ in themesToUse)
            {
               for each(_loc4_ in param1)
               {
                  if(_loc4_.key == _loc3_)
                  {
                     _loc2_ = _loc2_ + _loc4_.shortLabel + ", ";
                  }
               }
            }
            themeField.text = _loc2_;
         };
         getThemes(gotThemes);
      }
      
      public static function updateCategoryText(param1:TextField) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc2_:String = getFlagText(categoriesToUse[0],"category");
         for each(_loc3_ in categoriesToUse)
         {
            for each(_loc4_ in clothesCategoryData)
            {
               if(_loc4_.key == _loc3_)
               {
                  _loc2_ = _loc2_ + _loc4_.label + ", ";
               }
            }
         }
         param1.text = _loc2_;
      }
   }
}

