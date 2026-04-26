package com.moviestarplanet.assetManager.optimizedAlternatives
{
   import com.moviestarplanet.assetManager.loaders.TextureAssetLoader;
   import com.moviestarplanet.commonaccesspoints.DebugAccessPoint;
   import feathers.textures.Scale9Textures;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.filters.BitmapFilter;
   import flash.filters.BlurFilter;
   import flash.filters.DropShadowFilter;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import starling.textures.Texture;
   
   public class HelperDetails
   {
      
      public var rawSize:Rectangle = new Rectangle();
      
      public var size:Rectangle = new Rectangle();
      
      public var inside:Rectangle = new Rectangle();
      
      public var texture:Texture;
      
      public var scale9Textures:Scale9Textures;
      
      public var drawDimensions:Rectangle;
      
      public var scaleKey:Number;
      
      private var delimiter:String = ":";
      
      internal var storeAbstractRectangles:Dictionary = new Dictionary();
      
      public var scaleX:Number;
      
      public var scaleY:Number;
      
      private var containerName:String = "";
      
      public var assetKey:String = "";
      
      private var forceWidth:int = -1;
      
      private var forceHeight:int = -1;
      
      private var fn:int = 0;
      
      private var filters:Array;
      
      private var filter:BitmapFilter;
      
      private var blurFilter:BlurFilter;
      
      private var dropShadowFilter:DropShadowFilter;
      
      private var reloadableTexture:ReloadableTexture;
      
      private var MATRIX:Matrix = new Matrix();
      
      private var trim:Boolean;
      
      public function HelperDetails(param1:String, param2:DisplayObjectContainer, param3:Number, param4:int = -1, param5:int = -1, param6:Boolean = false)
      {
         super();
         this.assetKey = param1;
         this.containerName = param2.name;
         this.scaleX = param3;
         this.scaleY = param3;
         this.forceWidth = param4;
         this.forceHeight = param5;
         this.trim = param6;
         this.generateRest(param2,this.getBitmapData(param2));
      }
      
      public function getBitmapData(param1:DisplayObjectContainer) : BitmapData
      {
         if(this.trim)
         {
            return this.getTrimmedBitmapData(param1);
         }
         var _loc2_:Number = this.scaleX;
         var _loc3_:DisplayObject = param1.getChildByName("size") as DisplayObject;
         if(_loc3_ == null)
         {
            this.rawSize = param1.getBounds(param1);
         }
         else
         {
            this.rawSize = new Rectangle(_loc3_.x,_loc3_.y,_loc3_.width,_loc3_.height);
         }
         if(_loc3_ == null)
         {
            trace("THIS IS SLOW!!! STOP DOING THIS... your Movieclip is not properly formatted to use Scale9WithHelpers / Scale9Details.. I\'ll just try to give you what I think fits...");
            this.rawSize = param1.getBounds(param1);
            this.size.x = this.rawSize.x;
            this.size.y = this.rawSize.x;
            this.size.width = this.rawSize.width * _loc2_;
            this.size.height = this.rawSize.height * _loc2_;
         }
         else
         {
            _loc3_.visible = false;
            this.rawSize = new Rectangle(_loc3_.x,_loc3_.y,_loc3_.width,_loc3_.height);
            this.size.x = this.rawSize.x * _loc2_;
            this.size.y = this.rawSize.y * _loc2_;
            this.size.width = this.rawSize.width * _loc2_;
            this.size.height = this.rawSize.height * _loc2_;
         }
         if(this.forceWidth != -1 || this.forceHeight != -1)
         {
            this.scaleKey = this.forceWidth * 100 + this.forceHeight;
         }
         else
         {
            this.scaleKey = _loc2_;
         }
         if(this.forceWidth != -1 && this.forceHeight != -1)
         {
            this.scaleX = this.forceWidth / this.rawSize.width;
            this.scaleY = this.forceHeight / this.rawSize.height;
            _loc2_ = this.scaleX + this.scaleY + 1000;
            this.size.x = this.rawSize.x * this.scaleX;
            this.size.y = this.rawSize.y * this.scaleY;
            this.size.width = this.rawSize.width * this.scaleX;
            this.size.height = this.rawSize.height * this.scaleY;
         }
         else if(this.forceHeight != -1)
         {
            _loc2_ = this.forceHeight / this.rawSize.height;
            this.scaleX = this.scaleY = _loc2_;
            this.size.x = this.rawSize.x * _loc2_;
            this.size.y = this.rawSize.y * _loc2_;
            this.size.width = this.rawSize.width * _loc2_;
            this.size.height = this.rawSize.height * _loc2_;
         }
         else if(this.forceWidth != -1)
         {
            _loc2_ = this.forceWidth / this.rawSize.width;
            this.scaleX = this.scaleY = _loc2_;
            this.size.x = this.rawSize.x * _loc2_;
            this.size.y = this.rawSize.y * _loc2_;
            this.size.width = this.rawSize.width * _loc2_;
            this.size.height = this.rawSize.height * _loc2_;
         }
         var _loc4_:Matrix = new Matrix();
         _loc4_.scale(this.scaleX,this.scaleY);
         _loc4_.translate(-this.size.x,-this.size.y);
         this.fixChildrenFilters(param1,this.scaleX);
         var _loc5_:BitmapData = new BitmapData(this.size.width,this.size.height,true,16711935);
         _loc5_.draw(param1,_loc4_);
         return _loc5_;
      }
      
      private function getVisibleBounds(param1:DisplayObject) : Rectangle
      {
         this.MATRIX.identity();
         var _loc2_:Rectangle = param1.getBounds(param1);
         this.MATRIX.tx = -_loc2_.x;
         this.MATRIX.ty = -_loc2_.y;
         var _loc3_:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         _loc3_.draw(param1,this.MATRIX);
         var _loc4_:Rectangle = _loc3_.getColorBoundsRect(4294967295,0,false);
         _loc3_.dispose();
         _loc4_.x += _loc2_.x;
         _loc4_.y += _loc2_.y;
         return _loc4_;
      }
      
      private function getTrimmedBitmapData(param1:DisplayObjectContainer) : BitmapData
      {
         var _loc2_:Rectangle = this.getVisibleBounds(param1);
         _loc2_.width *= this.scaleX;
         _loc2_.height *= this.scaleY;
         if(_loc2_.width == 0 || _loc2_.height == 0)
         {
            _loc2_.width = 1;
            _loc2_.height = 1;
         }
         var _loc3_:BitmapData = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         this.MATRIX.identity();
         this.MATRIX.translate(-_loc2_.x,-_loc2_.y);
         this.MATRIX.scale(this.scaleX,this.scaleY);
         _loc3_.draw(param1,this.MATRIX);
         return _loc3_;
      }
      
      private function generateRest(param1:DisplayObjectContainer, param2:BitmapData) : void
      {
         var _loc3_:Boolean = false;
         this.texture = Texture.fromBitmapData(param2,_loc3_);
         param2.dispose();
         var _loc4_:DisplayObject = param1.getChildByName("inside") as DisplayObject;
         if(_loc4_ != null)
         {
            _loc4_.visible = false;
            this.inside.x = _loc4_.x * this.scaleX;
            this.inside.y = _loc4_.y * this.scaleY;
            this.inside.width = _loc4_.width * this.scaleX;
            this.inside.height = _loc4_.height * this.scaleY;
            this.inside.x -= this.size.x;
            this.inside.y -= this.size.y;
            this.scale9Textures = new Scale9Textures(this.texture,this.inside);
         }
         this.calculateAbstracts(param1,this.scaleX,this.scaleY);
      }
      
      private function fixChildrenFilters(param1:DisplayObjectContainer, param2:Number) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < param1.numChildren)
         {
            if(param1.getChildAt(_loc3_) is DisplayObjectContainer)
            {
               this.fixChildrenFilters(param1.getChildAt(_loc3_) as DisplayObjectContainer,param2);
            }
            this.filters = param1.getChildAt(_loc3_).filters;
            if(this.filters != null)
            {
               this.fn = 0;
               while(this.fn < this.filters.length)
               {
                  this.filter = this.filters[this.fn];
                  if(this.filter is BlurFilter)
                  {
                     this.blurFilter = this.filter as BlurFilter;
                     this.blurFilter.blurX *= param2;
                     this.blurFilter.blurY *= param2;
                     this.blurFilter = null;
                  }
                  else if(this.filter is DropShadowFilter)
                  {
                     this.dropShadowFilter = this.filter as DropShadowFilter;
                     this.dropShadowFilter.blurX *= param2;
                     this.dropShadowFilter.blurY *= param2;
                     this.dropShadowFilter.distance *= param2;
                     this.dropShadowFilter = null;
                  }
                  ++this.fn;
               }
               param1.getChildAt(_loc3_).filters = this.filters;
            }
            _loc3_++;
         }
      }
      
      private function calculateAbstracts(param1:DisplayObjectContainer, param2:Number, param3:Number) : void
      {
         var _loc5_:DisplayObject = null;
         var _loc6_:int = 0;
         var _loc7_:Rectangle = null;
         var _loc4_:int = 0;
         while(_loc4_ < param1.numChildren)
         {
            _loc5_ = param1.getChildAt(_loc4_) as DisplayObject;
            if(_loc5_ != null && _loc5_.name.substr(0,String("abstract").length) == "abstract")
            {
               _loc5_.visible = false;
               _loc6_ = int(int(_loc5_.name.substr(String("abstract").length + 1)));
               _loc7_ = new Rectangle();
               _loc7_.x = _loc5_.x * param2;
               _loc7_.y = _loc5_.y * param3;
               _loc7_.width = _loc5_.width * param2;
               _loc7_.height = _loc5_.height * param3;
               _loc7_.x -= this.size.x;
               _loc7_.y -= this.size.y;
               this.storeAbstractRectangles[_loc6_] = _loc7_;
            }
            _loc4_++;
         }
      }
      
      internal function getUnalteredSize() : Rectangle
      {
         return this.rawSize as Rectangle;
      }
      
      internal function getUnalteredAbstractRectangle(param1:int) : Rectangle
      {
         return this.storeAbstractRectangles[param1] as Rectangle;
      }
      
      internal function getAbstractRectangle(param1:int, param2:int, param3:int) : Rectangle
      {
         var _loc4_:Rectangle = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         if(this.storeAbstractRectangles[param1] == null)
         {
            DebugAccessPoint.log("HelperDetails.getAbstractRectangle is trying to get abstract:" + param1 + " but it does not exist in child:" + this.containerName + " unknown url path");
            return null;
         }
         _loc4_ = Rectangle(this.storeAbstractRectangles[param1]).clone();
         if(this.scale9Textures == null)
         {
            _loc5_ = param2 / this.size.width;
            _loc6_ = param3 / this.size.height;
            _loc4_.x *= _loc5_;
            _loc4_.y *= _loc6_;
            _loc4_.width *= _loc5_;
            _loc4_.height *= _loc6_;
            return _loc4_;
         }
         _loc7_ = param2 - this.size.width;
         _loc8_ = param3 - this.size.height;
         if(this.inside != null && _loc4_.x > this.inside.x)
         {
            _loc4_.x += _loc7_;
         }
         else
         {
            _loc4_.width += _loc7_;
         }
         if(this.inside != null && _loc4_.y > this.inside.y)
         {
            _loc4_.y += _loc8_;
         }
         else
         {
            _loc4_.height += _loc8_;
         }
         return _loc4_;
      }
      
      public function generateTextureRestorer(param1:TextureAssetLoader) : void
      {
         this.reloadableTexture = new ReloadableTexture(this.texture,param1);
      }
      
      public function dispose() : void
      {
         if(this.reloadableTexture != null)
         {
            this.reloadableTexture.dispose();
         }
         this.texture.root.dispose();
         this.texture.base.dispose();
         this.texture.dispose();
         this.texture = null;
      }
   }
}

