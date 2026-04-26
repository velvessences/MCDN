package com.moviestarplanet.assetManager.optimizedAlternatives
{
   import com.moviestarplanet.assetManager.UnionRep;
   import com.moviestarplanet.assetManager.resources.HelperDetailsResourceWrapper;
   import feathers.display.Scale9Image;
   import flash.geom.Rectangle;
   import starling.display.Quad;
   
   public class SWFChildAsStarlingScale9 extends Scale9Image
   {
      
      private namespace AssetManagerNS = "AssetManager";
      
      internal var url:String = "";
      
      internal var childName:String = "";
      
      internal var keyScale:Number = 1;
      
      private var _details:HelperDetails;
      
      private var _detailsResourceWrapper:HelperDetailsResourceWrapper;
      
      public function SWFChildAsStarlingScale9(param1:UnionRep, param2:HelperDetailsResourceWrapper)
      {
         this._detailsResourceWrapper = param2;
         this._detailsResourceWrapper.subscribe(this);
         this._details = this._detailsResourceWrapper.getHelperDetails(this);
         if(this._details.scale9Textures == null)
         {
            trace("--------------------------");
            trace("--------------------------");
            trace("------- Scale 9 from AssetManager needs to be formatted correctly, ie: with an \"inside\" display object that determins the 9slice dimensions");
            trace("--------------------------");
            trace("--------------------------");
         }
         super(this._details.scale9Textures);
         if(param1 == null)
         {
            throw new Error("SWFChildAsStarlingScale9 can only be instantiated from AssetManager");
         }
      }
      
      public static function create(param1:UnionRep, param2:HelperDetailsResourceWrapper) : SWFChildAsStarlingScale9
      {
         return new SWFChildAsStarlingScale9(param1,param2);
      }
      
      public function clone() : SWFChildAsStarlingScale9
      {
         return SWFChildAsStarlingScale9.create(UnionRep.instance,this._detailsResourceWrapper);
      }
      
      public function getUnalteredSize() : Rectangle
      {
         return this._details.getUnalteredSize();
      }
      
      public function getUnalteredAbstractRectangle(param1:int) : Rectangle
      {
         return this._details.getUnalteredAbstractRectangle(param1);
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
         width = int(param2 + (this._details.size.width - _loc4_.width));
         height = int(param3 + (this._details.size.height - _loc4_.height));
      }
      
      public function getScale9ScaledX() : Number
      {
         return this._details.scaleX;
      }
      
      public function getScale9ScaledY() : Number
      {
         return this._details.scaleY;
      }
      
      public function showHelpers() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Rectangle = null;
         var _loc3_:Quad = null;
         var _loc4_:Quad = null;
         var _loc5_:Quad = null;
         var _loc6_:Quad = null;
         for(_loc1_ in this._details.storeAbstractRectangles)
         {
            _loc2_ = this._details.getAbstractRectangle(int(_loc1_),width,height);
            _loc3_ = new Quad(1,_loc2_.height,16711680);
            _loc3_.x = int(_loc2_.x);
            _loc3_.y = int(_loc2_.y);
            addChild(_loc3_);
            _loc4_ = new Quad(1,_loc2_.height,16711680);
            _loc4_.x = int(_loc2_.x + _loc2_.width);
            _loc4_.y = int(_loc2_.y);
            addChild(_loc4_);
            _loc5_ = new Quad(_loc2_.width,1,16711680);
            _loc5_.x = int(_loc2_.x);
            _loc5_.y = int(_loc2_.y);
            addChild(_loc5_);
            _loc6_ = new Quad(_loc2_.width,1,16711680);
            _loc6_.x = int(_loc2_.x);
            _loc6_.y = int(_loc2_.y + _loc2_.height);
            addChild(_loc6_);
         }
      }
      
      override public function dispose() : void
      {
         this._details = null;
         if(this._detailsResourceWrapper != null)
         {
            this._detailsResourceWrapper.unsubscribe(this);
         }
         this._detailsResourceWrapper = null;
         super.dispose();
      }
   }
}

