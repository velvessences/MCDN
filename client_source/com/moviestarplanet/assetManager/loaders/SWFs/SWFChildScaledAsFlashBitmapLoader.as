package com.moviestarplanet.assetManager.loaders.SWFs
{
   import com.moviestarplanet.assetManager.AssetManager;
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.assetManager.UnionRep;
   import com.moviestarplanet.assetManager.loaders.AssetLoader;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class SWFChildScaledAsFlashBitmapLoader extends AssetLoader
   {
      
      private static const MaxHeightWidth:int = 2048;
      
      private var _searchForName:String = "";
      
      private var _scale:Number = 1;
      
      private var swfchildloader:SWFChildAsDisplayObjectLoader;
      
      private var myDisplayObject:DisplayObject;
      
      public function SWFChildScaledAsFlashBitmapLoader(param1:UnionRep, param2:String, param3:Number, param4:IAssetUrl, param5:Function = null, param6:Function = null)
      {
         isWrapper = true;
         this._scale = param3;
         this._searchForName = param2;
         super(param1,param4,param5,param6);
         if(param1 == null)
         {
            throw new Error("SWFChildScaledAsFlashBitmapLoader can only be instantiated from AssetManager");
         }
      }
      
      public static function getBitmapFromSprite(param1:DisplayObject, param2:Number = 1) : Bitmap
      {
         var _loc3_:Rectangle = param1.getBounds(param1);
         var _loc4_:Matrix = new Matrix();
         _loc4_.translate(-_loc3_.x,-_loc3_.y);
         if(param1.width * param2 > MaxHeightWidth || param1.height * param2 > MaxHeightWidth)
         {
            if(param1.width > param1.height)
            {
               param2 = MaxHeightWidth / param1.width;
            }
            else
            {
               param2 = MaxHeightWidth / param1.height;
            }
         }
         _loc4_.scale(param2,param2);
         var _loc5_:BitmapData = new BitmapData(_loc3_.width * param2,_loc3_.height * param2,true,65280);
         _loc5_.draw(param1,_loc4_);
         return new Bitmap(_loc5_);
      }
      
      override public function load() : void
      {
         this.swfchildloader = AssetManager.createLoaderForSWFChildAsDisplayObject(this._searchForName,_smartUrl,this.myOnSuccess,this.myOnFail);
         this.swfchildloader.load();
      }
      
      private function myOnSuccess(param1:SWFChildAsDisplayObjectLoader) : void
      {
         this.myDisplayObject = param1.getDisplayObject();
         triggerOnSuccess();
      }
      
      private function myOnFail(param1:SWFAssetLoader) : void
      {
      }
      
      public function getBitmap() : Bitmap
      {
         return getBitmapFromSprite(this.myDisplayObject,this._scale);
      }
      
      override public function dispose() : void
      {
         this.swfchildloader.dispose();
         super.dispose();
      }
   }
}

