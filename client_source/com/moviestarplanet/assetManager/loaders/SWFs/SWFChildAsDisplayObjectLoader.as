package com.moviestarplanet.assetManager.loaders.SWFs
{
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.assetManager.UnionRep;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   public class SWFChildAsDisplayObjectLoader extends SWFAsDisplayObjectLoader
   {
      
      private var _searchForName:String = "";
      
      public function SWFChildAsDisplayObjectLoader(param1:UnionRep, param2:String, param3:IAssetUrl, param4:Function = null, param5:Function = null)
      {
         this._searchForName = param2;
         assetKeyModifier = this._searchForName;
         super(param1,param3,param4,param5);
         if(param1 == null)
         {
            throw new Error("SWFChildAsDisplayObjectLoader can only be instantiated from AssetManager");
         }
      }
      
      override public function getDisplayObject() : DisplayObject
      {
         var _loc2_:DisplayObjectContainer = null;
         var _loc1_:int = 0;
         while(_loc1_ < mySprite.numChildren)
         {
            if(mySprite.getChildAt(_loc1_) is DisplayObjectContainer)
            {
               _loc2_ = mySprite.getChildAt(_loc1_) as DisplayObjectContainer;
               if(_loc2_.name == this._searchForName)
               {
                  return _loc2_;
               }
            }
            else if(mySprite.getChildAt(_loc1_).name == this._searchForName)
            {
               throw new Error("Tried to getDisplayObject(" + this._searchForName + ") on a child which is not a DisplayObjectContainer");
            }
            _loc1_++;
         }
         throw new Error(_urlFullPath + " getDisplayObject(" + this._searchForName + ") returns null - check if the asset has a child instance with that name.. and it is uploaded..");
      }
   }
}

