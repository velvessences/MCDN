package com.moviestarplanet.assetManager.loaders.SWFs
{
   import com.moviestarplanet.assetManager.AssetManager;
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.assetManager.UnionRep;
   import com.moviestarplanet.assetManager.loaders.AssetLoader;
   
   public class SWFChildScaledAsStarlingImageLoader extends SWFScaledAsStarlingImageLoader
   {
      
      private var _searchForName:String = "";
      
      public function SWFChildScaledAsStarlingImageLoader(param1:UnionRep, param2:String, param3:Number, param4:IAssetUrl, param5:Boolean, param6:Function = null, param7:Function = null)
      {
         this._searchForName = param2;
         assetKeyModifier = this._searchForName + _scale + param5.toString();
         super(param1,param3,param4,param5,param6,param7);
         if(param1 == null)
         {
            throw new Error("SWFChildScaledAsStarlingImageLoader can only be instantiated from AssetManager");
         }
      }
      
      override public function clone() : AssetLoader
      {
         return AssetManager.createLoaderForSWFChildScaledAsStarlingImage(this._searchForName,_scale,_smartUrl,_trim,_onSuccess,_onFail);
      }
      
      override protected function createSwfLoader() : SWFAsDisplayObjectLoader
      {
         return AssetManager.createLoaderForSWFChildAsDisplayObject(this._searchForName,_smartUrl,this.myOnSuccess,this.myOnFail);
      }
      
      private function myOnSuccess(param1:SWFChildAsDisplayObjectLoader) : void
      {
         myDisplayObject = param1.getDisplayObject();
         triggerOnSuccess();
      }
      
      private function myOnFail(param1:SWFAssetLoader) : void
      {
         triggerOnFail();
      }
   }
}

