package com.moviestarplanet.dragonbones
{
   import com.moviestarplanet.dragonbones.color.DBWColorMap;
   import com.moviestarplanet.dragonbones.display.IArmatureDisplayWrapper;
   import com.moviestarplanet.dragonbones.event.DBWEvent;
   import com.moviestarplanet.dragonbones.loading.IArmatureLoader;
   import com.moviestarplanet.dragonbones.loading.StarlingBitmapArmatureLoader;
   import dragonBones.Armature;
   import dragonBones.Bone;
   import dragonBones.animation.Animation;
   import dragonBones.animation.AnimationState;
   import dragonBones.animation.WorldClock;
   import dragonBones.events.AnimationEvent;
   import dragonBones.factorys.BaseFactory;
   import dragonBones.factorys.StarlingFactory;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import starling.display.Sprite;
   
   public class DragonBonesWrapper extends EventDispatcher
   {
      
      private static var boneDict:Dictionary = new Dictionary();
      
      public var armatures:Dictionary;
      
      protected var _armatureLoader:IArmatureLoader;
      
      protected var _displayWrapper:IArmatureDisplayWrapper;
      
      private var _loopAmt:int = 1;
      
      private var _color:uint;
      
      private var _typeOfColor:int;
      
      private var _animated:Boolean = false;
      
      private var _armature:Armature;
      
      private var _animState:AnimationState;
      
      private var doneCallback:Function = null;
      
      private var failCallback:Function = null;
      
      private var lastPlayedAnimation:String = "";
      
      public function DragonBonesWrapper(param1:IArmatureLoader = null)
      {
         super();
         this._armatureLoader = param1;
      }
      
      public function getArmature() : Armature
      {
         return _armature;
      }
      
      public function setArmature(param1:Armature) : void
      {
         _armature = param1;
         (getDisplay() as IArmatureDisplayWrapper).armature = _armature;
      }
      
      protected function getAnimated() : Boolean
      {
         return _animated;
      }
      
      protected function setAnimated(param1:Boolean) : void
      {
         if(param1 != _animated)
         {
            _animated = param1;
            if(getArmature())
            {
               if(param1)
               {
                  WorldClock.clock.add(getArmature());
               }
               else
               {
                  WorldClock.clock.remove(getArmature());
               }
            }
         }
      }
      
      public function loadWithAssetManager(param1:String, param2:String, param3:String, param4:Function, param5:Function, param6:Function, param7:Function, param8:Function) : void
      {
         if(param4 == null)
         {
            throw new Error("DragonBonesWrapper.loadWithCallback: callback is null");
         }
         if(getAnimated())
         {
            setAnimated(false);
         }
         doneCallback = param4;
         _armatureLoader.loadArmatureWithAssetManager(param1,param2,param3,armatureLoaded,param5,param6,param7,param8);
      }
      
      public function loadWithCallback(param1:String, param2:String, param3:String, param4:Function, param5:Function) : void
      {
         if(param4 == null)
         {
            throw new Error("DragonBonesWrapper.loadWithCallback: callback is null");
         }
         if(getAnimated())
         {
            setAnimated(false);
         }
         doneCallback = param4;
         _armatureLoader.loadArmature(param1,param2,param3,armatureLoaded,param5);
      }
      
      public function addAnimationData(param1:AnimationDataValueObject) : void
      {
         if(_armatureLoader is StarlingBitmapArmatureLoader)
         {
            StarlingBitmapArmatureLoader(_armatureLoader).addAnimationData(param1);
         }
      }
      
      public function play(param1:String, param2:* = null) : void
      {
         var _loc3_:int = 0;
         if(param2 == null)
         {
            _loc3_ = 1;
         }
         else if(param2 is int)
         {
            _loc3_ = param2;
         }
         else if(param2 is Boolean)
         {
            if(param2)
            {
               _loc3_ = 0;
            }
            else
            {
               _loc3_ = 1;
            }
         }
         playAnimation(param1,-1,-1,_loc3_);
      }
      
      public function getDisplay() : Object
      {
         if(_displayWrapper == null)
         {
            _displayWrapper = _armatureLoader.createDisplayWrapper();
         }
         return _displayWrapper;
      }
      
      private function playAnimation(param1:String, param2:int = -1, param3:int = -1, param4:int = 1) : void
      {
         if(getArmature() == null || _armatureLoader == null)
         {
            return;
         }
         if(getArmature().animation == null)
         {
            return;
         }
         var _loc8_:Boolean = hasAnimation(getArmature(),param1);
         var _loc6_:ArmatureLoaderFactoryCollection = ArmatureLoaderFactoryCollection.getInstance();
         var _loc7_:BaseFactory = _loc6_.getFactory(param1) as StarlingFactory;
         var _loc5_:Boolean = false;
         if(_loc7_)
         {
            _loc5_ = true;
         }
         if(!_loc8_ && (_armatureLoader is StarlingBitmapArmatureLoader && StarlingBitmapArmatureLoader(_armatureLoader).canLoadAnimation(param1) == false))
         {
            return;
         }
         if(_animState)
         {
            _animState.stop();
         }
         var _loc9_:Boolean = param1 != lastPlayedAnimation;
         if(_loc9_)
         {
            if(_armatureLoader is StarlingBitmapArmatureLoader)
            {
               StarlingBitmapArmatureLoader(_armatureLoader).revertToOriginal(this);
            }
         }
         lastPlayedAnimation = param1;
         _loopAmt = param4;
         if(_loc8_)
         {
            if(_loc5_ && _loc9_)
            {
               _armatureLoader.setAlreadyLoadedData(this,param1,armatureReady);
            }
            else
            {
               armatureReady(param1);
            }
         }
         else
         {
            _armatureLoader.loadAnimationData(this,param1,armatureReady);
         }
      }
      
      protected function hasAnimation(param1:Armature, param2:String) : Boolean
      {
         return recursiveHasAnimation(param1,param2);
      }
      
      final private function armatureReady(param1:String) : void
      {
         doAnimation(param1,-1,-1,_loopAmt);
      }
      
      private function recursiveHasAnimation(param1:Armature, param2:String) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc6_:int = 0;
         var _loc4_:* = undefined;
         var _loc5_:* = 0;
         if(param1 == null)
         {
            return false;
         }
         if(param1.animation.hasAnimation(param2))
         {
            return true;
         }
         _loc3_ = false;
         _loc6_ = 0;
         _loc4_ = param1.getBones(false);
         _loc5_ = uint(_loc4_.length);
         while(_loc6_ < _loc5_)
         {
            if(recursiveHasAnimation(_loc4_[_loc6_].childArmature,param2))
            {
               _loc3_ = true;
            }
            _loc6_++;
         }
         return _loc3_;
      }
      
      private function recursiveTryAnimation(param1:Armature, param2:String, param3:int = -1, param4:int = -1, param5:int = 1, param6:int = 0) : void
      {
         var _loc9_:int = 0;
         var _loc7_:* = undefined;
         var _loc8_:* = 0;
         if(param1 == null)
         {
            return;
         }
         if(param1.animation.hasAnimation(param2))
         {
            _animState = param1.animation.gotoAndPlay(param2,0,param4,param5,0,null,"all");
         }
         else
         {
            _loc9_ = 0;
            _loc7_ = param1.getBones(false);
            _loc8_ = uint(_loc7_.length);
            while(_loc9_ < _loc8_)
            {
               recursiveTryAnimation(_loc7_[_loc9_].childArmature,param2,param3,param4,param5,param6 + 1);
               _loc9_++;
            }
         }
      }
      
      private function finishAnim(param1:AnimationEvent) : void
      {
         getArmature().removeEventListener("complete",finishAnim);
         _animState.stop();
         _animState = null;
         dispatchEvent(new DBWEvent("Bonster.ANIMATION_COMPLETE"));
      }
      
      private function doAnimation(param1:String, param2:int = -1, param3:int = -1, param4:int = 1) : void
      {
         setAnimated(true);
         recursiveTryAnimation(getArmature(),param1,param2,param3,param4,0);
         if(_animState)
         {
            if(param4 >= 1)
            {
               getArmature().addEventListener("complete",finishAnim);
            }
         }
      }
      
      public function armatureLoaded(param1:Armature) : void
      {
         if(param1 == null)
         {
            return;
         }
         setArmature(param1);
         armatures = buildArmatureMap(getArmature());
         if(doneCallback != null)
         {
            doneCallback(this);
         }
         else
         {
            trace("DragonBonesWrapper.armatureLoaded() has NO CALL BACK");
         }
      }
      
      public function buildArmatureMap(param1:Armature) : Dictionary
      {
         var _loc2_:Dictionary = new Dictionary();
         _loc2_[param1.name] = param1;
         findSubArmatures(param1,_loc2_);
         return _loc2_;
      }
      
      private function findSubArmatures(param1:Armature, param2:Dictionary) : void
      {
         var _loc4_:Bone = null;
         var _loc6_:* = 0;
         var _loc3_:Vector.<Bone> = param1.getBones(false);
         var _loc5_:uint = uint(_loc3_.length);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = _loc3_[_loc6_];
            if(_loc4_.childArmature)
            {
               param2[_loc4_.childArmature.name] = _loc4_.childArmature;
               findSubArmatures(_loc4_.childArmature,param2);
            }
            _loc6_++;
         }
      }
      
      public function findBoneRecursively(param1:String) : Bone
      {
         var _loc3_:* = null;
         var _loc10_:* = undefined;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc4_:* = null;
         var _loc2_:* = undefined;
         var _loc9_:Bone = null;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc11_:Vector.<Bone> = new Vector.<Bone>();
         for each(_loc3_ in armatures)
         {
            _loc11_.length = 0;
            _loc10_ = _loc3_.getBones(false);
            _loc6_ = uint(_loc10_.length);
            _loc11_.length = _loc6_;
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc11_[_loc5_] = _loc10_[_loc5_];
               _loc5_++;
            }
            while(_loc11_.length >= 1)
            {
               _loc9_ = _loc11_.shift();
               if(_loc9_.name == param1)
               {
                  return _loc9_;
               }
               if(_loc9_.childArmature != null)
               {
                  _loc2_ = _loc9_.childArmature.getBones(false);
                  _loc7_ = uint(_loc2_.length);
                  _loc8_ = 0;
                  while(_loc8_ < _loc7_)
                  {
                     _loc11_.push(_loc2_[_loc8_]);
                     _loc8_++;
                  }
               }
            }
         }
         return null;
      }
      
      public function getBone(param1:String) : Bone
      {
         var _loc3_:Bone = null;
         for each(var _loc2_ in armatures)
         {
            _loc3_ = _loc2_.getBone(param1);
            if(_loc3_ != null)
            {
               return _loc3_;
            }
         }
         return getBoneIgnoreCase(param1);
      }
      
      public function getBoneIgnoreCase(param1:String) : Bone
      {
         var _loc5_:* = undefined;
         var _loc6_:Bone = null;
         var _loc4_:String = null;
         var _loc3_:String = null;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         for each(var _loc2_ in armatures)
         {
            _loc5_ = _loc2_.getBones(false);
            _loc7_ = uint(_loc5_.length);
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               _loc6_ = _loc5_[_loc8_];
               if(_loc6_.name == param1)
               {
                  return _loc6_;
               }
               if(!boneDict[_loc6_.name])
               {
                  _loc4_ = _loc6_.name.toLowerCase().split(" ").join("");
                  boneDict[_loc6_.name] = _loc4_;
               }
               _loc4_ = boneDict[_loc6_.name];
               if(!boneDict[param1])
               {
                  boneDict[param1] = param1.toLowerCase().split(" ").join("");
               }
               _loc3_ = boneDict[param1];
               if(_loc4_ == _loc3_)
               {
                  return _loc6_;
               }
               _loc8_++;
            }
         }
         return null;
      }
      
      public function removeBone(param1:String) : void
      {
         var _loc2_:Bone = getBone(param1);
         if(_loc2_ != null)
         {
            _loc2_.armature.removeBone(_loc2_);
         }
      }
      
      public function colorize(param1:Object, param2:String = "color", param3:Array = null, param4:String = "pattern", param5:int = 1) : void
      {
         var _loc6_:* = 0;
         var _loc10_:int = 0;
         var _loc7_:Array = null;
         var _loc8_:* = 0;
         var _loc11_:String = null;
         var _loc9_:int = 0;
         if(param1 == null)
         {
            return;
         }
         var _loc13_:int = 0;
         if(armatures == null)
         {
            armatures = buildArmatureMap(getArmature());
         }
         var _loc12_:Array = DBWUtils.convertObjectToArray(param1);
         var _loc14_:DBWColorMap = new DBWColorMap();
         if(_loc12_ != null)
         {
            _loc6_ = uint(_loc12_.length);
            _loc10_ = param5;
            while(_loc10_ < _loc6_ + param5)
            {
               _loc14_.reset();
               _loc14_.buildColorMap(armatures,param2 + _loc10_);
               if(_loc14_.colorablesSize <= 0)
               {
                  break;
               }
               _loc13_++;
               _loc14_.applySingleColor(_loc12_[_loc10_ - param5] as uint);
               _loc10_++;
            }
         }
         if(_loc13_ == 0)
         {
            trace("Warning: No base color found on DragonBoneWrapper");
         }
         if(param3 != null)
         {
            _loc7_ = DBWUtils.convertObjectToArray(param3);
            if(_loc7_ != null)
            {
               _loc8_ = uint(_loc7_.length);
               _loc9_ = param5;
               while(_loc9_ < _loc8_ + param5)
               {
                  _loc14_.reset();
                  _loc11_ = param4 + _loc9_ + "_";
                  _loc14_.buildColorMap(armatures,_loc11_);
                  _loc14_.applySingleColor(_loc7_[_loc9_ + _loc13_ - param5]);
                  _loc9_++;
               }
            }
         }
         _loc14_.destroy();
      }
      
      public function changeSpeed(param1:int) : void
      {
         var _loc2_:Animation = getArmature().animation;
         if(param1 > 0)
         {
            if(_loc2_.timeScale < 10)
            {
               _loc2_.timeScale += 0.1;
            }
         }
         else if(_loc2_.timeScale > 0.2)
         {
            _loc2_.timeScale -= 0.1;
         }
      }
      
      public function set typeOfColor(param1:int) : void
      {
         _typeOfColor = param1;
      }
      
      public function stop() : void
      {
         setAnimated(false);
      }
      
      public function resume() : void
      {
         setAnimated(true);
      }
      
      public function gotoAndPlay(param1:Number) : void
      {
         var _loc2_:Armature = getArmature();
         _loc2_.animation.gotoAndPlay(lastPlayedAnimation.toLowerCase(),-1,-1,param1);
      }
      
      public function gotoAndStop(param1:Number) : void
      {
         var _loc2_:Armature = getArmature();
         _loc2_.animation.gotoAndStop(lastPlayedAnimation.toLowerCase(),param1);
         setAnimated(false);
      }
      
      public function dispose() : void
      {
         var _loc1_:* = undefined;
         setAnimated(false);
         if(_armatureLoader is StarlingBitmapArmatureLoader)
         {
            StarlingBitmapArmatureLoader(_armatureLoader).revertToOriginal(this);
         }
         if(_displayWrapper != null)
         {
            if(_displayWrapper is Sprite)
            {
               (_displayWrapper as Sprite).removeChildren(0,-1,true);
               (_displayWrapper as Sprite).dispose();
            }
            _displayWrapper.armature = null;
            _displayWrapper = null;
         }
         if(_armatureLoader != null)
         {
            _armatureLoader.destroy();
            _armatureLoader = null;
         }
         if(_armature != null)
         {
            _armature.dispose();
            _armature = null;
         }
         for(_loc1_ in armatures)
         {
            (armatures[_loc1_] as Armature).dispose();
            delete armatures[_loc1_];
         }
         armatures = null;
         _animState = null;
         doneCallback = null;
         failCallback = null;
      }
   }
}

