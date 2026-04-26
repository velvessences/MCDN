package com.moviestarplanet.assetManager.loaders.SWFs
{
   import com.moviestarplanet.assetManager.AssetManager;
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.assetManager.UnionRep;
   import com.moviestarplanet.assetManager.loaders.AssetLoader;
   import com.moviestarplanet.assetManager.loaders.TextureAssetLoader;
   import com.moviestarplanet.assetManager.optimizedAlternatives.HelperDetails;
   import com.moviestarplanet.assetManager.optimizedAlternatives.SWFChildAsStarlingScale9;
   import com.moviestarplanet.assetManager.resources.HelperDetailsResourceWrapper;
   import com.moviestarplanet.resources.GenericResourceManager;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   public class SWFChildAsStarlingScale9Loader extends TextureAssetLoader
   {
      
      private namespace AssetManagerNS = "AssetManager";
      
      private var _url:String = "";
      
      private var _searchForName:String = "";
      
      private var _scale:Number = 1;
      
      private var swfChildAsDisplayObjectLoader:SWFChildAsDisplayObjectLoader;
      
      private var _myOriginalDisplayObject:DisplayObject;
      
      public function SWFChildAsStarlingScale9Loader(param1:UnionRep, param2:String, param3:Number, param4:IAssetUrl, param5:Function = null, param6:Function = null)
      {
         isWrapper = true;
         this._url = param4.getAbsolutePath();
         this._scale = param3;
         this._searchForName = param2;
         assetKeyModifier = this._searchForName + this._scale;
         super(param1,param4,param5,param6);
         if(param1 == null)
         {
            throw new Error("SWFChildAsStarlingScale9Loader can only be instantiated from AssetManager");
         }
      }
      
      override public function clone() : AssetLoader
      {
         return AssetManager.createLoaderForSWFChildAsStarlingScale9(this._searchForName,this._scale,_smartUrl,_onSuccess,_onFail);
      }
      
      override §§namespace("AssetManager") function CallManagerSaysYouHaveLoaded() : void
      {
         triggerOnSuccess();
      }
      
      override public function doLoad() : void
      {
         if(forceLoad)
         {
            this.swfChildAsDisplayObjectLoader = AssetManager.createLoaderForSWFChildAsDisplayObject(this._searchForName,_smartUrl,this.onLoadDisplayObject,this.onFailDisplayObject);
            this.swfChildAsDisplayObjectLoader.load();
         }
         else if(GenericResourceManager.hasResource(assetKey))
         {
            triggerOnSuccess();
         }
         else
         {
            this.swfChildAsDisplayObjectLoader = AssetManager.createLoaderForSWFChildAsDisplayObject(this._searchForName,_smartUrl,this.onLoadDisplayObject,this.onFailDisplayObject);
            this.swfChildAsDisplayObjectLoader.load();
         }
      }
      
      private function onLoadDisplayObject(param1:SWFChildAsDisplayObjectLoader) : void
      {
         this._myOriginalDisplayObject = param1.getDisplayObject();
         triggerOnSuccess();
      }
      
      private function onFailDisplayObject(param1:SWFChildAsDisplayObjectLoader) : void
      {
         triggerOnFail();
      }
      
      override §§namespace("AssetManager") function getBitmapData() : BitmapData
      {
         var _loc1_:HelperDetails = new HelperDetails(assetKey + "tempLostContextRestorer",DisplayObjectContainer(this._myOriginalDisplayObject),this._scale);
         var _loc2_:BitmapData = _loc1_.getBitmapData(DisplayObjectContainer(this._myOriginalDisplayObject));
         _loc1_.dispose();
         return _loc2_;
      }
      
      public function getScale9() : SWFChildAsStarlingScale9
      {
         var _loc2_:HelperDetails = null;
         if(!GenericResourceManager.getResource(assetKey))
         {
            if(this._myOriginalDisplayObject == null)
            {
               throw new Error("getScale9() has tried to create from a display object, because the resource was not available... but no display object was loaded.");
            }
            _loc2_ = new HelperDetails(assetKey,DisplayObjectContainer(this._myOriginalDisplayObject),this._scale);
            new HelperDetailsResourceWrapper(assetKey,_loc2_,this);
         }
         var _loc1_:HelperDetailsResourceWrapper = HelperDetailsResourceWrapper(GenericResourceManager.getResource(assetKey));
         return SWFChildAsStarlingScale9.create(UnionRep.instance,_loc1_);
      }
      
      override public function dispose() : void
      {
         if(this.swfChildAsDisplayObjectLoader != null)
         {
            this.swfChildAsDisplayObjectLoader.dispose();
            this.swfChildAsDisplayObjectLoader = null;
         }
         this._myOriginalDisplayObject = null;
         super.dispose();
      }
   }
}

