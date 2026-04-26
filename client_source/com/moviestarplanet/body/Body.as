package com.moviestarplanet.body
{
   import com.moviestarplanet.body.bodyparts.BodyPartBase;
   import com.moviestarplanet.body.msg.AttachedItemEvent;
   import com.moviestarplanet.math.NumberUtils;
   import com.moviestarplanet.utils.translation.LocaleHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class Body extends MovieClip
   {
      
      private static const MOOD_HAPPY:String = "MOOD_HAPPY";
      
      private static const MOOD_ANGRY:String = "MOOD_ANGRY";
      
      private static const MOOD_SAD:String = "MOOD_SAD";
      
      private static const MOOD_SURPRISED:String = "MOOD_SURPRISED";
      
      private static const MOOD_NEUTRAL:String = "MOOD_NEUTRAL";
      
      private static const talkPoses:Array = ["MouthNeutral","Mouth_a","Mouth_f","Mouth_t","Mouth_o"];
      
      private static const mouthAnimationSymbols:Array = [talkPoses[0],talkPoses[0],talkPoses[1],talkPoses[2],talkPoses[3],talkPoses[4]];
      
      private static var defaultFaceExpression:FaceExpression = new FaceExpression("neutral",LocaleHelper.getInstance().getString(MOOD_NEUTRAL),"EyesNeutral","MouthNeutral");
      
      public static var faceExpresssions:Array = [defaultFaceExpression,new FaceExpression("happy",LocaleHelper.getInstance().getString(MOOD_HAPPY),"EyesHappy","MouthHappy"),new FaceExpression("angry",LocaleHelper.getInstance().getString(MOOD_ANGRY),"EyesAngry","MouthAngry"),new FaceExpression("sad",LocaleHelper.getInstance().getString(MOOD_SAD),"EyesSad","MouthSad"),new FaceExpression("surprised",LocaleHelper.getInstance().getString(MOOD_SURPRISED),"EyesHappy","MouthSurprised")];
      
      public static const MODE_NOCLICK:int = 0;
      
      public static const MODE_CLICK:int = 1;
      
      public static const MODE_CLICK_ALL_BUT_HAIR:int = 2;
      
      public static const MODE_INSPECT:int = 3;
      
      public static const MODE_DRAG:int = 4;
      
      private static const max_mode:int = 4;
      
      private var _bodyParts:Dictionary = new Dictionary();
      
      private var isFlattened:Boolean = false;
      
      private var mouthTime:Number = 0;
      
      public var instance:MovieClip;
      
      private var _currentMouthBodyPart:BodyPartBase;
      
      private var _currentNoseBodyPart:BodyPartBase;
      
      private var lastAddedEyes:MovieClip;
      
      private var _movieStar:IBodyPartDescriptorsProvider;
      
      private const MOUTH_ANIMATION_DELAY:Number = 100;
      
      private var lastAnimatedMouth:MovieClip;
      
      private var lastMouthAnimationTime:int = 0;
      
      public var currentFaceExpression:FaceExpression = defaultFaceExpression;
      
      public var previousFaceExpression:FaceExpression = defaultFaceExpression;
      
      private var _mode:int;
      
      private var _isFacingLeft:Boolean = false;
      
      public function Body()
      {
         super();
         buttonMode = true;
         useHandCursor = true;
      }
      
      public function GetBodyPart(param1:String) : BodyPartBase
      {
         return BodyPartBase(this._bodyParts[param1]);
      }
      
      public function Repaint() : void
      {
         var _loc1_:Object = null;
         var _loc2_:BodyPartDescriptor = null;
         this.unFlattenBodyParts();
         for each(_loc1_ in this.movieStar.bodyPartDescriptors)
         {
            _loc2_ = BodyPartDescriptor(_loc1_);
            _loc2_.Repaint(this);
         }
      }
      
      public function flattenBodyParts() : void
      {
         var _loc1_:Object = null;
         var _loc2_:BodyPartBase = null;
         var _loc3_:BodyPartDescriptor = null;
         if(this.isFlattened)
         {
            return;
         }
         for each(_loc1_ in this._bodyParts)
         {
            _loc2_ = _loc1_ as BodyPartBase;
            _loc3_ = this.movieStar.GetBodyPartDescriptor(_loc2_.Id);
            if(_loc3_.canBeFlattened())
            {
               _loc2_.flatten((this.movieStar as DisplayObject).scaleX);
            }
         }
         this.isFlattened = true;
      }
      
      public function unFlattenBodyParts() : void
      {
         var _loc1_:Object = null;
         var _loc2_:BodyPartBase = null;
         if(this.isFlattened)
         {
            for each(_loc1_ in this._bodyParts)
            {
               _loc2_ = _loc1_ as BodyPartBase;
               _loc2_.unFlatten();
            }
            this.isFlattened = false;
         }
      }
      
      public function set movieStar(param1:IBodyPartDescriptorsProvider) : void
      {
         var _loc2_:BodyPartDescriptor = null;
         var _loc3_:BodyPartBase = null;
         var _loc4_:String = null;
         var _loc5_:Object = null;
         for each(_loc5_ in this._bodyParts)
         {
            _loc3_ = _loc5_ as BodyPartBase;
            _loc4_ = _loc3_.Id;
            if(param1.bodyPartDescriptors[_loc4_] == null)
            {
               _loc2_ = new BodyPartDescriptor();
               _loc2_.bodyPartId = _loc4_;
               param1.bodyPartDescriptors[_loc4_] = _loc2_;
            }
         }
         this._movieStar = param1;
      }
      
      public function get movieStar() : IBodyPartDescriptorsProvider
      {
         return this._movieStar;
      }
      
      public function get bodyPartList() : Dictionary
      {
         return this._bodyParts;
      }
      
      public function RegisterBodyPart(param1:BodyPartBase) : void
      {
         var _loc2_:BodyPartDescriptor = null;
         this._bodyParts[param1.Id] = param1;
         if(param1.Id == Const.FrontMouth || param1.Id == Const.SideMouth)
         {
            this._currentMouthBodyPart = param1;
            this.UpdateMouth();
         }
         else if(param1.Id == Const.FrontEyes || param1.Id == Const.SideEyes)
         {
            this.UpdateEyes();
         }
         else if(param1.Id == Const.FrontNose || param1.Id == Const.SideNose)
         {
            this._currentNoseBodyPart = param1;
            this.UpdateNose();
         }
         else if(param1.Id == Const.FrontLeftFoot || param1.Id == Const.SideLeftFoot)
         {
            this.UpdateFeet();
         }
         else if(this.movieStar != null)
         {
            this.AttachSkinPartToBodySlot(this.movieStar.skinParts[param1.Id] as MovieClip,param1);
         }
         if(this.movieStar != null)
         {
            _loc2_ = this._movieStar.GetBodyPartDescriptor(param1.Id);
            _loc2_.bodyPartId = param1.Id;
            _loc2_.Repaint(this);
         }
      }
      
      public function UpdateNose() : void
      {
         if(this.movieStar != null)
         {
            if(this.movieStar.isDragonBoneNose)
            {
               this.updateDragonBoneNose();
            }
            else if(this.movieStar.noseMC != null)
            {
               this.AttachSkinPart(this.movieStar.noseMC.FrontNose);
               this.AttachSkinPart(this.movieStar.noseMC.SideNose);
            }
         }
      }
      
      private function updateDragonBoneNose() : void
      {
         var _loc1_:BodyPartBase = BodyPartBase(this._bodyParts[Const.FrontNose]);
         if(_loc1_ != null)
         {
            this.AttachSkinPartToBodySlot(this.movieStar.frontNose,_loc1_);
         }
         _loc1_ = BodyPartBase(this._bodyParts[Const.SideNose]);
         if(_loc1_ != null)
         {
            this.AttachSkinPartToBodySlot(this.movieStar.sideNose,_loc1_);
         }
      }
      
      public function UpdateEyes() : void
      {
         if(this.movieStar == null)
         {
            return;
         }
         var _loc1_:Boolean = false;
         if(this.movieStar.isDragonBoneEyes)
         {
            if(this.movieStar.frontEyes == null && this.movieStar.sideEyes == null)
            {
               _loc1_ = true;
            }
         }
         else if(this.movieStar.eyesMC == null)
         {
            _loc1_ = true;
         }
         if(_loc1_)
         {
            return;
         }
         var _loc2_:String = this.currentFaceExpression.eyes;
         this.setEyes(_loc2_);
      }
      
      public function CheckEyeAnimationDragonBone() : void
      {
         if(this.movieStar != null && this.movieStar.frontEyes != null && this.movieStar.sideEyes != null)
         {
            this.movieStar.playEyeAnimation(this.currentFaceExpression.eyes);
         }
      }
      
      public function CheckMouthAnimationDragonBone() : void
      {
         if(this.movieStar != null && this.movieStar.frontMouth != null && this.movieStar.sideMouth != null)
         {
            this.movieStar.playMouthAnimation(this.currentFaceExpression.mouth);
         }
      }
      
      public function UpdateEyeShadow() : void
      {
         if(this.movieStar != null && (this.movieStar.frontEyeShadow != null || this.movieStar.sideEyeShadow != null))
         {
            this.setEyeShadow();
         }
      }
      
      public function removeEyeShadow() : void
      {
         var _loc1_:MovieClip = this.movieStar.skinParts[Const.FrontEyeShadow] as MovieClip;
         if(_loc1_ != null)
         {
            this.safelyRemoveChild(_loc1_);
            delete this.movieStar.skinParts[Const.FrontEyeShadow];
         }
         var _loc2_:MovieClip = this.movieStar.skinParts[Const.SideEyeShadow] as MovieClip;
         if(_loc2_ != null)
         {
            this.safelyRemoveChild(_loc2_);
            delete this.movieStar.skinParts[Const.SideEyeShadow];
         }
      }
      
      public function closeEyes() : void
      {
         if(this.movieStar != null && this.movieStar.eyesMC != null)
         {
            this.setEyes("EyesClosed");
         }
      }
      
      public function setFeet(param1:Boolean) : void
      {
         if(this._bodyParts[Const.FrontRightFoot])
         {
            this.setFoot(param1,Const.FrontRightFoot,Const.FrontRightFootHighHeel);
         }
         if(this._bodyParts[Const.FrontLeftFoot])
         {
            this.setFoot(param1,Const.FrontLeftFoot,Const.FrontLeftFootHighHeel);
         }
         if(this._bodyParts[Const.SideLeftFoot])
         {
            this.setFoot(param1,Const.SideLeftFoot,Const.SideLeftFootHighHeel);
         }
         if(this._bodyParts[Const.SideRightFoot])
         {
            this.setFoot(param1,Const.SideRightFoot,Const.SideRightFootHighHeel);
         }
      }
      
      private function setFoot(param1:Boolean, param2:String, param3:String) : void
      {
         var _loc4_:BodyPartBase = this._bodyParts[param2] as BodyPartBase;
         var _loc5_:MovieClip = MovieClip(this.movieStar.skinParts[param2]);
         var _loc6_:MovieClip = MovieClip(this.movieStar.skinParts[param3]);
         if(param1)
         {
            this.safelyRemoveChild(_loc5_);
            this.AttachSkinPartToBodySlot(_loc6_,_loc4_);
            _loc5_.visible = false;
            _loc6_.visible = true;
         }
         else
         {
            this.safelyRemoveChild(_loc6_);
            this.AttachSkinPartToBodySlot(_loc5_,_loc4_);
            if(_loc6_ != null)
            {
               _loc6_.visible = false;
            }
            _loc5_.visible = true;
         }
      }
      
      public function UpdateFeet() : void
      {
         if(this.movieStar != null)
         {
            this.setFeet(this.isHighHeelsAttached());
         }
      }
      
      public function isHighHeelsAttached() : Boolean
      {
         var _loc1_:AttachedItem = null;
         for each(_loc1_ in this.movieStar.AttachedItems)
         {
            if(_loc1_.Rel.isHighHeel)
            {
               return true;
            }
         }
         return false;
      }
      
      private function setEyes(param1:String) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         if(this.movieStar.isDragonBoneEyes)
         {
            _loc2_ = this.movieStar.frontEyes;
            _loc3_ = this.movieStar.sideEyes;
         }
         else
         {
            _loc2_ = MovieClip(this.movieStar.eyesMC["front" + param1]);
            _loc3_ = MovieClip(this.movieStar.eyesMC["side" + param1]);
         }
         var _loc4_:BodyPartBase = this._bodyParts[Const.FrontEyes] as BodyPartBase;
         if(_loc4_ != null && _loc2_ != null)
         {
            _loc6_ = MovieClip(this.movieStar.skinParts[Const.FrontEyes]);
            this.safelyRemoveChild(_loc6_);
            this.AttachSkinPartToBodySlot(_loc2_,_loc4_,this.movieStar.isDragonBoneEyes);
            this.movieStar.skinParts[Const.FrontEyes] = _loc2_;
         }
         var _loc5_:BodyPartBase = this._bodyParts[Const.SideEyes] as BodyPartBase;
         if(_loc5_ != null && _loc3_ != null)
         {
            _loc7_ = MovieClip(this.movieStar.skinParts[Const.SideEyes]);
            this.safelyRemoveChild(_loc7_);
            this.AttachSkinPartToBodySlot(_loc3_,_loc5_,this.movieStar.isDragonBoneEyes);
            this.movieStar.skinParts[Const.SideEyes] = _loc3_;
         }
      }
      
      private function setEyeShadow() : void
      {
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc1_:MovieClip = this.movieStar.frontEyeShadow;
         var _loc2_:MovieClip = this.movieStar.sideEyeShadow;
         var _loc3_:BodyPartBase = this._bodyParts[Const.FrontEyes] as BodyPartBase;
         if(_loc3_ != null && _loc1_ != null)
         {
            _loc5_ = MovieClip(this.movieStar.skinParts[Const.FrontEyeShadow]);
            this.safelyRemoveChild(_loc5_);
            this.AttachSkinPartToBodySlot(_loc1_,_loc3_);
            this.movieStar.skinParts[Const.FrontEyeShadow] = this.movieStar.frontEyeShadow;
         }
         var _loc4_:BodyPartBase = this._bodyParts[Const.SideEyes] as BodyPartBase;
         if(_loc4_ != null && _loc2_ != null)
         {
            _loc6_ = MovieClip(this.movieStar.skinParts[Const.SideEyeShadow]);
            this.safelyRemoveChild(_loc6_);
            this.AttachSkinPartToBodySlot(_loc2_,_loc4_);
            this.movieStar.skinParts[Const.SideEyeShadow] = _loc2_;
         }
      }
      
      private function safelyRemoveChild(param1:MovieClip) : void
      {
         if(param1 != null && param1.parent != null)
         {
            param1.parent.removeChild(param1);
         }
      }
      
      public function UpdateMouth() : void
      {
         if(this.movieStar != null)
         {
            if(this.movieStar.isDragonBoneMouth)
            {
               this.UpdateMouthDragonBone();
            }
            else
            {
               this.UpdateMouthFromName(this.currentFaceExpression.mouth);
            }
         }
      }
      
      private function UpdateMouthDragonBone() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         if(this.movieStar != null && this._currentMouthBodyPart != null)
         {
            _loc1_ = this._currentMouthBodyPart.Id == Const.FrontMouth ? true : false;
            _loc2_ = this.movieStar.frontMouth;
            _loc3_ = this.movieStar.sideMouth;
            _loc4_ = MovieClip(this.movieStar.skinParts[this._currentMouthBodyPart.Id]);
            this.safelyRemoveChild(_loc4_);
            if(this.movieStar.frontMouth != null && _loc1_)
            {
               this.movieStar.skinParts[Const.FrontMouth] = _loc2_;
               this.AttachSkinPartToBodySlot(_loc2_,this._currentMouthBodyPart);
            }
            if(this.movieStar.sideMouth != null && !_loc1_)
            {
               this.movieStar.skinParts[Const.SideMouth] = _loc3_;
               this.AttachSkinPartToBodySlot(_loc3_,this._currentMouthBodyPart);
            }
            this.CheckMouthAnimationDragonBone();
         }
      }
      
      private function UpdateMouthFromName(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         if(this.movieStar != null && this.movieStar.mouthMC != null && this._currentMouthBodyPart != null)
         {
            _loc2_ = this._currentMouthBodyPart.Id == Const.FrontMouth ? "front" : "side";
            _loc3_ = MovieClip(this.movieStar.mouthMC[_loc2_ + param1]);
            _loc4_ = MovieClip(this.movieStar.skinParts[this._currentMouthBodyPart.Id]);
            this.safelyRemoveChild(_loc4_);
            this.AttachSkinPartToBodySlot(_loc3_,this._currentMouthBodyPart);
            this.movieStar.skinParts[this._currentMouthBodyPart.Id] = _loc3_;
         }
      }
      
      private function getNextMouthAnimationSymbolName() : String
      {
         var _loc1_:int = NumberUtils.random(0,mouthAnimationSymbols.length - 1);
         return mouthAnimationSymbols[_loc1_];
      }
      
      public function AnimateMouth() : void
      {
         var _loc1_:int = int(getTimer());
         var _loc2_:int = _loc1_ - this.lastMouthAnimationTime;
         if(_loc2_ >= this.MOUTH_ANIMATION_DELAY)
         {
            this.lastMouthAnimationTime = _loc1_;
            if(this.movieStar.isDragonBoneMouth)
            {
               this.movieStar.playMouthAnimation(this.getNextMouthAnimationSymbolName());
            }
            else
            {
               this.UpdateMouthFromName(this.getNextMouthAnimationSymbolName());
            }
         }
      }
      
      public function SetFaceExpression(param1:String) : void
      {
         var _loc2_:FaceExpression = null;
         for each(_loc2_ in faceExpresssions)
         {
            if(_loc2_.key == param1)
            {
               this.currentFaceExpression = _loc2_;
               if(this.movieStar.isDragonBoneEyes)
               {
                  this.CheckEyeAnimationDragonBone();
               }
               else
               {
                  this.UpdateEyes();
               }
               if(this.movieStar.isDragonBoneMouth)
               {
                  this.CheckMouthAnimationDragonBone();
               }
               else
               {
                  this.UpdateMouth();
               }
               return;
            }
         }
         trace("Unknown face expression key: " + param1);
      }
      
      public function set Mode(param1:int) : void
      {
         if(param1 < 0 || param1 > max_mode)
         {
            throw new RangeError("Invalid Mode value");
         }
         this._mode = param1;
      }
      
      public function get Mode() : int
      {
         return this._mode;
      }
      
      public function AttachItem(param1:IAttachable, param2:MovieClip) : void
      {
         var _loc3_:AttachedItem = AttachedItem.CreateAttachedItem(this.movieStar,param1,param2,this.Mode);
         if(param1.isFootwear)
         {
            this.setFeet(param1.isHighHeel);
         }
         this.movieStar.AttachedItems.push(_loc3_);
         _loc3_.Attach();
         param1.attach();
         if(this.Mode == MODE_INSPECT)
         {
            _loc3_.addEventListener(AttachedItem.ATTACHED_ITEM_CLICKED,this.itemInspected,false,0,true);
            dispatchEvent(new AttachedItemEvent(_loc3_,AttachedItemEvent.ITEM_ATTACHED));
         }
         else if(this.Mode != MODE_NOCLICK)
         {
            _loc3_.addEventListener(AttachedItem.ATTACHED_ITEM_CLICKED,this.itemClicked,false,0,true);
            dispatchEvent(new AttachedItemEvent(_loc3_,AttachedItemEvent.ITEM_ATTACHED));
         }
         if(_loc3_ is AttachedHairItem)
         {
            this._movieStar.currentHair = AttachedHairItem(_loc3_);
         }
         if(_loc3_.IsHeadWear)
         {
            ++this._movieStar.HeadWearCount;
         }
      }
      
      public function get isFacingLeft() : Boolean
      {
         return this._isFacingLeft;
      }
      
      public function FlipHorizontally() : void
      {
         var _loc1_:Matrix = this.instance.transform.matrix;
         _loc1_.a *= -1;
         if(this.isFacingLeft)
         {
            _loc1_.translate(-50,0);
         }
         else
         {
            _loc1_.translate(50,0);
         }
         this.instance.transform.matrix = _loc1_;
         this._isFacingLeft = !this.isFacingLeft;
      }
      
      public function DetachItem(param1:AttachedItem) : void
      {
         param1.removeEventListener(AttachedItem.ATTACHED_ITEM_CLICKED,this.itemInspected);
         if(this.Mode != MODE_NOCLICK)
         {
            dispatchEvent(new AttachedItemEvent(param1,AttachedItemEvent.ITEM_DETACHING));
            param1.removeEventListener(AttachedItem.ATTACHED_ITEM_CLICKED,this.itemClicked);
         }
         if(param1 is AttachedHairItem)
         {
            this._movieStar.currentHair = null;
         }
         if(param1.IsHeadWear)
         {
            --this._movieStar.HeadWearCount;
         }
         var _loc2_:int = int(this.movieStar.AttachedItems.indexOf(param1));
         this.movieStar.AttachedItems.splice(_loc2_,1);
         param1.Detach();
         dispatchEvent(new AttachedItemEvent(param1.Rel,AttachedItemEvent.TAKEOFF));
      }
      
      protected function itemInspected(param1:Event) : void
      {
         var _loc2_:AttachedItem = null;
         if(this.Mode == MODE_INSPECT)
         {
            _loc2_ = AttachedItem(param1.currentTarget);
            dispatchEvent(new AttachedItemEvent(_loc2_.Rel,AttachedItemEvent.INSPECT,true));
         }
      }
      
      private function itemClicked(param1:Event) : void
      {
         var _loc2_:AttachedItem = AttachedItem(param1.currentTarget);
         this.DetachItem(_loc2_);
      }
      
      public function StripAll() : void
      {
         var _loc1_:* = int(this.movieStar.AttachedItems.length - 1);
         while(_loc1_ >= 0)
         {
            this.DetachItem(this.movieStar.AttachedItems[_loc1_]);
            _loc1_--;
         }
      }
      
      public function StripClothes() : void
      {
         var _loc2_:AttachedItem = null;
         var _loc3_:Boolean = false;
         var _loc1_:* = int(this.movieStar.AttachedItems.length - 1);
         while(_loc1_ >= 0)
         {
            _loc2_ = AttachedItem(this.movieStar.AttachedItems[_loc1_]);
            _loc3_ = _loc2_ is AttachedHairItem;
            if(!_loc3_)
            {
               this.DetachItem(this.movieStar.AttachedItems[_loc1_]);
            }
            _loc1_--;
         }
      }
      
      public function AttachSkin(param1:MovieClip) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:String = null;
         var _loc2_:Array = new Array(param1.numChildren);
         var _loc3_:int = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc2_[_loc3_] = param1.getChildAt(_loc3_);
            _loc3_++;
         }
         for each(_loc4_ in _loc2_)
         {
            _loc5_ = _loc4_.name.toUpperCase();
            this.movieStar.skinParts[_loc5_] = _loc4_;
            this.AttachSkinPart(_loc4_);
         }
      }
      
      public function AttachSkinPart(param1:MovieClip) : void
      {
         var _loc2_:String = param1.name.toUpperCase();
         var _loc3_:BodyPartBase = BodyPartBase(this._bodyParts[_loc2_]);
         if(_loc3_ != null)
         {
            this.AttachSkinPartToBodySlot(param1,_loc3_);
         }
      }
      
      public function AttachSkinPartToBodySlot(param1:MovieClip, param2:BodyPartBase, param3:Boolean = false) : void
      {
         if(param1 != null)
         {
            param1.x = 0;
            param1.y = 0;
            param2.addSkinPart(param1,param3);
         }
      }
   }
}

