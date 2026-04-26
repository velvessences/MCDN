package com.moviestarplanet.emoticon.valueobjects
{
   import com.moviestarplanet.assetManager.AssetManager;
   import com.moviestarplanet.assetManager.loaders.SWFs.SWFChildScaledAsStarlingImageLoader;
   import com.moviestarplanet.fontmanager.starling.emoticons.EmoticonMapper;
   import com.moviestarplanet.utils.loader.AssetUrl;
   
   public class EmoticonPackage
   {
      
      public var emoticonPackageId:String;
      
      public var specialsItemId:int;
      
      public var category:int;
      
      public var hardCurrencyPrice:int;
      
      public var nameResourceId:String;
      
      public var swfFileName:String;
      
      public var emoticons:Array;
      
      public var hasPurchased:Boolean;
      
      public var isVipPackage:Boolean;
      
      public function EmoticonPackage(param1:String = null, param2:int = 0, param3:int = 0, param4:int = 0, param5:String = null, param6:String = null, param7:Boolean = false, param8:Array = null)
      {
         var _loc9_:int = 0;
         var _loc10_:Emoticon = null;
         var _loc11_:AssetUrl = null;
         var _loc12_:SWFChildScaledAsStarlingImageLoader = null;
         super();
         this.emoticonPackageId = param1;
         this.specialsItemId = param2;
         this.category = param3;
         this.hardCurrencyPrice = param4;
         this.nameResourceId = param5;
         this.swfFileName = param6;
         this.hasPurchased = param7;
         this.emoticons = new Array();
         if(param8)
         {
            _loc9_ = 0;
            while(_loc9_ < param8.length)
            {
               _loc10_ = new Emoticon(param8[_loc9_]);
               this.emoticons.push(_loc10_);
               _loc11_ = new AssetUrl("swf/emoticonsWithStandards/" + param6,-1);
               _loc12_ = AssetManager.createLoaderForSWFChildScaledAsStarlingImage(_loc10_.Symbol,3,_loc11_,false);
               EmoticonMapper.addSmiley(_loc10_.CharSequence,null,_loc12_);
               _loc9_++;
            }
         }
      }
   }
}

