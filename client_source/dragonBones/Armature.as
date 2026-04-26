package dragonBones
{
   import dragonBones.animation.Animation;
   import dragonBones.animation.AnimationState;
   import dragonBones.animation.IAnimatable;
   import dragonBones.animation.TimelineState;
   import dragonBones.core.DBObject;
   import dragonBones.core.dragonBones_internal;
   import dragonBones.events.ArmatureEvent;
   import dragonBones.events.FrameEvent;
   import dragonBones.events.SoundEvent;
   import dragonBones.events.SoundEventManager;
   import dragonBones.objects.ArmatureData;
   import dragonBones.objects.Frame;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   use namespace dragonBones_internal;
   
   public class Armature extends EventDispatcher implements IAnimatable
   {
      
      private static const sortingIndex:String = "0";
      
      private static const sortingAlgorithm:uint = 18;
      
      private static const _soundManager:SoundEventManager = SoundEventManager.getInstance();
      
      public var name:String;
      
      public var userData:Object;
      
      dragonBones_internal var _slotsZOrderChanged:Boolean;
      
      dragonBones_internal var _eventList:Vector.<Event>;
      
      protected var _slotList:Vector.<Slot>;
      
      private var _slotDictionary:Dictionary;
      
      protected var _boneList:Vector.<Bone>;
      
      private var _boneDictionary:Dictionary;
      
      private var _delayDispose:Boolean;
      
      private var _lockDispose:Boolean;
      
      dragonBones_internal var _armatureData:ArmatureData;
      
      protected var _display:Object;
      
      protected var _animation:Animation;
      
      protected var _cacheFrameRate:int;
      
      private var helpArray:Array = [];
      
      private var helpArraySwap:Array = [];
      
      public function Armature(param1:Object)
      {
         super(this);
         _display = param1;
         _animation = new Animation(this);
         dragonBones_internal::_slotsZOrderChanged = false;
         _slotList = new Vector.<Slot>();
         _slotList.fixed = true;
         _slotDictionary = new Dictionary();
         _boneList = new Vector.<Bone>();
         _boneList.fixed = true;
         _boneDictionary = new Dictionary();
         dragonBones_internal::_eventList = new Vector.<Event>();
         _delayDispose = false;
         _lockDispose = false;
         dragonBones_internal::_armatureData = null;
         _cacheFrameRate = 0;
      }
      
      public function get armatureData() : ArmatureData
      {
         return _armatureData;
      }
      
      public function get display() : Object
      {
         return _display;
      }
      
      public function get animation() : Animation
      {
         return _animation;
      }
      
      public function get cacheFrameRate() : int
      {
         return _cacheFrameRate;
      }
      
      public function set cacheFrameRate(param1:int) : void
      {
         if(_cacheFrameRate == param1)
         {
            return;
         }
         _cacheFrameRate = param1;
      }
      
      public function dispose() : void
      {
         _delayDispose = true;
         if(!_animation || _lockDispose)
         {
            return;
         }
         userData = null;
         _animation.dispose();
         var _loc1_:int = int(_slotList.length);
         while(_loc1_--)
         {
            _slotList[_loc1_].dispose();
         }
         _loc1_ = int(_boneList.length);
         while(_loc1_--)
         {
            _boneList[_loc1_].dispose();
         }
         _slotList.fixed = false;
         _slotList.length = 0;
         _boneList.fixed = false;
         _boneList.length = 0;
         _eventList.length = 0;
         _armatureData = null;
         _animation = null;
         _slotList = null;
         _slotDictionary = null;
         _boneList = null;
         _boneDictionary = null;
         _eventList = null;
      }
      
      public function invalidUpdate(param1:String = null) : void
      {
         var _loc2_:Bone = null;
         var _loc3_:int = 0;
         if(param1)
         {
            _loc2_ = getBone(param1);
            if(_loc2_)
            {
               _loc2_.invalidUpdate();
            }
         }
         else
         {
            _loc3_ = int(_boneList.length);
            while(_loc3_--)
            {
               _boneList[_loc3_].invalidUpdate();
            }
         }
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:Bone = null;
         var _loc7_:Slot = null;
         var _loc5_:Armature = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         _lockDispose = true;
         _animation.advanceTime(param1);
         param1 *= _animation.timeScale;
         var _loc3_:Boolean = animation._isFading;
         var _loc8_:int = int(_boneList.length);
         while(_loc8_--)
         {
            _loc2_ = _boneList[_loc8_];
            _loc2_.update(_loc3_);
         }
         _loc8_ = int(_slotList.length);
         while(_loc8_--)
         {
            _loc7_ = _slotList[_loc8_];
            _loc7_.update();
            if(_loc7_._isShowDisplay)
            {
               _loc5_ = _loc7_.childArmature;
               if(_loc5_)
               {
                  _loc5_.advanceTime(param1);
               }
            }
         }
         if(_slotsZOrderChanged)
         {
            updateSlotsZOrder();
            if(this.hasEventListener("zOrderUpdated"))
            {
               this.dispatchEvent(new ArmatureEvent("zOrderUpdated"));
            }
         }
         if(_eventList.length)
         {
            _loc4_ = int(_eventList.length);
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               this.dispatchEvent(_eventList[_loc6_]);
               _loc6_++;
            }
            _eventList.length = 0;
         }
         _lockDispose = false;
         if(_delayDispose)
         {
            dispose();
         }
      }
      
      public function getSlots(param1:Boolean = true) : Vector.<Slot>
      {
         return param1 ? _slotList.concat() : _slotList;
      }
      
      public function getSlot(param1:String) : Slot
      {
         return _slotDictionary[param1];
      }
      
      public function getSlotByDisplay(param1:Object) : Slot
      {
         var _loc3_:Slot = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(param1)
         {
            _loc2_ = int(_slotList.length);
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc3_ = _slotList[_loc4_];
               if(_loc3_.display == param1)
               {
                  return _loc3_;
               }
               _loc4_++;
            }
         }
         return null;
      }
      
      public function addSlot(param1:Slot, param2:String) : void
      {
         var _loc3_:Bone = getBone(param2);
         if(_loc3_)
         {
            _loc3_.addChild(param1);
            return;
         }
         throw new ArgumentError();
      }
      
      public function removeSlot(param1:Slot) : void
      {
         if(!param1 || param1.armature != this)
         {
            throw new ArgumentError();
         }
         param1.parent.removeChild(param1);
      }
      
      public function removeSlotByName(param1:String) : Slot
      {
         var _loc2_:Slot = getSlot(param1);
         if(_loc2_)
         {
            removeSlot(_loc2_);
         }
         return _loc2_;
      }
      
      public function getBones(param1:Boolean = true) : Vector.<Bone>
      {
         if(param1)
         {
            return _boneList.concat();
         }
         return _boneList;
      }
      
      public function getBone(param1:String) : Bone
      {
         return _boneDictionary[param1];
      }
      
      public function getBoneByDisplay(param1:Object) : Bone
      {
         var _loc2_:Slot = getSlotByDisplay(param1);
         return _loc2_ ? _loc2_.parent : null;
      }
      
      public function addBone(param1:Bone, param2:String = null) : void
      {
         var _loc3_:Bone = null;
         if(param2)
         {
            _loc3_ = getBone(param2);
            if(!_loc3_)
            {
               throw new ArgumentError();
            }
            _loc3_.addChild(param1);
         }
         else
         {
            if(param1.parent)
            {
               param1.parent.removeChild(param1);
            }
            param1.setArmature(this);
         }
      }
      
      public function removeBone(param1:Bone) : void
      {
         if(!param1 || param1.armature != this)
         {
            throw new ArgumentError();
         }
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
         }
         else
         {
            param1.setArmature(null);
         }
      }
      
      public function removeBoneByName(param1:String) : Bone
      {
         var _loc2_:Bone = getBone(param1);
         if(_loc2_)
         {
            removeBone(_loc2_);
         }
         return _loc2_;
      }
      
      dragonBones_internal function addDBObject(param1:DBObject) : void
      {
         var _loc3_:Slot = null;
         var _loc2_:Bone = null;
         if(param1 is Slot)
         {
            _loc3_ = param1 as Slot;
            if(_slotList.indexOf(_loc3_) < 0)
            {
               _slotList.fixed = false;
               _slotList[_slotList.length] = _loc3_;
               _slotDictionary[_loc3_.name] = _loc3_;
               _slotList.fixed = true;
            }
         }
         else if(param1 is Bone)
         {
            _loc2_ = param1 as Bone;
            if(_boneList.indexOf(_loc2_) < 0)
            {
               _boneList.fixed = false;
               _boneList[_boneList.length] = _loc2_;
               _boneDictionary[_loc2_.name] = _loc2_;
               sortBoneList();
               _boneList.fixed = true;
               _animation.updateAnimationStates();
            }
         }
      }
      
      dragonBones_internal function removeDBObject(param1:DBObject) : void
      {
         var _loc4_:Slot = null;
         var _loc2_:int = 0;
         var _loc3_:Bone = null;
         if(param1 is Slot)
         {
            _loc4_ = param1 as Slot;
            _loc2_ = int(_slotList.indexOf(_loc4_));
            if(_loc2_ >= 0)
            {
               delete _slotDictionary[_loc4_.name];
               _slotList.fixed = false;
               _slotList.splice(_loc2_,1);
               _slotList.fixed = true;
            }
         }
         else if(param1 is Bone)
         {
            _loc3_ = param1 as Bone;
            _loc2_ = int(_boneList.indexOf(_loc3_));
            if(_loc2_ >= 0)
            {
               delete _boneDictionary[_loc3_.name];
               _boneList.fixed = false;
               _boneList.splice(_loc2_,1);
               _boneList.fixed = true;
               _animation.updateAnimationStates();
            }
         }
      }
      
      public function updateSlotsZOrder() : void
      {
         var _loc1_:Slot = null;
         _slotList.fixed = false;
         _slotList.sort(sortSlot);
         _slotList.fixed = true;
         var _loc2_:int = int(_slotList.length);
         while(_loc2_--)
         {
            _loc1_ = _slotList[_loc2_];
            if(_loc1_._isShowDisplay)
            {
               _loc1_.addDisplayToContainer(display);
            }
         }
         _slotsZOrderChanged = false;
      }
      
      private function sortBoneList() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Bone = null;
         var _loc1_:Bone = null;
         var _loc4_:int = int(_boneList.length);
         if(_loc4_ == 0)
         {
            return;
         }
         helpArray.length = 0;
         helpArraySwap.length = 0;
         while(_loc4_--)
         {
            _loc2_ = 0;
            _loc3_ = _boneList[_loc4_];
            _loc1_ = _loc3_;
            while(_loc1_)
            {
               _loc2_++;
               _loc1_ = _loc1_.parent;
            }
            helpArray[_loc4_] = [_loc2_,_loc3_];
         }
         if(helpArray.length != 1)
         {
            if(helpArray.length == 2)
            {
               if(helpArray[0][0] < helpArray[1][0])
               {
                  helpArraySwap = helpArray[1];
                  helpArray[1] = helpArray[0];
                  helpArray[0] = helpArraySwap;
               }
            }
            else
            {
               helpArray.sortOn("0",18);
            }
         }
         _loc4_ = int(helpArray.length);
         while(_loc4_--)
         {
            _boneList[_loc4_] = helpArray[_loc4_][1];
         }
      }
      
      dragonBones_internal function arriveAtFrame(param1:Frame, param2:TimelineState, param3:AnimationState, param4:Boolean) : void
      {
         var _loc5_:FrameEvent = null;
         var _loc6_:SoundEvent = null;
         if(param1.event && this.hasEventListener("animationFrameEvent"))
         {
            _loc5_ = new FrameEvent("animationFrameEvent");
            _loc5_.animationState = param3;
            _loc5_.frameLabel = param1.event;
            _eventList.push(_loc5_);
         }
         if(param1.sound && _soundManager.hasEventListener("sound"))
         {
            _loc6_ = new SoundEvent("sound");
            _loc6_.armature = this;
            _loc6_.animationState = param3;
            _loc6_.sound = param1.sound;
            _soundManager.dispatchEvent(_loc6_);
         }
         if(param1.action)
         {
            if(param3.displayControl)
            {
               animation.gotoAndPlay(param1.action);
            }
         }
      }
      
      private function sortSlot(param1:Slot, param2:Slot) : int
      {
         return param1.zOrder < param2.zOrder ? 1 : -1;
      }
   }
}

