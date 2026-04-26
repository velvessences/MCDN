package com.moviestarplanet.moviestudio
{
   import com.boostworthy.animation.easing.Transitions;
   import com.boostworthy.animation.management.AnimationManager;
   import com.boostworthy.animation.rendering.RenderMethod;
   import com.moviestarplanet.Components.BackgroundSelector;
   import com.moviestarplanet.Components.Buttons.EditButton;
   import com.moviestarplanet.Components.Buttons.ReportButton;
   import com.moviestarplanet.Components.Buttons.SaveButton;
   import com.moviestarplanet.Components.Buttons.SendMailButton;
   import com.moviestarplanet.Components.Buttons.ShareWithButton;
   import com.moviestarplanet.Components.CallOut;
   import com.moviestarplanet.Components.CloseButton;
   import com.moviestarplanet.Components.Friends.FriendshipManager;
   import com.moviestarplanet.Components.MSP_ClickImage;
   import com.moviestarplanet.Components.MSP_ItemContainer;
   import com.moviestarplanet.Components.Movie.SendMovieAsMailPopup;
   import com.moviestarplanet.Components.MusicSelector;
   import com.moviestarplanet.Components.PopUpCanvas;
   import com.moviestarplanet.Components.Slider;
   import com.moviestarplanet.Components.TitleBar;
   import com.moviestarplanet.Components.ViewComponent.ViewComponentCanvas;
   import com.moviestarplanet.Components.callout.CalloutBubbleTypes;
   import com.moviestarplanet.Components.pushcontent.frienddisplayer.FriendDisplayer;
   import com.moviestarplanet.Events.BooleanEvent;
   import com.moviestarplanet.Forms.EnterMovieName;
   import com.moviestarplanet.Forms.FriendListPopup;
   import com.moviestarplanet.Forms.MovieNotifier;
   import com.moviestarplanet.Forms.MovieStatuses;
   import com.moviestarplanet.Forms.RateMovieComponent;
   import com.moviestarplanet.Forms.SceneListCanvas;
   import com.moviestarplanet.Forms.movie.BonsterClickItemMovieWrapper;
   import com.moviestarplanet.Forms.movie.BonsterItemMovieWrapper;
   import com.moviestarplanet.Forms.movie.IFlippable;
   import com.moviestarplanet.Forms.movie.IMovieAddable;
   import com.moviestarplanet.Forms.movie.IScaleable;
   import com.moviestarplanet.activities.OldActivityCreator;
   import com.moviestarplanet.alert.DebugAlert;
   import com.moviestarplanet.anchorCharacters.AnchorCharacters;
   import com.moviestarplanet.award.visualization.AwardVisualizationController;
   import com.moviestarplanet.award.visualization.AwardVisualizationType;
   import com.moviestarplanet.bonster.BonsterClickItem;
   import com.moviestarplanet.bonster.BonsterTemplateCache;
   import com.moviestarplanet.bonster.service.BonsterAMFService;
   import com.moviestarplanet.bonster.service.IBonsterService;
   import com.moviestarplanet.bonster.valueobjects.ActorBonsterRelItem;
   import com.moviestarplanet.bonster.valueobjects.BonsterTemplateObject;
   import com.moviestarplanet.chatCommunicator.chatHelpers.configuration.InputLocations;
   import com.moviestarplanet.clickitems.ClickItem;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.contentservices.lasteditservice.LastEditManager;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.flash.components.popups.viponly.VIPOnlyPopUp;
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.logging.services.loggingservice.LoggingAmfService;
   import com.moviestarplanet.managers.SoundManager;
   import com.moviestarplanet.mangroveanalytics.MangroveAnalytics;
   import com.moviestarplanet.mangroveanalytics.constants.EntityActionEventConst;
   import com.moviestarplanet.media.valueobjects.Background;
   import com.moviestarplanet.media.valueobjects.Music;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.model.IActorModel;
   import com.moviestarplanet.model.notification.NotificationType;
   import com.moviestarplanet.movie.MovieUtil;
   import com.moviestarplanet.movie.service.IMovieService;
   import com.moviestarplanet.movie.service.MovieAMFService;
   import com.moviestarplanet.movie.valueobjects.KeyFrameActor;
   import com.moviestarplanet.movie.valueobjects.KeyFrameProp;
   import com.moviestarplanet.movie.valueobjects.Movie;
   import com.moviestarplanet.movie.valueobjects.MovieActorRel;
   import com.moviestarplanet.movie.valueobjects.Prop;
   import com.moviestarplanet.movie.valueobjects.Scene;
   import com.moviestarplanet.movies.Module.MovieModuleManager;
   import com.moviestarplanet.movies.Module.controller.HackActorSkinCommand;
   import com.moviestarplanet.movies.MovieStudioController;
   import com.moviestarplanet.moviestar.MovieStar;
   import com.moviestarplanet.moviestar.service.MovieStarService;
   import com.moviestarplanet.moviestar.utils.ActorCache;
   import com.moviestarplanet.moviestar.valueObjects.Actor;
   import com.moviestarplanet.moviestar.valueObjects.ActorClothesRel;
   import com.moviestarplanet.moviestar.valueObjects.Cloth;
   import com.moviestarplanet.msg.MSP_Event;
   import com.moviestarplanet.msg.events.QuestEvent;
   import com.moviestarplanet.pet.service.IPetService;
   import com.moviestarplanet.pet.valueobjects.ActorClickItemRel;
   import com.moviestarplanet.popup.OldPopupHandler;
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import com.moviestarplanet.userbehavior.UserBehaviorResult;
   import com.moviestarplanet.userbehavior.utils.chatfilter.userbehaviorcontrol.UserBehaviorControl;
   import com.moviestarplanet.utils.DateUtils;
   import com.moviestarplanet.utils.EntityTypeType;
   import com.moviestarplanet.utils.FriendItem;
   import com.moviestarplanet.utils.ItemHelpers;
   import com.moviestarplanet.utils.MSP_SWFLoader;
   import com.moviestarplanet.utils.MovieStudioFriendItem;
   import com.moviestarplanet.utils.MyRoomItem;
   import com.moviestarplanet.utils.PropSorter;
   import com.moviestarplanet.utils.ReportUtils;
   import com.moviestarplanet.utils.SnapshotUtils;
   import com.moviestarplanet.utils.StringUtilities;
   import com.moviestarplanet.utils.displayobject.FlattenUtilities;
   import com.moviestarplanet.utils.loader.ContentUrl;
   import com.moviestarplanet.utils.loader.FlippableLoader;
   import com.moviestarplanet.utils.loader.MSP_LoaderManager;
   import com.moviestarplanet.utils.loader.RawUrl;
   import com.moviestarplanet.utils.tooltips.MSP_ToolTipManager;
   import com.moviestarplanet.utils.translation.LocaleHelper;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.window.loading.LoadingProgressBarAS;
   import com.moviestarplanet.window.stack.WindowStack;
   import com.moviestarplanet.window.utils.PopupUtils;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   import com.moviestarplanet.windowpopup.popup.PromptEvent;
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import mx.binding.*;
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.TabNavigator;
   import mx.containers.Tile;
   import mx.controls.Alert;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.TextInput;
   import mx.core.Container;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Fade;
   import mx.effects.Glow;
   import mx.effects.Sequence;
   import mx.events.EffectEvent;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.SliderEvent;
   import mx.graphics.ImageSnapshot;
   import mx.graphics.codec.JPEGEncoder;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class MovieStudio extends ViewComponentCanvas implements IBindingClient
   {
      
      public static var meItem:MovieStudioFriendItem;
      
      public static var extraItems:Array;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      public static const PLAYENABLE_CHANGED:String = "com.moviestarplanet.Forms.MovieStudio.PLAYENABLE_CHANGED";
      
      public static const SCENE_ADDED:String = "com.moviestarplanet.Forms.MovieStudio.SCENE_ADDED";
      
      public static const SCENE_CHANGED:String = "com.moviestarplanet.Forms.MovieStudio.SCENE_CHANGED";
      
      public static const MovieStudioEditModeActiveChanged:String = "MovieStudioEditModeActiveChanged";
      
      public static const MovieStudioReset:String = "MovieStudioReset";
      
      public static const secsPrFrame:Number = 2;
      
      public static const E_ITEMMOVED:String = "E_ITEMMOVED";
      
      public static const AUTOSAVE_NAME:String = "Autosaved";
      
      public var _MovieStudio_Canvas11:Canvas;
      
      public var _MovieStudio_Label5:Label;
      
      public var _MovieStudio_LoadingProgressBarAS2:LoadingProgressBarAS;
      
      public var _MovieStudio_TitleBar1:TitleBar;
      
      public var _MovieStudio_TitleBar2:TitleBar;
      
      public var _MovieStudio_TitleBar3:TitleBar;
      
      private var _133774467addSceneButton:Button;
      
      private var _1233296422backgroundCanvas:BackgroundSelector;
      
      private var _1367706280canvas:Canvas;
      
      private var _968087718canvasBackground:Canvas;
      
      private var _1241021830canvasSpeechBubble:Canvas;
      
      private var _951543133control:Canvas;
      
      private var _757271524controlCanvasBelow:Canvas;
      
      private var _804135654editActorsButton:MSP_ClickImage;
      
      private var _52122582editBackgroundButton:MSP_ClickImage;
      
      private var _1454002652editButton:EditButton;
      
      private var _1892417203editMusicButton:MSP_ClickImage;
      
      private var _1166014552editPropsButton:MSP_ClickImage;
      
      private var _797845155editScenesButton:MSP_ClickImage;
      
      private var _1602095055editView:Canvas;
      
      private var _1607668233endFade:Fade;
      
      private var _863783179endOverlay:Canvas;
      
      private var _335348240exitButton:CloseButton;
      
      private var _765381553extrasTile:Tile;
      
      private var _1091436750fadeOut:Fade;
      
      private var _1824548685friendsCanvas:Canvas;
      
      private var _3175821glow:Sequence;
      
      private var _735423955helpButton:MSP_ClickImage;
      
      private var _167065204labelActorName:Label;
      
      private var _1473639298labelFrameNumber:Label;
      
      private var _648431943labelMovieName:Label;
      
      private var _1965190251loadMovieName:LoadingProgressBarAS;
      
      private var _1845661867loadView:Canvas;
      
      private var _1852515056meCanvas:Canvas;
      
      private var _578887433movieActorForm:MovieActorForm;
      
      private var _478995897movieActorListForm:Canvas;
      
      private var _1183189358movieContentView:Canvas;
      
      private var _1187386843movieName:Label;
      
      private var _907225898moviebarLoader:MSP_SWFLoader;
      
      private var _770858973musicCanvas:MusicSelector;
      
      private var _3443508play:MSP_ClickImage;
      
      private var _465676568propsCanvas:PopUpCanvas;
      
      private var _117682566reportButton:ReportButton;
      
      private var _584254223saveButton:SaveButton;
      
      private var _2072548926saveView:Canvas;
      
      private var _1455583647scenesCanvas:PopUpCanvas;
      
      private var _1813479704secondCounter:Label;
      
      private var _331781489sendMailButton:SendMailButton;
      
      private var _2038122281shareWithButton:ShareWithButton;
      
      private var _899647263slider:Slider;
      
      private var _1884363014stopBtn:MSP_ClickImage;
      
      private var _821223289stuffViewItems:MSP_ItemContainer;
      
      private var _1771368233textNbrFrames:TextInput;
      
      private var _595150635topControls:HBox;
      
      private var _975191204vboxScenes:HBox;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      [Inject]
      public var bonsterService:IBonsterService;
      
      [Inject]
      public var petService:IPetService;
      
      [Inject]
      public var actorModel:IActorModel;
      
      public var showMovieFromUrl:Boolean;
      
      private const DEFAULT_NUMBER_OF_KEYS:Number = 5;
      
      public var movieDetails:MovieDetails;
      
      private var selectedScene:Number;
      
      private var selectedKey:Number = 0;
      
      private var backgroundSound:Sound;
      
      public var actorFigures:Array;
      
      public var speechBubbles:Array;
      
      private var sortOrder:Array;
      
      private var m_objAnimationManager:AnimationManager;
      
      protected var minuteTimer:Timer;
      
      private var autoSaveTimer:Timer;
      
      public var movie:Movie;
      
      public var scene:Scene;
      
      private var movingActor:Boolean = false;
      
      private var needsToStopWalking:Boolean = false;
      
      private var _inPlayMode:Boolean = false;
      
      private var animationCanvas:Canvas;
      
      private var loadingActors:Boolean = false;
      
      private var numberOfActorFiguresToUpdate:Number = 0;
      
      private var currentCallOut:CallOut = null;
      
      private var _exitCallBackFunction:Function;
      
      private var mDelayedValue:int;
      
      private var lastEditedKeyFrame:int = 0;
      
      private var items:Array;
      
      private var highlightGlow:GlowFilter;
      
      private var currentProp:Prop;
      
      private var dragItem:UIComponent;
      
      private var lastDragX:Number;
      
      private var lastDragY:Number;
      
      private var _movieChanged:Boolean;
      
      private var confirmedDelete:Boolean = false;
      
      protected var isPlaying:Boolean = false;
      
      private var onlyPlaySelectedScene:Boolean = false;
      
      private var sound:Sound;
      
      private var channel:SoundChannel;
      
      private var paused:Boolean = false;
      
      private var sceneShiftTimer:Timer;
      
      private var frame:Number;
      
      private var lastFrameToPlay:Number;
      
      private var serverDone:Boolean = true;
      
      private var movieAlreadyRatedByActor:Boolean = true;
      
      private var friendDisplayer:FriendDisplayer;
      
      private var numberOfClothesNotSavedYet:Number;
      
      private var movieSnapshot_big:ByteArray;
      
      private var movieSnapshot_small:ByteArray;
      
      private var sceneKeyFrameOffset:int = 0;
      
      public var textDisplayedFromPreviousKeyFrame:Array;
      
      protected var currentMovieStar:MovieStar;
      
      protected var openMovieActorForm:Boolean = true;
      
      private var oldX:Number;
      
      private var oldY:Number;
      
      private var soundPlaying:String = "";
      
      private var instructorId:Number;
      
      private var speechActorId:Number;
      
      private var sceneNumberSpeech:Number = -1;
      
      private var topControlButtonsAdded:Boolean = false;
      
      private const MAX_ACTORS_IN_MOVIE:int = 6;
      
      private const MAX_ACTORS_IN_MOVIE_VIP:int = 8;
      
      private var loadActorPerScene:Boolean = true;
      
      private var movieTotalKeyFrameCount:int = 0;
      
      private var backgroundSwfExisting:DisplayObject;
      
      private var backgroundSwf:MSP_SWFLoader;
      
      private const HORIZON_Y_COORD:Number = 280;
      
      public var reloadMovieToGetNewStats:Boolean = false;
      
      private var _friendListPopup:FriendListPopup;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function MovieStudio()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":ViewComponentCanvas,
            "events":{
               "creationComplete":"___MovieStudio_ViewComponentCanvas1_creationComplete",
               "preinitialize":"___MovieStudio_ViewComponentCanvas1_preinitialize"
            },
            "stylesFactory":function():void
            {
               this.backgroundAlpha = 1;
               this.backgroundColor = 0;
               this.borderStyle = "solid";
               this.borderThickness = 0;
               this.cornerRadius = 6;
            },
            "propertiesFactory":function():Object
            {
               return {
                  "width":980,
                  "height":500,
                  "creationPolicy":"all",
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"editView",
                     "stylesFactory":function():void
                     {
                        this.backgroundAlpha = 0;
                        this.backgroundColor = 0;
                        this.borderStyle = "solid";
                        this.borderThickness = 0;
                        this.cornerRadius = 10;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":980,
                           "height":500,
                           "label":"View 2",
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"movieContentView",
                              "propertiesFactory":function():Object
                              {
                                 return {"childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"canvasBackground",
                                    "stylesFactory":function():void
                                    {
                                       this.backgroundAlpha = 0;
                                       this.backgroundColor = 16116458;
                                       this.backgroundSize = "100%";
                                       this.borderStyle = "solid";
                                       this.borderThickness = 0;
                                       this.cornerRadius = 10;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "x":10,
                                          "y":10,
                                          "width":960,
                                          "height":480,
                                          "maxWidth":730,
                                          "maxHeight":400,
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"canvas",
                                    "events":{
                                       "mouseDown":"__canvas_mouseDown",
                                       "mouseMove":"__canvas_mouseMove",
                                       "mouseUp":"__canvas_mouseUp"
                                    },
                                    "stylesFactory":function():void
                                    {
                                       this.backgroundAlpha = 0;
                                       this.backgroundColor = 16116458;
                                       this.backgroundSize = "100%";
                                       this.borderStyle = "solid";
                                       this.borderThickness = 0;
                                       this.cornerRadius = 10;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "x":10,
                                          "y":10,
                                          "width":960,
                                          "height":480,
                                          "maxWidth":730,
                                          "maxHeight":400,
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"canvasSpeechBubble",
                                    "stylesFactory":function():void
                                    {
                                       this.backgroundAlpha = 0;
                                       this.backgroundSize = "100%";
                                       this.borderStyle = "solid";
                                       this.borderThickness = 0;
                                       this.cornerRadius = 10;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "x":0,
                                          "y":0,
                                          "width":980,
                                          "height":500,
                                          "maxWidth":730,
                                          "maxHeight":400,
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"topControls",
                                    "stylesFactory":function():void
                                    {
                                       this.backgroundAlpha = 1;
                                       this.backgroundColor = 0;
                                       this.borderStyle = "solid";
                                       this.borderThickness = 0;
                                       this.cornerRadius = 8;
                                       this.horizontalGap = 10;
                                       this.paddingBottom = 5;
                                       this.paddingLeft = 10;
                                       this.paddingRight = 8;
                                       this.paddingTop = 8;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "right":0,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":MSP_ClickImage,
                                             "id":"helpButton",
                                             "events":{"click":"__helpButton_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {"visible":false};
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":SaveButton,
                                             "id":"saveButton",
                                             "events":{"click":"__saveButton_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {"enabled":true};
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":EditButton,
                                             "id":"editButton",
                                             "events":{"click":"__editButton_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "visible":false,
                                                   "width":18,
                                                   "height":18,
                                                   "includeInLayout":false
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":ReportButton,
                                             "id":"reportButton",
                                             "events":{"click":"__reportButton_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "visible":false,
                                                   "width":18,
                                                   "height":18,
                                                   "includeInLayout":false
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":SendMailButton,
                                             "id":"sendMailButton",
                                             "events":{"click":"__sendMailButton_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "visible":false,
                                                   "includeInLayout":false,
                                                   "scaleX":0.55,
                                                   "scaleY":0.55
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":ShareWithButton,
                                             "id":"shareWithButton",
                                             "events":{"click":"__shareWithButton_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "visible":false,
                                                   "includeInLayout":false
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":CloseButton,
                                             "id":"exitButton",
                                             "events":{"click":"__exitButton_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "width":18,
                                                   "height":18
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 })]};
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"controlCanvasBelow",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":10,
                                    "y":440,
                                    "width":960,
                                    "height":53,
                                    "horizontalScrollPolicy":"off",
                                    "verticalScrollPolicy":"off",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":MSP_SWFLoader,
                                       "id":"moviebarLoader",
                                       "events":{"creationComplete":"__moviebarLoader_creationComplete"}
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"play",
                                       "events":{"click":"__play_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":10,
                                             "y":20,
                                             "enabled":true
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"stopBtn",
                                       "events":{"click":"__stopBtn_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":37,
                                             "y":20,
                                             "enabled":true
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Slider,
                                       "id":"slider",
                                       "events":{
                                          "change":"__slider_change",
                                          "frameAdded":"__slider_frameAdded"
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":56,
                                             "y":15
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"editActorsButton",
                                       "events":{"click":"__editActorsButton_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":500,
                                             "y":18
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"editPropsButton",
                                       "events":{"click":"__editPropsButton_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":562,
                                             "y":18
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"editScenesButton",
                                       "events":{"click":"__editScenesButton_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":624,
                                             "y":18
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"editBackgroundButton",
                                       "events":{"click":"__editBackgroundButton_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":686,
                                             "y":18
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"editMusicButton",
                                       "events":{"click":"__editMusicButton_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":748,
                                             "y":18
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"secondCounter",
                                       "stylesFactory":function():void
                                       {
                                          this.color = 16711679;
                                          this.fontSize = 18;
                                          this.fontWeight = "normal";
                                          this.textAlign = "left";
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "visible":false,
                                             "x":69,
                                             "y":21,
                                             "width":121,
                                             "text":"10:00 / 10:00"
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"movieName",
                                       "stylesFactory":function():void
                                       {
                                          this.color = 16711679;
                                          this.fontSize = 18;
                                          this.fontWeight = "bold";
                                          this.textAlign = "left";
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "visible":false,
                                             "x":198,
                                             "y":21,
                                             "width":313,
                                             "text":"My Movie Name"
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":TextInput,
                              "id":"textNbrFrames",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":721,
                                    "y":386,
                                    "width":31,
                                    "text":"20"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"control",
                              "stylesFactory":function():void
                              {
                                 this.borderStyle = "solid";
                                 this.borderThickness = 0;
                                 this.cornerRadius = 10;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":true,
                                    "y":36,
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "horizontalScrollPolicy":"off",
                                    "verticalScrollPolicy":"off",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":MovieActorForm,
                                       "id":"movieActorForm",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "visible":true,
                                             "horizontalScrollPolicy":"off",
                                             "verticalScrollPolicy":"off"
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"labelFrameNumber",
                                       "stylesFactory":function():void
                                       {
                                          this.color = 16711679;
                                          this.fontSize = 20;
                                          this.textAlign = "center";
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "visible":false,
                                             "x":906,
                                             "y":180,
                                             "width":58,
                                             "mouseChildren":false,
                                             "mouseEnabled":false,
                                             "text":"1/10"
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"movieActorListForm",
                              "stylesFactory":function():void
                              {
                                 this.backgroundAlpha = 0.92;
                                 this.backgroundColor = 0;
                                 this.borderStyle = "solid";
                                 this.borderThickness = 0;
                                 this.cornerRadius = 10;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":515,
                                    "y":95,
                                    "width":455,
                                    "height":356,
                                    "horizontalScrollPolicy":"off",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":TitleBar,
                                       "id":"_MovieStudio_TitleBar1",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "left":0,
                                             "right":0,
                                             "top":0
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":CloseButton,
                                       "events":{"click":"___MovieStudio_CloseButton2_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "right":5,
                                             "top":5,
                                             "width":20,
                                             "height":20
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"meCanvas",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":5,
                                             "y":74,
                                             "width":100,
                                             "height":132,
                                             "label":"Me"
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":TabNavigator,
                                       "stylesFactory":function():void
                                       {
                                          this.backgroundAlpha = 0;
                                          this.borderStyle = "none";
                                          this.color = 65793;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":110,
                                             "y":35,
                                             "width":331,
                                             "height":311,
                                             "creationPolicy":"all",
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "id":"friendsCanvas",
                                                "stylesFactory":function():void
                                                {
                                                   this.color = 16776958;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "percentHeight":100,
                                                      "clipContent":false,
                                                      "horizontalScrollPolicy":"off",
                                                      "verticalScrollPolicy":"off"
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Canvas,
                                                "id":"_MovieStudio_Canvas11",
                                                "stylesFactory":function():void
                                                {
                                                   this.color = 16776958;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "percentHeight":100,
                                                      "horizontalScrollPolicy":"off",
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":Tile,
                                                         "id":"extrasTile",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "percentHeight":100,
                                                               "horizontalScrollPolicy":"off"
                                                            };
                                                         }
                                                      })]
                                                   };
                                                }
                                             })]
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":PopUpCanvas,
                              "id":"scenesCanvas",
                              "stylesFactory":function():void
                              {
                                 this.backgroundAlpha = 0.9;
                                 this.backgroundColor = 0;
                                 this.borderColor = 16448765;
                                 this.borderStyle = "solid";
                                 this.borderThickness = 0;
                                 this.cornerRadius = 10;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":515,
                                    "y":95,
                                    "width":455,
                                    "height":356,
                                    "horizontalScrollPolicy":"off",
                                    "verticalScrollPolicy":"off",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":TitleBar,
                                       "id":"_MovieStudio_TitleBar2",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "left":0,
                                             "right":0,
                                             "top":0
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":CloseButton,
                                       "events":{"click":"___MovieStudio_CloseButton3_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "right":5,
                                             "top":5,
                                             "width":20,
                                             "height":20
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":HBox,
                                       "id":"vboxScenes",
                                       "stylesFactory":function():void
                                       {
                                          this.backgroundAlpha = 1;
                                          this.cornerRadius = 10;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":10,
                                             "y":76,
                                             "width":435,
                                             "height":268,
                                             "verticalScrollPolicy":"off"
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"addSceneButton",
                                       "events":{"click":"__addSceneButton_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":355,
                                             "y":41
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":PopUpCanvas,
                              "id":"propsCanvas",
                              "stylesFactory":function():void
                              {
                                 this.backgroundAlpha = 0.9;
                                 this.backgroundColor = 0;
                                 this.borderColor = 16448765;
                                 this.borderStyle = "solid";
                                 this.borderThickness = 0;
                                 this.cornerRadius = 10;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":515,
                                    "y":95,
                                    "width":455,
                                    "height":356,
                                    "horizontalScrollPolicy":"off",
                                    "verticalScrollPolicy":"off",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":TitleBar,
                                       "id":"_MovieStudio_TitleBar3",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "left":0,
                                             "right":0,
                                             "top":0
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":CloseButton,
                                       "events":{"click":"___MovieStudio_CloseButton4_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "right":5,
                                             "top":5,
                                             "width":20,
                                             "height":20
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ItemContainer,
                                       "id":"stuffViewItems",
                                       "stylesFactory":function():void
                                       {
                                          this.backgroundAlpha = 0.8;
                                          this.backgroundColor = 0;
                                          this.borderStyle = "solid";
                                          this.borderThickness = 0;
                                          this.cornerRadius = 10;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "visible":true,
                                             "x":18,
                                             "y":49,
                                             "width":419,
                                             "height":292,
                                             "HorizontalGap":10,
                                             "PageSize":15,
                                             "VerticalGap":5
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":BackgroundSelector,
                              "id":"backgroundCanvas",
                              "events":{
                                 "CANCEL":"__backgroundCanvas_CANCEL",
                                 "OK":"__backgroundCanvas_OK"
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":700,
                                    "y":170
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":MusicSelector,
                              "id":"musicCanvas",
                              "events":{"OK":"__musicCanvas_OK"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":750,
                                    "y":170
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"loadView",
                              "stylesFactory":function():void
                              {
                                 this.backgroundAlpha = 1;
                                 this.backgroundColor = 0;
                                 this.borderStyle = "solid";
                                 this.borderThickness = 0;
                                 this.cornerRadius = 10;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "percentWidth":100,
                                    "height":500,
                                    "label":"Main",
                                    "horizontalScrollPolicy":"off",
                                    "verticalScrollPolicy":"off",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":LoadingProgressBarAS,
                                       "id":"loadMovieName",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":700,
                                             "y":260,
                                             "width":299.5,
                                             "height":23,
                                             "fontSize":14
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"labelMovieName",
                                       "stylesFactory":function():void
                                       {
                                          this.color = 16645886;
                                          this.fontSize = 30;
                                          this.fontWeight = "bold";
                                          this.textAlign = "left";
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":286,
                                             "y":298,
                                             "width":684
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"_MovieStudio_Label5",
                                       "stylesFactory":function():void
                                       {
                                          this.color = 16711422;
                                          this.fontSize = 20;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":286,
                                             "y":238
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"labelActorName",
                                       "stylesFactory":function():void
                                       {
                                          this.color = 16777215;
                                          this.fontSize = 24;
                                          this.fontWeight = "bold";
                                          this.textAlign = "left";
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":286,
                                             "y":195,
                                             "width":684
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"endOverlay",
                              "stylesFactory":function():void
                              {
                                 this.backgroundAlpha = 0.7;
                                 this.backgroundColor = 0;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "horizontalScrollPolicy":"off",
                                    "verticalScrollPolicy":"off"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"saveView",
                              "stylesFactory":function():void
                              {
                                 this.backgroundAlpha = 0;
                                 this.backgroundColor = 0;
                                 this.borderStyle = "solid";
                                 this.borderThickness = 0;
                                 this.cornerRadius = 10;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "percentWidth":100,
                                    "height":500,
                                    "label":"Main",
                                    "horizontalScrollPolicy":"off",
                                    "verticalScrollPolicy":"off",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":LoadingProgressBarAS,
                                       "id":"_MovieStudio_LoadingProgressBarAS2",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":90,
                                             "y":222,
                                             "width":800
                                          };
                                       }
                                    })]
                                 };
                              }
                           })]
                        };
                     }
                  })]
               };
            }
         });
         this.actorFigures = new Array();
         this.speechBubbles = new Array();
         this.sortOrder = new Array();
         this.items = [];
         this.highlightGlow = new GlowFilter(16777215,1,8,8,3,1);
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         bindings = this._MovieStudio_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_com_moviestarplanet_moviestudio_MovieStudioWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return MovieStudio[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.width = 980;
         this.height = 500;
         this.creationPolicy = "all";
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this._MovieStudio_Fade2_i();
         this._MovieStudio_Fade1_i();
         this._MovieStudio_Sequence1_i();
         this.addEventListener("creationComplete",this.___MovieStudio_ViewComponentCanvas1_creationComplete);
         this.addEventListener("preinitialize",this.___MovieStudio_ViewComponentCanvas1_preinitialize);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         MovieStudio._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         var factory:IFlexModuleFactory = param1;
         super.moduleFactory = factory;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration(null,styleManager);
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.backgroundAlpha = 1;
            this.backgroundColor = 0;
            this.borderStyle = "solid";
            this.borderThickness = 0;
            this.cornerRadius = 6;
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function onPreinitialize(param1:Event) : void
      {
         InjectionManager.manager().injectMe(this);
      }
      
      public function get inPlayMode() : Boolean
      {
         return this._inPlayMode;
      }
      
      private function moviebarLoad(param1:FlexEvent) : void
      {
         this.moviebarLoader.LoadUrl(new RawUrl(Config.toAbsoluteURL("swf/moviestudio/moviebar.swf",Config.LOCAL_CDN_URL)),MSP_LoaderManager.PRIORITY_LOW,true);
      }
      
      private function editProps() : void
      {
         if(this.propsCanvas.visible)
         {
            this.propsCanvas.visible = false;
            return;
         }
         this.scenesCanvas.visible = false;
         this.backgroundCanvas.close();
         this.musicCanvas.close();
         this.movieStarsOk();
         this.populateStuffViewItems(Main.Instance.mainCanvas.applicationViewStack.mainView.moviestarContainer.myMovieStar.actor);
         this.propsCanvas.visible = true;
      }
      
      private function editBackgroundClicked() : void
      {
         if(this.backgroundCanvas.visible)
         {
            this.backgroundCanvas.visible = false;
            return;
         }
         this.movieActorListForm.visible = false;
         this.propsCanvas.visible = false;
         this.scenesCanvas.visible = false;
         this.musicCanvas.close();
         this.backgroundCanvas.actorId = this.instructorId;
         this.backgroundCanvas.visible = true;
      }
      
      private function editMusicClicked() : void
      {
         if(this.musicCanvas.visible)
         {
            this.musicCanvas.close();
            return;
         }
         this.movieActorListForm.visible = false;
         this.propsCanvas.visible = false;
         this.scenesCanvas.visible = false;
         this.backgroundCanvas.visible = false;
         this.musicCanvas.actorId = this.instructorId;
         this.musicCanvas.visible = true;
      }
      
      private function populateStuffViewItems(param1:Actor) : void
      {
         var resultBonster:Function;
         var resultClickItem:Function;
         var resultClothItem:Function;
         var finishedcalls:int = 0;
         var bonsterItems:Array = null;
         var clickItems:Array = null;
         var clothItems:Array = null;
         var j:int = 0;
         var actor:Actor = param1;
         var finishload:Function = function():void
         {
            ++finishedcalls;
            if(finishedcalls >= 3)
            {
               items = items.concat(bonsterItems).concat(clickItems);
               allItemsLoaded();
            }
         };
         var allItemsLoaded:Function = function():void
         {
            var _loc2_:ActorClothesRel = null;
            var _loc3_:Cloth = null;
            var _loc4_:Array = null;
            var _loc5_:MyRoomItem = null;
            var _loc1_:* = int(clothItems.length - 1);
            while(_loc1_ >= 0)
            {
               _loc2_ = clothItems[_loc1_];
               _loc3_ = _loc2_.Cloth;
               _loc4_ = GetTargetArray(_loc3_);
               if(_loc4_ != null)
               {
                  _loc5_ = new MyRoomItem(_loc3_,_loc2_,false);
                  _loc5_.addEventListener(MouseEvent.CLICK,itemClicked);
                  updateItemStatus(_loc5_);
                  _loc4_.push(_loc5_);
               }
               _loc1_--;
            }
            stuffViewItems.PagedItems = items;
         };
         finishedcalls = 0;
         if(this.items.length == 0)
         {
            resultBonster = function(param1:Array):void
            {
               var _loc2_:ActorBonsterRelItem = null;
               var _loc3_:BonsterItemMovieWrapper = null;
               bonsterItems = new Array();
               for each(_loc2_ in param1)
               {
                  _loc3_ = new BonsterItemMovieWrapper(_loc2_);
                  _loc3_.addEventListener(MouseEvent.CLICK,itemClicked);
                  updateItemStatus(_loc3_);
                  bonsterItems.push(_loc3_);
               }
               finishload();
            };
            resultClickItem = function(param1:Array):void
            {
               var _loc2_:ActorClickItemRel = null;
               var _loc3_:MyRoomItem = null;
               clickItems = new Array();
               for each(_loc2_ in param1)
               {
                  _loc3_ = new MyRoomItem(null,null,false,_loc2_);
                  _loc3_.addEventListener(MouseEvent.CLICK,itemClicked);
                  updateItemStatus(_loc3_);
                  clickItems.push(_loc3_);
               }
               finishload();
            };
            resultClothItem = function(param1:Array):void
            {
               clothItems = param1;
               finishload();
            };
            this.bonsterService.GetBonsterListByActor((this.actorModel as IActorModel).actorId,false,resultBonster);
            this.petService.GetClickItemsForActor(actor.ActorId,resultClickItem);
            ActorCache.getInstance().getActorClothItems(ActorSession.getActorId(),resultClothItem);
         }
         else
         {
            j = 0;
            while(j < this.items.length)
            {
               this.updateItemStatus(this.items[j]);
               j++;
            }
         }
      }
      
      private function isPropInScene(param1:IMovieAddable) : Boolean
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:Prop = null;
         if(param1.clickItem)
         {
            _loc2_ = -param1.actorClickItemRel.ActorClickItemRelId;
         }
         else if(param1.actorBonsterRel)
         {
            _loc2_ = param1.actorBonsterRel.ActorBonsterRelId;
         }
         else
         {
            _loc2_ = param1.rel.ActorClothesRelId;
         }
         if(this.scene.PropsInScene != null)
         {
            _loc3_ = 0;
            while(_loc3_ < this.scene.PropsInScene.length)
            {
               _loc4_ = this.scene.PropsInScene.getItemAt(_loc3_) as Prop;
               if(_loc4_.ItemId == _loc2_)
               {
                  return true;
               }
               _loc3_++;
            }
         }
         return false;
      }
      
      private function removePropFromMovie(param1:IMovieAddable) : void
      {
         var _loc2_:Number = NaN;
         var _loc4_:Prop = null;
         var _loc5_:int = 0;
         this.movieChanged = true;
         if(param1.clickItem)
         {
            _loc2_ = -param1.actorClickItemRel.ActorClickItemRelId;
         }
         else if(param1.actorBonsterRel)
         {
            _loc2_ = param1.actorBonsterRel.ActorBonsterRelId;
         }
         else
         {
            _loc2_ = param1.rel.ActorClothesRelId;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.scene.PropsInScene.length)
         {
            _loc4_ = this.scene.PropsInScene.getItemAt(_loc3_) as Prop;
            if(_loc4_.ItemId == _loc2_)
            {
               this.canvas.removeChild(_loc4_.SWF as UIComponent);
               this.scene.PropsInScene.removeItemAt(_loc3_);
               _loc5_ = 0;
               while(_loc5_ < this.sortOrder.length)
               {
                  if(this.sortOrder[_loc5_] == _loc4_.SWF)
                  {
                     this.sortOrder.splice(_loc5_,1);
                  }
                  _loc5_++;
               }
               break;
            }
            _loc3_++;
         }
      }
      
      private function itemClicked(param1:Event) : void
      {
         this.movieChanged = true;
         var _loc2_:IMovieAddable = param1.currentTarget as IMovieAddable;
         var _loc3_:Container = _loc2_ as Container;
         _loc3_.enabled = false;
         if(this.scene.PropsInScene == null)
         {
            this.scene.PropsInScene = new ArrayCollection();
         }
         if(this.isPropInScene(_loc2_))
         {
            this.removePropFromMovie(_loc2_);
            this.updateItemStatus(_loc2_,0);
            _loc3_.enabled = true;
         }
         else
         {
            if(this.scene.PropsInScene.length >= 20)
            {
               Prompt.show(MSPLocaleManagerWeb.getInstance().getString("MAX_20_PROPS"),MSPLocaleManagerWeb.getInstance().getString("CANNOT_ADD_PROPS"));
               _loc3_.enabled = true;
               return;
            }
            this.addCloth(_loc2_,this.scene.PropsInScene.length * 30,200);
            this.updateItemStatus(_loc2_,1);
         }
      }
      
      private function updateItemStatus(param1:IMovieAddable, param2:int = -1) : void
      {
         var _loc3_:Boolean = false;
         if(param2 == -1)
         {
            _loc3_ = this.isPropInScene(param1);
         }
         else
         {
            _loc3_ = param2 == 1;
         }
         if(_loc3_)
         {
            (param1 as DisplayObject).filters = [this.highlightGlow];
         }
         else
         {
            (param1 as DisplayObject).filters = [];
         }
      }
      
      private function addCloth(param1:IMovieAddable, param2:Number, param3:Number, param4:Boolean = false) : void
      {
         var itemcontainer:Container = null;
         var propInMovie:Prop = null;
         var done:Function = null;
         var item:IMovieAddable = param1;
         var x:Number = param2;
         var y:Number = param3;
         var isModeratorItem:Boolean = param4;
         done = function(param1:UIComponent):void
         {
            propInMovie.SWF = param1;
            currentProp = propInMovie;
            param1.cacheAsBitmap = true;
            displayPropInScene(param1,x,y);
            keyclick(selectedKey);
            itemcontainer.enabled = true;
         };
         itemcontainer = item as Container;
         propInMovie = new Prop();
         if(item.clickItem)
         {
            propInMovie.Type = Prop.TYPE_CLICKITEM;
            propInMovie.ItemId = -item.actorClickItemRel.ActorClickItemRelId;
         }
         else if(item.actorBonsterRel)
         {
            propInMovie.Type = Prop.TYPE_BONSTER;
            propInMovie.ItemId = item.actorBonsterRel.ActorBonsterRelId;
         }
         else
         {
            propInMovie.Type = Prop.TYPE_CLOTHES;
            propInMovie.ItemId = item.rel.ActorClothesRelId;
         }
         this.scene.PropsInScene.addItem(propInMovie);
         this.initPropKeyFramesForOneProp(propInMovie,x,y);
         this.loadProp(item.rel,item.actorClickItemRel,item.actorBonsterRel,done);
         this.goToFirstFrame();
      }
      
      private function loadProp(param1:ActorClothesRel, param2:ActorClickItemRel, param3:ActorBonsterRelItem, param4:Function = null) : UIComponent
      {
         var loadClickitemDone:Function = null;
         var loadItemDone:Function = null;
         var timeout:Function = null;
         var bonsterLoaded:Function = null;
         var clickItem:ClickItem = null;
         var bonsterClickItem:BonsterClickItem = null;
         var wrapper:BonsterClickItemMovieWrapper = null;
         var rel:ActorClothesRel = param1;
         var actorClickItemRel:ActorClickItemRel = param2;
         var actorBonsterRel:ActorBonsterRelItem = param3;
         var resultFunction:Function = param4;
         loadClickitemDone = function():void
         {
            if(instructorId != 0)
            {
               clickItem.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownOnItem,false,0,true);
               clickItem.addEventListener(MouseEvent.MOUSE_UP,mouseUpOnItem,false,0,true);
            }
            if(resultFunction != null)
            {
               resultFunction(clickItem);
            }
         };
         loadItemDone = function(param1:FlippableLoader):void
         {
            param1.originalScale = rel.Cloth.Scale;
            param1.cacheAsBitmap = true;
            if(instructorId != 0)
            {
               param1.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownOnItem,false,0,true);
               param1.addEventListener(MouseEvent.MOUSE_UP,mouseUpOnItem,false,0,true);
            }
            if(resultFunction != null)
            {
               resultFunction(param1);
            }
         };
         timeout = function():void
         {
            if(resultFunction != null)
            {
               resultFunction(wrapper);
            }
         };
         bonsterLoaded = function():void
         {
            if(instructorId != 0)
            {
               wrapper.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownOnItem,false,0,true);
               wrapper.addEventListener(MouseEvent.MOUSE_UP,mouseUpOnItem,false,0,true);
            }
            setTimeout(timeout,1);
         };
         if(actorClickItemRel != null)
         {
            clickItem = ClickItem.create(actorClickItemRel);
            clickItem.loadClickItemSwf(loadClickitemDone);
            return clickItem;
         }
         if(actorBonsterRel != null)
         {
            bonsterClickItem = new BonsterClickItem(actorBonsterRel,100,100);
            wrapper = new BonsterClickItemMovieWrapper(bonsterClickItem);
            bonsterClickItem.loadPet(bonsterLoaded);
            return wrapper;
         }
         return ItemHelpers.loadItem(rel,loadItemDone,false);
      }
      
      private function displayPropInScene(param1:UIComponent, param2:int, param3:int) : void
      {
         this.canvas.addChild(param1);
         param1.move(param2,param3);
         this.setPropScale(param1);
         this.sortOrder.push(param1);
      }
      
      private function mouseDownOnItem(param1:MouseEvent) : void
      {
         var _loc3_:Prop = null;
         this.dragItem = param1.currentTarget as UIComponent;
         this.lastDragX = mouseX;
         this.lastDragY = mouseY;
         var _loc2_:int = 0;
         while(_loc2_ < this.scene.PropsInScene.length)
         {
            _loc3_ = this.scene.PropsInScene.getItemAt(_loc2_) as Prop;
            if(_loc3_.SWF == this.dragItem)
            {
               this.currentProp = _loc3_;
               return;
            }
            _loc2_++;
         }
      }
      
      private function mouseUpOnItem(param1:MouseEvent) : void
      {
         this.dragItem = null;
      }
      
      private function getPropScale(param1:UIComponent, param2:Number) : Number
      {
         var _loc3_:Number = NaN;
         var _loc4_:FlippableLoader = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         if(param1 is FlippableLoader)
         {
            _loc3_ = 380;
            _loc4_ = param1 as FlippableLoader;
            if(param2 < _loc3_ - _loc4_.contentHeight)
            {
               param2 = _loc3_ - _loc4_.contentHeight;
            }
            return _loc4_.originalScale * (0.3 + param2 / this.canvas.height);
         }
         if(param1 is IScaleable)
         {
            _loc5_ = 210;
            _loc6_ = 0.75;
            _loc7_ = 1;
            if(param2 < _loc5_)
            {
               return _loc6_;
            }
            _loc8_ = this.canvas.height - _loc5_;
            _loc9_ = param2 - _loc5_;
            return _loc9_ / _loc8_ * (_loc7_ - _loc6_) + _loc6_;
         }
         return 1;
      }
      
      private function setPropScale(param1:UIComponent) : void
      {
         var _loc2_:Number = this.getPropScale(param1,param1.y);
         param1.scaleX = _loc2_;
         param1.scaleY = _loc2_;
      }
      
      private function GetTargetArray(param1:Cloth) : Array
      {
         switch(param1.ClothesCategoryId)
         {
            case 19:
            case 20:
            case 21:
            case 22:
            case 23:
            case 24:
            case 33:
            case 46:
               return this.items;
            default:
               return null;
         }
      }
      
      public function get movieChanged() : Boolean
      {
         return this._movieChanged;
      }
      
      public function set movieChanged(param1:Boolean) : void
      {
         this._movieChanged = param1;
      }
      
      public function setPlayMode(param1:Boolean) : void
      {
         var _loc2_:Boolean = false;
         this._inPlayMode = param1;
         if(param1)
         {
            if(this.movie != null && this.movie.ActorId == ActorSession.getActorId() && this.movie.State < MovieStatuses.M_STATUS_SUBMITTED)
            {
               this.editButton.visible = this.editButton.includeInLayout = true;
               this.reportButton.visible = this.reportButton.includeInLayout = false;
            }
            else
            {
               this.reportButton.visible = this.reportButton.includeInLayout = true;
               this.editButton.visible = this.editButton.includeInLayout = false;
               _loc2_ = this.movie != null;
               this.reportButton.visible = _loc2_ && !AnchorCharacters.isSpecialCharacter(this.movie.ActorId);
            }
            this.sendMailButton.visible = this.sendMailButton.includeInLayout = true;
            this.shareWithButton.visible = this.shareWithButton.includeInLayout = true;
            this.exitButton.visible = this.exitButton.includeInLayout = true;
            this.helpButton.visible = this.helpButton.includeInLayout = false;
            this.saveButton.visible = this.saveButton.includeInLayout = false;
            MSP_ToolTipManager.add(this.exitButton,MSPLocaleManagerWeb.getInstance().getString("STOP_MOVIE"));
         }
         else
         {
            this.helpButton.visible = this.helpButton.includeInLayout = true;
            this.saveButton.visible = this.saveButton.includeInLayout = true;
            this.exitButton.visible = this.exitButton.includeInLayout = true;
            this.editButton.visible = this.editButton.includeInLayout = false;
            this.sendMailButton.visible = this.sendMailButton.includeInLayout = false;
            this.shareWithButton.visible = this.shareWithButton.includeInLayout = false;
            MSP_ToolTipManager.add(this.exitButton,MSPLocaleManagerWeb.getInstance().getString("EXIT_MOVIESTUDIO"));
         }
         this.editScenesButton.visible = !param1;
         this.editPropsButton.visible = !param1;
         this.editActorsButton.visible = !param1;
         this.editBackgroundButton.visible = !param1;
         this.editMusicButton.visible = !param1;
         this.slider.visible = !param1;
         this.movieActorForm.visible = !param1;
         this.secondCounter.visible = param1;
         this.movieName.visible = param1;
         this.stopBtn.visible = param1;
         this.playEnable(!param1);
      }
      
      private function setSpeecRecordMode(param1:Boolean) : void
      {
         this.saveButton.enabled = !param1;
         this.editActorsButton.enabled = !param1;
         this.textNbrFrames.enabled = !param1;
         this.addSceneButton.visible = !param1;
      }
      
      public function nbrFramesChange(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:KeyFrameActor = null;
         var _loc6_:Prop = null;
         var _loc7_:KeyFrameProp = null;
         var _loc8_:Number = NaN;
         var _loc9_:KeyFrameActor = null;
         var _loc10_:Prop = null;
         if(isNaN(param1))
         {
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("INVALID_NUMBER_FRAMES"),MSPLocaleManagerWeb.getInstance().getString("INVALID_NUMBER_FRAMES"));
            this.textNbrFrames.text = (this.scene.KeyFrameCount - 2).toString();
            return;
         }
         if(param1 <= 0)
         {
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("ATLEAST_ONE"),MSPLocaleManagerWeb.getInstance().getString("INVALID_NUMBER_FRAMES"));
            this.textNbrFrames.text = (this.scene.KeyFrameCount - 2).toString();
            return;
         }
         if(param1 > 30)
         {
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("MAXIMUM_99"),MSPLocaleManagerWeb.getInstance().getString("INVALID_NUMBER_FRAMES"));
            this.textNbrFrames.text = (this.scene.KeyFrameCount - 2).toString();
            return;
         }
         this.movieChanged = true;
         _loc2_ = param1;
         if(_loc2_ > this.scene.KeyFrameCount)
         {
            _loc3_ = this.scene.KeyFrameCount;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = 0;
               while(_loc4_ < this.movie.MovieActorRels.length)
               {
                  _loc5_ = new KeyFrameActor();
                  this.scene.KeyFrameActors.addItem(_loc5_);
                  _loc5_.FigureNumber = _loc4_;
                  _loc5_.KeyFrameId = 0;
                  _loc5_.KeyFrameNumber = _loc3_;
                  _loc5_.X = -1;
                  _loc5_.Y = -1;
                  _loc5_.Line = "";
                  _loc5_.BubbleType = CalloutBubbleTypes.SPEECH_RECTANGLE;
                  _loc5_.Animation = "";
                  _loc5_.Speech = 0;
                  _loc5_.Face = "";
                  _loc5_.IsFacingLeft = -1;
                  _loc5_.SceneId = this.scene.SceneId;
                  _loc4_++;
               }
               _loc3_++;
            }
            if(this.scene.PropsInScene != null)
            {
               _loc4_ = 0;
               while(_loc4_ < this.scene.PropsInScene.length)
               {
                  _loc6_ = this.scene.PropsInScene.getItemAt(_loc4_) as Prop;
                  _loc3_ = this.scene.KeyFrameCount;
                  while(_loc3_ < _loc2_)
                  {
                     _loc7_ = new KeyFrameProp();
                     _loc6_.KeyFrameProps.addItem(_loc7_);
                     _loc7_.ItemId = _loc6_.ItemId;
                     _loc7_.KeyFrameNumber = _loc3_;
                     _loc7_.X = -1;
                     _loc7_.Y = -1;
                     _loc7_.IsFacingLeft = -1;
                     _loc3_++;
                  }
                  _loc4_++;
               }
            }
            this.movieTotalKeyFrameCount += _loc2_ - this.scene.KeyFrameCount;
            this.scene.KeyFrameCount = _loc2_;
            this.updateFrameCount();
         }
         else if(_loc2_ < this.scene.KeyFrameCount)
         {
            if(!this.confirmedDelete && _loc2_ <= this.lastEditedKeyFrame)
            {
               this.confirmDeleteKeyFrame(_loc2_);
            }
            else
            {
               _loc8_ = this.scene.KeyFrameActors.length - 1;
               while(_loc8_ >= 0)
               {
                  _loc9_ = this.scene.KeyFrameActors.getItemAt(_loc8_) as KeyFrameActor;
                  if(_loc9_.KeyFrameNumber >= _loc2_)
                  {
                     this.scene.KeyFrameActors.removeItemAt(_loc8_);
                  }
                  _loc8_--;
               }
               if(this.scene.PropsInScene != null)
               {
                  _loc4_ = 0;
                  while(_loc4_ < this.scene.PropsInScene.length)
                  {
                     _loc10_ = this.scene.PropsInScene.getItemAt(_loc4_) as Prop;
                     _loc8_ = _loc10_.KeyFrameProps.length - 1;
                     while(_loc8_ >= _loc2_)
                     {
                        _loc10_.KeyFrameProps.removeItemAt(_loc8_);
                        _loc8_--;
                     }
                     _loc4_++;
                  }
               }
               this.scene.KeyFrameCount = _loc2_;
               this.updateFrameCount();
            }
         }
         (this.vboxScenes.getChildAt(this.scene.SceneNumber) as SceneListCanvas).setFrameCount(this.scene.KeyFrameCount);
      }
      
      private function confirmDeleteKeyFrame(param1:Number) : void
      {
         var closeHandler:Function = null;
         var newFrameNumber:Number = param1;
         closeHandler = function(param1:PromptEvent):void
         {
            if(param1.detail == Prompt.YES)
            {
               confirmedDelete = true;
               nbrFramesChange(newFrameNumber);
            }
         };
         Prompt.show(MSPLocaleManagerWeb.getInstance().getString("SURE_DELETE_FRAME"),MSPLocaleManagerWeb.getInstance().getString("DELETE_FRAME"),Alert.YES | Alert.NO,null,closeHandler,null,Alert.NO);
      }
      
      public function sliderClick(param1:Event) : void
      {
         if(!this.inPlayMode && this.isPlaying)
         {
            this.stopclick();
            this.m_objAnimationManager.removeAll();
            this.isPlaying = false;
         }
      }
      
      private function GetCallOutFocused() : CallOut
      {
         var _loc2_:CallOut = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.canvasSpeechBubble.numChildren)
         {
            _loc2_ = CallOut(this.canvasSpeechBubble.getChildAt(_loc1_));
            if(Boolean(_loc2_) && _loc2_.IsFocused())
            {
               return _loc2_;
            }
            _loc1_++;
         }
         return null;
      }
      
      public function sliderChange(param1:SliderEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:CallOut = null;
         if(!this.isPlaying)
         {
            _loc2_ = param1.value ? int(param1.value) : int(this.slider.value);
            _loc3_ = this.GetCallOutFocused();
            if(_loc3_)
            {
               _loc3_.ForceLoseFocus();
               this.mDelayedValue = _loc2_ - 1;
               this.doneEditingBubble(_loc3_,Number(_loc3_.name),true);
            }
            else
            {
               callLater(this.keyclick,[_loc2_ - 1]);
            }
         }
      }
      
      public function keyClickDynamic(param1:Event) : void
      {
         var _loc2_:Number = Number(param1.target.name);
         this.keyclick(_loc2_);
      }
      
      private function getNewActorCoordX(param1:int) : int
      {
         return 50 + param1 * 100;
      }
      
      private function getNewActorCoordY(param1:int) : int
      {
         return 180;
      }
      
      private function loadKeyFramesForMovie() : void
      {
         var done:Function = null;
         done = function(param1:Event = null):void
         {
            loadView.visible = false;
            if(inPlayMode)
            {
               playclick();
            }
         };
         this.markCurrentScene(this.vboxScenes.getChildAt(0) as SceneListCanvas,0);
         MovieModuleManager.getInstance().setIsLoadingAutoSavedMovieInitially(false);
         this.fadeOut.addEventListener(EffectEvent.EFFECT_END,done);
         this.fadeOut.play([this.loadView]);
      }
      
      private function loadPropsForMovie() : void
      {
         var numPropsToLoad:int = 0;
         var i:int = 0;
         var j:int = 0;
         var m:int = 0;
         var l:int = 0;
         var numberOfScenes:int = 0;
         var numberOfPropsIntoScene:int = 0;
         var scene:Scene = null;
         var scene2:Scene = null;
         var doneBonster:Function = null;
         var doneClickItem:Function = null;
         var doneClothesList:Function = null;
         var doneupdating:Function = null;
         var prop:Prop = null;
         var legacyCondition:Boolean = false;
         doneBonster = function(param1:ActorBonsterRelItem):void
         {
            searchForPropAndLoad(null,null,param1);
         };
         doneClickItem = function(param1:ActorClickItemRel):void
         {
            searchForPropAndLoad(null,param1,null);
         };
         doneClothesList = function(param1:Array):void
         {
            var _loc2_:int = 0;
            if(param1 != null)
            {
               _loc2_ = 0;
               while(_loc2_ < param1.length)
               {
                  searchForPropAndLoad(param1[_loc2_],null,null);
                  _loc2_++;
               }
            }
         };
         var searchForPropAndLoad:Function = function(param1:ActorClothesRel, param2:ActorClickItemRel, param3:ActorBonsterRelItem):void
         {
            var _loc4_:int = 0;
            var _loc5_:Object = null;
            if(param1 == null && param2 == null && param3 == null)
            {
               --numPropsToLoad;
               if(numPropsToLoad == 0)
               {
                  loadPropsDone(movie);
               }
               return;
            }
            if(param1 != null)
            {
               _loc4_ = param1.ActorClothesRelId;
            }
            else if(param2 != null)
            {
               _loc4_ = -param2.ActorClickItemRelId;
            }
            else if(param3 != null)
            {
               _loc4_ = param3.ActorBonsterRelId;
            }
            m = 0;
            while(m < numberOfScenes)
            {
               scene2 = movie.Scenes.getItemAt(m) as Scene;
               numberOfPropsIntoScene = scene2.PropsInScene.length;
               l = 0;
               while(l < numberOfPropsIntoScene)
               {
                  prop = scene2.PropsInScene.getItemAt(l) as Prop;
                  if(prop.ItemId == _loc4_ && prop.SWF == null && Boolean(_loc5_))
                  {
                     prop.SWF = _loc5_;
                     doneupdating();
                     break;
                  }
                  if(prop.ItemId == _loc4_ && prop.SWF == null)
                  {
                     _loc5_ = loadProp(param1,param2,param3,doneupdating);
                     prop.SWF = _loc5_;
                     break;
                  }
                  ++l;
               }
               ++m;
            }
         };
         doneupdating = function():void
         {
            --numPropsToLoad;
            if(numPropsToLoad == 0)
            {
               loadPropsDone(movie);
            }
         };
         var propsToLoadExist:Boolean = false;
         numPropsToLoad = 0;
         var propList:Array = new Array();
         numberOfScenes = this.movie.Scenes.length;
         i = 0;
         while(i < numberOfScenes)
         {
            scene = this.movie.Scenes.getItemAt(i) as Scene;
            if(scene.PropsInScene != null)
            {
               numberOfPropsIntoScene = scene.PropsInScene.length;
               j = 0;
               for(; j < numberOfPropsIntoScene; j++)
               {
                  prop = scene.PropsInScene.getItemAt(j) as Prop;
                  if(prop.SWF != null)
                  {
                     if(this.instructorId != 0)
                     {
                        prop.SWF.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownOnItem,false,0,true);
                        prop.SWF.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpOnItem,false,0,true);
                     }
                     continue;
                  }
                  legacyCondition = prop.Type == Prop.TYPE_NONE && prop.ItemId >= 0;
                  if(legacyCondition || prop.Type == Prop.TYPE_CLOTHES)
                  {
                     if(propList.indexOf(prop.ItemId) == -1)
                     {
                        propList.push(prop.ItemId);
                     }
                     propsToLoadExist = true;
                     numPropsToLoad++;
                     continue;
                  }
                  propsToLoadExist = true;
                  numPropsToLoad++;
                  if(prop.Type == Prop.TYPE_NONE)
                  {
                     if(prop.ItemId < 0)
                     {
                        this.petService.GetActorClickItem(-prop.ItemId,doneClickItem);
                     }
                     continue;
                  }
                  switch(prop.Type)
                  {
                     case Prop.TYPE_CLICKITEM:
                        this.petService.GetActorClickItem(-prop.ItemId,doneClickItem);
                        break;
                     case Prop.TYPE_BONSTER:
                        this.bonsterService.GetBonsterById(prop.ItemId,doneBonster);
                  }
               }
            }
            i++;
         }
         if(propList.length > 0)
         {
            MovieStarService.getInstance().getActorClothesRelList(propList,doneClothesList);
         }
         if(!propsToLoadExist)
         {
            this.loadPropsDone(this.movie);
         }
      }
      
      public function addSpeechBubble(param1:Number) : void
      {
         var _loc2_:CallOut = null;
         if(this.speechBubbles[param1])
         {
            this.canvasSpeechBubble.addChild(this.speechBubbles[param1]);
         }
         else
         {
            _loc2_ = new CallOut(this.movie.ActorId);
            _loc2_.name = param1.toString();
            _loc2_.maxChars = 100;
            _loc2_.editable = false;
            _loc2_.closeButtonImage = Config.toAbsoluteURL("img/icons/trashcan_sb.png",Config.LOCAL_CDN_URL);
            _loc2_.addEventListener(CallOut.CLOSE_CLICKED,this.onCallOutCloseClicked);
            _loc2_.addEventListener(CallOut.USER_CHANGED_TEXT,this.speechBubbleChanged);
            _loc2_.addEventListener(CallOut.DONE_EDITING,this.HandleDoneEditing);
            this.canvasSpeechBubble.addChild(_loc2_);
            if(!this.inPlayMode)
            {
               _loc2_.focus();
            }
            _loc2_.visible = false;
            this.speechBubbles[param1] = _loc2_;
         }
      }
      
      private function speechBubbleChanged(param1:Event) : void
      {
         var _loc4_:KeyFrameActor = null;
         this.currentCallOut = param1.currentTarget as CallOut;
         var _loc2_:CallOut = param1.currentTarget as CallOut;
         var _loc3_:Number = Number(param1.currentTarget.name);
         if(!this.textDisplayedFromPreviousKeyFrame[_loc3_])
         {
            _loc4_ = this.getKeyFrameActor(_loc3_,this.selectedKey);
         }
         else
         {
            _loc4_ = this.getKeyFrameActor(_loc3_,this.selectedKey - 1);
         }
         _loc2_.originalText = _loc2_.text;
         _loc4_.Line = _loc2_.text;
         _loc4_.rawLine = _loc2_.originalText;
         this.keyFrameEdited();
      }
      
      private function HandleDoneEditing(param1:Event) : void
      {
         var _loc2_:CallOut = null;
         var _loc3_:Number = NaN;
         if(!this._inPlayMode && this.textDisplayedFromPreviousKeyFrame != null)
         {
            this.currentCallOut = null;
            _loc2_ = param1.currentTarget as CallOut;
            _loc3_ = Number(param1.currentTarget.name);
            this.doneEditingBubble(_loc2_,_loc3_);
         }
      }
      
      private function doneEditingBubble(param1:CallOut, param2:Number, param3:Boolean = false, param4:Function = null) : void
      {
         var userBehaviorFailed:Function = null;
         var inputUserBehaviorFilterCallback:Function = null;
         var keyFrameActor:KeyFrameActor = null;
         var callOut:CallOut = param1;
         var figureNumber:Number = param2;
         var triggerFrameChange:Boolean = param3;
         var callback:Function = param4;
         userBehaviorFailed = function():void
         {
            callOut.dispatchEvent(new Event(CallOut.CLOSE_CLICKED));
         };
         inputUserBehaviorFilterCallback = function(param1:UserBehaviorResult):void
         {
            callOut.text = keyFrameActor.Line = UserBehaviorMessageFormatter.getInstance().embedFilteredMessages2(callOut.text,param1);
            callOut.originalText = keyFrameActor.rawLine = callOut.originalText;
            afterServerResponse();
         };
         var afterServerResponse:Function = function():void
         {
            keyFrameEdited();
            if(triggerFrameChange)
            {
               callLater(keyclick,[mDelayedValue]);
               mDelayedValue = -1;
            }
            if(callback != null)
            {
               callback();
            }
         };
         if(!this._inPlayMode && this.textDisplayedFromPreviousKeyFrame != null)
         {
            if(!this.textDisplayedFromPreviousKeyFrame[figureNumber])
            {
               keyFrameActor = this.getKeyFrameActor(figureNumber,this.selectedKey);
            }
            else
            {
               keyFrameActor = this.getKeyFrameActor(figureNumber,this.selectedKey - 1);
            }
            UserBehaviorControl.getInstance().inputUserBehaviorFilterAndLog(callOut.textArea,inputUserBehaviorFilterCallback,ActorSession.getActorId(),String(0),InputLocations.LOC_MOVIE,true,true,false,userBehaviorFailed);
         }
      }
      
      public function pauseClick() : void
      {
         if(this.sceneShiftTimer != null)
         {
            this.sceneShiftTimer.stop();
         }
         if(this.minuteTimer != null)
         {
            this.minuteTimer.stop();
            this.stop(this.frame);
         }
         this.playEnable(true);
         if(this.instructorId == 0 && !this.inPlayMode)
         {
            this.onActorTick(null);
         }
         this.paused = true;
      }
      
      public function stopclick(param1:Boolean = false) : void
      {
         this.paused = false;
         if(this.sceneShiftTimer != null)
         {
            this.sceneShiftTimer.stop();
         }
         if(this.minuteTimer != null)
         {
            this.minuteTimer.stop();
            this.stop(this.frame);
         }
         this.playEnable(true);
         if(this.instructorId == 0 && !param1 && !this.inPlayMode)
         {
            this.onActorTick(null);
         }
         this.isPlaying = false;
      }
      
      private function playEnable(param1:Boolean) : void
      {
         if(param1)
         {
            this.play.enabled = true;
            if(!this.inPlayMode)
            {
               this.saveButton.enabled = true;
               if(this.instructorId != 0)
               {
                  this.startAutoSaving();
               }
               this.editScenesButton.enabled = true;
               this.editPropsButton.enabled = true;
               this.editActorsButton.enabled = true;
               this.editBackgroundButton.enabled = true;
               this.editMusicButton.enabled = true;
               this.helpButton.enabled = true;
               this.slider.sliderEnabled = true;
            }
            this.play.source = Config.toAbsoluteURL("swf/moviestudio/play.swf",Config.LOCAL_CDN_URL);
            MSP_ToolTipManager.add(this.play,MSPLocaleManagerWeb.getInstance().getString("PLAY_MOVIE"));
         }
         else
         {
            if(!this.inPlayMode)
            {
               this.saveButton.enabled = false;
               this.stopAutoSaving();
               this.scenesCanvas.visible = false;
               this.propsCanvas.visible = false;
               this.movieStarsOk();
               this.editScenesButton.enabled = false;
               this.editPropsButton.enabled = false;
               this.editActorsButton.enabled = false;
               this.editBackgroundButton.enabled = false;
               this.editMusicButton.enabled = false;
               this.helpButton.enabled = false;
               this.slider.sliderEnabled = false;
               this.movieActorForm.speechBubbleSelector.close();
            }
            this.play.source = Config.toAbsoluteURL("swf/moviestudio/pause.swf",Config.LOCAL_CDN_URL);
            MSP_ToolTipManager.add(this.play,MSPLocaleManagerWeb.getInstance().getString("PAUSE_MOVIE"));
         }
         if(!this.inPlayMode && param1)
         {
            if(this.instructorId != 0)
            {
               this.saveButton.enabled = true;
               this.editScenesButton.enabled = true;
               this.editPropsButton.enabled = true;
               this.editActorsButton.enabled = true;
               this.editBackgroundButton.enabled = true;
               this.editMusicButton.enabled = true;
               this.helpButton.enabled = true;
               this.setSpeecRecordMode(false);
               this.movieActorForm.setInstructorMode();
            }
            else
            {
               this.setSpeecRecordMode(true);
               this.movieActorForm.setSpeechRecordMode();
            }
         }
         dispatchEvent(new BooleanEvent(PLAYENABLE_CHANGED,param1));
      }
      
      public function playclick(param1:Event = null) : void
      {
         SoundManager.Instance().addEventListener(MSP_Event.E_MUTE_CHANGED,this.toggleMute);
         this.onlyPlaySelectedScene = !this.inPlayMode;
         if(this.isPlaying)
         {
            this.pauseClick();
         }
         else
         {
            this.playEnable(false);
            if(!this.inPlayMode && this.instructorId != 0)
            {
               this.playScene(this.scene.SceneNumber,0);
            }
            else if(this.paused)
            {
               this.playScene(this.scene.SceneNumber,this.frame);
            }
            else
            {
               this.frame = 0;
               this.playScene(0,0);
            }
            this.paused = false;
         }
         this.isPlaying = !this.isPlaying;
         this.movieActorForm.close();
      }
      
      protected function playScene(param1:Number, param2:int, param3:int = -1, param4:Boolean = true) : void
      {
         var numTicks:int;
         var done:Function;
         var transform:SoundTransform = null;
         var sceneNumber:Number = param1;
         var frameStart:int = param2;
         var frameEnd:int = param3;
         var autoStart:Boolean = param4;
         if(this.movieActorForm != null && !this.movieActorForm.isClosed)
         {
            this.movieActorForm.close();
         }
         if(sceneNumber != this.scene.SceneNumber || frameStart != this.frame)
         {
            this.markCurrentScene(this.vboxScenes.getChildAt(sceneNumber) as SceneListCanvas,frameStart);
         }
         if(this.backgroundSound != null)
         {
            if(this.scene.Sound != this.soundPlaying && this.scene.Sound != "" && this.scene.Sound.length > 0)
            {
               if(autoStart)
               {
                  this.channel = this.backgroundSound.play();
                  this.soundPlaying = this.scene.Sound;
               }
               if(SoundManager.Instance().isMuted)
               {
                  transform = this.channel.soundTransform;
                  transform.volume = 0;
                  this.channel.soundTransform = transform;
               }
            }
            else if(!(this.scene.Sound == this.soundPlaying && this.scene.Sound != ""))
            {
               this.soundPlaying = "";
            }
         }
         if(frameEnd < 0)
         {
            frameEnd = this.scene.KeyFrameCount;
         }
         numTicks = frameEnd - frameStart + 1;
         this.lastFrameToPlay = frameEnd;
         this.m_objAnimationManager = new AnimationManager();
         if(this.minuteTimer != null)
         {
            this.minuteTimer.stop();
            this.minuteTimer.removeEventListener(TimerEvent.TIMER,this.onTick);
         }
         this.minuteTimer = new Timer(secsPrFrame * 1000,numTicks);
         this.minuteTimer.addEventListener(TimerEvent.TIMER,this.onTick);
         this.frame = frameStart;
         if(autoStart)
         {
            done = function(param1:Event = null):void
            {
               onTick(null);
               minuteTimer.start();
            };
            this.sceneShiftTimer = new Timer(500,1);
            this.sceneShiftTimer.addEventListener(TimerEvent.TIMER,done);
            this.sceneShiftTimer.start();
         }
      }
      
      public function toggleMute(param1:Event = null) : void
      {
         var _loc2_:SoundTransform = null;
         if(this.channel != null)
         {
            _loc2_ = this.channel.soundTransform;
            if(SoundManager.Instance().isMuted)
            {
               _loc2_.volume = 0;
            }
            else
            {
               _loc2_.volume = 1;
            }
            this.channel.soundTransform = _loc2_;
         }
      }
      
      public function getKeyFrameActor(param1:Number, param2:Number) : KeyFrameActor
      {
         var _loc5_:KeyFrameActor = null;
         var _loc3_:ArrayCollection = this.movie.Scenes.getItemAt(this.selectedScene).KeyFrameActors;
         var _loc4_:Number = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = _loc3_.getItemAt(_loc4_) as KeyFrameActor;
            if(_loc5_.FigureNumber == param1 && _loc5_.KeyFrameNumber == param2)
            {
               return _loc5_;
            }
            _loc4_++;
         }
         return null;
      }
      
      private function placeSpeechBubble(param1:KeyFrameActor, param2:Number) : void
      {
         var _loc3_:CallOut = this.speechBubbles[param2];
         var _loc4_:Point = this.getSpeechBubblePoint(param1.X,param1.Y,_loc3_.bubbleWidth,_loc3_.bubbleHeight);
         _loc3_.x = _loc4_.x;
         _loc3_.y = _loc4_.y;
      }
      
      private function getSpeechBubblePoint(param1:Number, param2:Number, param3:Number, param4:Number) : Point
      {
         var _loc5_:Number = param1 + 50;
         var _loc6_:Number = param2;
         if(_loc6_ < param4 + 10)
         {
            _loc6_ = param4 + 10;
         }
         if(_loc5_ > this.width - param3 - 10)
         {
            _loc5_ = this.width - param3 - 10;
         }
         else if(_loc5_ < 10)
         {
            _loc5_ = 10;
         }
         return new Point(_loc5_,_loc6_);
      }
      
      private function moveFigure(param1:Number) : void
      {
         var _loc4_:KeyFrameActor = null;
         var _loc9_:CallOut = null;
         var _loc10_:UIComponent = null;
         var _loc11_:Point = null;
         var _loc12_:KeyFrameActor = null;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:CallOut = null;
         var _loc16_:Point = null;
         var _loc2_:KeyFrameActor = this.getKeyFrameActor(param1,this.frame - 1);
         var _loc3_:KeyFrameActor = this.getKeyFrameActor(param1,this.frame);
         var _loc5_:Boolean = false;
         if(this.frame - 2 >= 0)
         {
            _loc4_ = this.getKeyFrameActor(param1,this.frame - 2);
            _loc5_ = this.hasSpeech(_loc4_);
         }
         if(this.hasSpeech(_loc2_))
         {
            _loc9_ = this.speechBubbles[param1] as CallOut;
            _loc9_.text = _loc2_.filteredLine;
            _loc9_.originalText = _loc2_.rawLine;
            _loc9_.type = _loc2_.BubbleType;
            _loc9_.visible = true;
            _loc9_.editable = false;
            _loc10_ = this.actorFigures[param1];
            _loc11_ = this.getSpeechBubblePoint(_loc10_.x,_loc10_.y,_loc9_.bubbleWidth,_loc9_.bubbleHeight);
            _loc9_.move(_loc11_.x,_loc11_.y);
         }
         else if(!_loc5_)
         {
            this.speechBubbles[param1].text = "";
            this.speechBubbles[param1].originalText = "";
            this.speechBubbles[param1].visible = false;
         }
         var _loc6_:MovieStar = this.actorFigures[param1] as MovieStar;
         if(_loc2_.Animation != "")
         {
            _loc6_.PlayAnimation(_loc2_.Animation,null,0,null,_loc2_.LastUpdated);
         }
         if(this.frame < this.scene.KeyFrameCount)
         {
            _loc12_ = this.getKeyFrameActor(param1,this.frame);
            if(_loc12_.Animation != "")
            {
               _loc6_.preloadAnimation(_loc12_.Animation,_loc12_.LastUpdated);
            }
         }
         if(_loc2_.Face != "")
         {
            _loc6_.SetFaceExpression(_loc2_.Face);
         }
         if((_loc2_.Speech != 0 || this.hasSpeech(_loc2_) || _loc5_ && _loc4_.BubbleType != CalloutBubbleTypes.THOUGHTS) && _loc2_.BubbleType != CalloutBubbleTypes.THOUGHTS)
         {
            _loc6_.talk();
         }
         else
         {
            _loc6_.StopTalk();
         }
         if(_loc2_.Speech != 0)
         {
            _loc6_.talk();
         }
         var _loc7_:KeyFrameActor = this.FindKeyFrameActorWhereCoordinatesHaveBeenSet(param1,this.frame - 1);
         var _loc8_:KeyFrameActor = this.FindKeyFrameActorWhereCoordinatesHaveBeenSet(param1,this.frame);
         if(_loc7_ != null && _loc8_ != null && _loc2_ != null && _loc2_.Animation == "walk")
         {
            if(_loc7_.X > _loc8_.X)
            {
               _loc2_.IsFacingLeft = 1;
            }
            else if(_loc7_.X < _loc8_.X)
            {
               _loc2_.IsFacingLeft = 0;
            }
         }
         if(_loc2_.IsFacingLeft == 1)
         {
            _loc6_.FaceLeft();
         }
         else if(_loc2_.IsFacingLeft == 0)
         {
            _loc6_.FaceRight();
         }
         if(_loc3_ != null && _loc3_.X != -1)
         {
            _loc13_ = secsPrFrame * 1000;
            this.m_objAnimationManager.move(_loc6_,_loc3_.X,_loc3_.Y,_loc13_,Transitions.LINEAR,RenderMethod.ENTER_FRAME);
            _loc14_ = this.getFigureScaleFromScreenY(_loc3_.Y);
            this.m_objAnimationManager.scale(_loc6_,_loc14_ * _loc6_.getSkinScaleX(),_loc14_ * _loc6_.getSkinScaleY(),_loc13_,Transitions.LINEAR,RenderMethod.ENTER_FRAME);
            _loc15_ = this.speechBubbles[param1] as CallOut;
            _loc16_ = this.getSpeechBubblePoint(_loc3_.X,_loc3_.Y,_loc15_.bubbleWidth,_loc15_.bubbleHeight);
            this.m_objAnimationManager.move(this.speechBubbles[param1],_loc16_.x,_loc16_.y,_loc13_,Transitions.LINEAR,RenderMethod.ENTER_FRAME);
         }
      }
      
      private function moveProp(param1:Number) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:Prop = this.scene.PropsInScene.getItemAt(param1) as Prop;
         var _loc3_:KeyFrameProp = this.FindKeyFramePropWhereCoordinatesHaveBeenSet(_loc2_,this.frame);
         if(_loc3_.ItemId > 0)
         {
            if(_loc3_.IsFacingLeft == 1)
            {
               _loc2_.SWF.FaceLeft();
            }
            else if(_loc3_.IsFacingLeft == 0)
            {
               _loc2_.SWF.FaceRight();
            }
         }
         if(_loc3_.X != -1)
         {
            _loc4_ = secsPrFrame * 1000;
            this.m_objAnimationManager.move(_loc2_.SWF as UIComponent,_loc3_.X,_loc3_.Y,_loc4_,Transitions.LINEAR,RenderMethod.ENTER_FRAME);
            _loc5_ = this.getPropScale(_loc2_.SWF as UIComponent,_loc3_.Y);
            this.m_objAnimationManager.scale(_loc2_.SWF as UIComponent,_loc5_,_loc5_,_loc4_,Transitions.LINEAR,RenderMethod.ENTER_FRAME);
         }
      }
      
      public function getFlvCodePlay(param1:Number, param2:Number) : String
      {
         var _loc3_:Scene = this.movie.Scenes.getItemAt(this.selectedScene) as Scene;
         return this.movie.Guid + "/Scene" + _loc3_.SceneNumberSpeech.toString() + "/ActorId" + param1.toString() + "-Key" + param2.toString();
      }
      
      private function stop(param1:Number) : void
      {
         if(param1 >= this.scene.KeyFrameCount)
         {
            param1 = this.scene.KeyFrameCount - 1;
         }
         if(this.minuteTimer != null && Boolean(this.minuteTimer.running))
         {
            this.minuteTimer.stop();
         }
         var _loc2_:Number = 0;
         while(_loc2_ < this.movie.MovieActorRels.length)
         {
            if(this.speechBubbles[_loc2_] != null)
            {
               this.speechBubbles[_loc2_].visible = false;
            }
            _loc2_++;
         }
         if(this.backgroundSound != null && this.channel != null)
         {
            this.channel.stop();
         }
         this.soundPlaying = "";
         if(!isNaN(this.selectedScene) && !this.inPlayMode)
         {
            this.keyclick(param1,param1 != this.frame);
         }
         this.playEnable(true);
      }
      
      public function onTick(param1:TimerEvent) : void
      {
         var done:Function;
         var i:Number = NaN;
         var j:Number = NaN;
         var evt:TimerEvent = param1;
         if(this.frame == this.lastFrameToPlay - 2 && this.movie.State >= 100 && this.scene.SceneNumber == this.movie.Scenes.length - 1)
         {
            done = function():void
            {
               serverDone = true;
               if(!isPlaying)
               {
                  finishPlayMovie();
               }
            };
            this.serverDone = false;
            this.addMovieActorWatched(done);
         }
         if(this.frame == this.lastFrameToPlay)
         {
            if(!this.onlyPlaySelectedScene && this.frame == this.lastFrameToPlay && this.scene.SceneNumber + 1 < this.movie.Scenes.length)
            {
               this.playScene(this.scene.SceneNumber + 1,0);
            }
            else
            {
               if(this.frame >= this.scene.KeyFrameCount)
               {
                  this.stop(--this.frame);
               }
               this.isPlaying = false;
               if(this.inPlayMode)
               {
                  this.fadeOnEnd();
               }
               if(this.inPlayMode && (this.movie.State < 100 || this.serverDone))
               {
                  this.finishPlayMovie();
               }
            }
         }
         else
         {
            ++this.frame;
            this.setKeyCounters(this.frame);
            i = 0;
            while(i < this.movie.MovieActorRels.length)
            {
               if(this.isActorCurrentlyVisible(i))
               {
                  this.moveFigure(i);
               }
               i++;
            }
            if(this.frame < this.lastFrameToPlay)
            {
               if(this.scene.PropsInScene != null)
               {
                  j = 0;
                  while(j < this.scene.PropsInScene.length)
                  {
                     this.moveProp(j);
                     j++;
                  }
               }
            }
         }
      }
      
      private function fadeOnEnd() : void
      {
         this.endFade.play([this.endOverlay]);
         this.endOverlay.visible = true;
      }
      
      protected function finishPlayMovie() : void
      {
         var endFadeDone:Function = null;
         var rateMovie:RateMovieComponent = null;
         endFadeDone = function(param1:EffectEvent):void
         {
            Exit();
         };
         SoundManager.Instance().removeEventListener(MSP_Event.E_MUTE_CHANGED,this.toggleMute);
         if(this.showMovieFromUrl)
         {
            this.onStopButtonClicked();
            this.endOverlay.visible = false;
            return;
         }
         if(!this.movieAlreadyRatedByActor && ActorSession.getActorId() != this.movie.ActorId)
         {
            rateMovie = new RateMovieComponent();
            rateMovie.movie = this.movie;
            rateMovie.movieDetails = this.movieDetails;
            WindowStack.showSpriteAsViewStackable(rateMovie,450,170,WindowStack.Z_INFO);
         }
         else if(this.endFade.isPlaying)
         {
            this.endFade.addEventListener(EffectEvent.EFFECT_END,endFadeDone);
         }
         else
         {
            endFadeDone(null);
         }
      }
      
      private function addMovieActorWatched(param1:Function) : void
      {
         var movieWatched:Function;
         var movieService:IMovieService = null;
         var done:Function = param1;
         if(ActorSession.getActorId() != this.movie.ActorId && this.showMovieFromUrl == false)
         {
            movieWatched = function(param1:int, param2:int):void
            {
               var _loc9_:Object = null;
               var _loc3_:int = -1;
               var _loc4_:int = 0;
               var _loc5_:int = 1;
               var _loc6_:int = 2;
               var _loc7_:Boolean = true;
               var _loc8_:Boolean = true;
               if(param1 == _loc6_)
               {
                  _loc7_ = false;
                  _loc8_ = false;
               }
               else if(param1 == _loc4_)
               {
                  _loc7_ = true;
                  _loc8_ = true;
               }
               else if(param1 == _loc5_)
               {
                  _loc7_ = true;
                  _loc8_ = false;
               }
               FriendshipManager.getInstance().sendBasicEventToFriend(NotificationType.UPDATE.type,movie.ActorId);
               if(!_loc7_)
               {
                  _loc9_ = {
                     "actorId":ActorSession.loggedInActor.ActorId,
                     "actorName":ActorSession.loggedInActor.Name,
                     "movieId":movie.MovieId,
                     "type":"HAS_WATCHED_YOUR_MOVIE"
                  };
                  FriendshipManager.getInstance().sendLegacyObjectEventToFriend(_loc9_,movie.ActorId);
               }
               if(param2 > 0)
               {
                  AwardVisualizationController.spawnAwardsFromType(AwardVisualizationType.SCREEN_CENTER,0,param2,0);
               }
               movieAlreadyRatedByActor = _loc8_;
               done();
            };
            movieService = new MovieAMFService();
            movieService.movieWatched(this.movie.MovieId,ActorSession.getActorId(),movieWatched);
         }
         else
         {
            done();
         }
      }
      
      private function autoSave(param1:Event) : void
      {
         if(!this.movieChanged)
         {
            return;
         }
         if(this.movie.MovieId == 0)
         {
            this.movie.State = MovieStatuses.M_STATUS_PRIVATE;
         }
         this.saveButton.enabled = false;
         MSP_ToolTipManager.add(this.saveButton,"Autosaving");
         this.autoSaveTimer.stop();
         if(this.movie.Name == "")
         {
            this.movie.Name = AUTOSAVE_NAME;
         }
         this.saveMovieAuto();
      }
      
      private function btn_Share_ClickHandler() : void
      {
         var _loc1_:int = 320;
         var _loc2_:int = 200;
         var _loc3_:Point = this.shareWithButton.parent.localToGlobal(new Point(this.shareWithButton.x + this.shareWithButton.width - _loc2_,this.shareWithButton.y + this.shareWithButton.height));
         _loc3_ = Main.Instance.mainCanvas.globalToLocal(_loc3_);
         if(this.friendDisplayer == null)
         {
            this.friendDisplayer = new FriendDisplayer(this.movie.MovieId,EntityTypeType.MOVIE,this.movie.MovieId);
         }
         PopupUtils.showPopupDimensions(this.friendDisplayer as Container,_loc3_.x,_loc3_.y,_loc2_,_loc1_,Main.Instance.mainCanvas.applicationViewStack.mainView.popupCanvas);
      }
      
      private function sendAsMail() : void
      {
         var _loc1_:SendMovieAsMailPopup = new SendMovieAsMailPopup();
         _loc1_.movieId = this.movie.MovieId;
         OldPopupHandler.getInstance().showFakePopup(_loc1_,400,200,false);
      }
      
      private function editClick() : void
      {
         this.Exit();
         this.movieDetails.editclick();
      }
      
      private function report() : void
      {
         ReportUtils.reportEntity(this.movie.ActorId,InputLocations.LOC_MOVIE,this.movie.MovieId,this.movie.Name);
      }
      
      protected function saveclick(param1:Function) : void
      {
         var crispDone:Function = null;
         var allowExitCallBack:Function = param1;
         crispDone = function():void
         {
            saveHandling(allowExitCallBack);
         };
         if(!this.saveButton.enabled)
         {
            return;
         }
         this.saveButton.enabled = false;
         if(this.currentCallOut != null)
         {
            this.doneEditingBubble(this.currentCallOut,Number(this.currentCallOut.name),false,crispDone);
         }
         else
         {
            this.saveHandling(allowExitCallBack);
         }
      }
      
      private function saveHandling(param1:Function) : void
      {
         var namewindowComplete:Function;
         var enterMovieNameWindow:EnterMovieName = null;
         var allowExitCallBack:Function = param1;
         this.fadeOnEnd();
         this.stopAutoSaving();
         this.MakeMovieSnapshot();
         this._exitCallBackFunction = allowExitCallBack;
         if(this.movie.MovieId == 0 || this.movie.Name == AUTOSAVE_NAME)
         {
            namewindowComplete = function(param1:FlexEvent):void
            {
               enterMovieNameWindow.btnDelete.visible = enterMovieNameWindow.btnDelete.includeInLayout = false;
            };
            enterMovieNameWindow = new EnterMovieName();
            enterMovieNameWindow.addEventListener(FlexEvent.CREATION_COMPLETE,namewindowComplete);
            enterMovieNameWindow.addEventListener(EnterMovieName.OK_CLICKED,this.onEnterMovieNameOkClicked);
            enterMovieNameWindow.addEventListener(EnterMovieName.CANCEL_CLICKED,this.onEnterMovieNameCancelClicked);
            enterMovieNameWindow.addEventListener(Event.REMOVED_FROM_STAGE,this.onEnterMovieNameRemoved);
            enterMovieNameWindow.stateValue = this.movie.State;
            enterMovieNameWindow.inputTextValue = this.movie.filteredName;
            PopupUtils.showPopupCentered(enterMovieNameWindow,this,null,true);
            this.movieChanged = false;
         }
         else
         {
            this.saveMovie(allowExitCallBack,null);
         }
      }
      
      private function get serializedMovie() : Movie
      {
         this.saveActorClothesData();
         MovieUtil.calculateMovieComplexity(this.movie);
         return MovieUtil.generateMovieWithSerializedSceneArray(this.movie);
      }
      
      private function saveActorClothesData() : void
      {
         var _loc3_:MovieStar = null;
         var _loc1_:Object = {};
         _loc1_.ClothesData = [];
         _loc1_.MovieActorRels = this.movie.MovieActorRels;
         var _loc2_:Number = 0;
         while(_loc2_ < this.actorFigures.length)
         {
            if(this.actorFigures[_loc2_] != null)
            {
               _loc3_ = this.actorFigures[_loc2_];
               _loc1_.ClothesData[_loc2_] = _loc3_.getAppearanceData();
            }
            else
            {
               Alert.show("actorFigures[j] == null","Error saving clothes");
            }
            _loc2_++;
         }
         this.movie.ActorClothesData = SerializeUtils.serialize(_loc1_);
      }
      
      public function MakeMovieSnapshot() : void
      {
         this.movieSnapshot_big = this.captureFrame(72 / 2);
         this.movieSnapshot_small = this.captureFrame(72 / 5);
      }
      
      protected function captureFrame(param1:Number) : ByteArray
      {
         var ba:ByteArray = null;
         var parrentRefs:Array = null;
         var itemA:CallOut = null;
         var itemB:CallOut = null;
         var dpi:Number = param1;
         try
         {
            ba = ImageSnapshot.captureImage(this.movieContentView,dpi,new JPEGEncoder()).data;
         }
         catch(e:Object)
         {
            parrentRefs = [];
            for each(itemA in speechBubbles)
            {
               parrentRefs[itemA.name] = itemA.parent;
               itemA.parent.removeChild(itemA);
            }
            try
            {
               ba = ImageSnapshot.captureImage(movieContentView,36,new JPEGEncoder()).data;
            }
            catch(e:Object)
            {
               ba = new ByteArray();
            }
            for each(itemB in speechBubbles)
            {
               UIComponent(parrentRefs[itemB.name]).addChild(itemB);
            }
         }
         return ba;
      }
      
      public function saveMovie(param1:Function, param2:String) : void
      {
         var movieService:IMovieService;
         var movieSaved:Function = null;
         var allowExitCallBack:Function = param1;
         var userInputName:String = param2;
         movieSaved = function(param1:int, param2:int):void
         {
            var onSmallSnapshotSaved:Function = null;
            var onBigSnapshotSaved:Function = null;
            var safeTime:Function = null;
            var isNew:Boolean = false;
            var isSmallSnapshotSaved:Boolean = false;
            var isBigSnapshotSaved:Boolean = false;
            var newId:int = param1;
            var fameAwarded:int = param2;
            onSmallSnapshotSaved = function():void
            {
               isSmallSnapshotSaved = true;
               checkIfBothSaved();
            };
            onBigSnapshotSaved = function():void
            {
               isBigSnapshotSaved = true;
               checkIfBothSaved();
            };
            var checkIfBothSaved:Function = function():void
            {
               if(isBigSnapshotSaved && isSmallSnapshotSaved)
               {
                  setTimeout(safeTime,2000);
               }
            };
            safeTime = function():void
            {
               var _loc1_:MovieNotifier = null;
               if(movie.State == MovieStatuses.M_STATUS_PUBLIC && isNew)
               {
                  _loc1_ = new MovieNotifier();
                  _loc1_.notifyFriends(ActorSession.getActorId(),movie.MovieId);
               }
            };
            if(newId == -1)
            {
               Prompt.show(LocaleHelper.getInstance().getString("CANT_CREATE_ANOTHER_MOVIE_YET",null),"",Prompt.OK,null,null,null,Prompt.OK);
               saveView.visible = false;
               return;
            }
            MessageCommunicator.send(new QuestEvent(QuestEvent.SPECIAL_QUEST_UPDATE,{
               "action":QuestEvent.ACTION_SAVE_MOVIE,
               "increment":1
            }));
            isNew = movie.MovieId == 0;
            movie.MovieId = newId;
            isSmallSnapshotSaved = false;
            isBigSnapshotSaved = false;
            SnapshotUtils.saveSnapshot(ActorSession.getActorId(),EntityTypeType.EntityTypeAsString(EntityTypeType.MOVIE),newId,movieSnapshot_small,"jpg",onSmallSnapshotSaved);
            SnapshotUtils.saveSnapshot(ActorSession.getActorId(),EntityTypeType.EntityTypeAsString(EntityTypeType.MOVIE_BIG),newId,movieSnapshot_big,"jpg",onBigSnapshotSaved);
            if(fameAwarded > 0)
            {
               AwardVisualizationController.spawnAwardsFromType(AwardVisualizationType.SCREEN_CENTER,0,fameAwarded,0);
            }
            saveView.visible = false;
            doClose(allowExitCallBack);
         };
         this.saveView.visible = true;
         movieService = new MovieAMFService();
         movieService.saveMovie(this.serializedMovie,userInputName,this.movie.Scenes.source,ActorSession.getActorId(),movieSaved);
      }
      
      private function doClose(param1:Function) : void
      {
         this.movieChanged = false;
         if(param1 != null)
         {
            param1(true);
         }
         else
         {
            this.Exit();
         }
      }
      
      public function saveMovieAuto() : void
      {
         var movieSaved:Function = null;
         movieSaved = function(param1:Number, param2:int):void
         {
            movie.MovieId = param1;
            movieChanged = false;
            MSP_ToolTipManager.add(saveButton,MSPLocaleManagerWeb.getInstance().getString("SAVE_EXIT"));
            saveButton.enabled = true;
            autoSaveTimer.start();
         };
         var movieService:IMovieService = new MovieAMFService();
         movieService.saveMovie(this.serializedMovie,null,null,ActorSession.getActorId(),movieSaved);
      }
      
      public function keyFrameEdited() : void
      {
         if(this.selectedKey > this.lastEditedKeyFrame)
         {
            this.lastEditedKeyFrame = this.selectedKey;
         }
      }
      
      private function findLastEditedKeyFrame() : int
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc5_:KeyFrameActor = null;
         var _loc6_:Prop = null;
         var _loc7_:KeyFrameProp = null;
         var _loc3_:int = 0;
         var _loc4_:ArrayCollection = this.scene.KeyFrameActors;
         _loc1_ = int(_loc4_.length - 1);
         while(_loc1_ >= 0)
         {
            _loc5_ = _loc4_.getItemAt(_loc1_) as KeyFrameActor;
            if(_loc5_.KeyFrameNumber > _loc3_)
            {
               if(_loc5_.X != -1 || _loc5_.Animation != "" || _loc5_.IsFacingLeft != -1 || _loc5_.Face != "" || this.hasSpeech(_loc5_))
               {
                  _loc3_ = _loc5_.KeyFrameNumber;
                  break;
               }
            }
            _loc1_--;
         }
         if(this.scene.PropsInScene != null)
         {
            for each(_loc6_ in this.scene.PropsInScene)
            {
               _loc1_ = int(_loc6_.KeyFrameProps.length - 1);
               while(_loc1_ >= 0)
               {
                  _loc7_ = _loc6_.KeyFrameProps.getItemAt(_loc1_) as KeyFrameProp;
                  if(_loc7_.KeyFrameNumber > _loc3_ && _loc7_.X != -1)
                  {
                     _loc3_ = _loc5_.KeyFrameNumber;
                     break;
                  }
                  _loc1_--;
               }
            }
         }
         return _loc3_;
      }
      
      private function FindKeyFramePropWhereCoordinatesHaveBeenSet(param1:Prop, param2:Number) : KeyFrameProp
      {
         var _loc4_:KeyFrameProp = null;
         var _loc3_:Number = param2;
         while(_loc3_ >= 0)
         {
            _loc4_ = param1.KeyFrameProps.getItemAt(_loc3_) as KeyFrameProp;
            if(_loc4_.X != -1 && _loc4_.Y != -1)
            {
               return _loc4_;
            }
            _loc3_--;
         }
         return _loc4_;
      }
      
      private function FindKeyFrameActorWhereCoordinatesHaveBeenSet(param1:Number, param2:Number) : KeyFrameActor
      {
         var _loc5_:KeyFrameActor = null;
         var _loc3_:ArrayCollection = this.movie.Scenes.getItemAt(this.selectedScene).KeyFrameActors;
         var _loc4_:Number = _loc3_.length - 1;
         while(_loc4_ >= 0)
         {
            _loc5_ = _loc3_.getItemAt(_loc4_) as KeyFrameActor;
            if(_loc5_.FigureNumber == param1 && _loc5_.KeyFrameNumber <= param2)
            {
               if(_loc5_.X != -1 && _loc5_.Y != -1)
               {
                  return _loc5_;
               }
            }
            _loc4_--;
         }
         return _loc5_;
      }
      
      private function FindKeyFrameActorWhereIsFacingLeftHaveBeenSet(param1:Number, param2:Number) : KeyFrameActor
      {
         var _loc5_:KeyFrameActor = null;
         var _loc3_:ArrayCollection = this.movie.Scenes.getItemAt(this.selectedScene).KeyFrameActors;
         var _loc4_:Number = _loc3_.length - 1;
         while(_loc4_ >= 0)
         {
            _loc5_ = _loc3_.getItemAt(_loc4_) as KeyFrameActor;
            if(_loc5_.FigureNumber == param1 && _loc5_.KeyFrameNumber <= param2)
            {
               if(_loc5_.IsFacingLeft != -1)
               {
                  return _loc5_;
               }
            }
            _loc4_--;
         }
         return _loc5_;
      }
      
      public function FindKeyFrameActorWhereAnimationHaveBeenSet(param1:Number, param2:Number) : KeyFrameActor
      {
         var _loc5_:KeyFrameActor = null;
         var _loc3_:ArrayCollection = this.movie.Scenes.getItemAt(this.selectedScene).KeyFrameActors;
         var _loc4_:Number = _loc3_.length - 1;
         while(_loc4_ >= 0)
         {
            _loc5_ = _loc3_.getItemAt(_loc4_) as KeyFrameActor;
            if(_loc5_.FigureNumber == param1 && _loc5_.KeyFrameNumber <= param2)
            {
               if(_loc5_.Animation != "")
               {
                  return _loc5_;
               }
            }
            _loc4_--;
         }
         return _loc5_;
      }
      
      public function FindKeyFrameActorWhereFaceHaveBeenSet(param1:Number, param2:Number) : KeyFrameActor
      {
         var _loc5_:KeyFrameActor = null;
         var _loc3_:ArrayCollection = this.movie.Scenes.getItemAt(this.selectedScene).KeyFrameActors;
         var _loc4_:Number = _loc3_.length - 1;
         while(_loc4_ >= 0)
         {
            _loc5_ = _loc3_.getItemAt(_loc4_) as KeyFrameActor;
            if(_loc5_.FigureNumber == param1 && _loc5_.KeyFrameNumber <= param2)
            {
               if(_loc5_.Face != "")
               {
                  return _loc5_;
               }
            }
            _loc4_--;
         }
         return _loc5_;
      }
      
      private function goToFirstFrame() : void
      {
         if(this.selectedKey > 0)
         {
            this.keyclick(0);
            this.glow.play([this.labelFrameNumber,this.slider]);
         }
      }
      
      public function updateFrameCount() : void
      {
         this.slider.maximum = this.scene.KeyFrameCount;
      }
      
      private function updateKeyCounters() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Scene = null;
         if(this.inPlayMode)
         {
            this.sceneKeyFrameOffset = 0;
            _loc1_ = 0;
            while(_loc1_ < this.scene.SceneNumber)
            {
               _loc2_ = this.movie.Scenes.getItemAt(_loc1_) as Scene;
               this.sceneKeyFrameOffset += _loc2_.KeyFrameCount;
               _loc1_++;
            }
         }
         else
         {
            this.updateFrameCount();
         }
      }
      
      private function setKeyCounters(param1:int) : void
      {
         if(this.inPlayMode)
         {
            this.updateSecondCounter(param1);
         }
         else
         {
            this.setLabelFrameNumber(param1);
            this.setSliderValue(param1);
         }
      }
      
      private function updateSecondCounter(param1:int) : void
      {
         this.secondCounter.text = this.keyCounterToSecondString(this.sceneKeyFrameOffset + param1) + " / " + this.keyCounterToSecondString(this.movieTotalKeyFrameCount);
      }
      
      private function keyCounterToSecondString(param1:int) : String
      {
         var _loc2_:String = int(param1 / 30).toString() + ":";
         if(param1 % 30 < 5)
         {
            _loc2_ += "0";
         }
         return _loc2_ + (param1 * 2 % 60).toString();
      }
      
      private function setLabelFrameNumber(param1:int) : void
      {
         this.labelFrameNumber.text = param1 + 1 + "/" + this.scene.KeyFrameCount;
      }
      
      private function setSliderValue(param1:Number) : void
      {
         this.slider.value = param1 + 1;
      }
      
      public function keyclickSelected() : void
      {
         this.keyclick(this.selectedKey);
      }
      
      private function keyclick(param1:Number, param2:Boolean = true, param3:Boolean = true) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:KeyFrameActor = null;
         var _loc6_:KeyFrameActor = null;
         var _loc7_:KeyFrameActor = null;
         var _loc8_:KeyFrameActor = null;
         var _loc9_:KeyFrameActor = null;
         var _loc10_:MovieStar = null;
         var _loc11_:KeyFrameActor = null;
         var _loc12_:Boolean = false;
         var _loc13_:Number = NaN;
         var _loc14_:Prop = null;
         var _loc15_:KeyFrameProp = null;
         this.selectedKey = param1;
         this.setKeyCounters(param1);
         if(param2)
         {
            this.textDisplayedFromPreviousKeyFrame = new Array(this.movie.MovieActorRels.length);
            _loc4_ = 0;
            while(_loc4_ < this.movie.MovieActorRels.length)
            {
               if(this.actorFigures[_loc4_] != null && this.isActorCurrentlyVisible(_loc4_))
               {
                  _loc5_ = this.FindKeyFrameActorWhereCoordinatesHaveBeenSet(_loc4_,this.selectedKey);
                  if(_loc5_ != null)
                  {
                     this.actorFigures[_loc4_].move(_loc5_.X,_loc5_.Y);
                     this.actorFigures[_loc4_].scale = this.getFigureScaleFromScreenY(_loc5_.Y);
                  }
                  _loc6_ = this.getKeyFrameActor(_loc4_,this.selectedKey);
                  if(_loc6_ == null)
                  {
                     new DebugAlert().show("keyFrameActor == null for figure " + _loc4_ + " key " + this.selectedKey);
                  }
                  else
                  {
                     _loc7_ = this.FindKeyFrameActorWhereAnimationHaveBeenSet(_loc4_,this.selectedKey);
                     _loc8_ = this.FindKeyFrameActorWhereFaceHaveBeenSet(_loc4_,this.selectedKey);
                     _loc9_ = this.FindKeyFrameActorWhereIsFacingLeftHaveBeenSet(_loc4_,this.selectedKey);
                     _loc10_ = this.actorFigures[_loc4_] as MovieStar;
                     if(param3)
                     {
                        _loc10_.PlayAnimation(_loc7_.Animation,null,0,null,_loc7_.LastUpdated);
                     }
                     _loc10_.SetFaceExpression(_loc8_.Face);
                     if((_loc6_.Speech != 0 || this.hasSpeech(_loc6_)) && _loc6_.BubbleType != CalloutBubbleTypes.THOUGHTS)
                     {
                        _loc10_.talk();
                     }
                     else
                     {
                        _loc10_.StopTalk();
                     }
                     if(_loc9_.IsFacingLeft == 1)
                     {
                        _loc10_.FaceLeft();
                     }
                     else
                     {
                        _loc10_.FaceRight();
                     }
                     this.textDisplayedFromPreviousKeyFrame[_loc4_] = false;
                     if(this.hasSpeech(_loc6_))
                     {
                        CallOut(this.speechBubbles[_loc4_]).type = _loc6_.BubbleType;
                        this.speechBubbles[_loc4_].text = _loc6_.filteredLine;
                        this.speechBubbles[_loc4_].originalText = _loc6_.rawLine;
                        this.speechBubbles[_loc4_].visible = true;
                        if(!this._inPlayMode && !this.isPlaying)
                        {
                           (this.speechBubbles[_loc4_] as CallOut).editable = true;
                        }
                     }
                     else if(this.selectedKey - 1 >= 0)
                     {
                        _loc11_ = this.getKeyFrameActor(_loc4_,this.selectedKey - 1);
                        _loc12_ = this.hasSpeech(_loc11_);
                        if(_loc12_)
                        {
                           this.textDisplayedFromPreviousKeyFrame[_loc4_] = true;
                           this.speechBubbles[_loc4_].type = _loc11_.BubbleType;
                           this.speechBubbles[_loc4_].text = _loc11_.filteredLine;
                           this.speechBubbles[_loc4_].originalText = _loc11_.rawLine;
                           this.speechBubbles[_loc4_].visible = true;
                           (this.speechBubbles[_loc4_] as CallOut).editable = true;
                        }
                        else
                        {
                           this.speechBubbles[_loc4_].visible = false;
                        }
                     }
                     else
                     {
                        this.speechBubbles[_loc4_].visible = false;
                     }
                     if(_loc5_ != null)
                     {
                        this.placeSpeechBubble(_loc5_,_loc4_);
                     }
                  }
               }
               _loc4_++;
            }
            if(this.scene.PropsInScene != null)
            {
               _loc13_ = 0;
               while(_loc13_ < this.scene.PropsInScene.length)
               {
                  _loc14_ = this.scene.PropsInScene.getItemAt(_loc13_) as Prop;
                  if(_loc14_.SWF != null)
                  {
                     _loc15_ = this.FindKeyFramePropWhereCoordinatesHaveBeenSet(_loc14_,this.selectedKey);
                     if(_loc15_ != null)
                     {
                        _loc14_.SWF.move(_loc15_.X,_loc15_.Y);
                        this.setPropScale(_loc14_.SWF as UIComponent);
                        if(_loc14_.ItemId > 0)
                        {
                           if(_loc15_.IsFacingLeft == 1)
                           {
                              if(_loc14_.SWF is IFlippable)
                              {
                                 (_loc14_.SWF as IFlippable).FaceLeft();
                              }
                              else
                              {
                                 (_loc14_.SWF as FlippableLoader).FaceLeft();
                              }
                           }
                           else if(_loc14_.SWF is IFlippable)
                           {
                              (_loc14_.SWF as IFlippable).FaceRight();
                           }
                           else
                           {
                              (_loc14_.SWF as FlippableLoader).FaceRight();
                           }
                        }
                     }
                  }
                  _loc13_++;
               }
            }
            this.UpdateActorArea();
            this.moveCurrentMovieActorForm();
         }
      }
      
      private function hasSpeech(param1:KeyFrameActor) : Boolean
      {
         return !StringUtilities.isEmpty(param1.Line) || param1.Line == " ";
      }
      
      private function UpdateActorArea() : void
      {
         if(this.movieActorForm != null)
         {
            this.movieActorForm.selectedMovieStar = this.currentMovieStar;
            this.movieActorForm.selectedKey = this.selectedKey;
            this.movieActorForm.movieStudio = this;
            this.movieActorForm.movie = this.movie;
            this.movieActorForm.setLastPoint();
            this.movieActorForm.UpdateActorArea();
         }
      }
      
      public function onActorTick(param1:TimerEvent) : void
      {
         if(this.currentMovieStar != null)
         {
            this.movieActorForm.isClosed = false;
            this.moveCurrentMovieActorForm();
            this.UpdateActorArea();
            this.movieActorForm.visible = true;
         }
      }
      
      private function moveCurrentMovieActorForm() : void
      {
         this.moveMovieActorForm(this.currentMovieStar);
      }
      
      protected function moveMovieActorForm(param1:MovieStar) : void
      {
         var _loc2_:Number = NaN;
         if(param1 != null && this.movieActorForm != null)
         {
            this.currentMovieStar = param1;
            _loc2_ = param1.x + 260;
            if(_loc2_ > 1100)
            {
               _loc2_ = 1100;
            }
            this.movieActorForm.move(_loc2_ - 210,param1.y + 20);
            this.movieActorForm.selectedMovieStar = param1;
         }
      }
      
      private function mouseDown(param1:MouseEvent) : void
      {
         if(!this.isPlaying && !this.inPlayMode)
         {
            if(this.movieActorForm != null && !this.movieActorForm.isClosed)
            {
               this.movieActorForm.close();
               if(this.currentMovieStar != param1.currentTarget as MovieStar)
               {
                  this.openMovieActorForm = true;
               }
            }
            else
            {
               this.openMovieActorForm = true;
            }
            this.currentMovieStar = param1.currentTarget as MovieStar;
            this.movingActor = true;
            this.oldX = mouseX;
            this.oldY = mouseY;
         }
      }
      
      private function mainMouseDown() : void
      {
         this.stage.focus = null;
      }
      
      protected function mouseUp() : void
      {
         if(!this.inPlayMode && this.openMovieActorForm)
         {
            this.onActorTick(null);
         }
         this.openMovieActorForm = false;
         this.movingActor = false;
         if(this.needsToStopWalking)
         {
            this.needsToStopWalking = false;
         }
         this.dragItem = null;
      }
      
      private function mouseMove() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:KeyFrameActor = null;
         var _loc6_:KeyFrameActor = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:KeyFrameProp = null;
         if(this.instructorId == 0)
         {
            return;
         }
         if(this.movingActor)
         {
            this.movieChanged = true;
            this.openMovieActorForm = false;
            _loc1_ = this.oldX - mouseX;
            _loc2_ = this.oldY - mouseY;
            this.oldX = mouseX;
            this.oldY = mouseY;
            _loc3_ = this.currentMovieStar.x - _loc1_;
            _loc4_ = this.currentMovieStar.y - _loc2_;
            if(_loc3_ > 940)
            {
               _loc3_ = 940;
            }
            if(_loc4_ > 240)
            {
               _loc4_ = 240;
            }
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            _loc5_ = this.getKeyFrameActor(this.currentMovieStar.actorMovieNumber,this.selectedKey);
            _loc5_.X = _loc3_;
            _loc5_.Y = _loc4_;
            if(this.currentMovieStar.x > _loc3_)
            {
               this.currentMovieStar.FaceLeft();
               _loc5_.IsFacingLeft = 1;
            }
            else if(this.currentMovieStar.x < _loc3_)
            {
               this.currentMovieStar.FaceRight();
               _loc5_.IsFacingLeft = 0;
            }
            if(this.selectedKey > 0)
            {
               _loc6_ = this.getKeyFrameActor(this.currentMovieStar.actorMovieNumber,this.selectedKey - 1);
               if(_loc6_.Animation == "walk")
               {
                  if(_loc6_.X > this.currentMovieStar.x)
                  {
                     _loc6_.IsFacingLeft = 1;
                  }
                  else if(_loc6_.X < this.currentMovieStar.x)
                  {
                     _loc6_.IsFacingLeft = 0;
                  }
               }
            }
            if(!this.needsToStopWalking && this.setAutoWalk(this.currentMovieStar.actorMovieNumber,this.selectedKey))
            {
               this.currentMovieStar.PlayAnimation("walk");
               this.needsToStopWalking = true;
            }
            else if(!this.needsToStopWalking && this.playLastSetAnimation(this.currentMovieStar,this.selectedKey))
            {
               this.needsToStopWalking = true;
            }
            this.currentMovieStar.scale = this.getFigureScaleFromScreenY(_loc4_);
            this.currentMovieStar.move(_loc3_,_loc4_);
            this.placeSpeechBubble(_loc5_,this.currentMovieStar.actorMovieNumber);
            this.moveCurrentMovieActorForm();
         }
         else if(this.dragItem != null)
         {
            this.movieChanged = true;
            _loc7_ = this.lastDragX - mouseX;
            _loc8_ = this.lastDragY - mouseY;
            _loc9_ = this.dragItem.x - _loc7_;
            _loc10_ = this.dragItem.y - _loc8_;
            _loc11_ = this.currentProp.KeyFrameProps.getItemAt(this.selectedKey) as KeyFrameProp;
            _loc11_.X = _loc9_;
            _loc11_.Y = _loc10_;
            if(!(this.dragItem is ClickItem))
            {
               if(this.dragItem.x > _loc9_)
               {
                  if(this.dragItem is IFlippable)
                  {
                     (this.dragItem as IFlippable).FaceLeft();
                  }
                  else
                  {
                     (this.dragItem as FlippableLoader).FaceLeft();
                  }
                  _loc11_.IsFacingLeft = 1;
               }
               else if(this.dragItem.x < _loc9_)
               {
                  if(this.dragItem is IFlippable)
                  {
                     (this.dragItem as IFlippable).FaceRight();
                  }
                  else
                  {
                     (this.dragItem as FlippableLoader).FaceRight();
                  }
                  _loc11_.IsFacingLeft = 0;
               }
            }
            this.lastDragX = mouseX;
            this.lastDragY = mouseY;
            this.setPropScale(this.dragItem);
            this.dragItem.move(_loc9_,_loc10_);
         }
         this.keyFrameEdited();
      }
      
      private function playLastSetAnimation(param1:MovieStar, param2:int) : Boolean
      {
         if(param2 == 0)
         {
            return false;
         }
         var _loc3_:KeyFrameActor = this.FindKeyFrameActorWhereAnimationHaveBeenSet(param1.actorMovieNumber,param2 - 1);
         if(_loc3_.Animation == "walk")
         {
            param1.PlayAnimation(_loc3_.Animation,null,0,null,_loc3_.LastUpdated);
            return true;
         }
         return false;
      }
      
      private function setAutoWalk(param1:Number, param2:int) : Boolean
      {
         var _loc5_:KeyFrameActor = null;
         if(param2 == 0)
         {
            return false;
         }
         var _loc3_:KeyFrameActor = this.getKeyFrameActor(param1,param2 - 1);
         var _loc4_:KeyFrameActor = this.getKeyFrameActor(param1,param2);
         if(_loc3_.X != _loc4_.X || _loc3_.Y != _loc4_.Y)
         {
            _loc5_ = this.FindKeyFrameActorWhereAnimationHaveBeenSet(param1,param2 - 1);
            if(_loc5_.Animation == "stand")
            {
               _loc3_.Animation = "walk";
               if(_loc4_.Animation == "")
               {
                  _loc4_.Animation = "stand";
               }
               return true;
            }
         }
         return false;
      }
      
      private function SortFiguresAccordingToY() : void
      {
         PropSorter.SortFiguresAccordingToY(this.canvas);
      }
      
      private function addScene() : void
      {
         if(this.movie.Scenes.length >= 10)
         {
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("MAXIMUM_5"),MSPLocaleManagerWeb.getInstance().getString("TOO_MANY_SCENES"));
            return;
         }
         this.movieChanged = true;
         this.scene = new Scene();
         this.scene.SceneId = 0;
         this.scene.SceneNumber = this.movie.Scenes.length;
         ++this.sceneNumberSpeech;
         this.scene.SceneNumberSpeech = this.sceneNumberSpeech;
         this.scene.MovieId = this.movie.MovieId;
         this.scene.KeyFrameCount = this.DEFAULT_NUMBER_OF_KEYS;
         this.scene.SecsPrFrame = secsPrFrame;
         this.scene.Sound = "Guitar/Bullet Proof.mp3";
         this.scene.Background = "hallway_day.jpg";
         this.scene.KeyFrameActors = new ArrayCollection();
         this.movie.Scenes.addItem(this.scene);
         var _loc1_:Number = 0;
         while(_loc1_ < this.movie.MovieActorRels.length)
         {
            this.initKeyFramesForOneScene(this.scene,_loc1_,true);
            _loc1_++;
         }
         this.scene.PropsInScene = new ArrayCollection();
         var _loc2_:SceneListCanvas = this.addSceneListItem(this.scene.Background,this.scene.LastUpdated,this.scene.Sound,this.movie.Scenes.length - 1,this.scene.KeyFrameCount,this.scene.Manuscript);
         this.markCurrentScene(_loc2_);
         dispatchEvent(new Event(SCENE_ADDED));
      }
      
      private function addSceneListItem(param1:String, param2:Date, param3:String, param4:Number, param5:Number, param6:String) : SceneListCanvas
      {
         var _loc7_:SceneListCanvas = new SceneListCanvas();
         _loc7_.movie = this.movie;
         _loc7_.moviestudio = this;
         _loc7_.addEventListener(SceneListCanvas.DELETE_SCENE,this.deleteScene);
         _loc7_.addEventListener(SceneListCanvas.SCENE_UP,this.sceneUp);
         _loc7_.addEventListener(SceneListCanvas.SCENE_DOWN,this.sceneDown);
         _loc7_.addEventListener(SceneListCanvas.SOUND_CHANGED,this.soundChanged);
         _loc7_.addEventListener(SceneListCanvas.FRAMECOUNT_CHANGED,this.frameCountChanged);
         _loc7_.addEventListener(SceneListCanvas.MANUSCRIPT_CHANGED,this.manuscriptChanged);
         _loc7_.height = 350;
         _loc7_.width = 170;
         _loc7_.sceneId = param4;
         _loc7_.setBackground(param1,param2);
         _loc7_.setSound(param3);
         _loc7_.setFrameCount(param5);
         if(param6 != null)
         {
            _loc7_.setManuscript(param6);
         }
         this.vboxScenes.addChild(_loc7_);
         return _loc7_;
      }
      
      public function sceneSelected(param1:Event) : void
      {
         this.markCurrentScene(param1.currentTarget.parent as SceneListCanvas);
      }
      
      private function markCurrentScene(param1:SceneListCanvas, param2:int = 0) : void
      {
         var _loc6_:SceneListCanvas = null;
         var _loc7_:URLRequest = null;
         var _loc8_:DisplayObject = null;
         var _loc9_:int = 0;
         var _loc10_:Prop = null;
         var _loc11_:KeyFrameProp = null;
         if(param1.sceneId + 1 > this.movie.Scenes.length)
         {
            return;
         }
         var _loc3_:Boolean = this.selectedScene != param1.sceneId;
         this.selectedScene = param1.sceneId;
         var _loc4_:Number = 0;
         while(_loc4_ < this.vboxScenes.getChildren().length)
         {
            _loc6_ = this.vboxScenes.getChildAt(_loc4_) as SceneListCanvas;
            _loc6_.setSelected(false,this.instructorId == 0);
            _loc4_++;
         }
         param1.setSelected(true,this.instructorId == 0);
         this.scene = this.movie.Scenes.getItemAt(this.selectedScene) as Scene;
         this.textNbrFrames.text = (this.scene.KeyFrameCount - 2).toString();
         this.setBackground(this.scene.Background,this.scene.BackgroundId,this.scene.LastUpdated);
         if(this.backgroundSound != null && this.channel != null && this.scene.Sound == "")
         {
            this.channel.stop();
         }
         else if(this.scene.Sound != this.soundPlaying)
         {
            if(this.backgroundSound != null && this.channel != null)
            {
               this.channel.stop();
            }
            if(this.scene.Sound != null && this.scene.Sound != "")
            {
               _loc7_ = new URLRequest(new ContentUrl(this.scene.Sound,ContentUrl.MUSIC).toString());
               this.backgroundSound = new Sound(_loc7_);
            }
            else
            {
               this.backgroundSound = null;
            }
         }
         var _loc5_:* = int(this.sortOrder.length - 1);
         while(_loc5_ >= 0)
         {
            if(!(this.sortOrder[_loc5_] is MovieStar))
            {
               _loc8_ = this.sortOrder[_loc5_] as DisplayObject;
               this.sortOrder.splice(_loc5_,1);
               _loc8_.parent.removeChild(_loc8_);
            }
            _loc5_--;
         }
         if(this.scene.PropsInScene != null)
         {
            _loc9_ = 0;
            while(_loc9_ < this.scene.PropsInScene.length)
            {
               _loc10_ = this.scene.PropsInScene.getItemAt(_loc9_) as Prop;
               _loc11_ = _loc10_.KeyFrameProps.getItemAt(0) as KeyFrameProp;
               if(_loc10_.SWF != null)
               {
                  this.displayPropInScene(_loc10_.SWF as UIComponent,_loc11_.X,_loc11_.Y);
               }
               _loc9_++;
            }
         }
         this.lastEditedKeyFrame = this.findLastEditedKeyFrame();
         this.updateKeyCounters();
         this.updateActorsVisibility();
         if(this.numberOfActorFiguresToUpdate <= 0)
         {
            this.keyclick(param2);
         }
         MovieStudioController.getInstance().updateMarkEditMovieInFriendList();
         if(_loc3_)
         {
            dispatchEvent(new Event(SCENE_CHANGED));
         }
      }
      
      private function deleteScene(param1:Event = null) : void
      {
         var _loc2_:SceneListCanvas = param1.currentTarget as SceneListCanvas;
         this.scene = this.movie.Scenes.getItemAt(_loc2_.sceneId) as Scene;
         if(this.movie.Scenes.length == 1)
         {
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("ATLEAST_ONE_SCENE"),MSPLocaleManagerWeb.getInstance().getString("TOO_FEW_SCENES"));
            return;
         }
         this.movieChanged = true;
         this.vboxScenes.removeChildAt(this.scene.SceneNumber);
         this.movie.Scenes.removeItemAt(this.scene.SceneNumber);
         var _loc3_:Number = 0;
         while(_loc3_ < this.movie.Scenes.length)
         {
            this.movie.Scenes.getItemAt(_loc3_).SceneNumber = _loc3_;
            (this.vboxScenes.getChildAt(_loc3_) as SceneListCanvas).sceneId = _loc3_;
            _loc3_++;
         }
         var _loc4_:Number = this.scene.SceneNumber;
         if(_loc4_ > 0)
         {
            _loc4_--;
         }
         this.scene = this.movie.Scenes.getItemAt(_loc4_) as Scene;
         this.markCurrentScene(this.vboxScenes.getChildAt(_loc4_) as SceneListCanvas);
      }
      
      private function sceneUp(param1:Event = null) : void
      {
         var _loc2_:SceneListCanvas = param1.currentTarget as SceneListCanvas;
         this.scene = this.movie.Scenes.getItemAt(_loc2_.sceneId) as Scene;
         if(this.scene.SceneNumber == 0)
         {
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("CANNOT_MOVE_UP"),MSPLocaleManagerWeb.getInstance().getString("MOVE_SCENE"));
            return;
         }
         this.movieChanged = true;
         this.swapScenes(this.scene.SceneNumber);
      }
      
      private function sceneDown(param1:Event = null) : void
      {
         var _loc2_:SceneListCanvas = param1.currentTarget as SceneListCanvas;
         this.scene = this.movie.Scenes.getItemAt(_loc2_.sceneId) as Scene;
         if(this.scene.SceneNumber + 1 == this.movie.Scenes.length)
         {
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("CANNOT_MOVE_DOWN"),MSPLocaleManagerWeb.getInstance().getString("MOVE_SCENE"));
            return;
         }
         this.movieChanged = true;
         this.swapScenes(this.scene.SceneNumber + 1);
      }
      
      private function swapScenes(param1:Number) : void
      {
         var _loc2_:Number = param1;
         var _loc3_:Scene = this.movie.Scenes.getItemAt(_loc2_) as Scene;
         var _loc4_:Scene = this.movie.Scenes.getItemAt(_loc2_ - 1) as Scene;
         this.movie.Scenes.setItemAt(_loc3_,_loc2_ - 1);
         this.movie.Scenes.setItemAt(_loc4_,_loc2_);
         _loc3_.SceneNumber = _loc2_ - 1;
         _loc4_.SceneNumber = _loc2_;
         var _loc5_:SceneListCanvas = this.vboxScenes.getChildAt(_loc2_) as SceneListCanvas;
         var _loc6_:SceneListCanvas = this.vboxScenes.getChildAt(_loc2_ - 1) as SceneListCanvas;
         this.vboxScenes.setChildIndex(_loc5_,_loc2_ - 1);
         this.vboxScenes.setChildIndex(_loc6_,_loc2_);
         _loc5_.sceneId = _loc2_ - 1;
         _loc6_.sceneId = _loc2_;
         this.markCurrentScene(this.vboxScenes.getChildAt(this.scene.SceneNumber) as SceneListCanvas);
      }
      
      private function newMovie() : void
      {
         this.clearMovie();
         this.movie = new Movie();
         this.movie.State = MovieStatuses.M_STATUS_PUBLIC;
         this.movie.Name = "";
         this.movie.MovieId = 0;
         this.movie.ActorId = this.instructorId;
         this.movie.WatchedActorCount = 0;
         this.movie.WatchedTotalCount = 0;
         this.movie.RatedCount = 0;
         this.movie.RatedTotalScore = 0;
         this.movie.AverageRating = 0;
         this.movie.StarCoinsEarned = 0;
         this.movie.CreatedDate = new Date(2000,1,1);
         this.movie.PublishedDate = new Date(2000,1,1);
         this.movie.CompetitionDate = new Date(2000,1,1);
         this.movie.MovieActorRels = new ArrayCollection();
         this.movie.Scenes = new ArrayCollection();
         this.addScene();
         this.movieChanged = false;
         this.updateFrameCount();
         this.movieActorListFormUpdateFriends();
         MovieStudioController.getInstance().markEditMovieInFriendList(this.movie);
      }
      
      private function clearMovie() : void
      {
         this.movieChanged = false;
         this.currentMovieStar = null;
         this.sortOrder = new Array();
         this.speechBubbles = new Array();
         this.canvas.removeAllChildren();
         this.backgroundSwfExisting = null;
         this.backgroundSound = null;
         this.sceneNumberSpeech = -1;
         this.vboxScenes.removeAllChildren();
         this.endOverlay.visible = false;
      }
      
      public function loadMovie(param1:int) : void
      {
         this.loadView.visible = true;
         this.clearMovie();
         var _loc2_:IMovieService = new MovieAMFService();
         _loc2_.getMovieById(param1,this.movieLoaded);
      }
      
      public function loadMovieByGuid(param1:String) : void
      {
         var dependenciesLoadedCallback:Function = null;
         var movieGuid:String = param1;
         dependenciesLoadedCallback = function():void
         {
            MovieAMFService.getMovieByGuid(movieGuid,movieLoaded);
         };
         this.loadView.visible = true;
         this.clearMovie();
         this.loadPreLoginDependencies(dependenciesLoadedCallback);
      }
      
      private function loadPreLoginDependencies(param1:Function) : void
      {
         var templateListReady:Function = null;
         var callback:Function = param1;
         templateListReady = function(param1:Array):void
         {
            var _loc2_:BonsterTemplateObject = null;
            for each(_loc2_ in param1)
            {
               BonsterTemplateCache.instance.setTemplate(_loc2_);
            }
            callback();
         };
         var bonsterService:IBonsterService = new BonsterAMFService();
         bonsterService.GetBonsterTemplateList(templateListReady);
      }
      
      private function movieLoaded(param1:Movie) : void
      {
         var onDone:Function = null;
         var InstructorMovieStarLoaded:Function = null;
         var loadedMovie:Movie = param1;
         onDone = function():void
         {
            var _loc1_:MovieStar = null;
            if(movieDetails != null && movieDetails._movieStar != null)
            {
               InstructorMovieStarLoaded(movieDetails._movieStar);
            }
            else if(movieDetails != null)
            {
               movieDetails._movieStar = new MovieStar();
               movieDetails._movieStar.Load(movie.ActorId,InstructorMovieStarLoaded,1);
            }
            else
            {
               _loc1_ = new MovieStar();
               _loc1_.Load(movie.ActorId,InstructorMovieStarLoaded,1);
            }
         };
         InstructorMovieStarLoaded = function(param1:MovieStar):void
         {
            param1.scaleX = 0.6;
            param1.scaleY = 0.6;
            param1.move(110,100);
            loadView.addChild(param1);
            labelActorName.text = param1.actor.Name;
            loadScenes(movie);
            loadPropsForMovie();
            if(!inPlayMode && instructorId != 0)
            {
               MovieStudioController.getInstance().markEditMovieInFriendList(movie);
            }
         };
         this.movie = loadedMovie;
         if(this.movie.MovieData != null)
         {
            this.movie.Scenes = SerializeUtils.deserialize(this.movie.MovieData) as ArrayCollection;
         }
         this.labelMovieName.text = this.movie.filteredName;
         this.movieName.text = this.movie.filteredName;
         new LastEditManager(onDone).loadMovieScenes(this.movie.Scenes);
      }
      
      public function playMovie(param1:int) : void
      {
         this.prepareMovieLoad();
         this.loadMovie(param1);
         addEventListener(Event.ENTER_FRAME,this.HandleEnterFrame);
      }
      
      public function playMovieFromGuid(param1:String) : void
      {
         this.prepareMovieLoad();
         this.loadMovieByGuid(param1);
         addEventListener(Event.ENTER_FRAME,this.HandleEnterFrame);
      }
      
      public function playMovieAlreadyLoaded(param1:Movie) : void
      {
         this.movie = param1;
         this.prepareMovieLoad();
         this.clearMovie();
         this.movieLoaded(param1);
         addEventListener(Event.ENTER_FRAME,this.HandleEnterFrame);
      }
      
      private function prepareMovieLoad() : void
      {
         this.loadView.visible = true;
         this.instructorId = 0;
         MovieStudioController.getInstance().markEditMovieInFriendList(null);
         this.movieChanged = false;
         this.setPlayMode(true);
      }
      
      public function editMovieInstructor(param1:Movie) : void
      {
         this.loadView.visible = true;
         this.instructorId = ActorSession.getActorId();
         this.speechActorId = 0;
         this.movieChanged = false;
         this.saveButton.visible = true;
         this.helpButton.visible = true;
         this.editScenesButton.visible = true;
         this.editPropsButton.visible = true;
         this.editActorsButton.visible = true;
         this.editBackgroundButton.visible = true;
         this.editMusicButton.visible = true;
         this.setPlayMode(false);
         this.clearMovie();
         this.movieLoaded(param1);
         addEventListener(Event.ENTER_FRAME,this.HandleEnterFrame);
         this.startAutoSaving();
      }
      
      public function startAutoSaving() : void
      {
         if(this.autoSaveTimer == null)
         {
            this.autoSaveTimer = new Timer(600000,99999999);
            this.autoSaveTimer.addEventListener(TimerEvent.TIMER,this.autoSave);
         }
         if(!this.autoSaveTimer.running)
         {
            this.autoSaveTimer.start();
         }
      }
      
      private function stopAutoSaving() : void
      {
         if(this.autoSaveTimer != null)
         {
            this.autoSaveTimer.stop();
         }
      }
      
      public function newMovie2(param1:Number) : void
      {
         this.movieChanged = false;
         this.setPlayMode(false);
         this.saveButton.enabled = true;
         this.editScenesButton.enabled = true;
         this.editPropsButton.enabled = true;
         this.editActorsButton.enabled = true;
         this.editBackgroundButton.visible = true;
         this.editMusicButton.visible = true;
         this.helpButton.enabled = true;
         this.saveButton.visible = true;
         this.editScenesButton.visible = true;
         this.editPropsButton.visible = true;
         this.editActorsButton.visible = true;
         this.editBackgroundButton.visible = true;
         this.editMusicButton.visible = true;
         this.helpButton.enabled = true;
         this.instructorId = param1;
         this.newMovie();
         this.loadView.visible = false;
         this.setSpeecRecordMode(false);
         this.movieActorForm.setInstructorMode();
         addEventListener(Event.ENTER_FRAME,this.HandleEnterFrame);
         this.addNewActorToScene(ActorSession.getActorId());
         MovieStudioController.getInstance().updateMarkEditMovieInFriendList();
         this.canvas.scrollRect = new Rectangle(0,0,this.canvas.width,this.canvas.height);
         this.startAutoSaving();
      }
      
      public function onCreationComplete() : void
      {
         SoundManager.Instance().addEventListener(MSP_Event.E_MUTE_CHANGED,this.toggleMute);
         MSP_ToolTipManager.add(this.addSceneButton,"Add a new scene to the movie");
         MSP_ToolTipManager.add(this.textNbrFrames,"The number of frames in the selected scene");
         MSP_ToolTipManager.add(this.stopBtn,MSPLocaleManagerWeb.getInstance().getString("STOP_MOVIE"));
         MSP_ToolTipManager.add(this.play,MSPLocaleManagerWeb.getInstance().getString("PLAY_MOVIE"));
         MSP_ToolTipManager.add(this.saveButton,MSPLocaleManagerWeb.getInstance().getString("SAVE_EXIT_MOVIESTUDIO"));
         MSP_ToolTipManager.add(this.helpButton,MSPLocaleManagerWeb.getInstance().getString("HELP"));
         MSP_ToolTipManager.add(this.exitButton,MSPLocaleManagerWeb.getInstance().getString("EXIT_MOVIESTUDIO"));
         MSP_ToolTipManager.add(this.editActorsButton,MSPLocaleManagerWeb.getInstance().getString("MOVIESTUDIO_EDIT_ACTORS"));
         MSP_ToolTipManager.add(this.editPropsButton,MSPLocaleManagerWeb.getInstance().getString("MOVIESTUDIO_EDIT_PROPS"));
         MSP_ToolTipManager.add(this.editScenesButton,MSPLocaleManagerWeb.getInstance().getString("MOVIESTUDIO_EDIT_SCENES"));
         MSP_ToolTipManager.add(this.editBackgroundButton,MSPLocaleManagerWeb.getInstance().getString("MOVIESTUDIO_EDIT_BACKGROUND"));
         MSP_ToolTipManager.add(this.editMusicButton,MSPLocaleManagerWeb.getInstance().getString("MOVIESTUDIO_EDIT_MUSIC"));
         if(!this.topControlButtonsAdded)
         {
            this.topControls.addChild(this.helpButton);
            this.topControls.addChild(this.saveButton);
            this.topControls.addChild(this.editButton);
            this.topControls.addChild(this.reportButton);
            this.topControls.addChild(this.sendMailButton);
            this.topControls.addChild(this.shareWithButton);
            this.topControls.addChild(this.exitButton);
            this.topControlButtonsAdded = true;
         }
         var _loc1_:Number = ApplicationReference.getApplicationScale();
         FlattenUtilities.flattenSprite(this.helpButton as Sprite,_loc1_,true);
         FlattenUtilities.flattenSprite(this.saveButton as Sprite,_loc1_,true);
         FlattenUtilities.flattenSprite(this.editButton as Sprite,_loc1_,true);
         FlattenUtilities.flattenSprite(this.sendMailButton as Sprite,_loc1_,true);
         FlattenUtilities.flattenSprite(this.shareWithButton as Sprite,_loc1_,true);
         FlattenUtilities.flattenSprite(this.exitButton as Sprite,_loc1_,true);
         FlattenUtilities.flattenSprite(this.stopBtn as Sprite,_loc1_,true);
         FlattenUtilities.flattenSprite(this.editActorsButton as Sprite,_loc1_,true);
         FlattenUtilities.flattenSprite(this.editPropsButton as Sprite,_loc1_,true);
         FlattenUtilities.flattenSprite(this.editScenesButton as Sprite,_loc1_,true);
         FlattenUtilities.flattenSprite(this.editBackgroundButton as Sprite,_loc1_,true);
         FlattenUtilities.flattenSprite(this.editMusicButton as Sprite,_loc1_,true);
         this.mDelayedValue = -1;
      }
      
      public function movieRated(param1:int) : void
      {
      }
      
      protected function HandleEnterFrame(param1:Event) : void
      {
         this.SortFiguresAccordingToY();
      }
      
      public function removeNewActorFromScene(param1:Number) : void
      {
         var _loc4_:MovieActorRel = null;
         var _loc5_:Number = NaN;
         var _loc2_:Number = -1;
         var _loc3_:Number = 0;
         while(_loc3_ < this.movie.MovieActorRels.length)
         {
            _loc4_ = this.movie.MovieActorRels.getItemAt(_loc3_) as MovieActorRel;
            if(param1 == _loc4_.ActorId)
            {
               _loc2_ = _loc3_;
               _loc5_ = _loc4_.FigureNumber;
               if(_loc5_ != _loc2_)
               {
                  new DebugAlert().show("Error. The figureNumber is incorrect.");
               }
            }
            _loc3_++;
         }
         if(_loc2_ == -1)
         {
            new DebugAlert().show("Error. The actor is not part of the movie.");
         }
         this.movieChanged = true;
         this.setActorVisibilityInScene(_loc2_,false);
         this.makeActorInvisible(_loc2_);
         this.currentMovieStar = null;
         if(this.isActorInvisibleInAllScenes(_loc2_))
         {
            this.removeActorFromMovie(_loc2_);
         }
      }
      
      private function removeActorFromMovie(param1:Number) : void
      {
         var _loc5_:CallOut = null;
         var _loc6_:Scene = null;
         var _loc7_:Number = NaN;
         var _loc8_:KeyFrameActor = null;
         var _loc9_:MovieActorRel = null;
         var _loc10_:MovieStar = null;
         var _loc11_:Number = NaN;
         var _loc12_:Scene = null;
         var _loc13_:Number = NaN;
         var _loc14_:KeyFrameActor = null;
         this.movie.MovieActorRels.removeItemAt(param1);
         this.actorFigures.splice(param1,1);
         this.speechBubbles.splice(param1,1);
         var _loc2_:int = 0;
         while(_loc2_ < this.speechBubbles.length)
         {
            _loc5_ = this.speechBubbles[_loc2_];
            _loc5_.name = _loc2_.toString();
            _loc2_++;
         }
         var _loc3_:Number = 0;
         while(_loc3_ < this.movie.Scenes.length)
         {
            _loc6_ = this.movie.Scenes.getItemAt(_loc3_) as Scene;
            _loc7_ = _loc6_.KeyFrameActors.length - 1;
            while(_loc7_ >= 0)
            {
               _loc8_ = _loc6_.KeyFrameActors.getItemAt(_loc7_) as KeyFrameActor;
               if(_loc8_.FigureNumber == param1)
               {
                  _loc6_.KeyFrameActors.removeItemAt(_loc7_);
               }
               _loc7_--;
            }
            _loc3_++;
         }
         var _loc4_:Number = param1;
         while(_loc4_ < this.movie.MovieActorRels.length)
         {
            _loc9_ = this.movie.MovieActorRels.getItemAt(_loc4_) as MovieActorRel;
            if(_loc9_.FigureNumber != _loc4_ + 1)
            {
               Alert.show("Error. The figureNumber is incorrect.","Error");
            }
            _loc9_.FigureNumber = _loc4_;
            _loc10_ = this.actorFigures[_loc4_] as MovieStar;
            _loc10_.actorMovieNumber = _loc4_;
            _loc11_ = 0;
            while(_loc11_ < this.movie.Scenes.length)
            {
               _loc12_ = this.movie.Scenes.getItemAt(_loc11_) as Scene;
               _loc13_ = _loc12_.KeyFrameActors.length - 1;
               while(_loc13_ >= 0)
               {
                  _loc14_ = _loc12_.KeyFrameActors.getItemAt(_loc13_) as KeyFrameActor;
                  if(_loc14_.FigureNumber == _loc4_ + 1)
                  {
                     _loc14_.FigureNumber = _loc4_;
                  }
                  _loc13_--;
               }
               _loc11_++;
            }
            _loc4_++;
         }
      }
      
      public function addNewActorToScene(param1:Number) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:MovieActorRel = this.getMovieActorRelForActor(param1);
         if(_loc3_ != null)
         {
            _loc2_ = true;
            if(!this.loadActorPerScene)
            {
               Prompt.show(MSPLocaleManagerWeb.getInstance().getString("ACTOR_ALREADY_IN"),MSPLocaleManagerWeb.getInstance().getString("CANNOT_ADD_ACTOR"));
               return;
            }
            if(this.isActorCurrentlyVisible(_loc3_.FigureNumber))
            {
               Prompt.show(MSPLocaleManagerWeb.getInstance().getString("ACTOR_ALREADY_IN_SCENE"),MSPLocaleManagerWeb.getInstance().getString("CANNOT_ADD_ACTOR"));
               return;
            }
         }
         if(!_loc2_)
         {
            if(this.movie.MovieActorRels.length >= this.MAX_ACTORS_IN_MOVIE && !ActorSession.isVip)
            {
               VIPOnlyPopUp.Show(MSPLocaleManagerWeb.getInstance().getString("MAX_ACTORS_NON_VIP"));
               return;
            }
            if(this.movie.MovieActorRels.length >= this.MAX_ACTORS_IN_MOVIE_VIP)
            {
               Prompt.show(MSPLocaleManagerWeb.getInstance().getString("MAX_6_ACTORS"),MSPLocaleManagerWeb.getInstance().getString("CANNOT_ADD_ACTORS"));
               return;
            }
            this.addNewActorToMovie(param1);
         }
         else
         {
            this.setActorVisibilityInScene(_loc3_.FigureNumber,true);
            this.makeActorVisible(_loc3_.FigureNumber);
            MovieStar(this.actorFigures[_loc3_.FigureNumber]).PlayAnimation("stand");
         }
         this.goToFirstFrame();
      }
      
      private function getMovieActorRelForActor(param1:Number) : MovieActorRel
      {
         var _loc3_:MovieActorRel = null;
         var _loc2_:Number = 0;
         while(_loc2_ < this.movie.MovieActorRels.length)
         {
            _loc3_ = this.movie.MovieActorRels.getItemAt(_loc2_) as MovieActorRel;
            if(param1 == _loc3_.ActorId)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      private function addNewActorToMovie(param1:Number) : void
      {
         this.movieChanged = true;
         ++this.numberOfActorFiguresToUpdate;
         var _loc2_:MovieActorRel = new MovieActorRel();
         this.movie.MovieActorRels.addItem(_loc2_);
         _loc2_.ActorId = param1;
         _loc2_.FigureNumber = this.movie.MovieActorRels.length - 1;
         _loc2_.MovieActorRelId = 0;
         _loc2_.MovieId = this.movie.MovieId;
         _loc2_.State = 0;
         this.initKeyFrames(_loc2_.FigureNumber);
         var _loc3_:Number = this.movie.MovieActorRels.length - 1;
         this.loadActor(param1,_loc3_,true,true);
      }
      
      protected function loadNewActorDone() : void
      {
         this.keyclick(this.selectedKey);
         MovieStudioController.getInstance().updateMarkEditMovieInFriendList();
      }
      
      private function initKeyFrames(param1:Number) : void
      {
         var _loc3_:Scene = null;
         var _loc4_:Boolean = false;
         var _loc2_:Number = 0;
         while(_loc2_ < this.movie.Scenes.length)
         {
            _loc3_ = this.movie.Scenes.getItemAt(_loc2_) as Scene;
            _loc4_ = this.scene == _loc3_ || param1 == 0;
            this.initKeyFramesForOneScene(_loc3_,param1,_loc4_);
            _loc2_++;
         }
      }
      
      private function initKeyFramesForOneScene(param1:Scene, param2:Number, param3:Boolean) : void
      {
         var _loc5_:KeyFrameActor = null;
         var _loc4_:Number = 0;
         while(_loc4_ < param1.KeyFrameCount)
         {
            _loc5_ = new KeyFrameActor();
            _loc5_.KeyFrameNumber = _loc4_;
            _loc5_.SceneId = param1.SceneId;
            _loc5_.FigureNumber = param2;
            _loc5_.KeyFrameId = 0;
            _loc5_.X = -1;
            _loc5_.Y = -1;
            _loc5_.Line = "";
            _loc5_.Animation = "";
            _loc5_.Face = "";
            _loc5_.Speech = 0;
            _loc5_.IsFacingLeft = -1;
            if(_loc4_ == 0)
            {
               if(param3 || !this.loadActorPerScene)
               {
                  _loc5_.X = this.getNewActorCoordX(param2);
                  _loc5_.Y = this.getNewActorCoordY(param2);
                  ++this.scene.visibleActorsCount;
               }
               else
               {
                  _loc5_.X = -100;
                  _loc5_.Y = -100;
               }
               _loc5_.Animation = "stand";
               _loc5_.Face = "neutral";
               _loc5_.IsFacingLeft = 0;
            }
            param1.KeyFrameActors.addItem(_loc5_);
            _loc4_++;
         }
      }
      
      private function setActorVisibilityInScene(param1:Number, param2:Boolean) : void
      {
         var _loc3_:KeyFrameActor = this.getKeyFrameActor(param1,0);
         if(param2)
         {
            _loc3_.X = this.getNewActorCoordX(param1);
            _loc3_.Y = this.getNewActorCoordY(param1);
            ++this.scene.visibleActorsCount;
         }
         else
         {
            _loc3_.X = -100;
            _loc3_.Y = -100;
            --this.scene.visibleActorsCount;
         }
      }
      
      private function isActorInvisibleInAllScenes(param1:Number) : Boolean
      {
         var _loc3_:Scene = null;
         var _loc2_:Number = 0;
         while(_loc2_ < this.movie.Scenes.length)
         {
            _loc3_ = this.movie.Scenes.getItemAt(_loc2_) as Scene;
            if(this.isActorVisibleInScene(param1,_loc3_))
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      public function canActorBeAdded(param1:Number) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.actorFigures.length)
         {
            if(Boolean((this.actorFigures[_loc2_] as MovieStar).actor) && (this.actorFigures[_loc2_] as MovieStar).actor.ActorId == param1)
            {
               return !this.isActorCurrentlyVisible(_loc2_);
            }
            _loc2_++;
         }
         return true;
      }
      
      public function isActorVisibleInScene(param1:Number, param2:Scene = null) : Boolean
      {
         var _loc4_:KeyFrameActor = null;
         if(!this.loadActorPerScene)
         {
            return true;
         }
         if(param2 == null)
         {
            param2 = this.scene;
         }
         var _loc3_:int = 0;
         while(_loc3_ < param2.KeyFrameActors.length)
         {
            _loc4_ = param2.KeyFrameActors.getItemAt(_loc3_) as KeyFrameActor;
            if(_loc4_.FigureNumber == param1 && _loc4_.KeyFrameNumber == 0)
            {
               if(_loc4_.X < -1 && _loc4_.Y < -1)
               {
                  return false;
               }
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function initPropKeyFramesForOneProp(param1:Prop, param2:int, param3:int) : void
      {
         var _loc5_:KeyFrameProp = null;
         param1.KeyFrameProps = new ArrayCollection();
         var _loc4_:Number = 0;
         while(_loc4_ < this.scene.KeyFrameCount)
         {
            _loc5_ = new KeyFrameProp();
            _loc5_.ItemId = param1.ItemId;
            _loc5_.KeyFrameNumber = _loc4_;
            _loc5_.X = -1;
            _loc5_.Y = -1;
            _loc5_.IsFacingLeft = -1;
            if(_loc4_ == 0)
            {
               _loc5_.X = param2;
               _loc5_.Y = param3;
               _loc5_.IsFacingLeft = 0;
            }
            param1.KeyFrameProps.addItem(_loc5_);
            _loc4_++;
         }
      }
      
      public function actorChanged() : void
      {
         this.UpdateActorArea();
      }
      
      private function loadScenes(param1:Movie) : void
      {
         var _loc4_:Scene = null;
         this.scene = param1.Scenes.getItemAt(0) as Scene;
         var _loc2_:Number = 0;
         while(_loc2_ < param1.Scenes.length)
         {
            _loc4_ = param1.Scenes.getItemAt(_loc2_) as Scene;
            this.addSceneListItem(_loc4_.Background,_loc4_.LastUpdated,_loc4_.Sound,_loc4_.SceneNumber,_loc4_.KeyFrameCount,_loc4_.Manuscript);
            this.sceneNumberSpeech = _loc4_.SceneNumberSpeech;
            this.movieTotalKeyFrameCount += _loc4_.KeyFrameCount;
            _loc2_++;
         }
         var _loc3_:Number = this.scene.KeyFrameActors.length;
      }
      
      public function backgroundLoaded(param1:MSP_SWFLoader) : void
      {
         param1.width = this.canvas.width;
         param1.height = this.canvas.height;
         param1.setStyle("cornerRadius","10");
         param1.setStyle("borderStyle","solid");
         param1.setStyle("borderThikness","0");
         param1.cacheAsBitmap = true;
         this.canvasBackground.addChild(param1);
         if(this.backgroundSwfExisting != null)
         {
            this.canvasBackground.removeChild(this.backgroundSwfExisting);
         }
         this.backgroundSwfExisting = param1;
      }
      
      public function setBackground(param1:String, param2:int, param3:Date) : void
      {
         this.scene.Background = param1;
         this.scene.BackgroundId = param2;
         this.backgroundSwf = MSP_SWFLoader.RequestLoad(new ContentUrl(this.scene.Background,ContentUrl.BACKGROUND,param3),this.backgroundLoaded,MSP_LoaderManager.PRIORITY_UI,false,false);
         this.backgroundSwf.maintainAspectRatio = false;
      }
      
      public function backgroundChanged(param1:MSP_Event) : void
      {
         this.scene = this.movie.Scenes.getItemAt(this.selectedScene) as Scene;
         var _loc2_:Background = Background(param1.data);
         var _loc3_:String = _loc2_.url;
         this.movieChanged = true;
         (this.vboxScenes.getChildAt(this.scene.SceneNumber) as SceneListCanvas).setBackground(_loc3_,_loc2_.LastUpdated);
         this.setBackground(_loc3_,_loc2_.BackgroundId,_loc2_.LastUpdated);
      }
      
      public function soundChanged(param1:MSP_Event) : void
      {
         var _loc2_:Music = null;
         var _loc3_:String = null;
         this.scene = this.movie.Scenes.getItemAt(this.selectedScene) as Scene;
         _loc2_ = Music(param1.data);
         _loc3_ = _loc2_.Url;
         this.movieChanged = true;
         this.setSound(_loc3_);
      }
      
      public function frameCountChanged(param1:MSP_Event) : void
      {
         var _loc2_:SceneListCanvas = null;
         var _loc3_:Number = NaN;
         _loc2_ = param1.currentTarget as SceneListCanvas;
         this.scene = this.movie.Scenes.getItemAt(_loc2_.sceneId) as Scene;
         _loc3_ = Number(Number(param1.data));
         this.movieChanged = true;
         this.nbrFramesChange(_loc3_);
         this.setLabelFrameNumber(this.selectedKey);
      }
      
      public function manuscriptChanged(param1:MSP_Event) : void
      {
         var _loc2_:SceneListCanvas = null;
         var _loc3_:String = null;
         _loc2_ = param1.currentTarget as SceneListCanvas;
         this.scene = this.movie.Scenes.getItemAt(_loc2_.sceneId) as Scene;
         _loc3_ = String(param1.data);
         this.movieChanged = true;
         this.scene.Manuscript = _loc3_;
      }
      
      public function setSound(param1:String) : void
      {
         var _loc2_:URLRequest = null;
         this.scene.Sound = param1;
         if(param1 != "")
         {
            _loc2_ = new URLRequest(new ContentUrl(this.scene.Sound,ContentUrl.MUSIC).toString());
            this.backgroundSound = new Sound(_loc2_);
         }
      }
      
      private function getFigureScaleFromScreenY(param1:Number) : Number
      {
         var _loc2_:Number = NaN;
         _loc2_ = param1 - this.HORIZON_Y_COORD;
         return 0.45 + _loc2_ / 1000;
      }
      
      public function loadActor(param1:Number, param2:Number, param3:Boolean, param4:Boolean, param5:Boolean = true, param6:Array = null) : void
      {
         var newActor:MovieStar = null;
         var movieStarCached:Boolean = false;
         var MovieStarLoaded:Function = null;
         var animationKeyFrameActor:KeyFrameActor = null;
         var actorId:Number = param1;
         var figureNumber:Number = param2;
         var isVisible:Boolean = param3;
         var isAddingNewActorToExistingMovie:Boolean = param4;
         var loadClothesFromContext:Boolean = param5;
         var appearanceData:Array = param6;
         MovieStarLoaded = function(param1:MovieStar):void
         {
            if(loadClothesFromContext && !isAddingNewActorToExistingMovie)
            {
               new HackActorSkinCommand(param1).hackActorSkin();
            }
            --numberOfActorFiguresToUpdate;
            if(!inPlayMode && speechActorId == param1.actor.ActorId)
            {
               currentMovieStar = param1;
            }
            if(loadingActors && numberOfActorFiguresToUpdate == 0)
            {
               loadActorsDone();
            }
            else if(!loadingActors && numberOfActorFiguresToUpdate == 0)
            {
               loadNewActorDone();
            }
            param1.currentBody.cacheAsBitmap = true;
            moveMovieActorForm(param1);
         };
         if(this.actorFigures[figureNumber] == null)
         {
            movieStarCached = false;
            newActor = new MovieStar();
            newActor.staticClothes = true;
         }
         else
         {
            movieStarCached = true;
            newActor = this.actorFigures[figureNumber];
         }
         newActor.movieStarPopupEnabled = false;
         if(loadClothesFromContext && this.movie.MovieId != 0 && !isAddingNewActorToExistingMovie)
         {
            newActor.ContextId = this.movie.MovieId;
         }
         newActor.x = this.getNewActorCoordX(figureNumber);
         newActor.y = this.getNewActorCoordY(figureNumber);
         newActor.scale = this.getFigureScaleFromScreenY(newActor.y);
         if(actorId == 0)
         {
            LoggingAmfService.Debug("MovieStudio.loadActor: Loading actor with id 0. ");
         }
         if(movieStarCached)
         {
            MovieStarLoaded(newActor);
         }
         else if(Boolean(appearanceData) && Boolean(appearanceData[figureNumber]))
         {
            newActor.LoadWithAppearanceData(actorId,appearanceData[figureNumber],MovieStarLoaded,false);
         }
         else
         {
            newActor.Load(actorId,MovieStarLoaded,2,false,false);
         }
         if(actorId > 0 && newActor != null && Boolean(newActor.actor))
         {
            newActor.actor.ActorId = actorId;
         }
         this.actorFigures[figureNumber] = newActor;
         newActor.actorMovieNumber = figureNumber;
         if(isVisible)
         {
            this.makeActorVisible(figureNumber);
         }
         if(this.inPlayMode)
         {
            animationKeyFrameActor = this.FindKeyFrameActorWhereAnimationHaveBeenSet(figureNumber,0);
            newActor.preloadAnimation(animationKeyFrameActor.Animation,animationKeyFrameActor.LastUpdated);
         }
         else if(this.instructorId != 0)
         {
            MSP_ToolTipManager.add(newActor,MSPLocaleManagerWeb.getInstance().getString("CLICK_ACTOR_ANIMATION"));
         }
         else if(this.speechActorId == actorId)
         {
            MSP_ToolTipManager.add(newActor,MSPLocaleManagerWeb.getInstance().getString("CLICK_RECORD_SPEECH"));
         }
      }
      
      private function copyClothesToFriendList() : void
      {
         var _loc1_:MovieStar = null;
         var _loc2_:FriendItem = null;
         var _loc3_:FriendItem = null;
         for each(_loc1_ in this.actorFigures)
         {
            if(_loc1_.actor.ActorId == this.instructorId)
            {
               if(meItem != null)
               {
                  meItem.friendMovieStar.SetClothes(_loc1_.GetAttachedClothes());
               }
            }
            else if(_loc1_.isExtra())
            {
               for each(_loc2_ in extraItems)
               {
                  if(_loc2_ != null)
                  {
                     if(_loc1_.actor.ActorId == _loc2_.friendActorId)
                     {
                        _loc2_.friendMovieStar.SetClothes(_loc1_.GetAttachedClothes());
                     }
                  }
               }
            }
            else
            {
               _loc3_ = this.friendListPopup.GetFriendFromCacheIfInitialized(_loc1_.actor.ActorId) as FriendItem;
               if(_loc3_ != null)
               {
                  _loc3_.friendMovieStar.SetClothes(_loc1_.GetAttachedClothes());
               }
            }
         }
      }
      
      private function loadPropsDone(param1:Movie) : void
      {
         var _loc2_:* = 0;
         var _loc3_:Scene = null;
         var _loc4_:* = 0;
         var _loc5_:Prop = null;
         _loc2_ = int(param1.Scenes.length - 1);
         while(_loc2_ >= 0)
         {
            _loc3_ = param1.Scenes.getItemAt(_loc2_) as Scene;
            if(_loc3_.PropsInScene != null)
            {
               _loc4_ = int(_loc3_.PropsInScene.length - 1);
               while(_loc4_ >= 0)
               {
                  _loc5_ = _loc3_.PropsInScene.getItemAt(_loc4_) as Prop;
                  if(_loc5_.SWF == null)
                  {
                     _loc3_.PropsInScene.removeItemAt(_loc4_);
                  }
                  _loc4_--;
               }
            }
            _loc2_--;
         }
         this.loadActors();
      }
      
      private function get areAllMovieStarsCached() : Boolean
      {
         var _loc1_:MovieActorRel = null;
         if(this.movie.MovieActorRels != null)
         {
            for each(_loc1_ in this.movie.MovieActorRels)
            {
               if(this.actorFigures[_loc1_.FigureNumber] == null)
               {
                  return false;
               }
            }
            return true;
         }
         return false;
      }
      
      private function loadActors() : void
      {
         var appearanceData:Array = null;
         var loadClothesFromContext:Boolean = false;
         var gotDates:Function = null;
         var objActorClothesDataA:Object = null;
         var objActorClothesDataB:Object = null;
         gotDates = function():void
         {
            numberOfActorFiguresToUpdate = movie.MovieActorRels.length;
            if(numberOfActorFiguresToUpdate == 0)
            {
               loadActorsDone();
            }
            else
            {
               loadingActors = true;
               loadActors2(movie,0,loadClothesFromContext,appearanceData);
            }
         };
         appearanceData = [];
         loadClothesFromContext = true;
         if(this.movie.ActorClothesData != null && this.movie.ActorClothesData.length != 0)
         {
            loadClothesFromContext = false;
            if(this.movie.MovieActorRels == null || this.movie.MovieActorRels.length == 0)
            {
               objActorClothesDataA = SerializeUtils.deserialize(this.movie.ActorClothesData);
               this.movie.MovieActorRels = objActorClothesDataA.MovieActorRels;
               appearanceData = objActorClothesDataA.ClothesData;
            }
            else if(!this.areAllMovieStarsCached)
            {
               objActorClothesDataB = SerializeUtils.deserialize(this.movie.ActorClothesData);
               appearanceData = objActorClothesDataB.ClothesData;
            }
         }
         new LastEditManager(gotDates).loadMovieAppearanceData(appearanceData);
      }
      
      private function loadActorsDone() : void
      {
         this.loadingActors = false;
         if(!this.inPlayMode)
         {
            this.copyClothesToFriendList();
         }
         this.loadKeyFramesForMovie();
      }
      
      private function loadActors2(param1:Movie, param2:Number, param3:Boolean = true, param4:Array = null) : void
      {
         var _loc5_:MovieActorRel = null;
         if(param1.MovieActorRels.length > param2)
         {
            _loc5_ = param1.MovieActorRels.getItemAt(param2) as MovieActorRel;
            if(param2 != _loc5_.FigureNumber)
            {
               new DebugAlert().show("TODO. -- db -- Ensure that actors are sorted accordning to figureNumber in the webservice");
            }
            this.loadActor(_loc5_.ActorId,_loc5_.FigureNumber,this.isActorVisibleInScene(_loc5_.FigureNumber,this.scene),false,param3,param4);
            this.loadActors2(param1,param2 + 1,param3,param4);
         }
      }
      
      private function updateActorsVisibility() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         _loc1_ = int(this.actorFigures.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(this.isActorVisibleInScene(_loc2_,this.scene))
            {
               if(!this.isActorCurrentlyVisible(_loc2_))
               {
                  this.makeActorVisible(_loc2_);
               }
            }
            else if(this.isActorCurrentlyVisible(_loc2_))
            {
               this.makeActorInvisible(_loc2_);
            }
            _loc2_++;
         }
      }
      
      private function isActorCurrentlyVisible(param1:Number) : Boolean
      {
         var _loc2_:MovieStar = null;
         _loc2_ = this.actorFigures[param1] as MovieStar;
         if(_loc2_ != null)
         {
            return this.canvas.contains(_loc2_);
         }
         return this.isActorVisibleInScene(param1);
      }
      
      private function makeActorVisible(param1:Number) : void
      {
         var _loc2_:MovieStar = null;
         _loc2_ = this.actorFigures[param1] as MovieStar;
         this.canvas.addChild(_loc2_);
         this.addSpeechBubble(param1);
         this.sortOrder.push(_loc2_);
         if(!this.inPlayMode && this.instructorId != 0)
         {
            _loc2_.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDown);
         }
      }
      
      private function makeActorInvisible(param1:Number) : void
      {
         var _loc2_:MovieStar = null;
         var _loc3_:int = 0;
         var _loc4_:CallOut = null;
         var _loc5_:MovieStar = null;
         _loc2_ = this.actorFigures[param1] as MovieStar;
         if(Boolean(_loc2_) && Boolean(_loc2_.parent) && _loc2_.parent == this.canvas)
         {
            this.canvas.removeChild(_loc2_);
            _loc3_ = 0;
            while(_loc3_ < this.sortOrder.length)
            {
               if(this.sortOrder[_loc3_] is MovieStar)
               {
                  _loc5_ = this.sortOrder[_loc3_] as MovieStar;
                  if(_loc5_.actor.ActorId == _loc2_.actor.ActorId)
                  {
                     this.sortOrder.splice(_loc3_,1);
                  }
               }
               _loc3_++;
            }
            _loc4_ = this.speechBubbles[param1];
            if(this.canvasSpeechBubble.contains(_loc4_))
            {
               this.canvasSpeechBubble.removeChild(_loc4_);
            }
            _loc2_.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDown);
            _loc2_ = null;
         }
      }
      
      private function loadKeys(param1:Movie) : void
      {
         var _loc2_:Scene = null;
         var _loc3_:Number = NaN;
         _loc2_ = param1.Scenes.getItemAt(0) as Scene;
         _loc3_ = _loc2_.KeyFrameCount;
         this.textNbrFrames.text = (_loc3_ - 2).toString();
         this.updateFrameCount();
      }
      
      public function editScenes() : void
      {
         if(this.scenesCanvas.visible)
         {
            this.scenesCanvas.visible = false;
            return;
         }
         this.musicCanvas.close();
         this.backgroundCanvas.visible = false;
         this.propsCanvas.visible = false;
         this.movieStarsOk();
         if(this.movieActorForm != null && !this.movieActorForm.isClosed)
         {
            this.movieActorForm.close();
         }
         this.confirmedDelete = false;
         this.scenesCanvas.visible = true;
      }
      
      override public function RequestExit(param1:Function) : void
      {
         var exitCalled:Function = null;
         var allowExitCallBack:Function = param1;
         if(this.isPlaying)
         {
            this.stopclick(true);
         }
         if(!this.inPlayMode && this.movieChanged && this.instructorId != 0 || this.movie.Name == AUTOSAVE_NAME && !this.inPlayMode && this.instructorId != 0)
         {
            exitCalled = function(param1:PromptEvent):void
            {
               var movieService:IMovieService = null;
               var movieDeleted:Function = null;
               var eventObj:PromptEvent = param1;
               stopTutorial();
               if(eventObj.detail == Prompt.YES)
               {
                  saveclick(allowExitCallBack);
               }
               else if(eventObj.detail == Prompt.NO)
               {
                  movieChanged = false;
                  if(movie.Name == AUTOSAVE_NAME)
                  {
                     movieDeleted = function():void
                     {
                        allowExitCallBack(true);
                     };
                     movieService = new MovieAMFService();
                     movieService.deleteMovie(movie.MovieId,ActorSession.getActorId(),movieDeleted);
                  }
                  else
                  {
                     allowExitCallBack(true);
                  }
               }
            };
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("SAVE_THE_MOVIE"),MSPLocaleManagerWeb.getInstance().getString("SAVE"),Alert.YES | Alert.NO,this,exitCalled);
         }
         else
         {
            allowExitCallBack(true);
         }
      }
      
      override public function Exit() : void
      {
         this.stopAutoSaving();
         MSP_LoaderManager.Reset(false);
         removeEventListener(Event.ENTER_FRAME,this.HandleEnterFrame);
         this.stopclick(true);
         this.isPlaying = false;
         this.movieChanged = false;
         this.scenesCanvas.visible = false;
         this.propsCanvas.visible = false;
         this.control.visible = false;
         this.movieActorListForm.visible = false;
         this.backgroundCanvas.visible = false;
         this.musicCanvas.close();
         this.selectedScene = NaN;
         if(this.movieActorForm != null && !this.movieActorForm.isClosed)
         {
            this.movieActorForm.close();
         }
         this.canvasSpeechBubble.removeAllChildren();
         this.meCanvas.removeAllChildren();
         this.extrasTile.removeAllChildren();
         MovieStudioController.getInstance().markEditMovieInFriendList(null);
         if(this.showMovieFromUrl)
         {
            dispatchEvent(new Event(Event.CLOSE));
         }
         else
         {
            if(this.movie.MovieId != 0)
            {
               this.movieDetails.gotoMovieStudioInitially = false;
               if(this.reloadMovieToGetNewStats)
               {
                  this.movieDetails.editMovie(this.movie.MovieId,false);
               }
               else
               {
                  this.movieDetails.movieLoaded(this.movie);
               }
            }
            else
            {
               this.movieDetails.closePopup();
            }
            this.movieDetails.detailsCanvas.visible = true;
            this.controlCanvasBelow.visible = false;
         }
      }
      
      public function allowExitCallBackInternal(param1:Boolean) : void
      {
         if(param1)
         {
            if(this.movieDetails != null && this.movieDetails.detailsCanvas != null)
            {
               this.movieDetails.detailsCanvas.visible = true;
            }
            if(this.controlCanvasBelow != null)
            {
               this.controlCanvasBelow.visible = false;
            }
            this.Exit();
         }
      }
      
      public function editFriendsClicked(param1:Event) : void
      {
         if(this.movieActorListForm.visible)
         {
            this.movieStarsOk();
            return;
         }
         this.scenesCanvas.visible = false;
         this.propsCanvas.visible = false;
         this.musicCanvas.close();
         this.backgroundCanvas.visible = false;
         if(this.movieActorForm != null && !this.movieActorForm.isClosed)
         {
            this.movieActorForm.close();
         }
         this.movieActorListFormUpdateFriends();
         this.stopAutoSaving();
         this.movieActorListForm.visible = true;
      }
      
      public function movieStarsOk() : void
      {
         this.movieActorListForm.visible = false;
         this.startAutoSaving();
      }
      
      private function get friendListPopup() : FriendListPopup
      {
         if(this._friendListPopup == null)
         {
            this._friendListPopup = new FriendListPopup();
            this._friendListPopup.movieStudio = this;
         }
         return this._friendListPopup;
      }
      
      public function get movieActorRels() : Array
      {
         if(this.movie != null && this.movie.MovieActorRels != null)
         {
            return this.movie.MovieActorRels.toArray();
         }
         return null;
      }
      
      public function movieActorListFormUpdateFriends(param1:Event = null) : void
      {
         var _loc2_:FriendItem = null;
         if(this.friendsCanvas != null && !this.friendsCanvas.contains(this.friendListPopup))
         {
            this.friendsCanvas.addChild(this.friendListPopup);
         }
         if(meItem == null)
         {
            meItem = new MovieStudioFriendItem(ActorSession.getActorId(),ActorSession.loggedInActor.Name,"");
            this.initExtras();
         }
         if(this.meCanvas != null)
         {
            this.meCanvas.addChild(meItem);
            for each(_loc2_ in extraItems)
            {
               this.extrasTile.addChild(_loc2_);
            }
         }
      }
      
      private function initExtras() : void
      {
         extraItems = [new MovieStudioFriendItem(279,"Pirate (extra)","",null,true),new MovieStudioFriendItem(274,"Mermaid (extra)","",null,true),new MovieStudioFriendItem(425,"Monster (extra)","",null,true),new MovieStudioFriendItem(416,"SheDevil (extra)","",null,true),new MovieStudioFriendItem(417,"Football Hero (extra)","",null,true),new MovieStudioFriendItem(275,"Queen (extra)","",null,true)];
      }
      
      protected function onHelpClicked() : void
      {
      }
      
      public function stopTutorial() : void
      {
      }
      
      private function onSliderFrameAdded() : void
      {
         this.nbrFramesChange(this.slider.maximum);
      }
      
      private function onBackgroundSelectorCancel() : void
      {
         this.backgroundCanvas.visible = false;
      }
      
      private function onMusicSelectorCancel() : void
      {
         this.musicCanvas.close();
      }
      
      private function onCallOutCloseClicked(param1:Event) : void
      {
         var _loc2_:MovieStar = null;
         var _loc3_:KeyFrameActor = null;
         var _loc4_:KeyFrameActor = null;
         _loc2_ = this.actorFigures[CallOut(param1.target).name];
         this.movieActorForm.selectedMovieStar = _loc2_;
         if(!this.textDisplayedFromPreviousKeyFrame[_loc2_.actorMovieNumber])
         {
            _loc3_ = this.getKeyFrameActor(_loc2_.actorMovieNumber,this.selectedKey);
            _loc3_.Line = "";
         }
         else
         {
            _loc4_ = this.getKeyFrameActor(_loc2_.actorMovieNumber,this.selectedKey - 1);
            _loc4_.Line = "";
         }
         this.keyclickSelected();
      }
      
      private function onEnterMovieNameOkClicked(param1:Event) : void
      {
         var _loc2_:EnterMovieName = null;
         _loc2_ = param1.target as EnterMovieName;
         this.movie.Name = _loc2_.embeddedName;
         this.movie.State = _loc2_.stateValue;
         PopupUtils.removePopup(_loc2_);
         if(this.movie.State == MovieStatuses.M_STATUS_PUBLIC)
         {
            this.saveMovie(this.createActivityOnSave,_loc2_.userInput);
         }
         else
         {
            this.saveMovie(null,_loc2_.userInput);
            this.sendMovieCreatedAnalytics();
            if(this._exitCallBackFunction != null && this._exitCallBackFunction is Function)
            {
               this._exitCallBackFunction(false);
            }
         }
      }
      
      private function createActivityOnSave(param1:Boolean) : void
      {
         if(param1)
         {
            OldActivityCreator.getInstance().createActivity(1,this.movie.MovieId);
            this.sendMovieCreatedAnalytics();
         }
         this.Exit();
      }
      
      private function onEnterMovieNameCancelClicked(param1:Event) : void
      {
         PopupUtils.removePopup(param1.currentTarget as EnterMovieName);
         this.movieChanged = true;
         this.saveButton.enabled = true;
         this.startAutoSaving();
         this.endOverlay.visible = false;
      }
      
      private function onEnterMovieNameRemoved(param1:Event) : void
      {
         this.saveButton.enabled = true;
         this.endOverlay.visible = false;
      }
      
      private function onStopButtonClicked() : void
      {
         if(this.showMovieFromUrl)
         {
            this.playScene(0,0,0,false);
            if(this.isPlaying)
            {
               this.playclick();
            }
         }
         else
         {
            this.fadeOnEnd();
            this.Exit();
         }
      }
      
      public function hideButtonsForFrontpage() : void
      {
         var _loc1_:UIComponent = null;
         for each(_loc1_ in this.topControls.getChildren())
         {
            _loc1_.visible = false;
         }
         this.exitButton.visible = true;
      }
      
      private function sendMovieCreatedAnalytics() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:Date = null;
         _loc1_ = "" + this.movie.MovieId;
         _loc2_ = "" + this.movie.ActorId;
         _loc3_ = this.movie.MovieActorRels.length;
         MovieUtil.calculateMovieComplexity(this.movie);
         _loc4_ = this.movie.Complexity;
         _loc5_ = this.movie.State == MovieStatuses.M_STATUS_PUBLIC;
         _loc6_ = _loc5_ ? DateUtils.nowUTC : null;
         MangroveAnalytics.registerMovieAction(EntityActionEventConst.ENTITY_MOVIE,EntityActionEventConst.ACTION_CREATE,_loc1_,_loc2_,_loc3_,_loc4_,null,null,null,null,DateUtils.nowUTC,_loc6_,null);
      }
      
      private function _MovieStudio_Fade2_i() : Fade
      {
         var _loc1_:Fade = null;
         _loc1_ = new Fade();
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.duration = 1000;
         this.endFade = _loc1_;
         BindingManager.executeBindings(this,"endFade",this.endFade);
         return _loc1_;
      }
      
      private function _MovieStudio_Fade1_i() : Fade
      {
         var _loc1_:Fade = null;
         _loc1_ = new Fade();
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         _loc1_.duration = 1000;
         this.fadeOut = _loc1_;
         BindingManager.executeBindings(this,"fadeOut",this.fadeOut);
         return _loc1_;
      }
      
      private function _MovieStudio_Sequence1_i() : Sequence
      {
         var _loc1_:Sequence = null;
         _loc1_ = new Sequence();
         _loc1_.repeatCount = 10;
         _loc1_.children = [this._MovieStudio_Glow1_c(),this._MovieStudio_Glow2_c()];
         this.glow = _loc1_;
         BindingManager.executeBindings(this,"glow",this.glow);
         return _loc1_;
      }
      
      private function _MovieStudio_Glow1_c() : Glow
      {
         var _loc1_:Glow = null;
         _loc1_ = new Glow();
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.blurXTo = 8;
         _loc1_.blurYTo = 8;
         _loc1_.color = 16777215;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      private function _MovieStudio_Glow2_c() : Glow
      {
         var _loc1_:Glow = null;
         _loc1_ = new Glow();
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         _loc1_.blurXTo = 8;
         _loc1_.blurYTo = 8;
         _loc1_.color = 16777215;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      public function ___MovieStudio_ViewComponentCanvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      public function ___MovieStudio_ViewComponentCanvas1_preinitialize(param1:FlexEvent) : void
      {
         this.onPreinitialize(param1);
      }
      
      public function __canvas_mouseDown(param1:MouseEvent) : void
      {
         this.mainMouseDown();
      }
      
      public function __canvas_mouseMove(param1:MouseEvent) : void
      {
         this.mouseMove();
      }
      
      public function __canvas_mouseUp(param1:MouseEvent) : void
      {
         this.mouseUp();
      }
      
      public function __helpButton_click(param1:MouseEvent) : void
      {
         this.onHelpClicked();
      }
      
      public function __saveButton_click(param1:MouseEvent) : void
      {
         this.saveclick(null);
      }
      
      public function __editButton_click(param1:MouseEvent) : void
      {
         this.editClick();
      }
      
      public function __reportButton_click(param1:MouseEvent) : void
      {
         this.report();
      }
      
      public function __sendMailButton_click(param1:MouseEvent) : void
      {
         this.sendAsMail();
      }
      
      public function __shareWithButton_click(param1:MouseEvent) : void
      {
         this.btn_Share_ClickHandler();
      }
      
      public function __exitButton_click(param1:MouseEvent) : void
      {
         this.fadeOnEnd();
         this.RequestExit(this.allowExitCallBackInternal);
      }
      
      public function __moviebarLoader_creationComplete(param1:FlexEvent) : void
      {
         this.moviebarLoad(param1);
      }
      
      public function __play_click(param1:MouseEvent) : void
      {
         this.playclick();
      }
      
      public function __stopBtn_click(param1:MouseEvent) : void
      {
         this.onStopButtonClicked();
      }
      
      public function __slider_change(param1:SliderEvent) : void
      {
         this.sliderChange(param1);
      }
      
      public function __slider_frameAdded(param1:Event) : void
      {
         this.onSliderFrameAdded();
      }
      
      public function __editActorsButton_click(param1:MouseEvent) : void
      {
         this.editFriendsClicked(param1);
      }
      
      public function __editPropsButton_click(param1:MouseEvent) : void
      {
         this.editProps();
      }
      
      public function __editScenesButton_click(param1:MouseEvent) : void
      {
         this.editScenes();
      }
      
      public function __editBackgroundButton_click(param1:MouseEvent) : void
      {
         this.editBackgroundClicked();
      }
      
      public function __editMusicButton_click(param1:MouseEvent) : void
      {
         this.editMusicClicked();
      }
      
      public function ___MovieStudio_CloseButton2_click(param1:MouseEvent) : void
      {
         this.movieStarsOk();
      }
      
      public function ___MovieStudio_CloseButton3_click(param1:MouseEvent) : void
      {
         this.scenesCanvas.visible = false;
      }
      
      public function __addSceneButton_click(param1:MouseEvent) : void
      {
         this.addScene();
      }
      
      public function ___MovieStudio_CloseButton4_click(param1:MouseEvent) : void
      {
         this.propsCanvas.visible = false;
      }
      
      public function __backgroundCanvas_CANCEL(param1:Event) : void
      {
         this.onBackgroundSelectorCancel();
      }
      
      public function __backgroundCanvas_OK(param1:MSP_Event) : void
      {
         this.backgroundChanged(param1);
      }
      
      public function __musicCanvas_OK(param1:MSP_Event) : void
      {
         this.soundChanged(param1);
      }
      
      private function _MovieStudio_bindingsSetup() : Array
      {
         var result:Array = null;
         result = [];
         result[0] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/moviestudio/help_icon.swf",Config.LOCAL_CDN_URL);
         },null,"helpButton.source");
         result[1] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/moviestudio/play.swf",Config.LOCAL_CDN_URL);
         },null,"play.source");
         result[2] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/moviestudio/stop.swf",Config.LOCAL_CDN_URL);
         },null,"stopBtn.source");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = Config.toAbsoluteURL("swf/moviestudio/nav_button.swf",Config.LOCAL_CDN_URL);
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"slider.arrowImage");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = Config.toAbsoluteURL("swf/moviestudio/frame_container_cover.swf",Config.LOCAL_CDN_URL);
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"slider.coverImage");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = Config.toAbsoluteURL("swf/moviestudio/current_frame_indicator.swf",Config.LOCAL_CDN_URL);
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"slider.currentFrameIndicatorImage");
         result[6] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/moviestudio/friends_icon.swf",Config.LOCAL_CDN_URL);
         },null,"editActorsButton.source");
         result[7] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/moviestudio/item_icon.swf",Config.LOCAL_CDN_URL);
         },null,"editPropsButton.source");
         result[8] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/moviestudio/scene_icon.swf",Config.LOCAL_CDN_URL);
         },null,"editScenesButton.source");
         result[9] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/moviestudio/bg_icon.swf",Config.LOCAL_CDN_URL);
         },null,"editBackgroundButton.source");
         result[10] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/moviestudio/music_icon.swf",Config.LOCAL_CDN_URL);
         },null,"editMusicButton.source");
         result[11] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = MSPLocaleManagerWeb.getInstance().getString("CLICK_ADD_ACTOR");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_MovieStudio_TitleBar1.label");
         result[12] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = MSPLocaleManagerWeb.getInstance().getString("FRIENDS");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"friendsCanvas.label");
         result[13] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = MSPLocaleManagerWeb.getInstance().getString("MOVIE_EXTRAS");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_MovieStudio_Canvas11.label");
         result[14] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = MSPLocaleManagerWeb.getInstance().getString("SCENES");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_MovieStudio_TitleBar2.label");
         result[15] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = MSPLocaleManagerWeb.getInstance().getString("ADD_SCENE");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"addSceneButton.label");
         result[16] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = MSPLocaleManagerWeb.getInstance().getString("ITEMS");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"propsCanvas.label");
         result[17] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = MSPLocaleManagerWeb.getInstance().getString("ITEMS_CLICK_ADD");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_MovieStudio_TitleBar3.label");
         result[18] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = MSPLocaleManagerWeb.getInstance().getString("LOADING_PLEASE");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"loadMovieName.label");
         result[19] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = MSPLocaleManagerWeb.getInstance().getString("PRESENTS");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_MovieStudio_Label5.text");
         result[20] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = MSPLocaleManagerWeb.getInstance().getString("SAVING_PLEASE");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_MovieStudio_LoadingProgressBarAS2.label");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get addSceneButton() : Button
      {
         return this._133774467addSceneButton;
      }
      
      public function set addSceneButton(param1:Button) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._133774467addSceneButton;
         if(_loc2_ !== param1)
         {
            this._133774467addSceneButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"addSceneButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get backgroundCanvas() : BackgroundSelector
      {
         return this._1233296422backgroundCanvas;
      }
      
      public function set backgroundCanvas(param1:BackgroundSelector) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1233296422backgroundCanvas;
         if(_loc2_ !== param1)
         {
            this._1233296422backgroundCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"backgroundCanvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get canvas() : Canvas
      {
         return this._1367706280canvas;
      }
      
      public function set canvas(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1367706280canvas;
         if(_loc2_ !== param1)
         {
            this._1367706280canvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get canvasBackground() : Canvas
      {
         return this._968087718canvasBackground;
      }
      
      public function set canvasBackground(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._968087718canvasBackground;
         if(_loc2_ !== param1)
         {
            this._968087718canvasBackground = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canvasBackground",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get canvasSpeechBubble() : Canvas
      {
         return this._1241021830canvasSpeechBubble;
      }
      
      public function set canvasSpeechBubble(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1241021830canvasSpeechBubble;
         if(_loc2_ !== param1)
         {
            this._1241021830canvasSpeechBubble = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canvasSpeechBubble",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get control() : Canvas
      {
         return this._951543133control;
      }
      
      public function set control(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._951543133control;
         if(_loc2_ !== param1)
         {
            this._951543133control = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"control",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get controlCanvasBelow() : Canvas
      {
         return this._757271524controlCanvasBelow;
      }
      
      public function set controlCanvasBelow(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._757271524controlCanvasBelow;
         if(_loc2_ !== param1)
         {
            this._757271524controlCanvasBelow = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"controlCanvasBelow",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get editActorsButton() : MSP_ClickImage
      {
         return this._804135654editActorsButton;
      }
      
      public function set editActorsButton(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._804135654editActorsButton;
         if(_loc2_ !== param1)
         {
            this._804135654editActorsButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"editActorsButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get editBackgroundButton() : MSP_ClickImage
      {
         return this._52122582editBackgroundButton;
      }
      
      public function set editBackgroundButton(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._52122582editBackgroundButton;
         if(_loc2_ !== param1)
         {
            this._52122582editBackgroundButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"editBackgroundButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get editButton() : EditButton
      {
         return this._1454002652editButton;
      }
      
      public function set editButton(param1:EditButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1454002652editButton;
         if(_loc2_ !== param1)
         {
            this._1454002652editButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"editButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get editMusicButton() : MSP_ClickImage
      {
         return this._1892417203editMusicButton;
      }
      
      public function set editMusicButton(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1892417203editMusicButton;
         if(_loc2_ !== param1)
         {
            this._1892417203editMusicButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"editMusicButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get editPropsButton() : MSP_ClickImage
      {
         return this._1166014552editPropsButton;
      }
      
      public function set editPropsButton(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1166014552editPropsButton;
         if(_loc2_ !== param1)
         {
            this._1166014552editPropsButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"editPropsButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get editScenesButton() : MSP_ClickImage
      {
         return this._797845155editScenesButton;
      }
      
      public function set editScenesButton(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._797845155editScenesButton;
         if(_loc2_ !== param1)
         {
            this._797845155editScenesButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"editScenesButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get editView() : Canvas
      {
         return this._1602095055editView;
      }
      
      public function set editView(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1602095055editView;
         if(_loc2_ !== param1)
         {
            this._1602095055editView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"editView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get endFade() : Fade
      {
         return this._1607668233endFade;
      }
      
      public function set endFade(param1:Fade) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1607668233endFade;
         if(_loc2_ !== param1)
         {
            this._1607668233endFade = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"endFade",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get endOverlay() : Canvas
      {
         return this._863783179endOverlay;
      }
      
      public function set endOverlay(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._863783179endOverlay;
         if(_loc2_ !== param1)
         {
            this._863783179endOverlay = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"endOverlay",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get exitButton() : CloseButton
      {
         return this._335348240exitButton;
      }
      
      public function set exitButton(param1:CloseButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._335348240exitButton;
         if(_loc2_ !== param1)
         {
            this._335348240exitButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"exitButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get extrasTile() : Tile
      {
         return this._765381553extrasTile;
      }
      
      public function set extrasTile(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._765381553extrasTile;
         if(_loc2_ !== param1)
         {
            this._765381553extrasTile = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"extrasTile",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fadeOut() : Fade
      {
         return this._1091436750fadeOut;
      }
      
      public function set fadeOut(param1:Fade) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1091436750fadeOut;
         if(_loc2_ !== param1)
         {
            this._1091436750fadeOut = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeOut",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get friendsCanvas() : Canvas
      {
         return this._1824548685friendsCanvas;
      }
      
      public function set friendsCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1824548685friendsCanvas;
         if(_loc2_ !== param1)
         {
            this._1824548685friendsCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"friendsCanvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get glow() : Sequence
      {
         return this._3175821glow;
      }
      
      public function set glow(param1:Sequence) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._3175821glow;
         if(_loc2_ !== param1)
         {
            this._3175821glow = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"glow",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get helpButton() : MSP_ClickImage
      {
         return this._735423955helpButton;
      }
      
      public function set helpButton(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._735423955helpButton;
         if(_loc2_ !== param1)
         {
            this._735423955helpButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"helpButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get labelActorName() : Label
      {
         return this._167065204labelActorName;
      }
      
      public function set labelActorName(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._167065204labelActorName;
         if(_loc2_ !== param1)
         {
            this._167065204labelActorName = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"labelActorName",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get labelFrameNumber() : Label
      {
         return this._1473639298labelFrameNumber;
      }
      
      public function set labelFrameNumber(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1473639298labelFrameNumber;
         if(_loc2_ !== param1)
         {
            this._1473639298labelFrameNumber = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"labelFrameNumber",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get labelMovieName() : Label
      {
         return this._648431943labelMovieName;
      }
      
      public function set labelMovieName(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._648431943labelMovieName;
         if(_loc2_ !== param1)
         {
            this._648431943labelMovieName = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"labelMovieName",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get loadMovieName() : LoadingProgressBarAS
      {
         return this._1965190251loadMovieName;
      }
      
      public function set loadMovieName(param1:LoadingProgressBarAS) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1965190251loadMovieName;
         if(_loc2_ !== param1)
         {
            this._1965190251loadMovieName = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"loadMovieName",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get loadView() : Canvas
      {
         return this._1845661867loadView;
      }
      
      public function set loadView(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1845661867loadView;
         if(_loc2_ !== param1)
         {
            this._1845661867loadView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"loadView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get meCanvas() : Canvas
      {
         return this._1852515056meCanvas;
      }
      
      public function set meCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1852515056meCanvas;
         if(_loc2_ !== param1)
         {
            this._1852515056meCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"meCanvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get movieActorForm() : MovieActorForm
      {
         return this._578887433movieActorForm;
      }
      
      public function set movieActorForm(param1:MovieActorForm) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._578887433movieActorForm;
         if(_loc2_ !== param1)
         {
            this._578887433movieActorForm = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"movieActorForm",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get movieActorListForm() : Canvas
      {
         return this._478995897movieActorListForm;
      }
      
      public function set movieActorListForm(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._478995897movieActorListForm;
         if(_loc2_ !== param1)
         {
            this._478995897movieActorListForm = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"movieActorListForm",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get movieContentView() : Canvas
      {
         return this._1183189358movieContentView;
      }
      
      public function set movieContentView(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1183189358movieContentView;
         if(_loc2_ !== param1)
         {
            this._1183189358movieContentView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"movieContentView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get movieName() : Label
      {
         return this._1187386843movieName;
      }
      
      public function set movieName(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1187386843movieName;
         if(_loc2_ !== param1)
         {
            this._1187386843movieName = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"movieName",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get moviebarLoader() : MSP_SWFLoader
      {
         return this._907225898moviebarLoader;
      }
      
      public function set moviebarLoader(param1:MSP_SWFLoader) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._907225898moviebarLoader;
         if(_loc2_ !== param1)
         {
            this._907225898moviebarLoader = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"moviebarLoader",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get musicCanvas() : MusicSelector
      {
         return this._770858973musicCanvas;
      }
      
      public function set musicCanvas(param1:MusicSelector) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._770858973musicCanvas;
         if(_loc2_ !== param1)
         {
            this._770858973musicCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"musicCanvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get play() : MSP_ClickImage
      {
         return this._3443508play;
      }
      
      public function set play(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._3443508play;
         if(_loc2_ !== param1)
         {
            this._3443508play = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"play",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get propsCanvas() : PopUpCanvas
      {
         return this._465676568propsCanvas;
      }
      
      public function set propsCanvas(param1:PopUpCanvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._465676568propsCanvas;
         if(_loc2_ !== param1)
         {
            this._465676568propsCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"propsCanvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get reportButton() : ReportButton
      {
         return this._117682566reportButton;
      }
      
      public function set reportButton(param1:ReportButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._117682566reportButton;
         if(_loc2_ !== param1)
         {
            this._117682566reportButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"reportButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get saveButton() : SaveButton
      {
         return this._584254223saveButton;
      }
      
      public function set saveButton(param1:SaveButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._584254223saveButton;
         if(_loc2_ !== param1)
         {
            this._584254223saveButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"saveButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get saveView() : Canvas
      {
         return this._2072548926saveView;
      }
      
      public function set saveView(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2072548926saveView;
         if(_loc2_ !== param1)
         {
            this._2072548926saveView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"saveView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get scenesCanvas() : PopUpCanvas
      {
         return this._1455583647scenesCanvas;
      }
      
      public function set scenesCanvas(param1:PopUpCanvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1455583647scenesCanvas;
         if(_loc2_ !== param1)
         {
            this._1455583647scenesCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"scenesCanvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get secondCounter() : Label
      {
         return this._1813479704secondCounter;
      }
      
      public function set secondCounter(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1813479704secondCounter;
         if(_loc2_ !== param1)
         {
            this._1813479704secondCounter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"secondCounter",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get sendMailButton() : SendMailButton
      {
         return this._331781489sendMailButton;
      }
      
      public function set sendMailButton(param1:SendMailButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._331781489sendMailButton;
         if(_loc2_ !== param1)
         {
            this._331781489sendMailButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sendMailButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get shareWithButton() : ShareWithButton
      {
         return this._2038122281shareWithButton;
      }
      
      public function set shareWithButton(param1:ShareWithButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2038122281shareWithButton;
         if(_loc2_ !== param1)
         {
            this._2038122281shareWithButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"shareWithButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get slider() : Slider
      {
         return this._899647263slider;
      }
      
      public function set slider(param1:Slider) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._899647263slider;
         if(_loc2_ !== param1)
         {
            this._899647263slider = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"slider",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get stopBtn() : MSP_ClickImage
      {
         return this._1884363014stopBtn;
      }
      
      public function set stopBtn(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1884363014stopBtn;
         if(_loc2_ !== param1)
         {
            this._1884363014stopBtn = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"stopBtn",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get stuffViewItems() : MSP_ItemContainer
      {
         return this._821223289stuffViewItems;
      }
      
      public function set stuffViewItems(param1:MSP_ItemContainer) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._821223289stuffViewItems;
         if(_loc2_ !== param1)
         {
            this._821223289stuffViewItems = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"stuffViewItems",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get textNbrFrames() : TextInput
      {
         return this._1771368233textNbrFrames;
      }
      
      public function set textNbrFrames(param1:TextInput) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1771368233textNbrFrames;
         if(_loc2_ !== param1)
         {
            this._1771368233textNbrFrames = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"textNbrFrames",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get topControls() : HBox
      {
         return this._595150635topControls;
      }
      
      public function set topControls(param1:HBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._595150635topControls;
         if(_loc2_ !== param1)
         {
            this._595150635topControls = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"topControls",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get vboxScenes() : HBox
      {
         return this._975191204vboxScenes;
      }
      
      public function set vboxScenes(param1:HBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._975191204vboxScenes;
         if(_loc2_ !== param1)
         {
            this._975191204vboxScenes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"vboxScenes",_loc2_,param1));
            }
         }
      }
   }
}

