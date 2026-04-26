package com.moviestarplanet.assetManager.loaders
{
   import com.moviestarplanet.assetManager.AssetBundle;
   import com.moviestarplanet.assetManager.AssetManager;
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.assetManager.UnionRep;
   import starling.display.Image;
   import starling.text.BitmapFont;
   import starling.text.TextField;
   import starling.textures.Texture;
   
   public class BitmapFontTextureAtlasLoader extends AssetLoader
   {
      
      private var fontNameAlias:String;
      
      private var _smartSpriteSheetUrl:IAssetUrl;
      
      private var _smartXMLUrl:IAssetUrl;
      
      private var xml:XML;
      
      private var texture:Texture;
      
      public function BitmapFontTextureAtlasLoader(param1:UnionRep, param2:String, param3:IAssetUrl, param4:IAssetUrl, param5:Function = null, param6:Function = null)
      {
         this.autoDisposeLoader = false;
         this.fontNameAlias = param2;
         isWrapper = true;
         this._smartSpriteSheetUrl = param3;
         this._smartXMLUrl = param4;
         _onSuccess = param5;
         _onFail = param6;
         super(param1,param3,param5,param6);
         autoDisposeLoader = false;
         if(param1 == null)
         {
            throw new Error("BitmapFontTextureAtlasLoader can only be instantiated from AssetManager");
         }
      }
      
      override public function load() : void
      {
         var _loc1_:AssetBundle = null;
         if(TextField.getBitmapFont(this.fontNameAlias) == null)
         {
            _loc1_ = new AssetBundle(this.onBundleLoaded,this.onBundleFail);
            _loc1_.addLoader(AssetManager.createLoaderForImageScaledAsStarlingImage(this._smartSpriteSheetUrl,1,this.textureLoaded,null));
            _loc1_.addLoader(AssetManager.createLoaderForXML(this._smartXMLUrl,XMLAssetLoader.FILE_PERMISSION_READ_ONLY,this.xmlLoaded));
            _loc1_.load();
         }
         else
         {
            triggerOnSuccess();
         }
      }
      
      private function xmlLoaded(param1:XMLAssetLoader) : void
      {
         this.xml = param1.getXML();
      }
      
      private function textureLoaded(param1:ImageScaledAsStarlingImageLoader) : void
      {
         var _loc2_:Image = param1.getImage();
         this.texture = _loc2_.texture;
      }
      
      private function onBundleLoaded(param1:AssetBundle) : void
      {
         TextField.registerBitmapFont(new BitmapFont(this.texture,this.xml),this.fontNameAlias);
         if(_onSuccess != null)
         {
            this.xml = null;
            this.texture = null;
            _onSuccess(this);
         }
         triggerOnSuccess();
      }
      
      private function onBundleFail() : void
      {
         if(_onFail != null)
         {
            _onFail();
         }
         triggerOnFail();
      }
      
      override public function dispose() : void
      {
         _onSuccess = null;
         _onFail = null;
         this._smartSpriteSheetUrl = null;
         this._smartXMLUrl = null;
         this.xml = null;
         super.dispose();
      }
   }
}

