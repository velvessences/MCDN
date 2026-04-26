package dragonBones.factorys
{
   import dragonBones.Armature;
   import dragonBones.Bone;
   import dragonBones.Slot;
   import dragonBones.core.dragonBones_internal;
   import dragonBones.objects.ArmatureData;
   import dragonBones.objects.BoneData;
   import dragonBones.objects.DataParser;
   import dragonBones.objects.DecompressedData;
   import dragonBones.objects.DisplayData;
   import dragonBones.objects.SkeletonData;
   import dragonBones.objects.SkinData;
   import dragonBones.objects.SlotData;
   import dragonBones.textures.ITextureAtlas;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   use namespace dragonBones_internal;
   
   public class BaseFactory extends EventDispatcher
   {
      
      protected static const _helpMatrix:Matrix = new Matrix();
      
      private static const _loaderContext:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
      
      protected var _dataDic:Object;
      
      protected var _textureAtlasDic:Object;
      
      protected var _currentDataName:String;
      
      protected var _currentTextureAtlasName:String;
      
      protected var _textureAtlasLoadingDic:Object = {};
      
      public function BaseFactory(param1:BaseFactory)
      {
         super(this);
         if(param1 != this)
         {
            throw new IllegalOperationError("Abstract class can not be instantiated!");
         }
         _loaderContext.allowCodeImport = true;
         _dataDic = {};
         _textureAtlasDic = {};
         _currentDataName = null;
         _currentTextureAtlasName = null;
      }
      
      public function getSkeletonData(param1:String) : SkeletonData
      {
         return _dataDic[param1];
      }
      
      public function addSkeletonData(param1:SkeletonData, param2:String = null) : void
      {
         if(!param1)
         {
            throw new ArgumentError();
         }
         param2 ||= param1.name;
         if(!param2)
         {
            throw new ArgumentError("Unnamed data!");
         }
         if(_dataDic[param2])
         {
            throw new ArgumentError();
         }
         _dataDic[param2] = param1;
      }
      
      public function removeSkeletonData(param1:String) : void
      {
         delete _dataDic[param1];
      }
      
      public function getTextureAtlas(param1:String) : Object
      {
         return _textureAtlasDic[param1];
      }
      
      public function addTextureAtlas(param1:Object, param2:String = null) : void
      {
         if(!param1)
         {
            throw new ArgumentError();
         }
         if(!param2 && param1 is ITextureAtlas)
         {
            param2 = param1.name;
         }
         if(!param2)
         {
            throw new ArgumentError("Unnamed data!");
         }
         if(_textureAtlasDic[param2])
         {
            throw new ArgumentError();
         }
         _textureAtlasDic[param2] = param1;
      }
      
      public function removeTextureAtlas(param1:String) : void
      {
         delete _textureAtlasDic[param1];
      }
      
      public function dispose(param1:Boolean = true) : void
      {
         if(param1)
         {
            for(var _loc3_ in _dataDic)
            {
               (_dataDic[_loc3_] as SkeletonData).dispose();
               delete _dataDic[_loc3_];
            }
            for(var _loc2_ in _textureAtlasDic)
            {
               (_textureAtlasDic[_loc2_] as ITextureAtlas).dispose();
               delete _textureAtlasDic[_loc2_];
            }
            _dataDic = null;
            _textureAtlasDic = null;
         }
         _currentDataName = null;
         _currentTextureAtlasName = null;
      }
      
      public function buildArmature(param1:String, param2:String = null, param3:String = null, param4:String = null, param5:String = null) : Armature
      {
         var _loc10_:SkeletonData = null;
         var _loc12_:ArmatureData = null;
         var _loc8_:ArmatureData = null;
         var _loc11_:SkinData = null;
         var _loc7_:* = null;
         var _loc6_:SkinData = null;
         if(param3)
         {
            _loc10_ = _dataDic[param3];
            if(_loc10_)
            {
               _loc12_ = _loc10_.getArmatureData(param1);
            }
         }
         else
         {
            for(param3 in _dataDic)
            {
               _loc10_ = _dataDic[param3];
               _loc12_ = _loc10_.getArmatureData(param1);
               if(_loc12_)
               {
                  break;
               }
            }
         }
         if(!_loc12_)
         {
            return null;
         }
         _currentDataName = param3;
         _currentTextureAtlasName = param4 || param3;
         if(param2 && param2 != param1)
         {
            _loc8_ = _loc10_.getArmatureData(param2);
            if(!_loc8_)
            {
               for(param3 in _dataDic)
               {
                  _loc10_ = _dataDic[param3];
                  _loc8_ = _loc10_.getArmatureData(param2);
                  if(_loc8_)
                  {
                     break;
                  }
               }
            }
            if(_loc8_)
            {
               _loc6_ = _loc8_.getSkinData("");
            }
         }
         _loc11_ = _loc12_.getSkinData(param5);
         var _loc9_:Armature = generateArmature();
         _loc9_.name = param1;
         _loc9_._armatureData = _loc12_;
         if(_loc8_)
         {
            _loc9_.animation.animationDataList = _loc8_.animationDataList;
         }
         else
         {
            _loc9_.animation.animationDataList = _loc12_.animationDataList;
         }
         buildBones(_loc9_,_loc12_);
         if(_loc11_)
         {
            buildSlots(_loc9_,_loc12_,_loc11_,_loc6_);
         }
         _loc9_.advanceTime(0);
         return _loc9_;
      }
      
      public function addAnimationToArmature(param1:Object, param2:Armature) : void
      {
         param2._armatureData.addAnimationData(DataParser.parseAnimationDataByAnimationRawData(param1,param2._armatureData));
      }
      
      public function getTextureDisplay(param1:String, param2:String = null, param3:Number = NaN, param4:Number = NaN) : Object
      {
         var _loc6_:Object = null;
         var _loc7_:SkeletonData = null;
         var _loc5_:Point = null;
         if(param2)
         {
            _loc6_ = _textureAtlasDic[param2];
         }
         if(!_loc6_ && !param2)
         {
            for(param2 in _textureAtlasDic)
            {
               _loc6_ = _textureAtlasDic[param2];
               if(_loc6_.getRegion(param1))
               {
                  break;
               }
               _loc6_ = null;
            }
         }
         if(_loc6_)
         {
            if(isNaN(param3) || Boolean(isNaN(param4)))
            {
               _loc7_ = _dataDic[param2];
               if(_loc7_)
               {
                  _loc5_ = _loc7_.getSubTexturePivot(param1);
                  if(_loc5_)
                  {
                     param3 = Number(_loc5_.x);
                     param4 = Number(_loc5_.y);
                  }
               }
            }
            return generateDisplay(_loc6_,param1,param3,param4);
         }
         return null;
      }
      
      protected function buildBones(param1:Armature, param2:ArmatureData) : void
      {
         var _loc5_:int = 0;
         var _loc4_:BoneData = null;
         var _loc3_:Bone = null;
         _loc5_ = 0;
         while(_loc5_ < param2.boneDataList.length)
         {
            _loc4_ = param2.boneDataList[_loc5_];
            _loc3_ = new Bone();
            _loc3_.name = _loc4_.name;
            _loc3_.inheritRotation = _loc4_.inheritRotation;
            _loc3_.inheritScale = _loc4_.inheritScale;
            _loc3_.origin.copy(_loc4_.transform);
            if(param2.getBoneData(_loc4_.parent))
            {
               param1.addBone(_loc3_,_loc4_.parent);
            }
            else
            {
               param1.addBone(_loc3_);
            }
            _loc5_++;
         }
      }
      
      protected function buildSlots(param1:Armature, param2:ArmatureData, param3:SkinData, param4:SkinData) : void
      {
         var _loc5_:SlotData = null;
         var _loc6_:int = 0;
         var _loc10_:Bone = null;
         var _loc14_:Slot = null;
         var _loc8_:int = 0;
         var _loc15_:DisplayData = null;
         var _loc7_:DisplayData = null;
         var _loc11_:SlotData = null;
         var _loc13_:Armature = null;
         var _loc9_:Array = [];
         var _loc12_:int = int(param3.slotDataList.length);
         _loc6_ = 0;
         while(_loc6_ < _loc12_)
         {
            _loc5_ = param3.slotDataList[_loc6_];
            _loc10_ = param1.getBone(_loc5_.parent);
            if(_loc10_)
            {
               _loc14_ = generateSlot();
               _loc14_.name = _loc5_.name;
               _loc14_.blendMode = _loc5_.blendMode;
               _loc14_._originZOrder = _loc5_.zOrder;
               _loc14_._displayDataList = _loc5_.displayDataList;
               _loc9_.length = 0;
               _loc8_ = int(_loc5_.displayDataList.length);
               while(_loc8_--)
               {
                  switch((_loc15_ = _loc5_.displayDataList[_loc8_]).type)
                  {
                     case "armature":
                        _loc7_ = null;
                        if(param4)
                        {
                           _loc11_ = param4.getSlotData(_loc5_.name);
                           if(_loc11_)
                           {
                              _loc7_ = _loc11_.displayDataList[_loc8_];
                           }
                        }
                        _loc13_ = buildArmature(_loc15_.name,_loc7_ ? _loc7_.name : null,_currentDataName,_currentTextureAtlasName);
                        if(_loc13_)
                        {
                           _loc9_[_loc8_] = _loc13_;
                        }
                        break;
                     case "image":
                        _loc9_[_loc8_] = generateDisplay(_textureAtlasDic[_currentTextureAtlasName],_loc15_.name,_loc15_.pivot.x,_loc15_.pivot.y);
                  }
               }
               _loc10_.addChild(_loc14_);
               _loc14_.displayList = _loc9_;
               _loc14_.changeDisplay(0);
            }
            _loc6_++;
         }
      }
      
      protected function generateTextureAtlas(param1:Object, param2:Object) : ITextureAtlas
      {
         return null;
      }
      
      protected function generateArmature() : Armature
      {
         return null;
      }
      
      protected function generateSlot() : Slot
      {
         return null;
      }
      
      protected function generateDisplay(param1:Object, param2:String, param3:Number, param4:Number) : Object
      {
         return null;
      }
      
      public function parseData(param1:ByteArray, param2:String = null, param3:Boolean = false, param4:Dictionary = null) : SkeletonData
      {
         if(!param1)
         {
            throw new ArgumentError();
         }
         var _loc7_:DecompressedData = DataParser.decompressData(param1);
         var _loc6_:SkeletonData = DataParser.parseData(_loc7_.dragonBonesData,param3,param4);
         param2 ||= _loc6_.name;
         addSkeletonData(_loc6_,param2);
         var _loc5_:Loader = new Loader();
         _loc5_.name = param2;
         _textureAtlasLoadingDic[param2] = _loc7_.textureAtlasData;
         _loc5_.contentLoaderInfo.addEventListener("complete",loaderCompleteHandler);
         _loc5_.loadBytes(_loc7_.textureBytes,_loaderContext);
         _loc7_.dispose();
         return _loc6_;
      }
      
      protected function loaderCompleteHandler(param1:Event) : void
      {
         var _loc4_:Object = null;
         param1.target.removeEventListener("complete",loaderCompleteHandler);
         var _loc5_:Loader = param1.target.loader;
         var _loc2_:Object = param1.target.content;
         _loc5_.unloadAndStop();
         var _loc6_:String = _loc5_.name;
         var _loc3_:Object = _textureAtlasLoadingDic[_loc6_];
         delete _textureAtlasLoadingDic[_loc6_];
         if(_loc6_ && _loc3_)
         {
            if(_loc2_ is Bitmap)
            {
               _loc2_ = (_loc2_ as Bitmap).bitmapData;
            }
            else if(_loc2_ is Sprite)
            {
               _loc2_ = (_loc2_ as Sprite).getChildAt(0) as MovieClip;
            }
            _loc4_ = generateTextureAtlas(_loc2_,_loc3_);
            addTextureAtlas(_loc4_,_loc6_);
            _loc6_ = null;
            var _loc8_:int = 0;
            var _loc7_:Object = _textureAtlasLoadingDic;
            for(_loc6_ in _loc7_)
            {
            }
            if(!_loc6_ && Boolean(this.hasEventListener("complete")))
            {
               this.dispatchEvent(new Event("complete"));
            }
         }
      }
   }
}

