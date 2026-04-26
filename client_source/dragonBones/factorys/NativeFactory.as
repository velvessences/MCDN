package dragonBones.factorys
{
   import dragonBones.Armature;
   import dragonBones.Slot;
   import dragonBones.core.dragonBones_internal;
   import dragonBones.display.NativeSlot;
   import dragonBones.textures.ITextureAtlas;
   import dragonBones.textures.NativeTextureAtlas;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   use namespace dragonBones_internal;
   
   public class NativeFactory extends BaseFactory
   {
      
      public var fillBitmapSmooth:Boolean;
      
      public var useBitmapDataTexture:Boolean;
      
      public function NativeFactory()
      {
         super(this);
      }
      
      override protected function generateTextureAtlas(param1:Object, param2:Object) : ITextureAtlas
      {
         return new NativeTextureAtlas(param1,param2,1,false);
      }
      
      override protected function generateArmature() : Armature
      {
         var _loc2_:Sprite = new Sprite();
         return new Armature(_loc2_);
      }
      
      override protected function generateSlot() : Slot
      {
         return new NativeSlot();
      }
      
      override protected function generateDisplay(param1:Object, param2:String, param3:Number, param4:Number) : Object
      {
         var _loc8_:NativeTextureAtlas = null;
         var _loc10_:MovieClip = null;
         var _loc5_:Object = null;
         var _loc7_:Rectangle = null;
         var _loc6_:Rectangle = null;
         var _loc9_:Shape = null;
         if(param1 is NativeTextureAtlas)
         {
            _loc8_ = param1 as NativeTextureAtlas;
         }
         if(_loc8_)
         {
            _loc10_ = _loc8_.movieClip;
            if(useBitmapDataTexture && _loc10_)
            {
               _loc8_.movieClipToBitmapData();
            }
            if(!useBitmapDataTexture && _loc10_ && _loc10_.totalFrames >= 3)
            {
               _loc10_.gotoAndStop(_loc10_.totalFrames);
               _loc10_.gotoAndStop(param2);
               if(_loc10_.numChildren > 0)
               {
                  try
                  {
                     _loc5_ = _loc10_.getChildAt(0);
                     _loc5_.x = 0;
                     _loc5_.y = 0;
                     return _loc5_;
                  }
                  catch(e:Error)
                  {
                     throw new Error("Can not get the movie clip, please make sure the version of the resource compatible with app version!");
                  }
               }
            }
            else
            {
               if(!_loc8_.bitmapData)
               {
                  throw new Error();
               }
               _loc7_ = _loc8_.getRegion(param2);
               if(_loc7_)
               {
                  _loc6_ = _loc8_.getFrame(param2);
                  if(_loc6_)
                  {
                     param3 += _loc6_.x;
                     param4 += _loc6_.y;
                  }
                  _loc9_ = new Shape();
                  _helpMatrix.a = 1;
                  _helpMatrix.b = 0;
                  _helpMatrix.c = 0;
                  _helpMatrix.d = 1;
                  _helpMatrix.scale(1 / _loc8_.scale,1 / _loc8_.scale);
                  _helpMatrix.tx = -param3 - _loc7_.x;
                  _helpMatrix.ty = -param4 - _loc7_.y;
                  _loc9_.graphics.beginBitmapFill(_loc8_.bitmapData,_helpMatrix,false,fillBitmapSmooth);
                  _loc9_.graphics.drawRect(-param3,-param4,_loc7_.width,_loc7_.height);
                  return _loc9_;
               }
            }
         }
         return null;
      }
   }
}

