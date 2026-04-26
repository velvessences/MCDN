package com.moviestarplanet.assetManager.optimizedAlternatives
{
   import com.moviestarplanet.assetManager.UnionRep;
   import com.moviestarplanet.assetManager.resources.TextureResourceWrapper;
   import flash.geom.Point;
   import starling.display.Image;
   
   public class ImageForAssetManager extends Image
   {
      
      private namespace AssetManagerNS = "AssetManager";
      
      internal var url:String = "";
      
      private var textureResourceWrapper:TextureResourceWrapper;
      
      public function ImageForAssetManager(param1:UnionRep, param2:TextureResourceWrapper, param3:String = "")
      {
         this.textureResourceWrapper = param2;
         this.textureResourceWrapper.subscribe(this);
         super(this.textureResourceWrapper.getTexture(this));
         if(param1 == null)
         {
            throw new Error("ImageForAssetManager can only be instantiated from AssetManager");
         }
      }
      
      public static function create(param1:UnionRep, param2:TextureResourceWrapper) : ImageForAssetManager
      {
         return new ImageForAssetManager(param1,param2);
      }
      
      public function unStretchTexture() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Point = new Point();
         if(scaleX > scaleY)
         {
            mVertexData.getPosition(3,_loc3_);
            _loc1_ = Number(_loc3_.x);
            _loc3_.x = _loc3_.x / scaleX * scaleY;
            _loc2_ = (_loc1_ - _loc3_.x) / 2;
            mVertexData.setPosition(3,_loc3_.x + _loc2_,_loc3_.y);
            mVertexData.getPosition(1,_loc3_);
            _loc3_.x = _loc3_.x / scaleX * scaleY;
            mVertexData.setPosition(1,_loc3_.x + _loc2_,_loc3_.y);
            mVertexData.getPosition(0,_loc3_);
            mVertexData.setPosition(0,_loc3_.x + _loc2_,_loc3_.y);
            mVertexData.getPosition(2,_loc3_);
            mVertexData.setPosition(2,_loc3_.x + _loc2_,_loc3_.y);
            return;
         }
         mVertexData.getPosition(2,_loc3_);
         _loc1_ = Number(_loc3_.y);
         _loc3_.y = _loc3_.y / scaleY * scaleX;
         _loc2_ = (_loc1_ - _loc3_.y) / 2;
         mVertexData.setPosition(2,_loc3_.x,_loc3_.y + _loc2_);
         mVertexData.getPosition(3,_loc3_);
         _loc3_.y = _loc3_.y / scaleY * scaleX;
         mVertexData.setPosition(3,_loc3_.x,_loc3_.y + _loc2_);
         mVertexData.getPosition(0,_loc3_);
         mVertexData.setPosition(0,_loc3_.x,_loc3_.y + _loc2_);
         mVertexData.getPosition(1,_loc3_);
         mVertexData.setPosition(1,_loc3_.x,_loc3_.y + _loc2_);
      }
      
      override public function dispose() : void
      {
         if(this.textureResourceWrapper != null)
         {
            this.textureResourceWrapper.unsubscribe(this);
         }
         this.textureResourceWrapper = null;
         super.dispose();
      }
   }
}

