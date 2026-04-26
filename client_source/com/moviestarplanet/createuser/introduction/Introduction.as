package com.moviestarplanet.createuser.introduction
{
   import com.greensock.TimelineLite;
   import com.greensock.TweenAlign;
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import com.moviestarplanet.IDestroyable;
   import com.moviestarplanet.actorutils.ActorUtils;
   import com.moviestarplanet.analytics.constants.AnalyticsConstants;
   import com.moviestarplanet.anchorCharacters.AnchorActivityManager;
   import com.moviestarplanet.anchorCharacters.AnchorCharacters;
   import com.moviestarplanet.configurations.AppSettings;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.createuser.present.SignupPresents;
   import com.moviestarplanet.createuser.present.definition.IPresentDefinition;
   import com.moviestarplanet.flash.components.buttons.ButtonWithFrames;
   import com.moviestarplanet.friendship.service.FriendshipServiceWeb;
   import com.moviestarplanet.frontpage.RegisterNewUserComponent;
   import com.moviestarplanet.locale.ILocaleManager;
   import com.moviestarplanet.managers.SoundManager;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.moviestar.MovieStarSprite;
   import com.moviestarplanet.msg.EventController;
   import com.moviestarplanet.school.popup.SchoolAfterCreationPopup;
   import com.moviestarplanet.utils.FontManager;
   import com.moviestarplanet.utils.MSP_SWFLoader;
   import com.moviestarplanet.utils.loader.RawUrl;
   import com.moviestarplanet.utils.sound.Sounds;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import flash.display.DisplayObject;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.describeType;
   import flash.utils.setTimeout;
   import flashx.textLayout.formats.TextAlign;
   
   public class Introduction extends Sprite implements IDestroyable
   {
      
      private static const W_WIDTH:Number = 1240;
      
      private static const W_HEIGHT:Number = 720;
      
      private static const EC_BACKGROUND_READY:String = "EC_BACKGROUND_READY";
      
      private static const EC_SELF_READY:String = "EC_SELF_READY";
      
      private static const EC_NPC_READY:String = "EC_NPC_READY";
      
      private static const EC_GRAPHICS_READY:String = "EC_GRAPHICS_READY";
      
      private static const EC_PRESENTS_READY:String = "EC_PRESENTS_READY";
      
      private static const EC_SPEECHBUBBLES_READY:String = "EC_SPEECHBUBBLES_READY";
      
      private static const MOVIESTARSPRITE_SCALE:Number = 0.6;
      
      private static const MSS_Y:Number = 350;
      
      private static const MSS_SELF_START_X:Number = -100;
      
      private static const MSS_SELF_INTERMEDIATE_X:Number = 300;
      
      private static const MSS_SELF_SCHOOL_X:Number = 100;
      
      private static const MSS_SELF_END_X:Number = 105;
      
      private static const MSS_SELF_END_Y:Number = 275;
      
      private static const MSS_NPC_SCHOOL_X:Number = 500;
      
      private static const MSS_NPC_START_X:Number = 1280;
      
      private static const MSS_NPC_END_X:Number = 840;
      
      private static const PARALLAX_OFFSET_START_X:Number = -700;
      
      private static const PARALLAX_OFFSET_START_Y:Number = -600;
      
      private static const PARALLAX_OFFSET_END_X:Number = -400;
      
      private static const PARALLAX_OFFSET_END_Y:Number = 0;
      
      private static const PARALLAX_PANTIME:Number = 2;
      
      private static const SPEECHBUBBLE_READTIME:Number = 3;
      
      private static const SPEECHBUBBLE_FADEINTIME:Number = 0.3;
      
      private static const SPEECHBUBBLE_FADEOUTTIME:Number = 0.3;
      
      private static const PRESENTS_END_X:Number = 10;
      
      private static const PRESENTS_END_Y:Number = 575;
      
      private static const PRESENTS_END_SCALE:Number = 0.4;
      
      private static const ACTIVITY_HOLE_X:Number = 510;
      
      private static const ACTIVITY_HOLE_Y:Number = 30;
      
      private static const ACTIVITY_HOLE_DIMENSION:Number = 50;
      
      public static var hadIntroduction:Boolean = false;
      
      private static const FLASH_SOUNDS:Vector.<String> = new <String>[Sounds.CAMERA_FLASH_1,Sounds.CAMERA_FLASH_2,Sounds.CAMERA_FLASH_3,Sounds.CAMERA_FLASH_4,Sounds.CAMERA_FLASH_5];
      
      private var npcActorIds:Dictionary;
      
      private var backgroundParallax:Parallaxer;
      
      private var backgroundParallaxInstanceMultipliers:Array = [{
         "name":"level1",
         "mx":1,
         "my":1
      },{
         "name":"level2",
         "mx":0.2,
         "my":0.2
      }];
      
      private var npc:MovieStarSprite;
      
      private var self:MovieStarSprite;
      
      private var background:DisplayObject;
      
      private var skip:MovieClip;
      
      private var speechbubblewelcome:DisplayObject;
      
      private var speechbubbletwo:DisplayObject;
      
      private var speechbubblepresents:DisplayObject;
      
      private var speechbubbletomorrow:DisplayObject;
      
      private var speechbubblemission:DisplayObject;
      
      private var speechbubblelast:DisplayObject;
      
      private var speechbubbleSchool:DisplayObject;
      
      private var speechbubbleAnchor:DisplayObject;
      
      private var introHole:Sprite;
      
      private var introNoHole:Sprite;
      
      private var npcLoadedCorrectly:Boolean = true;
      
      private var selfLoadedCorrectly:Boolean = true;
      
      private var npcLoadedTimeout:uint;
      
      private var selfLoadedTimeout:uint;
      
      private var SpeechbubbleStaticType:Class;
      
      private var SpeechbubbleCenteredStaticType:Class;
      
      private var eventcontroller:EventController;
      
      private var eventcontrollerPresentSpeechbubble:EventController;
      
      private var dispatcher:IEventDispatcher;
      
      private var dispatcherPresentSpeechbubble:IEventDispatcher;
      
      private var animateFromTimeline:TimelineLite;
      
      private var animateToTimeline:TimelineLite;
      
      private var signuppresents:SignupPresents;
      
      private var removed:Function;
      
      private var preremoved:Function;
      
      private var starting:Function;
      
      private var npcRideTimer:Timer;
      
      private var flashsoundtimer:Timer;
      
      private var ArrowType:Class;
      
      private var SkipType:Class;
      
      private var skiphandler:ButtonWithFrames;
      
      private var showSchoolPopup:Boolean;
      
      private var schoolPopup:SchoolAfterCreationPopup;
      
      public function Introduction(param1:Function, param2:Function, param3:Function)
      {
         super();
         this.showSchoolPopup = AppSettings.getInstance().getSetting(AppSettings.SCHOOL_FRIENDS_ENABLED_SWITCH).toLowerCase() == "true";
         this.starting = param1;
         this.preremoved = param2;
         this.removed = param3;
         hadIntroduction = true;
         this.npcActorIds = new Dictionary(true);
         this.npcActorIds[1] = AnchorCharacters.FEMALE_ANCHOR;
         this.npcActorIds[2] = AnchorCharacters.MALE_ANCHOR;
         this.eventcontroller = new EventController();
         this.eventcontrollerPresentSpeechbubble = new EventController();
         this.dispatcher = new EventDispatcher();
         this.dispatcherPresentSpeechbubble = new EventDispatcher();
         this.setupLoadingQueue();
         this.eventcontroller.notifyMe(this.setupAnimations);
         this.eventcontrollerPresentSpeechbubble.notifyMe(this.setupSpeechbubbles);
      }
      
      private function setupLoadingQueue() : void
      {
         this.eventcontroller.listenForEvent(this.dispatcher,EC_BACKGROUND_READY);
         this.eventcontroller.listenForEvent(this.dispatcher,EC_SELF_READY);
         this.eventcontroller.listenForEvent(this.dispatcher,EC_NPC_READY);
         this.eventcontroller.listenForEvent(this.dispatcher,EC_GRAPHICS_READY);
         this.eventcontroller.listenForEvent(this.dispatcher,EC_PRESENTS_READY);
         this.eventcontroller.listenForEvent(this.dispatcher,EC_SPEECHBUBBLES_READY);
         this.eventcontrollerPresentSpeechbubble.listenForEvent(this.dispatcherPresentSpeechbubble,EC_GRAPHICS_READY);
         this.eventcontrollerPresentSpeechbubble.listenForEvent(this.dispatcherPresentSpeechbubble,EC_PRESENTS_READY);
         this.loadBackground();
         this.loadGraphicObjects();
         this.loadPresents();
         this.loadSelf();
         this.loadNPC();
      }
      
      private function loadSelf() : void
      {
         this.self = new MovieStarSprite();
         this.self.allowClickEvents = false;
         this.self.scale = MOVIESTARSPRITE_SCALE;
         this.self.Load(ActorSession.loggedInActor.ActorId,this.selfLoaded);
         this.selfLoadedTimeout = setTimeout(this.selfLoadFailed,5000);
      }
      
      private function selfLoadFailed() : void
      {
         this.self.destroy();
         this.self = null;
         this.selfLoadedCorrectly = false;
         this.dispatcher.dispatchEvent(new Event(EC_SELF_READY));
      }
      
      private function selfLoaded(param1:MovieStarSprite) : void
      {
         if(this.selfLoadedCorrectly)
         {
            clearTimeout(this.selfLoadedTimeout);
            this.self.x = MSS_SELF_START_X;
            this.self.y = MSS_Y;
            this.dispatcher.dispatchEvent(new Event(EC_SELF_READY));
         }
      }
      
      private function loadNPC() : void
      {
         var _loc1_:int = ActorUtils.getSkinIdActor(ActorSession.loggedInActor);
         this.npc = new MovieStarSprite();
         this.npc.allowClickEvents = false;
         this.npc.visible = false;
         this.npc.scale = MOVIESTARSPRITE_SCALE;
         this.npc.Load(this.npcActorIds[_loc1_],this.npcLoaded);
         this.npcLoadedTimeout = setTimeout(this.npcLoadFailed,5000);
      }
      
      private function npcLoadFailed() : void
      {
         this.npc.destroy();
         this.npc = null;
         this.npcLoadedCorrectly = false;
         this.dispatcher.dispatchEvent(new Event(EC_NPC_READY));
      }
      
      private function npcLoaded(param1:MovieStarSprite) : void
      {
         if(this.npcLoadedCorrectly)
         {
            clearTimeout(this.npcLoadedTimeout);
            this.npc.x = MSS_NPC_END_X;
            this.npc.y = MSS_Y;
            this.dispatcher.dispatchEvent(new Event(EC_NPC_READY));
         }
      }
      
      private function loadBackground() : void
      {
         MSP_SWFLoader.RequestLoad(new RawUrl("swf/newplayerexperience/NewUserExperienceBackground.swf"),this.backgroundLoadComplete);
      }
      
      private function backgroundLoadComplete(param1:MSP_SWFLoader) : void
      {
         var _loc4_:Object = null;
         var _loc2_:Class = param1.content.loaderInfo.applicationDomain.getDefinition("ParObject") as Class;
         this.background = new _loc2_() as DisplayObject;
         this.background.scrollRect = new Rectangle(0,0,1240,720);
         var _loc3_:MovieClip = (this.background as MovieClip)["level1"];
         if(_loc3_ != null)
         {
            _loc3_ = _loc3_["planet"];
            if(_loc3_ != null)
            {
               _loc3_ = _loc3_["MSPsculpture"];
               if(_loc3_ != null)
               {
                  _loc3_.gotoAndStop(Config.getCurrentSiteConfig().brandName);
               }
            }
         }
         this.backgroundParallax = new Parallaxer(1000 / 24);
         var _loc5_:int = 0;
         while(_loc5_ < this.backgroundParallaxInstanceMultipliers.length)
         {
            _loc4_ = this.backgroundParallaxInstanceMultipliers[_loc5_];
            _loc3_ = this.background[_loc4_.name];
            _loc3_.stop();
            this.backgroundParallax.addObject(_loc3_,_loc4_.mx,_loc4_.my);
            _loc5_++;
         }
         this.backgroundParallax.x = PARALLAX_OFFSET_START_X;
         this.backgroundParallax.y = PARALLAX_OFFSET_START_Y;
         this.dispatcher.dispatchEvent(new Event(EC_BACKGROUND_READY));
      }
      
      private function loadGraphicObjects() : void
      {
         MSP_SWFLoader.RequestLoad(new RawUrl("swf/newplayerexperience/NewPlayerExperienceUIElements.swf"),this.graphicsLoadComplete);
      }
      
      private function graphicsLoadComplete(param1:MSP_SWFLoader) : void
      {
         var _loc2_:LoaderInfo = param1.content.loaderInfo;
         this.ArrowType = _loc2_.applicationDomain.getDefinition("Arrow") as Class;
         this.SkipType = _loc2_.applicationDomain.getDefinition("Skip") as Class;
         this.SpeechbubbleStaticType = _loc2_.applicationDomain.getDefinition("Speechbubble") as Class;
         this.SpeechbubbleCenteredStaticType = _loc2_.applicationDomain.getDefinition("SpeechbubbleCentered") as Class;
         this.skip = new this.SkipType();
         this.skip["bounds"].visible = false;
         this.skip.x = W_WIDTH - (this.skip["bounds"].width + 5);
         this.skip.y = 5;
         this.introHole = this.createIntroHoles(true);
         this.introNoHole = this.createIntroHoles(false);
         this.skiphandler = new ButtonWithFrames(this.skip,this.skipClicked,false,null,Sounds.SKIP,Sounds.BUTTON_HOVER);
         this.dispatcher.dispatchEvent(new Event(EC_GRAPHICS_READY));
         this.dispatcherPresentSpeechbubble.dispatchEvent(new Event(EC_GRAPHICS_READY));
      }
      
      private function loadPresents() : void
      {
         this.signuppresents = new SignupPresents(this.presenttimeoutmet,ActorSession.loggedInActor.ActorId,SignupPresents.OPENING_METHOD_ANIMATE,SignupPresents.REFIT_METHOD_CENTER,SignupPresents.ANIMATION_METHOD_PULSE);
         this.signuppresents.alpha = 0;
         this.signuppresents.visible = false;
         this.signuppresents.loadPresents(this.presentsLoaded);
      }
      
      private function presenttimeoutmet(param1:IPresentDefinition) : void
      {
         this.signuppresents.cleanoutOpenedPresents();
         this.signuppresents.setEnabled(false);
         this.animateFromActions();
      }
      
      private function presentsLoaded() : void
      {
         this.dispatcher.dispatchEvent(new Event(EC_PRESENTS_READY));
         this.dispatcherPresentSpeechbubble.dispatchEvent(new Event(EC_PRESENTS_READY));
      }
      
      private function skipClicked(param1:MouseEvent) : void
      {
         SoundManager.Instance().stopSoundEffect(Sounds.CROWD);
         if(this.flashsoundtimer != null)
         {
            this.flashsoundtimer.stop();
            this.flashsoundtimer.removeEventListener(TimerEvent.TIMER,this.nextFlash,false);
         }
         var _loc2_:int = 0;
         while(_loc2_ < FLASH_SOUNDS.length)
         {
            SoundManager.Instance().stopSoundEffect(FLASH_SOUNDS[_loc2_]);
            _loc2_++;
         }
         SoundManager.Instance().stopSoundEffect(Sounds.CAR_DRIVEAWAY);
         SoundManager.Instance().stopSoundEffect(Sounds.CAR_PULLUP);
         if(this.skiphandler != null)
         {
            this.skiphandler.setButtonizedEnabled(false);
         }
         if(this.animateToTimeline)
         {
            this.animateToTimeline.kill();
         }
         if(this.animateFromTimeline)
         {
            this.animateFromTimeline.kill();
         }
         if(this.self)
         {
            this.self.x = MSS_SELF_INTERMEDIATE_X;
         }
         if(this.npc)
         {
            this.npc.visible = true;
         }
         this.signuppresents.cleanoutOpenedPresents();
         this.signuppresents.setEnabled(false);
         removeChild(this.speechbubblewelcome);
         removeChild(this.speechbubbletwo);
         removeChild(this.speechbubblepresents);
         removeChild(this.speechbubbletomorrow);
         removeChild(this.background);
         if(!this.showSchoolPopup)
         {
            this.npcTalk();
         }
         this.selfEnd();
         this.presentsComplete();
         RegisterNewUserComponent.sendAnalyticsEvent(AnalyticsConstants.CHARACTER_CREATION_STEP4A);
      }
      
      private function setupAnimations() : void
      {
         addChild(this.background);
         addChild(this.introHole);
         addChild(this.introNoHole);
         if(this.showSchoolPopup)
         {
            addChild(this.speechbubbleSchool);
         }
         if(this.npcLoadedCorrectly)
         {
            addChild(this.npc);
         }
         if(this.selfLoadedCorrectly)
         {
            addChild(this.self);
         }
         addChild(this.speechbubblewelcome);
         addChild(this.speechbubbletwo);
         addChild(this.speechbubblepresents);
         addChild(this.speechbubbletomorrow);
         addChild(this.speechbubblemission);
         addChild(this.speechbubblelast);
         addChild(this.signuppresents);
         addChild(this.skip);
         this.starting();
         this.animateFromStartToRide();
      }
      
      private function st(param1:String, param2:Array = null) : String
      {
         var _loc3_:ILocaleManager = MSPLocaleManagerWeb.getInstance();
         return _loc3_.getString(param1,param2) || "";
      }
      
      private function setupSpeechbubbles() : void
      {
         var _loc1_:DisplayObject = this.createPresentPlaceholder(200,130);
         var _loc2_:DisplayObject = this.createPresentPlaceholder(200,130);
         var _loc3_:String = this.st("NEWUSERSEQUENCE_SCENE1_LINE1",[ActorSession.loggedInActor.Name]) + "\n" + this.st("NEWUSERSEQUENCE_SCENE1_LINE2");
         var _loc4_:String = this.st("NEWUSERSEQUENCE_SCENE1_LINE3");
         var _loc5_:String = this.st("NEWUSERSEQUENCE_SCENE2_LINE1");
         var _loc6_:String = this.st("NEWUSERSEQUENCE_SCENE3_LINE1");
         var _loc7_:String = this.st("NEWUSERSEQUENCE_SCENE4_LINE1");
         var _loc8_:String = this.st("NEWUSERSEQUENCE_SCENE5_LINE1",[ActorSession.loggedInActor.Name]);
         var _loc9_:String = AnchorCharacters.getNameForGender(ActorSession.isFemale);
         var _loc10_:String = this.st("ANCHOR_GAMEINTRO_GREETING_02",[_loc9_]);
         var _loc11_:String = MSPLocaleManagerWeb.getInstance().getString("MSP_MY_SCHOOL_HEADLINE_1");
         this.speechbubblewelcome = this.createStaticSpeechbubble(MSS_NPC_END_X - 50,MSS_Y,400,_loc3_,[]);
         this.speechbubbletwo = this.createStaticSpeechbubble(MSS_NPC_END_X - 50,MSS_Y,400,_loc4_,[]);
         this.speechbubblepresents = this.createStaticSpeechbubble(MSS_NPC_END_X - 50,MSS_Y,400,_loc5_,[_loc1_],2);
         this.speechbubbletomorrow = this.createStaticSpeechbubble(MSS_NPC_END_X - 50,MSS_Y,400,_loc6_,[_loc2_],2);
         this.speechbubbleAnchor = this.createStaticSpeechbubble(MSS_NPC_SCHOOL_X + 50,MSS_Y - 100,500,_loc10_,[],3,true);
         if(this.showSchoolPopup)
         {
            this.speechbubbleSchool = this.createStaticSpeechbubble(MSS_NPC_SCHOOL_X - 50,MSS_Y + 150,400,_loc11_,[],1,true);
            this.speechbubblemission = this.createStaticSpeechbubble(MSS_NPC_SCHOOL_X - 50,MSS_Y + 100,400,_loc7_,[],1,true);
            this.speechbubblelast = this.createStaticSpeechbubble(MSS_NPC_SCHOOL_X - 50,MSS_Y + 100,400,_loc8_,[],1,true);
         }
         else
         {
            this.speechbubblemission = this.createStaticSpeechbubble(MSS_NPC_END_X - 50,MSS_Y + 100,400,_loc7_,[]);
            this.speechbubblelast = this.createStaticSpeechbubble(MSS_NPC_END_X - 50,MSS_Y + 100,400,_loc8_,[]);
         }
         var _loc12_:Rectangle = new Rectangle(400,220,400,50);
         this.signuppresents.x = _loc12_.x + (_loc12_.width - this.signuppresents.width) / 2;
         this.signuppresents.y = _loc12_.y;
         this.dispatcher.dispatchEvent(new Event(EC_SPEECHBUBBLES_READY));
      }
      
      private function createPresentPlaceholder(param1:Number, param2:Number) : DisplayObject
      {
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.beginFill(16711680,0);
         _loc3_.graphics.drawRect(0,0,param1,param2);
         _loc3_.graphics.endFill();
         return _loc3_;
      }
      
      private function npcRideLoaded() : void
      {
         if(this.npc)
         {
            this.npc.visible = true;
         }
         this.npcRideTimer = new Timer(6000,1);
         this.npcRideTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.npcRideDone,false,0,true);
         this.npcRideTimer.start();
      }
      
      private function npcRideDone(param1:TimerEvent) : void
      {
         this.npcRideTimer.stop();
         this.npcRideTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.npcRideDone,false);
         this.animateFromRideToActions();
      }
      
      private function npcRide() : void
      {
         if(this.npcLoadedCorrectly)
         {
            this.npc.PlayAnimation("jetSet_2012_car_mirror",this.npcRideLoaded);
         }
         else
         {
            setTimeout(this.npcRideLoaded,1000);
         }
      }
      
      private function selfStart() : void
      {
         if(this.self)
         {
            this.self.PlayAnimation("walk");
         }
      }
      
      private function selfEnd() : void
      {
         if(this.self)
         {
            this.self.PlayAnimation("stand");
         }
      }
      
      private function npcTalk() : void
      {
         if(this.npc)
         {
            this.npc.PlayAnimation("talk");
         }
      }
      
      private function npcEnd() : void
      {
         if(this.npc)
         {
            this.npc.StopAnimation();
         }
      }
      
      private function npcPoint() : void
      {
         if(this.npc)
         {
            this.npc.PlayAnimation("point1");
         }
      }
      
      private function npcWave() : void
      {
         if(this.npc)
         {
            this.npc.PlayAnimation("Wave");
         }
      }
      
      private function selfHappy() : void
      {
         if(this.self)
         {
            this.self.PlayAnimation("realweatermill");
         }
      }
      
      private function crowdEnd() : void
      {
         this.flashsoundtimer.stop();
         this.flashsoundtimer.removeEventListener(TimerEvent.TIMER,this.nextFlash,false);
         SoundManager.Instance().stopSoundEffect(Sounds.CROWD);
         var _loc1_:int = 0;
         while(_loc1_ < FLASH_SOUNDS.length)
         {
            SoundManager.Instance().stopSoundEffect(FLASH_SOUNDS[_loc1_]);
            _loc1_++;
         }
      }
      
      private function carStart() : void
      {
         var driveaway:Function = null;
         var pullup:Function = null;
         driveaway = function():void
         {
            SoundManager.Instance().playSoundEffect(Sounds.CAR_DRIVEAWAY);
         };
         pullup = function():void
         {
            SoundManager.Instance().playSoundEffect(Sounds.CAR_PULLUP);
         };
         setTimeout(driveaway,4200);
         setTimeout(pullup,500);
      }
      
      private function nextFlash(param1:TimerEvent) : void
      {
         SoundManager.Instance().playSoundEffect(FLASH_SOUNDS[int(Math.random() * 10) % FLASH_SOUNDS.length],0);
      }
      
      private function startFlash() : void
      {
         this.flashsoundtimer = new Timer(1000);
         this.flashsoundtimer.addEventListener(TimerEvent.TIMER,this.nextFlash,false,0,true);
         this.flashsoundtimer.start();
      }
      
      private function startCrowd() : void
      {
         SoundManager.Instance().playSoundEffect(Sounds.CROWD,int.MAX_VALUE);
      }
      
      private function animatePrePresents() : void
      {
         this.npcEnd();
         this.selfHappy();
      }
      
      private function animateFromWalk() : void
      {
         this.selfEnd();
         this.npcRide();
         this.carStart();
      }
      
      private function animateFromStartToRide() : void
      {
         this.startFlash();
         this.startCrowd();
         this.animateToTimeline = new TimelineLite();
         this.animateToTimeline.append(TweenMax.to(this.backgroundParallax,PARALLAX_PANTIME,{"bezier":[{
            "x":this.backgroundParallax.x,
            "y":PARALLAX_OFFSET_END_Y
         },{
            "x":PARALLAX_OFFSET_END_X,
            "y":PARALLAX_OFFSET_END_Y
         }]}));
         if(this.selfLoadedCorrectly)
         {
            this.animateToTimeline.appendMultiple([TweenLite.to(this.self,3,{
               "x":MSS_SELF_INTERMEDIATE_X,
               "ease":Linear.easeNone,
               "onStart":this.selfStart
            })]);
         }
         this.animateToTimeline.append(TweenLite.to(this.backgroundParallax,3,{
            "x":0,
            "ease":Linear.easeNone,
            "onComplete":this.animateFromWalk
         }));
      }
      
      private function animateFromRideToActions() : void
      {
         this.npcTalk();
         if(this.npc)
         {
            this.npc.Talk(7500);
         }
         this.animateToTimeline = new TimelineLite();
         this.animateToTimeline.appendMultiple([TweenLite.to(this.speechbubblewelcome,SPEECHBUBBLE_FADEINTIME,{"autoAlpha":1}),TweenLite.to(this.speechbubblewelcome,SPEECHBUBBLE_FADEOUTTIME,{"autoAlpha":0})],0,TweenAlign.START,SPEECHBUBBLE_READTIME);
         this.animateToTimeline.appendMultiple([TweenLite.to(this.speechbubbletwo,SPEECHBUBBLE_FADEINTIME,{"autoAlpha":1}),TweenLite.to(this.speechbubbletwo,SPEECHBUBBLE_FADEOUTTIME,{"autoAlpha":0})],0,TweenAlign.START,SPEECHBUBBLE_READTIME);
         this.animateToTimeline.appendMultiple([TweenLite.to(this.speechbubblepresents,SPEECHBUBBLE_FADEINTIME,{"autoAlpha":1}),TweenLite.to(this.signuppresents,SPEECHBUBBLE_FADEINTIME,{
            "autoAlpha":1,
            "onComplete":this.animatePrePresents
         })]);
      }
      
      private function animateFromActions() : void
      {
         if(this.npc)
         {
            this.npc.Talk(4600);
         }
         this.animateFromTimeline = new TimelineLite();
         this.animateFromTimeline.append(TweenLite.to(this.speechbubbletomorrow,SPEECHBUBBLE_FADEINTIME,{"autoAlpha":1}));
         this.animateFromTimeline.appendMultiple([TweenLite.to(this.speechbubblepresents,0,{
            "delay":SPEECHBUBBLE_READTIME,
            "autoAlpha":0,
            "onStart":this.npcPoint
         }),TweenLite.to(this.speechbubbletomorrow,SPEECHBUBBLE_FADEOUTTIME,{
            "delay":SPEECHBUBBLE_READTIME,
            "autoAlpha":0,
            "onComplete":this.presentsComplete
         })]);
         RegisterNewUserComponent.sendAnalyticsEvent(AnalyticsConstants.CHARACTER_CREATION_STEP5);
      }
      
      private function animateLastPart() : void
      {
         this.skip.visible = false;
         if(this.showSchoolPopup)
         {
            this.npcEnd();
            if(this.npc)
            {
               this.npc.flipHorizontally();
            }
            this.schoolPopup = new SchoolAfterCreationPopup(this.onSchoolClose,this.onSchoolInitialized,this.onSchoolChosen);
            this.schoolPopup.x = 175;
            this.schoolPopup.y = 123;
            addChild(this.schoolPopup);
            if(this.npcLoadedCorrectly)
            {
               addChild(this.npc);
            }
            if(this.selfLoadedCorrectly)
            {
               addChild(this.self);
            }
            addChild(this.speechbubbleSchool);
            addChild(this.speechbubblelast);
            addChild(this.speechbubblemission);
         }
         else
         {
            this.onSchoolClose();
         }
      }
      
      private function onSchoolChosen() : void
      {
         if(this.self)
         {
            this.self.visible = false;
         }
         if(this.npc)
         {
            this.npc.visible = false;
         }
         this.speechbubbleSchool.visible = false;
      }
      
      private function onSchoolInitialized(param1:DisplayObject, param2:DisplayObject, param3:DisplayObject) : void
      {
         var _loc4_:Point = param3.parent.localToGlobal(new Point(param3.x,param3.y));
         _loc4_.x += 175;
         _loc4_.y += 103;
         this.speechbubbleSchool.x = this.speechbubblelast.x = this.speechbubblemission.x = _loc4_.x;
         this.speechbubbleSchool.y = this.speechbubblelast.y = this.speechbubblemission.y = _loc4_.y;
         param3.visible = false;
         var _loc5_:Point = param1.parent.localToGlobal(new Point(param1.x,param1.y));
         _loc5_.x += 175;
         _loc5_.y += 103;
         param1.visible = false;
         var _loc6_:Point = param2.parent.localToGlobal(new Point(param2.x,param2.y));
         _loc6_.x += 175;
         _loc6_.y += 103;
         param2.visible = false;
         this.animateFromTimeline = new TimelineLite();
         this.animateFromTimeline.appendMultiple([TweenLite.to(this.introNoHole,0.5,{"autoAlpha":0.6}),TweenLite.to(this.background,1,{
            "x":1240,
            "onComplete":this.crowdEnd
         })]);
         if(this.selfLoadedCorrectly)
         {
            this.animateFromTimeline.appendMultiple([TweenLite.to(this.self,2,{"bezier":[{"x":this.self.x},{"x":_loc5_.x}]}),TweenLite.to(this.self,2,{"bezier":[{"y":this.self.y},{"y":_loc5_.y}]})]);
         }
         if(this.npcLoadedCorrectly)
         {
            this.animateFromTimeline.appendMultiple([TweenLite.to(this.npc,2,{"x":_loc6_.x}),TweenLite.to(this.npc,2,{
               "y":_loc6_.y,
               "onComplete":this.selfEnd
            })]);
         }
         this.animateFromTimeline.append(TweenLite.to(this.speechbubbleSchool,SPEECHBUBBLE_FADEINTIME,{"autoAlpha":1}));
      }
      
      private function onSchoolClose() : void
      {
         if(this.showSchoolPopup)
         {
            if(this.self)
            {
               this.self.visible = true;
            }
            if(this.npc)
            {
               this.npc.visible = true;
            }
            removeChild(this.speechbubbleSchool);
            removeChild(this.schoolPopup);
            this.schoolPopup.destroy();
            this.npcTalk();
         }
         if(this.npc)
         {
            this.npc.Talk(4600);
         }
         this.animateFromTimeline = new TimelineLite({"onComplete":this.showAnchorGreeting});
         if(this.showSchoolPopup)
         {
            this.animateFromTimeline.appendMultiple([TweenLite.to(this.speechbubbleSchool,SPEECHBUBBLE_FADEINTIME,{"autoAlpha":0}),TweenLite.to(this.introNoHole,0.5,{"autoAlpha":0}),TweenLite.to(this.introHole,0.5,{"autoAlpha":0.6})]);
         }
         else
         {
            this.animateFromTimeline.appendMultiple([TweenLite.to(this.introHole,0.5,{"autoAlpha":0.6}),TweenLite.to(this.background,1,{
               "x":1240,
               "onComplete":this.crowdEnd
            })]);
         }
         this.animateFromTimeline.appendMultiple([TweenLite.to(this.speechbubblemission,SPEECHBUBBLE_FADEINTIME,{"autoAlpha":1}),TweenLite.to(this.speechbubblemission,SPEECHBUBBLE_FADEOUTTIME,{"autoAlpha":0})],0,TweenAlign.START,SPEECHBUBBLE_READTIME);
         this.animateFromTimeline.appendMultiple([TweenLite.to(this.speechbubblelast,SPEECHBUBBLE_FADEINTIME,{
            "autoAlpha":1,
            "onStart":this.npcWave
         }),TweenLite.to(this.speechbubblelast,SPEECHBUBBLE_FADEOUTTIME,{
            "autoAlpha":0,
            "onComplete":this.npcEnd
         })],0,TweenAlign.START,SPEECHBUBBLE_READTIME);
      }
      
      private function onAnchorEnd() : void
      {
         var onAnchorFriended:Function = null;
         onAnchorFriended = function():void
         {
            FriendshipServiceWeb.instance.approveDefaultAnchorFriendship(ActorSession.loggedInActor.ActorId,null);
            visible = false;
            TweenLite.to(introNoHole,0.3,{"autoAlpha":0});
            TweenLite.to(this,0.3,{
               "autoAlpha":0,
               "onStart":preremoveInitiate,
               "onComplete":animationsComplete
            });
         };
         removeChild(this.speechbubbleAnchor);
         this.npcEnd();
         this.animateFromTimeline = new TimelineLite();
         this.introNoHole.visible = true;
         if(this.selfLoadedCorrectly)
         {
            this.animateFromTimeline.appendMultiple([TweenLite.to(this.self,3,{"bezier":[{
               "x":MSS_SELF_END_X,
               "y":this.self.y
            },{
               "x":MSS_SELF_END_X,
               "y":MSS_SELF_END_Y
            }]})]);
         }
         if(this.npcLoadedCorrectly)
         {
            this.animateFromTimeline.append(TweenLite.to(this.npc,2,{
               "x":280,
               "y":595,
               "scaleX":0.23,
               "scaleY":0.23,
               "onComplete":this.showAnchorFriendshipPopup
            }));
         }
         else
         {
            setTimeout(this.showAnchorFriendshipPopup,5000);
         }
         if(this.selfLoadedCorrectly)
         {
            this.animateFromTimeline.appendMultiple([TweenLite.to(this.self,2,{"bezier":[{
               "x":MSS_SELF_END_X,
               "y":this.self.y
            },{
               "x":MSS_SELF_END_X,
               "y":MSS_SELF_END_Y
            }]})]);
         }
         this.animateFromTimeline.appendMultiple([TweenLite.to(this.introHole,1.5,{"autoAlpha":0}),TweenLite.to(this.introNoHole,1.5,{"alpha":0.6})]);
         AnchorActivityManager.tellMeWhenAnchorAdded(onAnchorFriended,ActorSession.loggedInActor.ActorId);
      }
      
      private function showAnchorGreeting() : void
      {
         addChild(this.speechbubbleAnchor);
         this.npcTalk();
         if(this.npc)
         {
            this.npc.Talk(2300);
         }
         this.speechbubbleAnchor.visible = true;
         TweenLite.to(this.speechbubbleAnchor,SPEECHBUBBLE_FADEINTIME,{"alpha":1});
         setTimeout(this.onAnchorEnd,5000);
      }
      
      private function showAnchorFriendshipPopup() : void
      {
         AnchorActivityManager.friendRequestAnchor(ActorSession.loggedInActor.isFemale);
         Main.Instance.mainCanvas.applicationViewStack.mainView.friendActivityListComponent.visible = true;
         if(this.npc)
         {
            this.npc.visible = false;
         }
      }
      
      private function preremoveInitiate() : void
      {
         this.preremoved();
      }
      
      private function presentsComplete() : void
      {
         removeChild(this.signuppresents);
         this.signuppresents.destroy();
         this.animateLastPart();
      }
      
      private function animationsComplete() : void
      {
         this.preremoved();
         this.removed();
      }
      
      public function destroy() : void
      {
         this.animationsComplete();
         this.disposeeventlisteners(this);
         if(this.self)
         {
            this.self.destroy();
         }
         if(this.npc)
         {
            this.npc.destroy();
         }
         this.signuppresents.destroy();
         this.chainnull(this);
         this.nullprivate(this);
      }
      
      private function disposeeventlisteners(param1:Introduction) : void
      {
         if(param1.skiphandler != null)
         {
            param1.skiphandler.setButtonizedEnabled(false);
         }
      }
      
      private function nullprivate(param1:Introduction) : void
      {
         param1.animateFromTimeline = null;
         param1.animateToTimeline = null;
         param1.background = null;
         param1.backgroundParallax = null;
         param1.backgroundParallaxInstanceMultipliers = null;
         param1.preremoved = null;
         param1.removed = null;
         param1.dispatcher = null;
         param1.dispatcherPresentSpeechbubble = null;
         param1.eventcontroller = null;
         param1.eventcontrollerPresentSpeechbubble = null;
         param1.npc = null;
         param1.npcActorIds = null;
         param1.self = null;
         param1.skip = null;
         param1.speechbubblemission = null;
         param1.speechbubbletwo = null;
         param1.speechbubblepresents = null;
         param1.speechbubblewelcome = null;
         param1.speechbubbletomorrow = null;
         param1.speechbubblelast = null;
         param1.SpeechbubbleStaticType = null;
         param1.SpeechbubbleCenteredStaticType = null;
         param1.starting = null;
         param1.signuppresents = null;
      }
      
      private function chainnull(param1:Object) : void
      {
         var variables:XMLList;
         var j:int = 0;
         var i:int = 0;
         var object:Object = param1;
         var description:XML = describeType(object);
         var accessors:XMLList = description.accessor;
         while(j < accessors.length())
         {
            if(accessors[j].@access != "readonly")
            {
               try
               {
                  object[accessors[j].@name] = null;
               }
               catch(e:Error)
               {
               }
            }
            j++;
         }
         variables = description.variable;
         while(i < variables.length())
         {
            try
            {
               object[variables[i].@name] = null;
            }
            catch(ve:Error)
            {
            }
            i++;
         }
      }
      
      private function createStaticSpeechbubble(param1:Number, param2:Number, param3:Number, param4:String, param5:Array, param6:int = 1, param7:Boolean = false) : DisplayObject
      {
         var tformat:TextFormat;
         var ITEM_SPACING:Number;
         var sum:Number;
         var i:int;
         var background:DisplayObject = null;
         var textfield:TextField = null;
         var renderFixCounter:int = 0;
         var renderFixMaxCounter:int = 0;
         var onTextFieldRender:Function = null;
         var visuals:Sprite = null;
         var dop:DisplayObject = null;
         var x:Number = param1;
         var y:Number = param2;
         var width:Number = param3;
         var text:String = param4;
         var displayobjects:Array = param5;
         var minimumNumberOfLines:int = param6;
         var useCenteredSpeechbubble:Boolean = param7;
         onTextFieldRender = function(param1:Event):void
         {
            if(renderFixCounter < renderFixMaxCounter)
            {
               ++renderFixCounter;
               return;
            }
            textfield.removeEventListener(Event.ENTER_FRAME,onTextFieldRender);
            var _loc2_:int = int(textfield.numLines);
            while(_loc2_ < minimumNumberOfLines)
            {
               textfield.appendText("\n ");
               _loc2_++;
            }
            var _loc3_:Number = 15;
            var _loc4_:Number = 10;
            textfield.x = _loc3_;
            textfield.y = _loc3_;
            visuals.x = (_loc3_ * 2 + textfield.width - visuals.width) / 2;
            visuals.y = _loc4_ + _loc3_ + textfield.textHeight;
            background.width = width + _loc3_ * 2;
            background.height = textfield.textHeight + visuals.height + _loc3_ * 2 + _loc4_ + 40;
         };
         var bubble:Sprite = new Sprite();
         bubble.visible = false;
         bubble.alpha = 0;
         if(useCenteredSpeechbubble)
         {
            background = new this.SpeechbubbleCenteredStaticType();
         }
         else
         {
            background = new this.SpeechbubbleStaticType();
         }
         textfield = new TextField();
         tformat = textfield.defaultTextFormat;
         tformat.color = 3421236;
         tformat.font = "Arezzo-Rounded";
         tformat.size = 32;
         tformat.align = TextAlign.CENTER;
         textfield.defaultTextFormat = tformat;
         FontManager.remapFonts(textfield);
         textfield.selectable = false;
         textfield.autoSize = TextFieldAutoSize.LEFT;
         textfield.width = width;
         textfield.multiline = true;
         textfield.wordWrap = true;
         textfield.text = text;
         textfield.addEventListener(Event.ENTER_FRAME,onTextFieldRender);
         renderFixCounter = 0;
         renderFixMaxCounter = 5;
         visuals = new Sprite();
         ITEM_SPACING = 5;
         sum = 0;
         i = 0;
         while(i < displayobjects.length)
         {
            dop = displayobjects[i] as DisplayObject;
            dop.x = sum;
            sum += dop.width + ITEM_SPACING;
            visuals.addChild(dop);
            i++;
         }
         bubble.addChild(background);
         bubble.addChild(textfield);
         bubble.addChild(visuals);
         bubble.x = x - bubble.width;
         bubble.y = y - bubble.height;
         return bubble;
      }
      
      private function createIntroHoles(param1:Boolean) : Sprite
      {
         var _loc2_:Sprite = new Sprite();
         var _loc3_:Sprite = new Sprite();
         _loc3_ = new this.ArrowType();
         _loc3_.x = ACTIVITY_HOLE_X + 15;
         _loc3_.y = ACTIVITY_HOLE_Y + 15;
         _loc2_.graphics.beginFill(0);
         _loc2_.graphics.drawRect(0,0,stage.fullScreenWidth,stage.fullScreenHeight);
         if(param1)
         {
            _loc2_.graphics.drawCircle(ACTIVITY_HOLE_X,ACTIVITY_HOLE_Y,ACTIVITY_HOLE_DIMENSION);
         }
         _loc2_.graphics.endFill();
         if(param1)
         {
            _loc2_.addChild(_loc3_);
         }
         _loc2_.alpha = 0;
         return _loc2_;
      }
   }
}

