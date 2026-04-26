package com.moviestarplanet.fontmanager.starling.emoticons
{
   import com.moviestarplanet.assetManager.loaders.SWFs.SWFChildScaledAsStarlingImageLoader;
   import flash.utils.Dictionary;
   import starling.text.BitmapChar;
   import starling.textures.Texture;
   
   public class EmoticonMapper
   {
      
      public static var testBitmapChar:BitmapChar;
      
      public static var letters:EmoticonMapper = new EmoticonMapper();
      
      public var bitmapChar:BitmapChar;
      
      public var subsets:Dictionary;
      
      public function EmoticonMapper()
      {
         super();
      }
      
      public static function addSmiley(param1:String, param2:Texture, param3:SWFChildScaledAsStarlingImageLoader = null) : void
      {
         var _loc5_:EmoticonMapper = null;
         var _loc6_:EmoticonMapper = null;
         var _loc10_:BitmapChar = null;
         var _loc4_:EmoticonMapper = letters;
         var _loc7_:Number = 0;
         var _loc8_:int = int(param1.length);
         var _loc9_:int = 0;
         while(_loc9_ < _loc8_)
         {
            _loc7_ = Number(param1.charCodeAt(_loc9_));
            if(_loc4_.subsets == null)
            {
               _loc4_.subsets = new Dictionary();
            }
            _loc5_ = _loc4_.subsets[_loc7_];
            if(_loc5_ == null)
            {
               _loc5_ = new EmoticonMapper();
               _loc4_.subsets[_loc7_] = _loc5_;
            }
            if(_loc9_ == _loc8_ - 1)
            {
               if(param2 != null)
               {
                  _loc10_ = new SpecialBitmapChar(0,param2,0,0,param2.width * 1.01);
               }
               else
               {
                  _loc10_ = new LoadableBitmapChar(param3);
               }
               _loc5_.bitmapChar = _loc10_;
            }
            _loc4_ = _loc5_;
            _loc9_++;
         }
      }
      
      public static function mappedBitmapChar(param1:BitmapChar, param2:Number) : BitmapChar
      {
         if(param1 is SpecialBitmapChar)
         {
            (param1 as SpecialBitmapChar).setProperties(param2);
         }
         else if(param1 is LoadableBitmapChar)
         {
            (param1 as LoadableBitmapChar).setProperties(param2);
         }
         return param1;
      }
      
      public static function getSmiley(param1:String, param2:int, param3:EmoticonBitmapCharReplacer, param4:Number) : void
      {
         param3.bitmapChar = null;
         param3.moveForward = 0;
         if(letters.subsets == null)
         {
            return;
         }
         var _loc5_:Number = Number(param1.charCodeAt(param2));
         if(letters.subsets[_loc5_] == null)
         {
            return;
         }
         var _loc6_:EmoticonMapper = letters.subsets[_loc5_];
         var _loc7_:* = 0;
         while(true)
         {
            _loc7_++;
            _loc5_ = Number(param1.charCodeAt(param2 + _loc7_));
            if(_loc6_.subsets == null || _loc6_.subsets[_loc5_] == null)
            {
               break;
            }
            _loc6_ = _loc6_.subsets[_loc5_];
         }
         _loc7_--;
         if(_loc6_.bitmapChar != null)
         {
            param3.bitmapChar = mappedBitmapChar(_loc6_.bitmapChar,param4);
         }
         param3.moveForward = _loc7_;
      }
   }
}

