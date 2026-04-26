package com.moviestarplanet.assetManager.optimizedAlternatives
{
   import com.moviestarplanet.assetManager.UnionRep;
   import com.moviestarplanet.assetManager.resources.HelperDetailsResourceWrapper;
   import com.moviestarplanet.commonaccesspoints.DebugAccessPoint;
   import flash.geom.Rectangle;
   import starling.display.DisplayObjectContainer;
   import starling.display.Image;
   import starling.display.Quad;
   
   public class SWFChildAsStarlingImage extends Image
   {
      
      private var _details:HelperDetails;
      
      private var detailsWrapper:HelperDetailsResourceWrapper;
      
      public function SWFChildAsStarlingImage(param1:UnionRep, param2:HelperDetailsResourceWrapper)
      {
         this.detailsWrapper = param2;
         this.detailsWrapper.subscribe(this);
         this._details = this.detailsWrapper.getHelperDetails(this);
         super(this._details.texture);
         if(param1 == null)
         {
            throw new Error("SWFChildAsStarlingImage can only be instantiated from AssetManager");
         }
      }
      
      public static function create(param1:UnionRep, param2:HelperDetailsResourceWrapper) : SWFChildAsStarlingImage
      {
         return new SWFChildAsStarlingImage(param1,param2);
      }
      
      public function getAbstractRectangle(param1:int) : Rectangle
      {
         return this._details.getAbstractRectangle(param1,width,height);
      }
      
      public function positionRelativeToAbstract(param1:int, param2:Number, param3:Number) : void
      {
         var _loc4_:Rectangle = this._details.getAbstractRectangle(param1,width,height);
         x = int(param2 - _loc4_.x);
         y = int(param3 - _loc4_.y);
      }
      
      public function sizeRelativeToAbstract(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:Rectangle = this._details.getUnalteredAbstractRectangle(param1);
         if(_loc4_ == null)
         {
            DebugAccessPoint.log("Error in the abstract details for:" + this._details.assetKey);
            return;
         }
         var _loc5_:Number = param2 / _loc4_.width;
         var _loc6_:Number = param3 / _loc4_.height;
         width = this._details.size.width * _loc5_;
         height = this._details.size.height * _loc6_;
      }
      
      public function showHelpers() : void
      {
         var _loc3_:Object = null;
         var _loc4_:Rectangle = null;
         var _loc5_:Quad = null;
         var _loc6_:Quad = null;
         var _loc7_:Quad = null;
         var _loc8_:Quad = null;
         var _loc1_:DisplayObjectContainer = this.parent;
         if(_loc1_ == null)
         {
            throw new Error("to showHelpers() on an image, you need to have added it as a child of a stage already");
         }
         var _loc2_:Quad = new Quad(this._details.size.width,this._details.size.height,255);
         _loc2_.alpha = 0.2;
         _loc2_.x = this.x;
         _loc2_.y = this.y;
         _loc1_.addChild(_loc2_);
         for(_loc3_ in this._details.storeAbstractRectangles)
         {
            _loc4_ = this._details.getAbstractRectangle(int(_loc3_),width,height);
            _loc5_ = new Quad(1,_loc4_.height,16711680);
            _loc5_.x = int(_loc4_.x);
            _loc5_.y = int(_loc4_.y);
            _loc5_.x += this.x;
            _loc5_.y += this.y;
            _loc1_.addChild(_loc5_);
            _loc6_ = new Quad(1,_loc4_.height,16711680);
            _loc6_.x = int(_loc4_.x + _loc4_.width);
            _loc6_.y = int(_loc4_.y);
            _loc6_.x += this.x;
            _loc6_.y += this.y;
            _loc1_.addChild(_loc6_);
            _loc7_ = new Quad(_loc4_.width,1,16711680);
            _loc7_.x = int(_loc4_.x);
            _loc7_.y = int(_loc4_.y);
            _loc7_.x += this.x;
            _loc7_.y += this.y;
            _loc1_.addChild(_loc7_);
            _loc8_ = new Quad(_loc4_.width,1,16711680);
            _loc8_.x = int(_loc4_.x);
            _loc8_.y = int(_loc4_.y + _loc4_.height);
            _loc8_.x += this.x;
            _loc8_.y += this.y;
            _loc1_.addChild(_loc8_);
         }
      }
      
      override public function dispose() : void
      {
         this._details = null;
         if(this.detailsWrapper != null)
         {
            this.detailsWrapper.unsubscribe(this);
         }
         this.detailsWrapper = null;
         super.dispose();
      }
   }
}

