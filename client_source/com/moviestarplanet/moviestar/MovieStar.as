package com.moviestarplanet.moviestar
{
   import com.moviestarplanet.actorutils.ActorUtils;
   import com.moviestarplanet.body.AttachedHairItem;
   import com.moviestarplanet.body.AttachedItem;
   import com.moviestarplanet.body.Body;
   import com.moviestarplanet.body.BodyPartDescriptor;
   import com.moviestarplanet.body.Const;
   import com.moviestarplanet.body.FaceExpression;
   import com.moviestarplanet.body.IBodyPartDescriptorsProvider;
   import com.moviestarplanet.body.msg.AttachedItemEvent;
   import com.moviestarplanet.body.skin.Skin;
   import com.moviestarplanet.chat.IChatRoomPet;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.clothesutils.ClothesUtils;
   import com.moviestarplanet.display.IDisplayObject;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.managers.SoundManager;
   import com.moviestarplanet.media.valueobjects.Animation;
   import com.moviestarplanet.moviestar.badge.IMovieStarBadge;
   import com.moviestarplanet.moviestar.service.MovieStarService;
   import com.moviestarplanet.moviestar.utils.ActorCache;
   import com.moviestarplanet.moviestar.utils.AppearanceUtil;
   import com.moviestarplanet.moviestar.valueObjects.*;
   import com.moviestarplanet.msg.MSP_Event;
   import com.moviestarplanet.utils.ColorMap;
   import com.moviestarplanet.utils.FlashUtils;
   import com.moviestarplanet.utils.MSP_SWFLoader;
   import com.moviestarplanet.utils.assets.AssetCacheManager;
   import com.moviestarplanet.utils.flash.MSP_FlashLoader;
   import com.moviestarplanet.utils.loader.AssetUrl;
   import com.moviestarplanet.utils.loader.ContentUrl;
   import com.moviestarplanet.utils.loader.FlippableLoader;
   import com.moviestarplanet.utils.loader.MSP_LoaderManager;
   import com.moviestarplanet.utils.sound.Sounds;
   import flash.display.DisplayObject;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import mx.containers.Canvas;
   import mx.controls.Image;
   import mx.effects.Move;
   import mx.effects.Sequence;
   import mx.effects.easing.Sine;
   import mx.events.EffectEvent;
   
   public class MovieStar extends Canvas implements IBodyPartDescriptorsProvider, MovieStarInterface, IClothLoader, IDisplayObject
   {
      
      public static const INVIS_STAND_ANIM:String = "stand_without_shadow";
      
      public static const DEFAULT_ANIMATION:String = "stand";
      
      private static var _hasLoadedAnimationFiles:Boolean = false;
      
      public static const TALK_ENDED:String = "TALK_ENDED";
      
      private static const FRAMES_PER_BLINK:int = 2;
      
      public const MALE_SKIN_SCALE_X:Number = 1.15;
      
      public const MALE_SKIN_SCALE_Y:Number = 1.05;
      
      private var _staticClothes:Boolean = false;
      
      private var moviestarDragonBone:MovieStarDragonBone;
      
      private var walkEffect:Sequence;
      
      private var isWalking:Boolean = false;
      
      private var _skinColor:uint = 16695945;
      
      private var isFirstShowBody:Boolean = true;
      
      private var waitForClothes:Boolean = true;
      
      private var _currentShownLoader:MSP_SWFLoader;
      
      private var myLoader:MSP_SWFLoader;
      
      private var mDoneCallback:Function;
      
      private var _msp_swfloader:MSP_SWFLoader = new MSP_SWFLoader();
      
      private var outlineImage:Image = new Image();
      
      private var _preloadQueue:Array = [];
      
      private var _isPreloading:Boolean = false;
      
      private var _isLoaded:Boolean = false;
      
      public var isSkinInvis:Boolean = false;
      
      public var _clickItem:DisplayObject;
      
      private var _isWearingHighHeels:Boolean;
      
      private var _skinMC:MovieClip;
      
      private var _frontRightFootMC:MovieClip;
      
      private var _frontLeftFootMC:MovieClip;
      
      private var _sideRightFootMC:MovieClip;
      
      private var _sideLeftFootMC:MovieClip;
      
      private var _sideMouth:MovieClip;
      
      private var _frontMouth:MovieClip;
      
      private var _mouthMC:MovieClip;
      
      private var _eyesMC:MovieClip;
      
      private var _frontEyes:MovieClip;
      
      private var _sideEyes:MovieClip;
      
      private var _noseMC:MovieClip;
      
      private var _frontNose:MovieClip;
      
      private var _sideNose:MovieClip;
      
      private var _frontEyeShadow:MovieClip;
      
      private var _sideEyeShadow:MovieClip;
      
      private var _chatRoomPet:IChatRoomPet;
      
      private var _movieStarPopupEnabled:Boolean = true;
      
      private var _isInChatRoom:Boolean;
      
      private var _attachedItems:Array = new Array();
      
      private var _skinParts:Dictionary = new Dictionary();
      
      private var _bodyPartDescriptors:Dictionary = new Dictionary();
      
      private var _isDestroyed:Boolean = false;
      
      private var _scale:Number = 1;
      
      private var _animationCache:Object = new Object();
      
      public var movieStarClickFunction:Function;
      
      public var ContextId:int;
      
      public var Mode:int;
      
      private var body:Body = null;
      
      public var _actor:Actor = null;
      
      public var actorMovieNumber:Number = 0;
      
      private var _currentHair:AttachedHairItem;
      
      private var headWearCount:int = 0;
      
      private var pendingAppearanceData:Object;
      
      private var shouldUseLowLoadPriority:Boolean = false;
      
      public var _isLoadDeletable:Boolean = true;
      
      private var thisMovieStar:MovieStar = null;
      
      private var isFacingLeft:Boolean = false;
      
      private var _pendingStopAnimationsRequest:Boolean;
      
      private var currentPlayingAnimation:Object;
      
      private var _pendingPlayAnimationRequest:String = null;
      
      private var _isFirstPlayAnimation:Boolean = true;
      
      private var _animation:Animation;
      
      private var _selectedStopFrame:int;
      
      private var _msp_swfloader_Previous:DisplayObject;
      
      private var _isListeningForEnterFrameEvents:Boolean = false;
      
      private const frameLength:Number = 41.666666666666664;
      
      private var isStartingAnimation:Boolean = true;
      
      private var startTime:int;
      
      private var lastFrame:int;
      
      private var stopFrames:Array;
      
      private var indexOfNextStopFrame:Number = 0;
      
      private var animationIsLooping:Boolean;
      
      private var nextAnimationFrame:int;
      
      private var prevDeltaFramesTotal:int;
      
      private var _isAnimating:Boolean = false;
      
      private var _isTalking:Boolean = false;
      
      private var _stopTalkingTimeStamp:Number = 0;
      
      private var _talkBeforeLoad:Boolean = false;
      
      private var _talkBeforeLoadMilliSeconds:Number;
      
      private var _currentlyPlayingFrameLabel:String;
      
      private var _faceExpression:FaceExpression;
      
      private var _faceExpressionBeforeLoad:String;
      
      private var _pendingFaceExpression:String;
      
      private var oldFace:String = null;
      
      private var tmpFaceTimer:Timer;
      
      private var blinkTimer:Timer;
      
      private var blinkFrameCounter:int;
      
      private var _platformBadge:IMovieStarBadge;
      
      private var _platformType:int;
      
      private var _isNewPet:Boolean;
      
      public function MovieStar(param1:int = 0)
      {
         this.movieStarClickFunction = this.emitClickEvent;
         super();
         AssetCacheManager.initialize();
         this.thisMovieStar = this;
         clipContent = false;
         this.outlineImage.source = new AssetUrl("img/moviestar_outline_new.png",AssetUrl.DEFAULT);
         addChild(this.outlineImage);
         this.Mode = param1;
         this.moviestarDragonBone = new MovieStarDragonBone();
      }
      
      public static function getDataAsClothes(param1:Object) : Array
      {
         return MovieStarUtils.getDataAsClothes(param1);
      }
      
      private static function dataToClothes(param1:Array, param2:int) : Array
      {
         return MovieStarUtils.dataToClothes(param1,param2);
      }
      
      public function walk() : void
      {
         var _loc1_:Move = null;
         var _loc2_:Move = null;
         this.isWalking = true;
         this.PlayAnimation("walk");
         if(this.clickItem != null)
         {
            if(!this.isNewPet)
            {
               if(this.walkEffect == null)
               {
                  _loc1_ = new Move();
                  _loc1_.duration = 250;
                  _loc1_.yFrom = this.clickItem.y;
                  _loc1_.yTo = this.clickItem.y - 80;
                  _loc1_.easingFunction = Sine.easeOut;
                  _loc2_ = new Move();
                  _loc2_.duration = 250;
                  _loc2_.yFrom = this.clickItem.y - 80;
                  _loc2_.yTo = this.clickItem.y;
                  _loc2_.easingFunction = Sine.easeIn;
                  this.walkEffect = new Sequence();
                  this.walkEffect.repeatCount = 1;
                  this.walkEffect.addEventListener(EffectEvent.EFFECT_END,this.pulseEndHandler,false,0,true);
                  this.walkEffect.addChild(_loc1_);
                  this.walkEffect.addChild(_loc2_);
               }
               if(!this.walkEffect.isPlaying)
               {
                  this.walkEffect.play([this.clickItem]);
               }
            }
         }
      }
      
      private function pulseEndHandler(param1:Event = null) : void
      {
         if(this.isWalking && this.walkEffect != null && this.clickItem != null)
         {
            this.walkEffect.play([this.clickItem]);
         }
      }
      
      public function stopWalk() : void
      {
         this.isWalking = false;
         this.PlayAnimation(DEFAULT_ANIMATION);
      }
      
      public function get clickItem() : DisplayObject
      {
         return this._clickItem;
      }
      
      public function set clickItem(param1:DisplayObject) : void
      {
         if(param1 == this.clickItem)
         {
            return;
         }
         if(this.clickItem != null && Boolean(this.contains(this.clickItem)))
         {
            removeChild(this.clickItem);
         }
         this.walkEffect = null;
         this._clickItem = param1;
         if(this.clickItem != null)
         {
            addChild(this.clickItem);
         }
      }
      
      public function set chatRoomPet(param1:IChatRoomPet) : void
      {
         this._chatRoomPet = param1;
      }
      
      public function get chatRoomPet() : IChatRoomPet
      {
         return this._chatRoomPet;
      }
      
      public function get movieStarPopupEnabled() : Boolean
      {
         return this._movieStarPopupEnabled;
      }
      
      public function set movieStarPopupEnabled(param1:Boolean) : void
      {
         this._movieStarPopupEnabled = param1;
      }
      
      public function get isInChatRoom() : Boolean
      {
         return this._isInChatRoom;
      }
      
      public function set isInChatRoom(param1:Boolean) : void
      {
         this._isInChatRoom = param1;
      }
      
      public function get staticClothes() : Boolean
      {
         return this._staticClothes;
      }
      
      public function set staticClothes(param1:Boolean) : void
      {
         if(this.staticClothes == param1)
         {
            return;
         }
         this._staticClothes = param1;
         if(this.isLoaded && this.body != null)
         {
            if(this.staticClothes)
            {
               this.body.flattenBodyParts();
            }
            else
            {
               this.body.Repaint();
            }
         }
      }
      
      public function setFacePartColors(param1:String, param2:String) : void
      {
         throw new Error("Implementation of MovieStar.setFacePartColors is empty");
      }
      
      public function get skinMC() : MovieClip
      {
         return this._skinMC;
      }
      
      public function get mouthMC() : MovieClip
      {
         return this._mouthMC;
      }
      
      public function get frontMouth() : MovieClip
      {
         return this._frontMouth;
      }
      
      public function set frontMouth(param1:MovieClip) : void
      {
         this._frontMouth = param1;
      }
      
      public function get sideMouth() : MovieClip
      {
         return this._sideMouth;
      }
      
      public function set sideMouth(param1:MovieClip) : void
      {
         this._sideMouth = param1;
      }
      
      public function get eyesMC() : MovieClip
      {
         return this._eyesMC;
      }
      
      public function get frontEyes() : MovieClip
      {
         return this._frontEyes;
      }
      
      public function set frontEyes(param1:MovieClip) : void
      {
         this._frontEyes = param1;
      }
      
      public function get sideEyes() : MovieClip
      {
         return this._sideEyes;
      }
      
      public function set sideEyes(param1:MovieClip) : void
      {
         this._sideEyes = param1;
      }
      
      public function get noseMC() : MovieClip
      {
         return this._noseMC;
      }
      
      public function get frontNose() : MovieClip
      {
         return this._frontNose;
      }
      
      public function set frontNose(param1:MovieClip) : void
      {
         this._frontNose = param1;
      }
      
      public function get sideNose() : MovieClip
      {
         return this._sideNose;
      }
      
      public function set sideNose(param1:MovieClip) : void
      {
         this._sideNose = param1;
      }
      
      public function get frontEyeShadow() : MovieClip
      {
         return this._frontEyeShadow;
      }
      
      public function get sideEyeShadow() : MovieClip
      {
         return this._sideEyeShadow;
      }
      
      public function get AttachedItems() : Array
      {
         return this._attachedItems;
      }
      
      public function get skinParts() : Dictionary
      {
         return this._skinParts;
      }
      
      public function get bodyPartDescriptors() : Dictionary
      {
         return this._bodyPartDescriptors;
      }
      
      public function GetBodyPartDescriptor(param1:String) : BodyPartDescriptor
      {
         var _loc2_:BodyPartDescriptor = BodyPartDescriptor(this.bodyPartDescriptors[param1]);
         if(_loc2_ == null)
         {
            _loc2_ = new BodyPartDescriptor();
            _loc2_.bodyPartId = param1;
            this.bodyPartDescriptors[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public function Repaint() : void
      {
         if(this.body != null)
         {
            this.body.Repaint();
         }
      }
      
      public function destroy() : void
      {
         if(this._isDestroyed)
         {
            return;
         }
         this._isDestroyed = true;
         this.unHookFromEnterFrameEvent();
         this.cleanTmpFaceTimer();
         if(this.moviestarDragonBone != null)
         {
            this.moviestarDragonBone.dispose();
         }
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      public function isFemale() : Boolean
      {
         return ActorUtils.isFemale(this.actor);
      }
      
      public function GetSkinId() : int
      {
         return ActorUtils.getSkinIdActor(this.actor);
      }
      
      public function getSkinScaleX() : Number
      {
         if(this.actor != null && this.GetSkinId() == 2)
         {
            return this.MALE_SKIN_SCALE_X;
         }
         return 1;
      }
      
      public function getSkinScaleY() : Number
      {
         if(this.actor != null && this.GetSkinId() == 2)
         {
            return this.MALE_SKIN_SCALE_Y;
         }
         return 1;
      }
      
      private function SetScale() : void
      {
         if(this.actor != null && this.GetSkinId() == 2)
         {
            this.scaleX = this._scale * this.MALE_SKIN_SCALE_X;
            this.scaleY = this._scale * this.MALE_SKIN_SCALE_Y;
         }
         else
         {
            this.scaleX = this._scale;
            this.scaleY = this._scale;
         }
      }
      
      public function set scale(param1:Number) : void
      {
         this._scale = param1;
         this.SetScale();
      }
      
      public function get scale() : Number
      {
         return this._scale;
      }
      
      public function get isDragonBoneEyes() : Boolean
      {
         return this.moviestarDragonBone.isDragonBoneEyes;
      }
      
      public function set isDragonBoneEyes(param1:Boolean) : void
      {
         this.moviestarDragonBone.isDragonBoneEyes = param1;
      }
      
      public function get isDragonBoneMouth() : Boolean
      {
         return this.moviestarDragonBone.isDragonBoneMouth;
      }
      
      public function set isDragonBoneMouth(param1:Boolean) : void
      {
         this.moviestarDragonBone.isDragonBoneMouth = param1;
      }
      
      public function get isDragonBoneNose() : Boolean
      {
         return this.moviestarDragonBone.isDragonBoneNose;
      }
      
      public function set isDragonBoneNose(param1:Boolean) : void
      {
         this.moviestarDragonBone.isDragonBoneNose = param1;
      }
      
      public function preloadAnimation(param1:String, param2:Date = null) : void
      {
         this._preloadQueue.push({
            "animation":param1,
            "lastEdited":param2
         });
         if(!this._isPreloading)
         {
            this.preloadNextAnimation();
         }
      }
      
      private function preloadNextAnimation() : void
      {
         if(this._preloadQueue.length == 0)
         {
            return;
         }
         this._isPreloading = true;
         var _loc1_:Object = this._preloadQueue.shift();
         this.loadAnimationFile(_loc1_.animation,_loc1_.lastEdited,this.preloadAnimationDone);
      }
      
      private function preloadAnimationDone(param1:Object) : void
      {
         this._isPreloading = false;
         this.preloadNextAnimation();
      }
      
      private function loadAnimationFile(param1:String, param2:Date, param3:Function, param4:Boolean = false) : void
      {
         var animation:Object = null;
         var loader:FlippableLoader = null;
         var animationFileLoaded:Function = null;
         var animationFail:Function = null;
         var animationFileName:String = param1;
         var lastUpdated:Date = param2;
         var callBack:Function = param3;
         var _testProgramMode:Boolean = param4;
         animationFileLoaded = function(param1:FlippableLoader):void
         {
            var _loc2_:Body = param1.content as Body;
            _loc2_.stop();
            _loc2_.instance.stop();
            _loc2_.movieStar = IBodyPartDescriptorsProvider(thisMovieStar);
            _loc2_.addEventListener(MouseEvent.CLICK,movieStarClicked,false,0,true);
            param1.animation.body = _loc2_;
            param1.animation.animationData = GetAnimationData(_loc2_);
            if(GetSkinId() == 2)
            {
               _loc2_.instance.x -= 12;
               _loc2_.instance.y -= 20;
            }
            _loc2_.Mode = Mode;
            _loc2_.addEventListener(AttachedItemEvent.TAKEOFF,clothesTakenOffHandler,false,0,true);
            _animationCache[animation.name] = animation;
            callBack(param1.animation);
         };
         animationFail = function(param1:FlippableLoader):void
         {
            callBack(null);
         };
         if(!ContentUrl.forceReload)
         {
            animation = this._animationCache[animationFileName];
            if(animation != null)
            {
               callBack(animation);
               return;
            }
         }
         animation = new Object();
         loader = new FlippableLoader(false);
         loader.autoLoad = false;
         loader.source = new ContentUrl(animationFileName,ContentUrl.ANIMATION,lastUpdated);
         loader.LoadCallBack = animationFileLoaded;
         loader.LoadFailCallBack = animationFail;
         animation.loader = loader;
         animation.name = animationFileName;
         loader.animation = animation;
         MSP_LoaderManager.RequestLoadForLoader(loader,MSP_LoaderManager.PRIORITY_NORMAL,this._isLoadDeletable);
      }
      
      private function movieStarClicked(param1:MouseEvent) : void
      {
         this.movieStarClickFunction(param1);
         SoundManager.Instance().playSoundEffect(Sounds.BUTTON_CLICK);
      }
      
      public function emitClickEvent(param1:MouseEvent) : void
      {
         MessageCommunicator.send(new MsgEvent(MSPEvent.MOVIESTAR_CLICKED,this));
         param1.stopImmediatePropagation();
      }
      
      public function get currentBody() : MovieClip
      {
         return this.body;
      }
      
      private function showBody(param1:Object, param2:Function = null) : void
      {
         if(param1 == null)
         {
            if(param2 != null)
            {
               param2();
            }
            return;
         }
         var _loc3_:Boolean = param1.body == this.body;
         this.mDoneCallback = param2;
         this.myLoader = param1.loader as MSP_SWFLoader;
         this.body = param1.body as Body;
         if(this.isFirstShowBody)
         {
            this.isFirstShowBody = false;
            this.addAppearanceToBody(this.body,this.doneAddingStuff);
         }
         else if(_loc3_)
         {
            if(param2 != null)
            {
               param2();
               param2 = null;
            }
         }
         else
         {
            this.doneAddingStuff();
         }
      }
      
      private function doneAddingStuff() : void
      {
         var _loc1_:Object = null;
         var _loc2_:String = null;
         var _loc3_:MSP_SWFLoader = null;
         var _loc4_:SoundTransform = null;
         for each(_loc1_ in this.skinParts)
         {
            _loc2_ = _loc1_.name.toUpperCase();
            if(_loc2_.indexOf("INSTANCE") < 0 && _loc2_ != Const.FrontLeftFoot && _loc2_ != Const.FrontRightFoot && _loc2_ != Const.SideLeftFoot && _loc2_ != Const.SideRightFoot && _loc2_ != Const.FrontLeftFootHighHeel && _loc2_ != Const.FrontRightFootHighHeel && _loc2_ != Const.SideLeftFootHighHeel && _loc2_ != Const.SideRightFootHighHeel)
            {
               this.body.AttachSkinPart(MovieClip(_loc1_));
            }
         }
         this.body.UpdateMouth();
         this.body.UpdateNose();
         this.body.UpdateEyes();
         this.body.UpdateEyeShadow();
         this.body.UpdateFeet();
         if(this.isFacingLeft != this.body.isFacingLeft)
         {
            this.flipHorizontally();
         }
         this.body.Repaint();
         if(this.outlineImage != null && this.outlineImage.parent != null)
         {
            this.outlineImage.parent.removeChild(this.outlineImage);
         }
         if(this._currentShownLoader != null)
         {
            _loc3_ = this._currentShownLoader;
            this.body.instance.gotoAndStop(1);
            if(this.myLoader != this._currentShownLoader)
            {
               removeChild(_loc3_);
            }
         }
         this._currentShownLoader = this.myLoader;
         if(!this._currentShownLoader.parent)
         {
            addChildAt(this._currentShownLoader,0);
         }
         if(SoundManager.Instance().isMuted)
         {
            _loc4_ = new SoundTransform();
            _loc4_.volume = 0;
            this.body.soundTransform = _loc4_;
         }
         if(this.staticClothes)
         {
            this.body.flattenBodyParts();
         }
         if(this.mDoneCallback != null)
         {
            this.mDoneCallback();
            this.mDoneCallback = null;
         }
      }
      
      private function addAppearanceToBody(param1:Body, param2:Function) : void
      {
         var AttachSkinDone:Function = null;
         var bdy:Body = param1;
         var doneCallback:Function = param2;
         AttachSkinDone = function():void
         {
            loadFaceAndClothes(doneCallback);
         };
         if(this.actor == null)
         {
            return;
         }
         this.AttachSkin(this.actor,AttachSkinDone);
      }
      
      private function loadFaceAndClothes(param1:Function) : void
      {
         var facepartsDone:Function;
         var AttachClothes:Function = null;
         var callBack:Function = param1;
         if(this.pendingAppearanceData != null && (Boolean(this.pendingAppearanceData.ClothesMin) || Boolean(this.pendingAppearanceData.ActorClothesRel)))
         {
            this.addAppearanceFromData(this.pendingAppearanceData,callBack);
         }
         else
         {
            facepartsDone = function():void
            {
               var _loc1_:Array = null;
               if(ContextId != 0)
               {
                  LoadClothesForContext(ContextId,AttachClothes);
               }
               else
               {
                  _loc1_ = GetIsWearingClothes(actor);
                  AttachClothes(_loc1_);
               }
            };
            AttachClothes = function(param1:Array):void
            {
               SetClothes(param1,callBack);
            };
            if(this.isSkinInvis)
            {
               facepartsDone();
            }
            else
            {
               this.LoadAllFaceParts(this.actor,facepartsDone);
            }
         }
      }
      
      public function LoadClothesForContext(param1:int, param2:Function) : void
      {
         var done:Function = null;
         var contextId:int = param1;
         var resultCallback:Function = param2;
         done = function(param1:Array):void
         {
            resultCallback(param1);
         };
         new MovieStarService().LoadContextClothes(this.actor.ActorId,contextId,done);
      }
      
      private function addAppearanceFromData(param1:Object, param2:Function) : void
      {
         var eyesDone:Function = null;
         var noseDone:Function = null;
         var mouthDone:Function = null;
         var eyeShadowDone:Function = null;
         var appearanceData:Object = param1;
         var callBack:Function = param2;
         eyesDone = function():void
         {
            if(appearanceData.Nose)
            {
               actor.Nose = noseFromData(appearanceData.Nose);
               LoadFacePart(actor.Nose.SWFLocation,actor.Nose.type,noseDone,null,actor.Nose.DragonBone);
            }
            else
            {
               loadActorNose(actor,noseDone);
            }
         };
         noseDone = function():void
         {
            if(appearanceData.Mouth)
            {
               actor.Mouth = mouthFromData(appearanceData.Mouth);
               actor.MouthColors = appearanceData.MouthColors;
               LoadFacePart(actor.Mouth.SWFLocation,actor.Mouth.type,mouthDone,actor.MouthColors,actor.Mouth.DragonBone);
            }
            else
            {
               loadActorMouth(actor,mouthDone);
            }
         };
         mouthDone = function():void
         {
            if(appearanceData.EyeShadow)
            {
               actor.EyeShadow = eyeShadowFromData(appearanceData.EyeShadow);
               actor.EyeShadowColors = appearanceData.EyeShadowColors;
               LoadFacePart(actor.EyeShadow.SWFLocation,actor.EyeShadow.type,eyeShadowDone,appearanceData.EyeShadowColors,actor.EyeShadow.DragonBone);
            }
            else
            {
               actor.EyeShadow = null;
               loadActorEyeShadow(actor,eyeShadowDone);
            }
         };
         eyeShadowDone = function():void
         {
            addClothesFromData(appearanceData,callBack);
         };
         if(appearanceData.SkinColor)
         {
            this.skinColor = parseInt(appearanceData.SkinColor);
         }
         if(appearanceData.Eye)
         {
            this.actor.Eye = this.eyeFromData(appearanceData.Eye);
            this.actor.EyeColors = appearanceData.EyeColors;
            this.LoadFacePart(this.actor.Eye.SWFLocation,this.actor.Eye.type,eyesDone,this.actor.EyeColors,this.actor.Eye.DragonBone);
         }
         else
         {
            this.loadActorEyes(this.actor,eyesDone);
         }
      }
      
      private function eyeFromData(param1:Object) : Eye
      {
         return AppearanceUtil.eyeFromData(param1);
      }
      
      private function noseFromData(param1:Object) : Nose
      {
         return AppearanceUtil.noseFromData(param1);
      }
      
      private function mouthFromData(param1:Object) : Mouth
      {
         return AppearanceUtil.mouthFromData(param1);
      }
      
      private function eyeShadowFromData(param1:Object) : EyeShadow
      {
         return AppearanceUtil.eyeShadowFromData(param1);
      }
      
      public function get actor() : Actor
      {
         return this._actor;
      }
      
      public function set actor(param1:Actor) : void
      {
         this._actor = param1;
      }
      
      public function SetName(param1:String) : void
      {
         this.actor.Name = param1;
      }
      
      public function GetName() : String
      {
         return this.actor.Name;
      }
      
      public function GetFaceExpressions() : Array
      {
         return Body.faceExpresssions;
      }
      
      public function isExtra() : Boolean
      {
         return this.actor.IsExtra > 0;
      }
      
      public function cloneFrom(param1:MovieStar, param2:Function = null) : void
      {
         var _loc3_:int = param1.actor.ActorId;
         if(_loc3_ == 0)
         {
            _loc3_ = param1.actor.isFemale ? -1 : -2;
         }
         this.LoadWithAppearanceData(_loc3_,param1.getAppearanceData(),param2);
      }
      
      public function synchronizeClothing(param1:Function = null) : void
      {
         var doneLoad:Function = null;
         var clothesDone:Function = null;
         var callback:Function = param1;
         doneLoad = function(param1:Actor):void
         {
            actor = param1;
            resetClothes(clothesDone);
         };
         clothesDone = function():void
         {
            if(staticClothes)
            {
               body.flattenBodyParts();
            }
            if(callback != null)
            {
               callback();
            }
         };
         ActorCache.loadActor(this.actor.ActorId,doneLoad);
      }
      
      public function synchronizeAppearance(param1:Function = null) : void
      {
         var doneLoad:Function = null;
         var facepartsDone:Function = null;
         var allDone:Function = null;
         var callback:Function = param1;
         doneLoad = function(param1:Actor):void
         {
            actor = param1;
            skinColor = parseInt(actor.SkinColor);
            LoadAllFaceParts(actor,facepartsDone);
         };
         facepartsDone = function():void
         {
            resetClothes(allDone);
         };
         allDone = function():void
         {
            if(callback != null)
            {
               callback();
            }
         };
         ActorCache.loadActor(this.actor.ActorId,doneLoad);
      }
      
      public function GetIsWearingClothes(param1:Actor) : Array
      {
         var _loc3_:ActorClothesRel = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in param1.ActorClothesRels)
         {
            if(_loc3_.IsWearing)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function GetAttachedClothes() : Array
      {
         var _loc2_:AttachedItem = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.AttachedItems)
         {
            _loc1_.push(_loc2_.Rel);
         }
         return _loc1_;
      }
      
      public function get currentHair() : AttachedHairItem
      {
         return this._currentHair;
      }
      
      public function set currentHair(param1:AttachedHairItem) : void
      {
         this._currentHair = param1;
      }
      
      public function get HeadWearCount() : int
      {
         return this.headWearCount;
      }
      
      public function set HeadWearCount(param1:int) : void
      {
         this.headWearCount = param1;
         if(this.currentHair != null)
         {
            this.currentHair.UpdateHairMode();
         }
      }
      
      public function SetClothes(param1:Array, param2:Function = null) : void
      {
         this.StripAll();
         this.PutOnClothes(param1,param2);
      }
      
      public function PutOnClothes(param1:Array, param2:Function = null) : void
      {
         var _loc4_:ActorClothesRel = null;
         var _loc3_:Array = [];
         for each(_loc4_ in param1)
         {
            _loc3_.push(_loc4_);
         }
         FlashUtils.NotifyWhenAllDone(this.PutOnCloth,_loc3_,param2);
      }
      
      public function LoadWithAppearanceData(param1:int, param2:Object, param3:Function, param4:Boolean = true) : void
      {
         var restoreActorId:Function = null;
         var actorId:int = param1;
         var appearanceData:Object = param2;
         var callBack:Function = param3;
         var isLoadDeletable:Boolean = param4;
         restoreActorId = function(param1:MovieStar):void
         {
            actor.ActorId = actorId;
            callBack(param1);
         };
         this.pendingAppearanceData = appearanceData;
         if(appearanceData != null && 1 == 2)
         {
            if(appearanceData.Eye.SkinId != 0)
            {
               this.Load(-appearanceData.Eye.SkinId,restoreActorId,1,false,isLoadDeletable);
            }
            else
            {
               this.Load(actorId,callBack,1,false,isLoadDeletable);
            }
         }
         else
         {
            this.Load(actorId,callBack,1,false,isLoadDeletable);
         }
      }
      
      public function Load(param1:int, param2:Function, param3:int = 1, param4:Boolean = false, param5:Boolean = true, param6:Boolean = false, param7:Function = null) : void
      {
         var loadActorDone:Function = null;
         var onLoadActorFail:Function = null;
         var actorId:int = param1;
         var callBack:Function = param2;
         var amountOfDataToLoad:int = param3;
         var lowpriorityload:Boolean = param4;
         var isLoadDeletable:Boolean = param5;
         var doPoseAnimation:Boolean = param6;
         var failCallback:Function = param7;
         loadActorDone = function(param1:Actor):void
         {
            if(_isDestroyed)
            {
               callBack(thisMovieStar);
               return;
            }
            LoadActorData(param1,callBack,false,doPoseAnimation);
         };
         onLoadActorFail = function():void
         {
            if(failCallback != null)
            {
               failCallback();
            }
         };
         if(this._isDestroyed)
         {
            callBack(this.thisMovieStar);
            return;
         }
         this.shouldUseLowLoadPriority = lowpriorityload;
         this._isLoadDeletable = isLoadDeletable;
         ActorCache.loadActor(actorId,loadActorDone,onLoadActorFail);
      }
      
      public function resetClothes(param1:Function = null) : void
      {
         if(this.actor != null)
         {
            this.SetClothes(this.actor.ActorClothesRels,param1);
         }
      }
      
      public function ReLoadClothes(param1:Function = null) : void
      {
         var loadActorDone:Function = null;
         var done:Function = param1;
         loadActorDone = function(param1:Actor):void
         {
            if(param1 == null)
            {
               throw new Error("LoadActorData: actor is null");
            }
            this.actor = param1;
            var _loc2_:Array = GetIsWearingClothes(param1);
            SetClothes(_loc2_,done);
         };
         if(this._isDestroyed)
         {
            if(done != null)
            {
               done();
            }
            return;
         }
         ActorCache.resetActor(this.actor.ActorId);
         ActorCache.loadActor(this.actor.ActorId,loadActorDone);
      }
      
      public function FaceLeft() : void
      {
         if(!this.isFacingLeft)
         {
            this.flipHorizontally();
         }
      }
      
      public function FaceRight() : void
      {
         if(this.isFacingLeft)
         {
            this.flipHorizontally();
         }
      }
      
      public function flipHorizontally() : void
      {
         if(this.body != null)
         {
            this.body.FlipHorizontally();
            this.isFacingLeft = this.body.isFacingLeft;
            if(this.isInChatRoom)
            {
            }
         }
         else
         {
            this.isFacingLeft = !this.isFacingLeft;
         }
      }
      
      private function GetAnimationData(param1:MovieClip) : Object
      {
         var _loc2_:Object = null;
         var _loc4_:FrameLabel = null;
         var _loc5_:Array = null;
         var _loc3_:int = 0;
         loop0:
         while(true)
         {
            if(_loc3_ >= param1.instance.currentLabels.length)
            {
               return _loc2_;
            }
            _loc4_ = FrameLabel(param1.instance.currentLabels[_loc3_]);
            if(_loc2_ == null)
            {
               _loc2_ = new Object();
               _loc2_.name = _loc4_.name;
               _loc2_.soundFrames = [];
               _loc2_.startFrame = _loc4_.frame;
               continue;
            }
            switch(_loc4_.name)
            {
               case "sound":
                  if(!SoundManager.Instance().isMuted)
                  {
                     _loc5_ = _loc2_.soundFrames as Array;
                     _loc5_.push(_loc4_.frame);
                  }
                  break;
               case "loop":
                  _loc2_.loop = true;
                  _loc2_.stopFrame = _loc4_.frame;
                  break;
               case "stop":
                  _loc2_.loop = false;
                  _loc2_.stopFrame = _loc4_.frame;
                  break;
               default:
                  break loop0;
            }
            _loc3_++;
         }
         throw new Error("Framelabel is missing a sound, stop or loop label: " + _loc4_.name);
      }
      
      public function LoadActorData(param1:Actor, param2:Function, param3:Boolean = false, param4:Boolean = false) : void
      {
         var done:Function = null;
         var actor:Actor = param1;
         var callBack:Function = param2;
         var _testProgramMode:Boolean = param3;
         var doPoseAnimation:Boolean = param4;
         done = function():void
         {
            if(callBack != null)
            {
               callBack(thisMovieStar);
            }
         };
         if(this._isDestroyed)
         {
            callBack(this.thisMovieStar);
            return;
         }
         if(actor == null)
         {
            throw new Error("LoadActorData: actor is null");
         }
         this.actor = actor;
         this.thisMovieStar = this;
         this.SetScale();
         this._isLoaded = true;
         if(this._talkBeforeLoad)
         {
            this.talk(this._talkBeforeLoadMilliSeconds);
         }
         if(this._faceExpressionBeforeLoad)
         {
            this.SetFaceExpression(this._faceExpressionBeforeLoad);
         }
         if(this._pendingPlayAnimationRequest == null)
         {
            if(doPoseAnimation)
            {
               this.PlayAnimation(this.defaultPoseName(),done);
            }
            else
            {
               this.PlayAnimation(DEFAULT_ANIMATION,done);
            }
         }
         else
         {
            done();
         }
      }
      
      public function get isLoaded() : Boolean
      {
         return this._isLoaded;
      }
      
      private function clothesTakenOffHandler(param1:AttachedItemEvent) : void
      {
         dispatchEvent(new AttachedItemEvent(param1.data,param1.type));
      }
      
      private function AttachSkin(param1:Actor, param2:Function) : void
      {
         if(this.isSkinInvis && param2 != null)
         {
            param2();
         }
         else
         {
            this.SetSkin(param1.SkinSWF,parseInt(param1.SkinColor),param2);
         }
      }
      
      public function SetSkin(param1:String, param2:uint, param3:Function) : void
      {
         var ms:MovieStar = null;
         var LoadSkinDone:Function = null;
         var skinSWF:String = param1;
         var value:uint = param2;
         var done:Function = param3;
         LoadSkinDone = function(param1:MovieClip):void
         {
            actor.SkinSWF = skinSWF;
            SetScale();
            ColorMap.SetColorsOnMovieClip(MovieClip(param1),skinColor,skinColor.toString());
            ms._skinMC = param1;
            body.AttachSkin(param1);
            skinColor = value;
            if(done != null)
            {
               done();
            }
         };
         ms = this;
         Skin.getSkin(skinSWF,LoadSkinDone);
      }
      
      private function loadActorEyes(param1:Actor, param2:Function) : void
      {
         if(param1.Eye == null)
         {
            param2();
            return;
         }
         this.LoadFacePart(param1.Eye.SWFLocation,Eye.TYPE,param2,param1.EyeColors,param1.Eye.DragonBone);
      }
      
      private function loadActorNose(param1:Actor, param2:Function) : void
      {
         if(param1.Nose == null)
         {
            param2();
            return;
         }
         this.LoadFacePart(param1.Nose.SWFLocation,Nose.TYPE,param2,null,param1.Nose.DragonBone);
      }
      
      private function loadActorMouth(param1:Actor, param2:Function) : void
      {
         if(param1.Mouth == null)
         {
            param2();
            return;
         }
         this.LoadFacePart(param1.Mouth.SWFLocation,Mouth.TYPE,param2,param1.MouthColors,param1.Mouth.DragonBone);
      }
      
      private function loadActorEyeShadow(param1:Actor, param2:Function) : void
      {
         if(param1.EyeShadow)
         {
            this.LoadFacePart(param1.EyeShadow.SWFLocation,EyeShadow.TYPE,param2,param1.EyeShadowColors,param1.EyeShadow.DragonBone);
         }
         else
         {
            this.removeEyeShadow();
            param2();
         }
      }
      
      public function LoadAllFaceParts(param1:Actor, param2:Function) : void
      {
         var eyesDone:Function = null;
         var noseDone:Function = null;
         var mouthDone:Function = null;
         var actor:Actor = param1;
         var done:Function = param2;
         eyesDone = function():void
         {
            loadActorNose(actor,noseDone);
         };
         noseDone = function():void
         {
            loadActorMouth(actor,mouthDone);
         };
         mouthDone = function():void
         {
            loadActorEyeShadow(actor,done);
         };
         if(this._isDestroyed)
         {
            done();
            return;
         }
         this.loadActorEyes(actor,eyesDone);
      }
      
      public function changeFacePartColor(param1:String, param2:String = null) : void
      {
         this.moviestarDragonBone.colorizePart(param1,param2);
      }
      
      public function removeEyeShadow() : void
      {
         this.body.removeEyeShadow();
         this._frontEyeShadow = null;
         this._sideEyeShadow = null;
         this.actor.EyeShadow = null;
         this.actor.EyeShadowId = -1;
         this.actor.EyeShadowColors = null;
      }
      
      public function LoadFacePart(param1:String, param2:String, param3:Function, param4:String = null, param5:Boolean = false) : void
      {
         var dragonBoneDone:Function = null;
         var flashLoaderDone:Function = null;
         var url:String = param1;
         var id:String = param2;
         var done:Function = param3;
         var colors:String = param4;
         var dragonBone:Boolean = param5;
         dragonBoneDone = function():void
         {
            if(id == Eye.TYPE)
            {
               actor.EyeColors = colors;
               moviestarDragonBone.playDragonBoneAnimation(MovieStarDragonBone.EYES_NEUTRAL_ANIM,true,Eye.TYPE);
            }
            else if(id == EyeShadow.TYPE)
            {
               actor.EyeShadowColors = colors;
               moviestarDragonBone.playDragonBoneAnimation(MovieStarDragonBone.EYES_NEUTRAL_ANIM,false,EyeShadow.TYPE);
            }
            else if(id == Nose.TYPE)
            {
               changeFacePartColor(id,actor.SkinColor);
            }
            else
            {
               if(id != Mouth.TYPE)
               {
                  throw new Error("Facepart Id: " + id + " is not dragonbone");
               }
               if(colors == null)
               {
                  colors = actor.SkinColor;
               }
               actor.MouthColors = colors;
               changeFacePartColor(id,colors);
            }
            if(done != null)
            {
               done();
            }
         };
         flashLoaderDone = function(param1:MSP_FlashLoader):void
         {
            var newLoader:MSP_FlashLoader = null;
            var loaderCopyCompleteHandler:Function = null;
            var loader:MSP_FlashLoader = param1;
            loaderCopyCompleteHandler = function(param1:Event):void
            {
               var _loc2_:MovieClip = MovieClip(newLoader.content);
               newLoader = null;
               switch(id)
               {
                  case Mouth.TYPE:
                     isDragonBoneMouth = false;
                     attachMouth(_loc2_,colors);
                     actor.MouthColors = colors ? colors : ColorMap.GetColorsOnMovieClip(_loc2_);
                     break;
                  case Eye.TYPE:
                     isDragonBoneEyes = false;
                     attachEyes(_loc2_,colors);
                     actor.EyeColors = colors ? colors : ColorMap.GetColorsOnMovieClip(_loc2_);
                     break;
                  case Nose.TYPE:
                     isDragonBoneNose = false;
                     attachNose(_loc2_,"skincolor");
                     break;
                  default:
                     throw new Error("Unknown facepart Id: " + id);
               }
               if(done != null)
               {
                  done();
               }
            };
            AssetCacheManager.addData(url,loader);
            newLoader = new MSP_FlashLoader();
            newLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,loaderCopyCompleteHandler);
            newLoader.loadBytes(loader.contentLoaderInfo.bytes);
         };
         if(this._isDestroyed)
         {
            done();
            return;
         }
         if(dragonBone)
         {
            if(colors != null)
            {
               colors = colors.replace("skincolor",this.actor.SkinColor);
            }
            if(id == Eye.TYPE)
            {
               this.isDragonBoneEyes = true;
               this.moviestarDragonBone.loadFacePartDragonBone(ContentUrl.DRAGONBONE_FACEPARTS_SUBPATH + url,null,id,colors,"eyeball",this.attachFrontEyesDragonBone,this.attachSideEyesDragonBone,dragonBoneDone);
            }
            if(id == EyeShadow.TYPE)
            {
               this.moviestarDragonBone.loadFacePartDragonBone(ContentUrl.DRAGONBONE_FACEPARTS_SUBPATH + url,null,id,colors,"color",this.attachFrontEyeShadowDragonBone,this.attachSideEyeShadowDragonBone,dragonBoneDone);
            }
            if(id == Nose.TYPE)
            {
               this.moviestarDragonBone.loadFacePartDragonBone(ContentUrl.DRAGONBONE_FACEPARTS_SUBPATH + url,null,id,colors,"color",this.attachFrontNoseDragonBone,this.attachSideNoseDragonBone,dragonBoneDone);
            }
            if(id == Mouth.TYPE)
            {
               this.isDragonBoneMouth = true;
               this.moviestarDragonBone.loadFacePartDragonBone(ContentUrl.DRAGONBONE_FACEPARTS_SUBPATH + url,null,id,colors,"color",this.attachFrontMouthDragonBone,this.attachSideMouthDragonBone,dragonBoneDone);
            }
         }
         else if(AssetCacheManager.hasDataForPath(url))
         {
            flashLoaderDone(AssetCacheManager.getData(url));
         }
         else
         {
            MSP_FlashLoader.RequestLoad(new ContentUrl(url,ContentUrl.FACEPART),flashLoaderDone,MSP_LoaderManager.PRIORITY_NORMAL,this._isLoadDeletable,false);
         }
      }
      
      public function attachFrontNoseDragonBone(param1:MovieClip) : void
      {
         this.removeOldNose();
         this.frontNose = param1;
         this.isDragonBoneNose = true;
         this.body.UpdateNose();
      }
      
      public function attachSideNoseDragonBone(param1:MovieClip) : void
      {
         this.removeOldNose();
         this.sideNose = param1;
         this.isDragonBoneNose = true;
         this.body.UpdateNose();
      }
      
      public function attachFrontMouthDragonBone(param1:MovieClip) : void
      {
         this.frontMouth = param1;
         this.body.UpdateMouth();
      }
      
      public function attachSideMouthDragonBone(param1:MovieClip) : void
      {
         this.sideMouth = param1;
         this.body.UpdateMouth();
      }
      
      private function attachMouth(param1:MovieClip, param2:String) : void
      {
         this._mouthMC = param1;
         ColorMap.SetColorsOnMovieClip(param1,this.skinColor,param2);
         this.body.UpdateMouth();
      }
      
      public function attachFrontEyesDragonBone(param1:MovieClip) : void
      {
         this.frontEyes = param1;
         this.body.UpdateEyes();
      }
      
      public function attachSideEyesDragonBone(param1:MovieClip) : void
      {
         this.sideEyes = param1;
         this.body.UpdateEyes();
      }
      
      private function attachEyes(param1:MovieClip, param2:String) : void
      {
         this._eyesMC = param1;
         ColorMap.SetColorsOnMovieClip(param1,this.skinColor,param2);
         this.body.UpdateEyes();
      }
      
      private function attachNose(param1:MovieClip, param2:String) : void
      {
         this.removeOldNose();
         this._noseMC = param1;
         ColorMap.SetColorsOnMovieClip(param1,this.skinColor,param2);
         this.body.UpdateNose();
      }
      
      private function removeOldNose() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:MovieClip = null;
         if(this.isDragonBoneNose)
         {
            _loc1_ = this.frontNose;
            _loc2_ = this.sideNose;
         }
         else if(this.noseMC != null)
         {
            _loc1_ = MovieClip(this.noseMC.FrontNose);
            _loc2_ = MovieClip(this.noseMC.SideNose);
         }
         if(_loc1_ != null && _loc1_.parent != null)
         {
            _loc1_.parent.removeChild(_loc1_);
         }
         if(_loc2_ != null && _loc2_.parent != null)
         {
            _loc2_.parent.removeChild(_loc2_);
         }
      }
      
      public function attachFrontEyeShadowDragonBone(param1:MovieClip) : void
      {
         this._frontEyeShadow = param1;
         this.body.UpdateEyeShadow();
      }
      
      public function attachSideEyeShadowDragonBone(param1:MovieClip) : void
      {
         this._sideEyeShadow = param1;
         this.body.UpdateEyeShadow();
      }
      
      public function StopAnimation() : void
      {
         this._pendingPlayAnimationRequest = null;
         this._pendingStopAnimationsRequest = true;
         if(this.body != null && this._pendingStopAnimationsRequest)
         {
            this._isAnimating = false;
            this.body.instance.gotoAndStop(1);
            this._pendingStopAnimationsRequest = false;
         }
      }
      
      public function setAnimation(param1:Animation, param2:Function = null, param3:int = 0) : void
      {
         this._animation = param1;
         this.PlayAnimation(this.animation.FrameLabel,param2,param3,null,this.animation.LastUpdated);
      }
      
      public function get animation() : Animation
      {
         return this._animation;
      }
      
      public function get startFrame() : int
      {
         if(this.currentPlayingAnimation)
         {
            return this.currentPlayingAnimation.startFrame;
         }
         return 0;
      }
      
      public function get finalFrame() : int
      {
         if(this.currentPlayingAnimation)
         {
            return this.currentPlayingAnimation.stopFrame;
         }
         return 0;
      }
      
      public function get stopFrame() : int
      {
         if(this._selectedStopFrame)
         {
            return this._selectedStopFrame;
         }
         return 0;
      }
      
      public function set stopFrame(param1:int) : void
      {
         this._selectedStopFrame = param1;
         if(this.currentPlayingAnimation)
         {
            if(this._isAnimating)
            {
               this._isAnimating = false;
            }
            this.body.instance.gotoAndStop(param1);
         }
      }
      
      public function PlayAnimation(param1:String, param2:Function = null, param3:int = 0, param4:Function = null, param5:Date = null) : void
      {
         var tempAnimation:Object = null;
         var animationFileLoaded:Function = null;
         var showBodyDone:Function = null;
         var name:String = param1;
         var done:Function = param2;
         var selectedStopFrame:int = param3;
         var doneCallLater:Function = param4;
         var lastUpdated:Date = param5;
         animationFileLoaded = function(param1:Object):void
         {
            isStartingAnimation = true;
            tempAnimation = param1;
            showBody(tempAnimation,showBodyDone);
         };
         showBodyDone = function():void
         {
            if(_talkBeforeLoad && _stopTalkingTimeStamp == 0)
            {
               talk(_talkBeforeLoadMilliSeconds);
            }
            if(_faceExpressionBeforeLoad)
            {
               SetFaceExpression(_faceExpressionBeforeLoad);
            }
            _selectedStopFrame = selectedStopFrame;
            if(tempAnimation != null)
            {
               startAnimation(tempAnimation.animationData);
            }
            if(done != null)
            {
               done();
            }
            if(doneCallLater != null)
            {
               callLater(doneCallLater);
            }
         };
         if(this._isDestroyed)
         {
            if(done != null)
            {
               done();
            }
            return;
         }
         this._pendingPlayAnimationRequest = name;
         if(this._isLoaded)
         {
            this._isAnimating = false;
            this.loadAnimationFile(this._pendingPlayAnimationRequest,lastUpdated,animationFileLoaded);
         }
      }
      
      private function startAnimation(param1:Object) : void
      {
         this.isStartingAnimation = true;
         this.currentPlayingAnimation = param1;
         this._isAnimating = true;
         this.hookUpToEnterFrameEvent();
         this._currentlyPlayingFrameLabel = this._pendingPlayAnimationRequest;
         this._pendingPlayAnimationRequest = null;
      }
      
      public function defaultPoseName() : String
      {
         if(this.isFemale())
         {
            return "Girl Pose";
         }
         return "Boy Pose";
      }
      
      private function hookUpToEnterFrameEvent() : void
      {
         if(this._isDestroyed)
         {
            return;
         }
         if(this._isListeningForEnterFrameEvents == false)
         {
            this._isListeningForEnterFrameEvents = true;
            addEventListener(Event.ENTER_FRAME,this.HandleEnterFrame,false,0,true);
            SoundManager.Instance().addEventListener(MSP_Event.E_MUTE_CHANGED,this.toggleMute);
         }
      }
      
      private function unHookFromEnterFrameEvent() : void
      {
         if(this._isListeningForEnterFrameEvents == true)
         {
            this._isListeningForEnterFrameEvents = false;
            removeEventListener(Event.ENTER_FRAME,this.HandleEnterFrame);
            SoundManager.Instance().removeEventListener(MSP_Event.E_MUTE_CHANGED,this.toggleMute);
         }
      }
      
      public function toggleMute(param1:Event = null) : void
      {
         var _loc2_:SoundTransform = null;
         if(this.body != null)
         {
            _loc2_ = this.body.soundTransform;
            if(SoundManager.Instance().isMuted)
            {
               _loc2_.volume = 0;
            }
            else
            {
               _loc2_.volume = 1;
            }
            this.body.soundTransform = _loc2_;
         }
      }
      
      private function HandleEnterFrame(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Boolean = false;
         if(this._isDestroyed)
         {
            return;
         }
         if(this.body == null)
         {
            return;
         }
         var _loc2_:int = int(getTimer());
         if(this._isAnimating)
         {
            if(this.isStartingAnimation)
            {
               this.startTime = _loc2_;
               this.lastFrame = this._selectedStopFrame ? this._selectedStopFrame : int(this.currentPlayingAnimation.stopFrame);
               this.stopFrames = new Array();
               for each(_loc7_ in this.currentPlayingAnimation.soundFrames)
               {
                  this.stopFrames.push(_loc7_);
               }
               this.stopFrames.push(this.lastFrame);
               this.nextAnimationFrame = this.startFrame;
               this.indexOfNextStopFrame = 0;
               this.animationIsLooping = this._selectedStopFrame ? false : this.currentPlayingAnimation.loop == true;
               this.prevDeltaFramesTotal = 0;
            }
            _loc3_ = _loc2_ - this.startTime;
            _loc4_ = _loc3_ / this.frameLength;
            _loc5_ = _loc4_ - this.prevDeltaFramesTotal;
            this.prevDeltaFramesTotal = _loc4_;
            this.nextAnimationFrame += _loc5_;
            _loc6_ = int(this.stopFrames[this.indexOfNextStopFrame]);
            if(this.nextAnimationFrame > _loc6_)
            {
               _loc8_ = this.indexOfNextStopFrame == this.stopFrames.length - 1;
               if(_loc8_)
               {
                  this.indexOfNextStopFrame = 0;
                  if(this.animationIsLooping)
                  {
                     this.nextAnimationFrame = this.startFrame + (this.nextAnimationFrame - this.startFrame) % (this.lastFrame - this.startFrame);
                     if(this.nextAnimationFrame > this.stopFrames[this.indexOfNextStopFrame])
                     {
                        this.nextAnimationFrame = this.stopFrames[this.indexOfNextStopFrame];
                     }
                  }
                  else
                  {
                     this.nextAnimationFrame = this.lastFrame;
                  }
               }
               else
               {
                  this.nextAnimationFrame = _loc6_;
                  ++this.indexOfNextStopFrame;
               }
            }
            if(this.isStartingAnimation)
            {
               this.isStartingAnimation = false;
               this.nextAnimationFrame = 1;
            }
            this.body.instance.gotoAndStop(this.nextAnimationFrame);
            if(this.animationIsLooping == false && this.nextAnimationFrame == this.lastFrame)
            {
               this._isAnimating = false;
            }
         }
         if(this._isTalking)
         {
            if(this._stopTalkingTimeStamp == -1 || _loc2_ < this._stopTalkingTimeStamp)
            {
               this.body.AnimateMouth();
            }
            else
            {
               this.StopTalk();
            }
         }
         if(this._isAnimating == false && this._isTalking == false)
         {
            this.unHookFromEnterFrameEvent();
         }
      }
      
      private function GetString() : String
      {
         var _loc1_:String = toString();
         var _loc2_:String = _loc1_.substr(_loc1_.length - 3,3);
         return "MovieStar_" + _loc2_;
      }
      
      public function get isAnimating() : Boolean
      {
         return this._isAnimating;
      }
      
      public function StopTalk() : void
      {
         if(this._isDestroyed)
         {
            return;
         }
         this._talkBeforeLoad = false;
         if(this.body == null)
         {
            return;
         }
         this.body.UpdateMouth();
         this._isTalking = false;
         this._stopTalkingTimeStamp = 0;
         dispatchEvent(new Event(TALK_ENDED));
      }
      
      public function StopAll() : void
      {
         this.StopAnimation();
         this.StopTalk();
      }
      
      public function talk(param1:Number = -1) : void
      {
         if(this._isDestroyed)
         {
            return;
         }
         this._talkBeforeLoad = true;
         this._talkBeforeLoadMilliSeconds = param1;
         if(this._isLoaded)
         {
            if(param1 == -1)
            {
               this._stopTalkingTimeStamp = -1;
            }
            else
            {
               this._stopTalkingTimeStamp = getTimer() + param1;
            }
            this._isTalking = true;
            this.hookUpToEnterFrameEvent();
         }
      }
      
      public function get currentlyPlayingFrameLabel() : String
      {
         return this._currentlyPlayingFrameLabel;
      }
      
      public function get content() : DisplayObject
      {
         return this._currentShownLoader;
      }
      
      public function get currentFaceExpression() : String
      {
         return this.body.currentFaceExpression.key;
      }
      
      public function playEyeAnimation(param1:String) : void
      {
         var _loc2_:Boolean = param1 == "EyesNeutral" ? true : false;
         this.moviestarDragonBone.playDragonBoneAnimation(param1,_loc2_,Eye.TYPE);
      }
      
      public function playMouthAnimation(param1:String) : void
      {
         this.moviestarDragonBone.playDragonBoneAnimation(param1,false,Mouth.TYPE);
      }
      
      public function set faceExpression(param1:FaceExpression) : void
      {
         this._faceExpression = param1;
         this.SetFaceExpression(this.faceExpression.key);
      }
      
      public function get faceExpression() : FaceExpression
      {
         return this._faceExpression;
      }
      
      public function SetFaceExpression(param1:String) : void
      {
         this._faceExpressionBeforeLoad = param1;
         if(this._isLoaded)
         {
            this._pendingFaceExpression = param1;
            if(this.body != null && this._pendingFaceExpression != null && this._pendingFaceExpression != "")
            {
               this.body.SetFaceExpression(this._pendingFaceExpression);
               this._pendingFaceExpression = null;
            }
         }
      }
      
      public function SetTempFaceExpression(param1:String, param2:Number) : void
      {
         if(this.oldFace == null && this.body != null && this.body.currentFaceExpression != null)
         {
            this.oldFace = this.body.currentFaceExpression.key;
         }
         this.SetFaceExpression(param1);
         if(this.tmpFaceTimer != null)
         {
            this.cleanTmpFaceTimer();
         }
         this.tmpFaceTimer = new Timer(param2,1);
         this.tmpFaceTimer.addEventListener(TimerEvent.TIMER,this.resetFaceExpression,false,0,true);
         this.tmpFaceTimer.start();
      }
      
      private function resetFaceExpression(param1:Event) : void
      {
         this.cleanTmpFaceTimer();
         if(this.oldFace == null)
         {
            this.oldFace = "neutral";
         }
         this.SetFaceExpression(this.oldFace);
         this.oldFace = null;
      }
      
      private function cleanTmpFaceTimer() : void
      {
         if(this.tmpFaceTimer == null)
         {
            return;
         }
         this.tmpFaceTimer.stop();
         this.tmpFaceTimer.removeEventListener(TimerEvent.TIMER,this.resetFaceExpression);
         this.tmpFaceTimer = null;
      }
      
      public function GetSkinColor() : uint
      {
         return this.skinColor;
      }
      
      public function GetCloth(param1:int) : ActorClothesRel
      {
         var _loc2_:ActorClothesRel = null;
         for each(_loc2_ in this.actor.ActorClothesRels)
         {
            if(_loc2_.ActorClothesRelId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function PutOnCloth(param1:ActorClothesRel, param2:Function = null) : void
      {
         var clothesReady:Function = null;
         var rel:ActorClothesRel = param1;
         var done:Function = param2;
         clothesReady = function(param1:MovieClip):void
         {
            var _loc2_:Cloth = null;
            if(param1 != null)
            {
               _loc2_ = rel.Cloth;
               TakeOffConflictingCloths(_loc2_);
               if(body != null)
               {
                  body.AttachItem(rel,param1);
               }
               if(rel.isFootwear)
               {
                  _isWearingHighHeels = rel.isHighHeel;
               }
            }
            if(done != null)
            {
               done();
            }
         };
         ClothesUtils.prepareClothesForWearing(rel,this.skinColor,clothesReady,true,scaleX);
      }
      
      public function get isWearingHighHeels() : Boolean
      {
         return this._isWearingHighHeels;
      }
      
      public function isWearingCloth(param1:Cloth) : Boolean
      {
         var _loc2_:AttachedItem = null;
         for each(_loc2_ in this.AttachedItems)
         {
            if((_loc2_.Rel as ActorClothesRel).Cloth.ClothesId == param1.ClothesId)
            {
               return true;
            }
         }
         return false;
      }
      
      public function isWearingRel(param1:ActorClothesRel) : Boolean
      {
         var _loc2_:AttachedItem = null;
         for each(_loc2_ in this.AttachedItems)
         {
            if((_loc2_.Rel as ActorClothesRel).ActorClothesRelId == param1.ActorClothesRelId)
            {
               return true;
            }
         }
         return false;
      }
      
      public function TakeOffConflictingCloths(param1:Cloth) : void
      {
         var _loc2_:AttachedItem = null;
         for each(_loc2_ in this.AttachedItems)
         {
            if(ClothingCategories.IsClothsConflicting(param1,(_loc2_.Rel as ActorClothesRel).Cloth))
            {
               this.body.DetachItem(_loc2_);
            }
         }
      }
      
      public function TakeOffCloth(param1:ActorClothesRel) : void
      {
         var _loc2_:AttachedItem = null;
         if(param1.IsWearing)
         {
            for each(_loc2_ in this.AttachedItems)
            {
               if((_loc2_.Rel as ActorClothesRel).ActorClothesRelId == param1.ActorClothesRelId)
               {
                  this.body.DetachItem(_loc2_);
               }
            }
         }
      }
      
      public function StripAll() : void
      {
         if(this.body != null)
         {
            this.body.StripAll();
         }
      }
      
      public function StripClothes() : void
      {
         if(this.body != null)
         {
            this.body.StripClothes();
         }
      }
      
      public function getAppearanceData() : Object
      {
         return AppearanceUtil.getAppearanceData(this.actor,this.GetAttachedClothes());
      }
      
      public function addClothesFromData(param1:Object, param2:Function) : void
      {
         if(param1.ClothesMin)
         {
            this.setClothesFromData(param1.ClothesMin,param1.actorId,param2);
         }
         else if(param1.ActorClothesRel)
         {
            this.SetClothes(param1.ActorClothesRel.toArray(),param2);
         }
         else
         {
            this.SetClothes(this.GetIsWearingClothes(this.actor),param2);
         }
      }
      
      public function setClothesFromData(param1:Array, param2:int, param3:Function) : void
      {
         var clothesDone:Function = null;
         var data:Array = param1;
         var actorId:int = param2;
         var callback:Function = param3;
         clothesDone = function():void
         {
            if(callback != null)
            {
               callback();
            }
         };
         this.SetClothes(dataToClothes(data,actorId),clothesDone);
      }
      
      public function getAttachedClothesAsData() : Array
      {
         return AppearanceUtil.clothesToData(this.GetAttachedClothes());
      }
      
      public function startBlinking() : void
      {
         this.stopBlinking();
         this.blinkTimer = new Timer((6000 + Math.random() * 500) / 1);
         this.blinkTimer.addEventListener(TimerEvent.TIMER,this.blink,false,0,true);
         this.blinkTimer.start();
      }
      
      public function stopBlinking() : void
      {
         if(this.blinkTimer)
         {
            this.blinkTimer.removeEventListener(TimerEvent.TIMER,this.blink);
            this.blinkTimer.stop();
         }
      }
      
      public function blink(param1:Event = null) : void
      {
         this.blinkFrameCounter = 0;
         addEventListener(Event.ENTER_FRAME,this.blinkFrame);
         this.body.closeEyes();
      }
      
      protected function blinkFrame(param1:Event) : void
      {
         if(this.blinkFrameCounter++ >= FRAMES_PER_BLINK)
         {
            removeEventListener(Event.ENTER_FRAME,this.blinkFrame);
            this.body.UpdateEyes();
         }
      }
      
      public function get platformBadge() : IMovieStarBadge
      {
         return this._platformBadge;
      }
      
      public function set platformBadge(param1:IMovieStarBadge) : void
      {
         if(this.platformBadge == param1)
         {
            return;
         }
         if(this.platformBadge != null)
         {
            removeChild(this.platformBadge as DisplayObject);
         }
         this._platformBadge = param1;
         if(this.platformBadge != null)
         {
            addChild(this.platformBadge as DisplayObject);
         }
      }
      
      public function get platformType() : int
      {
         return this._platformType;
      }
      
      public function set platformType(param1:int) : void
      {
         this._platformType = param1;
      }
      
      public function get isNewPet() : Boolean
      {
         return this._isNewPet;
      }
      
      public function set isNewPet(param1:Boolean) : void
      {
         this._isNewPet = param1;
      }
      
      public function get skinColor() : uint
      {
         return this._skinColor;
      }
      
      public function set skinColor(param1:uint) : void
      {
         var _loc2_:String = null;
         this._skinColor = param1;
         this._actor.SkinColor = this._skinColor.toString();
         ColorMap.SetColorsOnMovieClip(this.skinMC,this._skinColor);
         if(!this.isDragonBoneEyes)
         {
            ColorMap.SetColorsOnMovieClip(this.eyesMC,this._skinColor);
         }
         if(this.isDragonBoneMouth)
         {
            _loc2_ = this._actor.MouthColors;
            _loc2_ = this.actor.SkinColor + _loc2_.substring(_loc2_.indexOf(","));
            this._actor.MouthColors = _loc2_;
            this.moviestarDragonBone.colorizePart(Mouth.TYPE,this._actor.MouthColors);
         }
         else
         {
            ColorMap.SetColorsOnMovieClip(this.mouthMC,this._skinColor);
         }
         if(this.isDragonBoneNose)
         {
            this.moviestarDragonBone.colorizePart(Nose.TYPE,this._actor.SkinColor);
         }
         else
         {
            ColorMap.SetColorsOnMovieClip(this.noseMC,this._skinColor);
         }
      }
      
      public function get clothLoader() : IClothLoader
      {
         return this;
      }
      
      public function get displayObject() : IDisplayObject
      {
         return this;
      }
      
      public function isWearing(param1:ActorClothesRel) : Boolean
      {
         return this.isWearingRel(param1);
      }
      
      public function wearCloth(param1:ActorClothesRel, param2:Function, param3:Function) : void
      {
         this.PutOnCloth(param1,param2);
      }
   }
}

