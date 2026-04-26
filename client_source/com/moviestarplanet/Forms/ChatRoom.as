package com.moviestarplanet.Forms
{
   import com.boostworthy.animation.easing.Transitions;
   import com.boostworthy.animation.management.AnimationManager;
   import com.boostworthy.animation.rendering.RenderMethod;
   import com.moviestarplanet.Components.Buttons.FontColorButton;
   import com.moviestarplanet.Components.Character.Buttons.GiveAutographButton;
   import com.moviestarplanet.Components.Character.CharacterContainer;
   import com.moviestarplanet.Components.ClickItems.Pet;
   import com.moviestarplanet.Components.CloseButton;
   import com.moviestarplanet.Components.FaceExpressionSelector;
   import com.moviestarplanet.Components.Friends.FriendshipManager;
   import com.moviestarplanet.Components.Friends.chatroominviter.ChatRoomInviter;
   import com.moviestarplanet.Components.GamesSelector.GamesSelector;
   import com.moviestarplanet.Components.MSP_ClickImage;
   import com.moviestarplanet.Components.MSP_EmoticonTextFlowAreaUI;
   import com.moviestarplanet.Components.MSP_Image;
   import com.moviestarplanet.Components.MonsterPopup;
   import com.moviestarplanet.Components.Profile.PublicProfile;
   import com.moviestarplanet.Components.ViewComponent.ViewComponentCanvas;
   import com.moviestarplanet.Components.Wrapper.BonsterClickItemWrapper;
   import com.moviestarplanet.Forms.ChatRoom.AdHolder;
   import com.moviestarplanet.Forms.ChatRoom.StarcoinShooter;
   import com.moviestarplanet.Forms.ChatRoom.StarcoinShooterCongratsPopup;
   import com.moviestarplanet.Forms.ChatRoom.StarcoinShooterPopup;
   import com.moviestarplanet.Forms.minigame.MiniGameBase;
   import com.moviestarplanet.Forms.minigame.queue.RoomRequester;
   import com.moviestarplanet.Forms.world.elements.MiniGameType;
   import com.moviestarplanet.Module.ProfileModuleManager;
   import com.moviestarplanet.actorutils.ActorValueType;
   import com.moviestarplanet.amf.ServiceUrlUtil;
   import com.moviestarplanet.amf.valueobjects.ServiceResultData;
   import com.moviestarplanet.analytics.AnalyticsReceiveCurrencyCommand;
   import com.moviestarplanet.analytics.constants.AnalyticsConstants;
   import com.moviestarplanet.analytics.timer.AnalyticsTimer;
   import com.moviestarplanet.animationPicker.AnimationSelector;
   import com.moviestarplanet.animationPicker.SelectorEvent;
   import com.moviestarplanet.award.visualization.AwardVisualizationController;
   import com.moviestarplanet.awarding.service.AwardingAmfService;
   import com.moviestarplanet.awarding.valueobjects.AwardAmount;
   import com.moviestarplanet.awarding.valueobjects.AwardingType;
   import com.moviestarplanet.bonster.BonsterConstants;
   import com.moviestarplanet.chat.ChatRoomController;
   import com.moviestarplanet.chat.ChatRoomSelector;
   import com.moviestarplanet.chat.ChatRoomType;
   import com.moviestarplanet.chat.chatroom.ChatFilteringHandler;
   import com.moviestarplanet.chat.chatroom.CommunicationHandler;
   import com.moviestarplanet.chat.video.videochatroom.VideoChatRoom;
   import com.moviestarplanet.chatCommunicator.chatHelpers.chatpermission.ChatPermissionEvent;
   import com.moviestarplanet.chatCommunicator.chatHelpers.chatpermission.ChatPermissionManager;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.chatCommunicator.chatHelpers.configuration.InputLocations;
   import com.moviestarplanet.chatCommunicator.chatHelpers.model.valueobjects.ActorCommunicationVO;
   import com.moviestarplanet.chatrooms.model.NotificationChatromObject;
   import com.moviestarplanet.chatutils.ChatServerCommands;
   import com.moviestarplanet.chatutils.GUID;
   import com.moviestarplanet.chatutils.chatroom.ChatroomConstants;
   import com.moviestarplanet.clientcensor.WhiteListBase;
   import com.moviestarplanet.clientcensor.textfield.TextFieldInputEmoticon;
   import com.moviestarplanet.clientcensor.textfield.TextFieldInputRestricted;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.configurations.FeatureToggle;
   import com.moviestarplanet.connections.ConnectionManager;
   import com.moviestarplanet.constants.ConstantsPlatform;
   import com.moviestarplanet.constants.analytics.FeatureUsage;
   import com.moviestarplanet.constants.analytics.TimeSpentConstants;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.flash.icons.MessagingIcons;
   import com.moviestarplanet.giftHunt.IGiftArea;
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   import com.moviestarplanet.globalsharedutils.SnapshotUrl;
   import com.moviestarplanet.icons.CurrencyIconsShared;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.loader.ILoaderUrl;
   import com.moviestarplanet.logging.services.loggingservice.LoggingAmfService;
   import com.moviestarplanet.managers.SoundManager;
   import com.moviestarplanet.mangroveanalytics.MangroveAnalytics;
   import com.moviestarplanet.mangroveanalytics.constants.EntityActionEventConst;
   import com.moviestarplanet.mangroveanalytics.utilities.MangroveFeatureTracker;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.model.IActorModel;
   import com.moviestarplanet.model.notification.NotificationType;
   import com.moviestarplanet.moviestar.MovieStar;
   import com.moviestarplanet.moviestar.controller.AddClickItemToMovieStarCommand;
   import com.moviestarplanet.moviestar.controller.SetMovieStarBadgeCommand;
   import com.moviestarplanet.moviestar.utils.AppearanceData;
   import com.moviestarplanet.moviestar.valueObjects.ActorMinimal;
   import com.moviestarplanet.msg.ActionEvent;
   import com.moviestarplanet.msg.MSPDataEvent;
   import com.moviestarplanet.msg.events.CareerQuestEvent;
   import com.moviestarplanet.msg.events.CareerQuestsGoToDestinations;
   import com.moviestarplanet.msg.events.QuestEvent;
   import com.moviestarplanet.notification.INotificationObject;
   import com.moviestarplanet.popup.OldPopupHandler;
   import com.moviestarplanet.quest.gifthunt.GiftHuntAreas;
   import com.moviestarplanet.quest.gifthunt.GiftHuntManager;
   import com.moviestarplanet.quest.gifthunt.GiftHuntMapping;
   import com.moviestarplanet.safety.MovieStarSafetySticker;
   import com.moviestarplanet.services.wrappers.CommonService;
   import com.moviestarplanet.services.wrappers.SessionService;
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import com.moviestarplanet.userbehavior.UserBehaviorResult;
   import com.moviestarplanet.utils.DateUtils;
   import com.moviestarplanet.utils.DisplayUtils;
   import com.moviestarplanet.utils.EntityTypeType;
   import com.moviestarplanet.utils.GameObject;
   import com.moviestarplanet.utils.InputObserver;
   import com.moviestarplanet.utils.MSP_AnimatedStateButton;
   import com.moviestarplanet.utils.MSP_SWFLoader;
   import com.moviestarplanet.utils.MultiPlayerGame;
   import com.moviestarplanet.utils.PropSorter;
   import com.moviestarplanet.utils.SharedActor;
   import com.moviestarplanet.utils.SnapshotUtils;
   import com.moviestarplanet.utils.TamperTechnology;
   import com.moviestarplanet.utils.Utils;
   import com.moviestarplanet.utils.WinSpendTypes;
   import com.moviestarplanet.utils.actorvalues.ActorValueManager;
   import com.moviestarplanet.utils.chat.ChatLogic;
   import com.moviestarplanet.utils.color.ColorFilterUtilities;
   import com.moviestarplanet.utils.displayobject.DisplayObjectUtilities;
   import com.moviestarplanet.utils.displayobject.FlattenUtilities;
   import com.moviestarplanet.utils.displayobject.MyRoomSnapshotTool;
   import com.moviestarplanet.utils.flash.MSP_FlashLoader;
   import com.moviestarplanet.utils.input.InputAreaInterface;
   import com.moviestarplanet.utils.input.InputUtils;
   import com.moviestarplanet.utils.loader.AssetUrl;
   import com.moviestarplanet.utils.loader.ContentUrl;
   import com.moviestarplanet.utils.loader.MSP_LoaderManager;
   import com.moviestarplanet.utils.loader.RawUrl;
   import com.moviestarplanet.utils.sound.Sounds;
   import com.moviestarplanet.utils.swfmapping.PathSelector;
   import com.moviestarplanet.utils.swfmapping.PropertyMappingAction;
   import com.moviestarplanet.utils.swfmapping.PropertyMappingInterface;
   import com.moviestarplanet.utils.swfmapping.SWFPropertyBinder;
   import com.moviestarplanet.utils.swfmapping.visualmapping.AbstractPropertyMappingVisual;
   import com.moviestarplanet.utils.swfmapping.visualmapping.PropertyMappingVisualUrl;
   import com.moviestarplanet.utils.tooltips.MSP_ToolTipManager;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.utils.ui.FlashInstanceUtils;
   import com.moviestarplanet.window.stack.WindowStack;
   import com.moviestarplanet.window.utils.PopupUtils;
   import com.moviestarplanet.windowpopup.popup.Prompt;
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
   import mx.containers.Box;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.LinkButton;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Glow;
   import mx.effects.Sequence;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class ChatRoom extends ViewComponentCanvas implements IGiftArea, InputAreaInterface, IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      private static const SWF_URL_INVITE:String = new AssetUrl("ChatRoom/InviteFriends_icon.swf",AssetUrl.ICON).toString();
      
      private static const SWF_URL_MYPROFILE:String = new AssetUrl("MyProfileIcon.swf",AssetUrl.ICON).toString();
      
      private static const SWF_URL_WAVE:String = new AssetUrl("ChatRoom/WaveAnimation.swf",AssetUrl.ICON).toString();
      
      private static const SWF_URL_JUMP:String = new AssetUrl("ChatRoom/JumpAnimation.swf",AssetUrl.ICON).toString();
      
      private static const SWF_URL_DANCE:String = new AssetUrl("ChatRoom/DanceAnimation.swf",AssetUrl.ICON).toString();
      
      private static const SWF_URL_ANIMLIST:String = new AssetUrl("ChatRoom/AnimationList_icon.swf",AssetUrl.ICON).toString();
      
      private static const SWF_URL_FACE:String = new AssetUrl("ChatRoom/face_icon.swf",AssetUrl.ICON).toString();
      
      private static const SWF_URL_GAME:String = new AssetUrl("games/gameIconVer3.swf",AssetUrl.SWF).toString();
      
      private static const SWF_URL_COUNTER:String = new AssetUrl("button_counter.swf",AssetUrl.ICON).toString();
      
      private static const SWF_URL_LOVEIT:String = new AssetUrl("button_loveit_animated.swf",AssetUrl.ICON).toString();
      
      private static const REWARD_FACE_TIMEOUT:Number = 5000;
      
      private static const starcoinShooterButtonUrl:String = "swf/diamondshop/scshooter/StarcoinShooterChatroomButton.swf";
      
      private static const starcoinShooterBgUrl:String = "swf/diamondshop/scshooter/StarcoinShooterChatroomBackgroundOverlay.swf";
      
      private static const starcoinShooterAnim:String = "scshooter";
      
      private static const starcoinShooterAnimTime:Number = 17500;
      
      public static const CHAT_ROOM:int = 0;
      
      public static const GAME_ROOM:int = 1;
      
      public static const MY_ROOM:int = 2;
      
      private var _1114030728LoveAndCommentsContainer:HBox;
      
      public var _ChatRoom_MSP_ClickImage2:MSP_ClickImage;
      
      private var _1316383979btnAnimations:MSP_ClickImage;
      
      private var _2082937527btnDance:MSP_ClickImage;
      
      private var _1720930735btnFaceExpression:MSP_ClickImage;
      
      private var _2085707205btnGames:MSP_ClickImage;
      
      private var _205936810btnJump:MSP_ClickImage;
      
      private var _764673619btnStarcoinShooter:UIComponent;
      
      private var _206305141btnWave:MSP_ClickImage;
      
      private var _2049440364btn_Invite:MSP_ClickImage;
      
      private var _1900815491canvasActor:Canvas;
      
      private var _968087718canvasBackground:Canvas;
      
      private var _790582501canvasControl:Canvas;
      
      private var _1731131734canvasSpeach:Canvas;
      
      private var _1883684996canvasStuff:Canvas;
      
      private var _1295020847chatRoomSelect:ChatRoomSelector;
      
      private var _408587541controlCanvas:Canvas;
      
      private var _407017993emoticonButtonContainer:UIComponent;
      
      private var _398505595fontColorButtonContainer:UIComponent;
      
      private var _3175821glow:Sequence;
      
      private var _760634046hboxselector:HBox;
      
      private var _676681552lblCaption:Label;
      
      private var _174103365likeBtn:MSP_AnimatedStateButton;
      
      private var _1114809071likesLoader:MSP_SWFLoader;
      
      private var _1392072535lockedText:Label;
      
      private var _513172914lovesCount:Label;
      
      private var _106111099outer:Canvas;
      
      private var _1173402135selectorCanvas:Canvas;
      
      private var _1684008345sliderCanvas:Canvas;
      
      private var _1315469055starGlow:Sequence;
      
      private var _2124835091starGlow2:Sequence;
      
      private var _2124835092starGlow3:Sequence;
      
      private var _2124835093starGlow4:Sequence;
      
      private var _2124835094starGlow5:Sequence;
      
      private var _2124835095starGlow6:Sequence;
      
      private var _2124835096starGlow7:Sequence;
      
      private var _2124835097starGlow8:Sequence;
      
      private var _817382675textTextLineContainer:UIComponent;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var m_objAnimationManager:AnimationManager;
      
      public var roomId:String;
      
      private var swfBackground:MSP_SWFLoader;
      
      public var actorTable:Array;
      
      protected var actorMessageTable:Array;
      
      public var text_so:SharedObject;
      
      public var actorId:Number;
      
      private var dummyActor:MovieStar;
      
      public var mySharedActor:SharedActor;
      
      private var myMovieStar:MovieStar;
      
      private var pooFlag:Boolean = false;
      
      private var moderatorSticker:MovieStarSafetySticker;
      
      private var disableButtons:Boolean = false;
      
      private var communicationHandler:CommunicationHandler;
      
      private var chatFilteringHandler:ChatFilteringHandler;
      
      private var _starcoinShooterPlaying:Boolean = false;
      
      private var starcoinShooters:Object;
      
      private var starcoinShooterBgLoader:MSP_SWFLoader;
      
      private var starcoinShooterButton:MovieClip;
      
      private var friendMovieStarCache:Object;
      
      protected var MIN_CLICKABLE_Y_COORD:Number = 0;
      
      protected var HORIZON_Y_COORD:Number;
      
      protected var X_MIN_COORD:Number;
      
      protected var X_MAX_COORD:Number;
      
      private var _emoticonButton:MovieClip;
      
      private var _fontColorButton:FontColorButton;
      
      public var textTextLine:TextFieldInputEmoticon;
      
      private var textBackground:MovieClip;
      
      public var fontColor:int = 0;
      
      private var isInChat:Boolean = false;
      
      private var isInMyRoom:Boolean = false;
      
      private const LONG_ANIM_TIME:int = 60000;
      
      private const SHORT_ANIM_TIME:int = 30000;
      
      private var actorMinimal:ActorMinimal;
      
      private var isMovieStarLoaded:Boolean;
      
      private var isStuffViewItemsLoaded:Boolean;
      
      private var hasAlreadyTriggeredSnapshot:Boolean;
      
      [Inject]
      public var actorModel:IActorModel;
      
      public var roomLocation:int;
      
      private var _publicProfile:PublicProfile;
      
      private var adMappers:Array;
      
      protected var binder:SWFPropertyBinder;
      
      protected var roomType:ChatRoomType;
      
      protected var minigameType:MiniGameType;
      
      private var giftsContainer:UIComponent;
      
      protected var firstTimeSync:Boolean = false;
      
      public var isExiting:Boolean = false;
      
      private var moveDuration:int = 6;
      
      private var _isInRunMode:Boolean;
      
      public var sortOrder:Array;
      
      private var actorsInsideChatroom:Object;
      
      private var battle:MultiPlayerGame;
      
      protected var initialX:Number;
      
      private var initialY:Number = 420;
      
      public var myClickItemString:String = "";
      
      public var closeHandler:Function = null;
      
      private var isReconnecting:Boolean = false;
      
      private var myRoomReadyToGo:Boolean = false;
      
      public var curMinigame:MiniGameBase = null;
      
      private var sendTimer:Timer;
      
      private var sendPositionPos:Point;
      
      private const SCALE_HORIZON_DUMMY:Number = 280;
      
      public var disableWalk:Boolean = false;
      
      private var _animationSelector:AnimationSelector;
      
      private var _animationSelectorOpenend:Boolean;
      
      private var _faceExpressionSelector:FaceExpressionSelector;
      
      public var selectedFramelabel:String = "stand";
      
      private var selectedFaceExpressionKey:String = "neutral";
      
      private var selectedMouthExpressionKey:String = "none";
      
      private var animTimer:Timer;
      
      private var games:Array;
      
      private var myMovieStarIsReady:Boolean = false;
      
      private var _fmsRewardingActive:Object = null;
      
      private var pooTimer:Timer;
      
      private var isGivingAutograph:Boolean = false;
      
      private var isGivingAutographToActorId:Number;
      
      private var actorIdRequestedGame:Number;
      
      private var _chatRoomInviter:ChatRoomInviter;
      
      private var _gamesSelector:GamesSelector;
      
      private var idleAnimTimer:Timer;
      
      private var innerIdleAnimTimer:Timer;
      
      private var cnt:int = 0;
      
      private const RANDOM_ANIMATIONS:Array;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function ChatRoom()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":ViewComponentCanvas,
            "events":{
               "addedToStage":"___ChatRoom_ViewComponentCanvas1_addedToStage",
               "initialize":"___ChatRoom_ViewComponentCanvas1_initialize"
            },
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
                  "width":980,
                  "height":500,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"outer",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "width":980,
                           "height":465,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"sliderCanvas",
                              "events":{"creationComplete":"__sliderCanvas_creationComplete"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":10,
                                    "y":10,
                                    "width":960,
                                    "height":445,
                                    "horizontalScrollPolicy":"off",
                                    "verticalScrollPolicy":"off",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"canvasBackground",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":0,
                                             "y":0,
                                             "width":2000,
                                             "height":445,
                                             "horizontalScrollPolicy":"off",
                                             "verticalScrollPolicy":"off"
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"canvasStuff",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":0,
                                             "y":0,
                                             "width":2000,
                                             "height":445,
                                             "horizontalScrollPolicy":"off",
                                             "verticalScrollPolicy":"off"
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"canvasActor",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":0,
                                             "y":0,
                                             "width":2000,
                                             "height":445,
                                             "horizontalScrollPolicy":"off",
                                             "verticalScrollPolicy":"off"
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"canvasSpeach",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":0,
                                             "y":0,
                                             "width":2000,
                                             "height":445,
                                             "horizontalScrollPolicy":"off",
                                             "verticalScrollPolicy":"off"
                                          };
                                       }
                                    })]
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"selectorCanvas",
                     "stylesFactory":function():void
                     {
                        this.backgroundAlpha = 1;
                        this.backgroundColor = 0;
                        this.borderStyle = "solid";
                        this.borderThickness = 0;
                        this.cornerRadius = 13;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "x":-3,
                           "y":-3,
                           "width":280,
                           "height":45,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":HBox,
                              "id":"hboxselector",
                              "stylesFactory":function():void
                              {
                                 this.horizontalGap = 13;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":13,
                                    "y":13,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":ChatRoomSelector,
                                       "id":"chatRoomSelect"
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":MSP_ClickImage,
                              "id":"btn_Invite",
                              "events":{"click":"__btn_Invite_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "width":25,
                                    "height":25,
                                    "includeInLayout":false,
                                    "isRectangularHitbox":true
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"lblCaption",
                     "stylesFactory":function():void
                     {
                        this.fontSize = 18;
                        this.fontWeight = "bold";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "x":175,
                           "y":10,
                           "text":"<CAPTION>"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"canvasControl",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":true,
                           "x":10,
                           "y":10,
                           "width":2000,
                           "height":480,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"controlCanvas",
                              "stylesFactory":function():void
                              {
                                 this.backgroundAlpha = 1;
                                 this.backgroundColor = 0;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":0,
                                    "y":445,
                                    "width":960,
                                    "height":35,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":UIComponent,
                                       "id":"textTextLineContainer",
                                       "events":{
                                          "creationComplete":"__textTextLineContainer_creationComplete",
                                          "focusIn":"__textTextLineContainer_focusIn",
                                          "focusOut":"__textTextLineContainer_focusOut"
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "visible":true,
                                             "x":5,
                                             "y":6,
                                             "width":460,
                                             "height":22
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":UIComponent,
                                       "id":"fontColorButtonContainer",
                                       "events":{"creationComplete":"__fontColorButtonContainer_creationComplete"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "visible":false,
                                             "x":475,
                                             "y":5,
                                             "width":20,
                                             "height":20,
                                             "alpha":0.8
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":UIComponent,
                                       "id":"emoticonButtonContainer",
                                       "events":{"creationComplete":"__emoticonButtonContainer_creationComplete"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "visible":false,
                                             "x":500,
                                             "y":5,
                                             "width":20,
                                             "height":20,
                                             "alpha":0.8
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":HBox,
                                       "id":"LoveAndCommentsContainer",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "visible":false,
                                             "x":545,
                                             "top":5,
                                             "width":520,
                                             "includeInLayout":false,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function():void
                                                {
                                                   this.paddingTop = 3;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"childDescriptors":[new UIComponentDescriptor({
                                                      "type":MSP_SWFLoader,
                                                      "id":"likesLoader",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "alpha":1,
                                                            "autoLoad":true,
                                                            "scaleContent":false,
                                                            "scaleX":1.2,
                                                            "scaleY":1.2
                                                         };
                                                      }
                                                   })]};
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function():void
                                                {
                                                   this.paddingTop = -3;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"childDescriptors":[new UIComponentDescriptor({
                                                      "type":MSP_AnimatedStateButton,
                                                      "id":"likeBtn",
                                                      "events":{"click":"__likeBtn_click"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "visible":false,
                                                            "width":78,
                                                            "height":35,
                                                            "autoLoad":true,
                                                            "buttonMode":true,
                                                            "includeInLayout":false,
                                                            "scaleContent":true,
                                                            "useHandCursor":true
                                                         };
                                                      }
                                                   })]};
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"lovesCount",
                                                "stylesFactory":function():void
                                                {
                                                   this.color = 16777215;
                                                   this.fontSize = 24;
                                                   this.fontWeight = "bold";
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"text":"0"};
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Box,
                                                "stylesFactory":function():void
                                                {
                                                   this.paddingTop = 4;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"childDescriptors":[new UIComponentDescriptor({
                                                      "type":MSP_ClickImage,
                                                      "id":"_ChatRoom_MSP_ClickImage2",
                                                      "events":{"click":"___ChatRoom_MSP_ClickImage2_click"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":27,
                                                            "height":27,
                                                            "isRectangularHitbox":true
                                                         };
                                                      }
                                                   })]};
                                                }
                                             })]
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":HBox,
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "y":7,
                                             "right":5,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":UIComponent,
                                                "id":"btnStarcoinShooter",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "visible":false,
                                                      "width":80,
                                                      "height":25,
                                                      "includeInLayout":false
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":MSP_ClickImage,
                                                "id":"btnWave",
                                                "events":{"click":"__btnWave_click"},
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "width":25,
                                                      "height":25,
                                                      "isRectangularHitbox":true
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":MSP_ClickImage,
                                                "id":"btnJump",
                                                "events":{"click":"__btnJump_click"},
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "width":25,
                                                      "height":25,
                                                      "isRectangularHitbox":true
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":MSP_ClickImage,
                                                "id":"btnDance",
                                                "events":{"click":"__btnDance_click"},
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "width":25,
                                                      "height":25,
                                                      "isRectangularHitbox":true
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":MSP_ClickImage,
                                                "id":"btnAnimations",
                                                "events":{"click":"__btnAnimations_click"},
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "width":25,
                                                      "height":25,
                                                      "isRectangularHitbox":true
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function():void
                                                {
                                                   this.paddingTop = 2;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"childDescriptors":[new UIComponentDescriptor({
                                                      "type":MSP_ClickImage,
                                                      "id":"btnFaceExpression",
                                                      "events":{"click":"__btnFaceExpression_click"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":25,
                                                            "height":25,
                                                            "isRectangularHitbox":true
                                                         };
                                                      }
                                                   })]};
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function():void
                                                {
                                                   this.paddingTop = 2;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"childDescriptors":[new UIComponentDescriptor({
                                                      "type":MSP_ClickImage,
                                                      "id":"btnGames",
                                                      "events":{"click":"__btnGames_click"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":25,
                                                            "height":25,
                                                            "isRectangularHitbox":true
                                                         };
                                                      }
                                                   })]};
                                                }
                                             })]
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"lockedText",
                              "stylesFactory":function():void
                              {
                                 this.color = 16711680;
                                 this.fontSize = 20;
                                 this.fontWeight = "bold";
                                 this.textAlign = "center";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":0,
                                    "y":445,
                                    "width":960,
                                    "height":35,
                                    "text":"Locked by Moderator. You will be unlocked shortly if you behave nicely."
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":CloseButton,
                     "events":{"click":"___ChatRoom_CloseButton1_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":955,
                           "y":5
                        };
                     }
                  })]
               };
            }
         });
         this.actorTable = new Array();
         this.actorMessageTable = new Array();
         this.starcoinShooters = {};
         this.friendMovieStarCache = {};
         this._emoticonButton = new MovieClip();
         this._fontColorButton = new FontColorButton();
         this.textTextLine = new TextFieldInputEmoticon();
         this.sortOrder = new Array();
         this.sendPositionPos = new Point();
         this.games = new Array();
         this.RANDOM_ANIMATIONS = ["idle_2012_foottap_dg","idle_2012_legscratch_dg","idle_2012_scratch_dg","idle_2012_sneeze_dg","idle_2012_weightshift_dg"];
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         bindings = this._ChatRoom_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_com_moviestarplanet_Forms_ChatRoomWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return ChatRoom[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.width = 980;
         this.height = 500;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this._ChatRoom_Sequence1_i();
         this._ChatRoom_Sequence2_i();
         this._ChatRoom_Sequence3_i();
         this._ChatRoom_Sequence4_i();
         this._ChatRoom_Sequence5_i();
         this._ChatRoom_Sequence6_i();
         this._ChatRoom_Sequence7_i();
         this._ChatRoom_Sequence8_i();
         this._ChatRoom_Sequence9_i();
         this.addEventListener("addedToStage",this.___ChatRoom_ViewComponentCanvas1_addedToStage);
         this.addEventListener("initialize",this.___ChatRoom_ViewComponentCanvas1_initialize);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function getNameFromroomId(param1:String) : String
      {
         var _loc2_:ChatRoomType = ChatRoomType.getChatType(param1);
         if(_loc2_ != null)
         {
            return _loc2_.localeText;
         }
         return "";
      }
      
      public static function generateChatRoomSnapshotByteArray(param1:int, param2:int, param3:StuffView, param4:Array) : ByteArray
      {
         var _loc5_:Number = Number(param3.canvasBackground.height);
         var _loc6_:Number = Number(param3.width);
         var _loc7_:Number = param1 / param2;
         var _loc8_:int = _loc5_ * _loc7_;
         var _loc9_:int = _loc5_;
         var _loc10_:Number = param2 / _loc9_;
         var _loc11_:Number = (_loc6_ - _loc8_) * _loc10_ / 2;
         var _loc12_:Number = (param3.height - _loc5_) * _loc10_ / 2;
         return MyRoomSnapshotTool.makeRoomSnapshotWithBounds(param4,param1,param2,_loc10_,_loc11_,_loc12_);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         ChatRoom._watcherSetupUtil = param1;
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
            this.cornerRadius = 10;
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function init() : void
      {
         InjectionManager.manager().injectMe(this);
         this.communicationHandler = new CommunicationHandler(this);
         this.chatFilteringHandler = new ChatFilteringHandler(this);
         this.setupInput();
      }
      
      private function setupInput() : void
      {
         if(this.actorModel.isModerator && !this.actorModel.isModeratorHidden)
         {
            this.textTextLine.disableUserInput();
         }
         else
         {
            this.textTextLine.enableUserInput();
         }
      }
      
      private function onCreation(param1:Event = null) : void
      {
         var scshooterButtonLoaded:Function = null;
         var evt:Event = param1;
         scshooterButtonLoaded = function(param1:MSP_SWFLoader):void
         {
            var _loc2_:Class = param1.content.loaderInfo.applicationDomain.getDefinition("SCShooterChatroomButton") as Class;
            starcoinShooterButton = new _loc2_() as MovieClip;
            starcoinShooterButton.x += 10;
            starcoinShooterButton.y -= 5;
            MSP_ToolTipManager.add(starcoinShooterButton,MSPLocaleManagerWeb.getInstance().getString("DIAMONDS_SPECIALS_STARCOINSHOOTER"));
            btnStarcoinShooter.addChild(starcoinShooterButton);
         };
         if(ChatRoomController.currentRoomPublic == "" && !this.isInMinigame)
         {
            this.sliderCanvas.horizontalScrollPosition = StuffView.SPACE_BETWEEN_ROOMS * ChatRoomController.currentRoomSection;
         }
         MSP_SWFLoader.RequestLoad(new RawUrl(starcoinShooterButtonUrl),scshooterButtonLoaded,MSP_LoaderManager.PRIORITY_UI);
      }
      
      override public function Enter() : void
      {
         var adUrlMapper:PropertyMappingVisualUrl;
         var adClickMapper:PropertyMappingAction;
         var iClick:Function = null;
         var mapper:PropertyMappingInterface = null;
         var noteObject:INotificationObject = null;
         iClick = function(param1:Object):void
         {
            navigateToURL(new URLRequest("http://openx.radialnetwork.com/www/delivery/ck.php?n=a619bc59&cb=123456789"),"_blank");
         };
         if(this.isExiting)
         {
            callLater(this.Enter);
            return;
         }
         if(this.roomId != null && this.roomId != "")
         {
            this.Exit();
            callLater(this.Enter);
            return;
         }
         if(this.myMovieStar != null)
         {
            this.myMovieStar.synchronizeClothing();
            this.myMovieStar.synchronizeAppearance();
         }
         if(this.curMinigame != null)
         {
            this.curMinigame = null;
         }
         this.actorId = ActorSession.getActorId();
         adUrlMapper = new PropertyMappingVisualUrl(new PathSelector(AdHolder,"content"),"http://openx.radialnetwork.com/www/delivery/avw.php?zoneid=13&amp;cb=123456789&amp;n=a619bc59&amp;ct0=http%3a%2f%2fopenx.radialnetwork.com%2fwww%2fdelivery%2fck.php%3fn%3da619bc59%26cb%3d123456789",AbstractPropertyMappingVisual.FITTING_STRATEGY_STRETCH);
         adClickMapper = new PropertyMappingAction(new PathSelector(AdHolder,"content"),iClick);
         this.adMappers = new Array();
         this.adMappers.push(adUrlMapper);
         this.adMappers.push(adClickMapper);
         this.binder = new SWFPropertyBinder();
         for each(mapper in this.adMappers)
         {
            this.binder.addPropertyMapping(mapper);
         }
         this.binder.cacheAsBitmap = true;
         this.binder.opaqueBackground = 0;
         this.binder.addEventListener(MSPEvent.PROPERTY_BINDER_CONTENT_READY,this.backgroundLoaded);
         this.X_MIN_COORD = 0;
         this.X_MAX_COORD = 2000;
         this.HORIZON_Y_COORD = 290;
         this.roomType = ChatRoomType.getChatType(ChatRoomController.currentRoomPublic);
         if(this.giftsContainer == null)
         {
            this.giftsContainer = new UIComponent();
            addChild(this.giftsContainer);
         }
         if(this.roomType != null)
         {
            this.isInChat = true;
            MessageCommunicator.send(new MsgEvent(CareerQuestEvent.USER_CLICKED_BUTTON,CareerQuestsGoToDestinations.OPEN_CHAT_ROOM));
            this.binder.url = new ContentUrl(this.roomType.background,-1).toString();
            this.roomLocation = this.roomType.roomLocId;
            this.HORIZON_Y_COORD = this.roomType.maxYCord;
            this.X_MIN_COORD = this.roomType.minXCord;
            this.btnGames.visible = this.btnGames.includeInLayout = true;
            if(Utils.getClass(this) != VideoChatRoom)
            {
               this.initSpecialsService();
            }
            if(this.isInThemeRoom)
            {
               this.X_MAX_COORD = 980;
               this.canvasBackground.width = 980;
               this.canvasStuff.width = 980;
               this.canvasSpeach.width = 980;
            }
         }
         else if(RoomRequester.isMinigameType(ChatRoomController.currentRoomPublic))
         {
            this.minigameType = MiniGameType.getMinigameByRoomStr(ChatRoomController.currentRoomPublic);
            this.curMinigame = this.minigameType.instance;
            this.binder.url = Config.toAbsoluteURL(this.minigameType.backgroundSwfName,Config.LOCAL_CDN_URL);
            this.HORIZON_Y_COORD = this.curMinigame.gamePlayerRect.minY;
            this.X_MIN_COORD = this.curMinigame.gamePlayerRect.minX;
            this.X_MAX_COORD = this.curMinigame.gamePlayerRect.maxX;
            this.roomLocation = this.minigameType.roomLocId;
            this.btnGames.visible = this.btnGames.includeInLayout = false;
            this.showSpecialsService(false);
         }
         else
         {
            this.isInMyRoom = true;
            this.btnGames.visible = this.btnGames.includeInLayout = true;
            this.showSpecialsService(false);
            this.roomLocation = InputLocations.LOC_CHAT_USER_ROOM;
         }
         this.enteringSwrveEvent();
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.leavingSwrveEvent);
         if(this.isPrivateRoom())
         {
            this.MIN_CLICKABLE_Y_COORD = 80;
            this.HORIZON_Y_COORD = 305;
            this.X_MIN_COORD = 0;
            this.X_MAX_COORD = 980;
            this.canvasBackground.width = 980;
            this.canvasStuff.width = 980;
            this.canvasSpeach.width = 980;
            this.canvasActor.width = StuffView.SPACE_BETWEEN_ROOMS * (StuffView.MAX_ROOMS - 1) + this.outer.width;
            this.canvasSpeach.width = this.canvasActor.width;
            this._publicProfile = new PublicProfile();
            this._publicProfile.actorId = ChatRoomController.currentRoomActorId;
            this._publicProfile.movieCompetition = ChatRoomController.currentRoomCompetition;
            this._publicProfile.closeHandler = ChatRoomController.currentRoomCloseHandler;
            this._publicProfile.update();
            this.outer.addChildAt(this._publicProfile,0);
            this.outer.addEventListener(MouseEvent.CLICK,this.mouseDown);
            this.lblCaption.text = ChatRoomController.currentRoomName;
            this.sliderCanvas.horizontalScrollPosition = StuffView.SPACE_BETWEEN_ROOMS * ChatRoomController.currentRoomSection;
            this._publicProfile.stuffView.addEventListener(StuffView.ALLITEMSLOADED,this.onAllItemsLoaded);
         }
         else
         {
            this.canvasBackground.width = 2000;
            this.canvasStuff.width = 2000;
            this.canvasSpeach.width = 2000;
            this.canvasActor.width = 2000;
            this.canvasSpeach.width = 2000;
            this.lblCaption.text = ChatRoomController.currentRoomName;
            if(!this.isInMinigame)
            {
               this.sliderCanvas.horizontalScrollPosition = 500;
            }
            else
            {
               this.sliderCanvas.horizontalScrollPosition = 0;
            }
         }
         this.invokeClassSpecificLogic(this.roomType);
         this.toggleSelectorCanvas();
         this.roomId = RoomRequester.roomId;
         this.loadMyActor(this.actorId);
         this.m_objAnimationManager = new AnimationManager();
         if(!this.isInMinigame)
         {
            if(!this.isPrivateRoom())
            {
               noteObject = NotificationChatromObject.create(ActorSession.getActorId(),ActorSession.loggedInActor.Name,NotificationType.CHATROOM_ENTER.type,ChatRoomController.currentRoomPublic);
               FriendshipManager.getInstance().sendNotificationToFriends(noteObject);
            }
            else if(FriendshipManager.getInstance().lastActivityType != NotificationType.MYROOM.type)
            {
               noteObject = NotificationChatromObject.create(ActorSession.getActorId(),ActorSession.loggedInActor.Name,NotificationType.CHATROOM_ENTER.type,ChatRoomController.currentRoomActorId + "_room",ChatRoomController.currentRoomName,ChatRoomController.currentRoomActorId,ChatRoomController.currentRoomSection);
               FriendshipManager.getInstance().sendNotificationToFriends(noteObject);
            }
            else
            {
               FriendshipManager.getInstance().resetLastActivityType();
            }
         }
         addEventListener(Event.ENTER_FRAME,this.HandleEnterFrame);
         MessageCommunicator.subscribe(GiveAutographButton.AUTOGRAPH_GIVEN,this.giveAutograph);
         MessageCommunicator.subscribe(GamesManager.REQUEST_DANCE_BATTLE_CHATROOM_GAME,this.requestDanceBattleGame);
         MessageCommunicator.subscribe(GamesManager.REQUEST_FIGHT_BATTLE_CHATROOM_GAME,this.requestFightBattleGame);
         MessageCommunicator.subscribe(GamesManager.REQUEST_FLASH_BATTLE_CHATROOM_GAME,this.requestFlashBattleGame);
         MessageCommunicator.subscribe(GamesManager.REQUEST_FLASH_BATTLE_ADVANCED_CHATROOM_GAME,this.requestFlashAdvancedBattleGame);
         MessageCommunicator.subscribe(GamesManager.REQUEST_CATCH_STARS_CHATROOM_GAME,this.requestCatchStarsGame);
         MessageCommunicator.subscribe(GamesManager.REQUEST_QUIZ_CHATROOM_GAME,this.requestQuizGame);
         MessageCommunicator.subscribe(MSPDataEvent.AWARD_DISTRUBTED,this.onActorDailyAward);
         MessageCommunicator.subscribe(MSPEvent.FMS_COM_DISCONNECTED,this.onComDisconnect);
         MessageCommunicator.subscribe(MSPEvent.BONSTER_ANIMATION_SELECTED,this.onBonsterAnimSelected);
         MessageCommunicator.subscribe(MSPEvent.MY_CLOTHES_CHANGED,this.onClothesChanged);
         ChatPermissionManager.instance.addEventListener(ChatPermissionEvent.CHAT_PERMISSION_UPDATE,this.onChatPermissionUpdate);
         this.setIdleKickTimer();
         this._chatRoomInviter = null;
      }
      
      private function onAllItemsLoaded(param1:Event) : void
      {
         this._publicProfile.stuffView.removeEventListener(StuffView.ALLITEMSLOADED,this.onAllItemsLoaded);
         this.isStuffViewItemsLoaded = true;
         if(this.isMovieStarLoaded)
         {
            this.triggerRoomSnapshots();
         }
      }
      
      public function getAreaType() : int
      {
         return GiftHuntAreas.GIFT_AREA_CHAT_ROOM;
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         setTimeout(this.addGiftsToArea,1);
      }
      
      private function addGiftsToArea() : void
      {
         var callback:Function = null;
         callback = function(param1:Vector.<GiftHuntMapping>):void
         {
            var _loc2_:int = 0;
            while(_loc2_ < param1.length)
            {
               GiftHuntManager.getInstance().placeGiftFlash(giftsContainer,param1[_loc2_]);
               _loc2_++;
            }
         };
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         GiftHuntManager.getInstance().getGiftsMappingFromArea(this,callback);
      }
      
      private function onBonsterAnimSelected(param1:MsgEvent) : void
      {
         this.sendBonsterAnimationToFriends(param1.data.bonsterAnimation);
      }
      
      protected function invokeClassSpecificLogic(param1:ChatRoomType) : void
      {
      }
      
      private function isPrivateRoom() : Boolean
      {
         return ChatRoomController.currentRoomPublic == "";
      }
      
      private function toggleSelectorCanvas() : void
      {
         this.LoveAndCommentsContainer.visible = false;
         if(!this.isInMinigame)
         {
            if(this.isPrivateRoom())
            {
               this.selectorCanvas.visible = false;
               this.chatRoomSelect.visible = this.chatRoomSelect.includeInLayout = false;
               this.addChild(this.btn_Invite);
               this.btn_Invite.visible = true;
               this.LoveAndCommentsContainer.visible = true;
               this.btn_Invite.setStyle("right","30");
               this.btn_Invite.setStyle("top","5");
               this.btn_Invite.y = 0;
            }
            if(!this.isPrivateRoom())
            {
               this.selectorCanvas.visible = true;
               this.hboxselector.addChild(this.btn_Invite);
               this.btn_Invite.visible = true;
               this.chatRoomSelect.visible = this.chatRoomSelect.includeInLayout = true;
               this.chatRoomSelect.refresh();
            }
         }
         else
         {
            this.selectorCanvas.visible = false;
            this.btn_Invite.visible = false;
            this.chatRoomSelect.visible = this.chatRoomSelect.includeInLayout = false;
         }
      }
      
      private function setIdleKickTimer() : void
      {
         MessageCommunicator.subscribe(MSPEvent.IDLE_TIMES_UP,this.onIdleTimesUp);
         var _loc1_:int = 0;
         if(this.isInMinigame)
         {
            _loc1_ = InputObserver.MINIGAMES_IDLE_KICK_SECONDS;
         }
         else
         {
            _loc1_ = InputObserver.CHATROOM_IDLE_KICK_SECONDS;
         }
         InputObserver.startIdleTimer(_loc1_);
      }
      
      private function onIdleTimesUp(param1:MsgEvent) : void
      {
         var _loc2_:String = "";
         if(this.isInMinigame)
         {
            _loc2_ = MSPLocaleManagerWeb.getInstance().getString("IDLE_DISCONNECT_GAME_TEXT");
         }
         else
         {
            _loc2_ = MSPLocaleManagerWeb.getInstance().getString("IDLE_DISCONNECT_TEXT");
         }
         this.close();
         Prompt.show(_loc2_);
      }
      
      public function reloadRoom() : void
      {
         var _loc2_:Object = null;
         var _loc3_:UIComponent = null;
         var _loc1_:Number = this.sortOrder.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = this.sortOrder[_loc1_];
            if(!(_loc2_ is MovieStar))
            {
               _loc3_ = this.sortOrder[_loc1_];
               _loc3_.parent.removeChild(_loc3_);
               this.sortOrder.splice(_loc1_,1);
            }
            _loc1_--;
         }
         this._publicProfile.update(false);
      }
      
      private function HandleEnterFrame(param1:Event) : void
      {
         this.SortFiguresAccordingToY();
         if(this.starcoinShooterPlaying)
         {
            this.sortStuff();
         }
         this.SetSlider();
         this.DisplayAllQuizIcons();
      }
      
      private function SetSlider() : void
      {
         if(!this.isInMinigame && ChatRoomController.currentRoomPublic != "" && !this.isInThemeRoom)
         {
            if(this.sliderCanvas.horizontalScrollPosition > 0 && this.mySharedActor.movieStar.x - 200 < this.sliderCanvas.horizontalScrollPosition && this.mySharedActor.movieStar.x != 0)
            {
               this.sliderCanvas.horizontalScrollPosition = this.mySharedActor.movieStar.x - 200;
            }
            if(this.sliderCanvas.horizontalScrollPosition < 1040 && this.mySharedActor.movieStar.x + 200 > this.sliderCanvas.horizontalScrollPosition + 960)
            {
               this.sliderCanvas.horizontalScrollPosition = this.mySharedActor.movieStar.x + 200 - 960;
            }
         }
      }
      
      private function backgroundLoaded(param1:Event) : void
      {
         this.canvasBackground.addChildAt(this.binder,0);
         this.canvasBackground.addEventListener(MouseEvent.CLICK,this.mouseDown);
         this.onBackgroundLoaded();
      }
      
      protected function onBackgroundLoaded() : void
      {
         var _loc1_:Number = ApplicationReference.getApplicationScale();
         FlattenUtilities.flattenSprite(this.binder.content,_loc1_,true,false,false);
      }
      
      public function getChatRoomType() : int
      {
         var _loc1_:ChatRoomType = ChatRoomType.getChatType(ChatRoomController.currentRoomPublic);
         if(_loc1_ != null)
         {
            return CHAT_ROOM;
         }
         if(RoomRequester.isMinigameType(ChatRoomController.currentRoomPublic))
         {
            return GAME_ROOM;
         }
         return MY_ROOM;
      }
      
      public function sendSpeechToFriends() : void
      {
         this.sendActorUpdateToRoom();
      }
      
      public function userSendAnimationInChat() : void
      {
         this.sendActorUpdateToRoom();
         MessageCommunicator.send(new QuestEvent(QuestEvent.SPECIAL_QUEST_UPDATE,{
            "action":QuestEvent.ACTION_SEND_ANIMATION_IN_CHAT,
            "increment":1
         }));
      }
      
      public function sendPetTrickToFriends(param1:int) : void
      {
         this.sendActorUpdateToRoom("",param1);
      }
      
      public function sendBonsterAnimationToFriends(param1:String) : void
      {
         this.sendActorUpdateToRoom("",-1,null,param1);
      }
      
      public function sendActorUpdateToRoom(param1:String = "", param2:int = -1, param3:UserBehaviorResult = null, param4:String = null) : void
      {
         if(param3 == null)
         {
            param3 = new UserBehaviorResult(false,null);
         }
         var _loc5_:ActorCommunicationVO = new ActorCommunicationVO();
         _loc5_.soGUID = GUID.create();
         _loc5_.actorId = this.actorId;
         _loc5_.actorName = this.actorModel.actorName;
         _loc5_.actorAction = ChatroomConstants.ACTOR_COMMUNICATION;
         _loc5_.posX = this.mySharedActor.x;
         _loc5_.posY = this.mySharedActor.y;
         _loc5_.animation = this.selectedFramelabel;
         _loc5_.message = param1;
         _loc5_.faceExpresion = this.selectedFaceExpressionKey;
         _loc5_.facing = this.mySharedActor.facingDirection;
         _loc5_.clickItemIdString = this.myClickItemString;
         _loc5_.trickIdx = param2;
         _loc5_.blacklistedMessage = param3.blacklistedMessage;
         _loc5_.whitelistedMessage = param3.whitelistedMessage;
         _loc5_.bonsterAnimation = param4;
         _loc5_.compressedActorData = SerializeUtils.serialize(this.actorMinimal);
         this.communicationHandler.sendStatus(_loc5_);
      }
      
      public function invokeEffectOnFriend(param1:Number, param2:String, param3:String) : void
      {
         var _loc5_:ActorCommunicationVO = null;
         var _loc4_:SharedActor = this.actorTable[param1];
         if(_loc4_ != null)
         {
            _loc5_ = new ActorCommunicationVO();
            _loc5_.soGUID = GUID.create();
            _loc5_.actorAction = ChatroomConstants.ACTOR_COMMUNICATION;
            _loc5_.actorId = param1;
            _loc5_.posX = _loc4_.x;
            _loc5_.posY = _loc4_.y;
            _loc5_.animation = param2;
            _loc5_.message = "";
            _loc5_.faceExpresion = _loc4_.faceAnimation;
            _loc5_.facing = _loc4_.facingDirection;
            _loc5_.clickItemIdString = this.myClickItemString;
            _loc5_.effect = param3;
            _loc5_.trickIdx = -1;
            _loc5_.compressedActorData = SerializeUtils.serialize(this.actorMinimal);
            this.communicationHandler.writeToSo(param1.toString(),_loc5_);
         }
      }
      
      private function focusIn_textline() : void
      {
         if(this.textTextLine.text == "Chat")
         {
            this.textTextLine.text = "";
         }
         this.setInputFieldState("down");
         this.emoticonButtonContainer.visible = true;
         this.fontColorButtonContainer.visible = true;
      }
      
      private function focusOut_textline() : void
      {
         if(this.textTextLine.text == "")
         {
            this.textTextLine.text = "Chat";
         }
         this.setInputFieldState("normal",true);
         this.emoticonButtonContainer.visible = false;
         this.fontColorButtonContainer.visible = false;
      }
      
      override public function Exit() : void
      {
         var _loc1_:StarcoinShooter = null;
         if(this.isExiting)
         {
            return;
         }
         this.isExiting = true;
         InputObserver.stopIdleTimer();
         this.stopIdleAnimTimer();
         MessageCommunicator.unscribe(MSPEvent.IDLE_TIMES_UP,this.onIdleTimesUp);
         MessageCommunicator.unscribe(MSPEvent.FMS_COM_DISCONNECTED,this.onComDisconnect);
         MessageCommunicator.unscribe(MSPDataEvent.AWARD_DISTRUBTED,this.onActorDailyAward);
         MessageCommunicator.unscribe(MSPEvent.BONSTER_ANIMATION_SELECTED,this.onBonsterAnimSelected);
         MessageCommunicator.unscribe(MSPEvent.MY_CLOTHES_CHANGED,this.onClothesChanged);
         if(this.curMinigame)
         {
            this.curMinigame.leaveMinigame();
            MessageCommunicator.send(new ActionEvent(ActionEvent.COMPLETE_ROUND_GAME));
         }
         this.roomConnection.call(ChatServerCommands.LEAVE_CHAT_ROOM,null,ActorSession.getActorId(),this.roomId);
         this.curMinigame = null;
         MSP_LoaderManager.Reset(false);
         for each(_loc1_ in this.starcoinShooters)
         {
            _loc1_.setGameState(3);
         }
         this.starcoinShooters = {};
         this._starcoinShooterPlaying = false;
         StarcoinShooterPopup.hide();
         removeEventListener(Event.ENTER_FRAME,this.HandleEnterFrame);
         MessageCommunicator.unscribe(GiveAutographButton.AUTOGRAPH_GIVEN,this.giveAutograph);
         MessageCommunicator.unscribe(GamesManager.REQUEST_DANCE_BATTLE_CHATROOM_GAME,this.requestDanceBattleGame);
         MessageCommunicator.unscribe(GamesManager.REQUEST_FIGHT_BATTLE_CHATROOM_GAME,this.requestFightBattleGame);
         MessageCommunicator.unscribe(GamesManager.REQUEST_FLASH_BATTLE_CHATROOM_GAME,this.requestFlashBattleGame);
         MessageCommunicator.unscribe(GamesManager.REQUEST_FLASH_BATTLE_ADVANCED_CHATROOM_GAME,this.requestFlashAdvancedBattleGame);
         MessageCommunicator.unscribe(GamesManager.REQUEST_CATCH_STARS_CHATROOM_GAME,this.requestCatchStarsGame);
         MessageCommunicator.unscribe(GamesManager.REQUEST_QUIZ_CHATROOM_GAME,this.requestQuizGame);
         if(this._publicProfile != null && this._publicProfile.parent != null)
         {
            this._publicProfile.parent.removeChild(this._publicProfile);
         }
         if(this.games[1] != null && this.games[1].canvas != null)
         {
            this.games[1].canvas.stopTimer();
         }
         if(this.games[3] != null && this.games[3].canvas != null)
         {
            this.games[3].canvas.stopTimer();
         }
         if(this.games[4] != null && this.games[4].canvas != null)
         {
            this.games[4].canvas.stopTimer();
         }
         if(this.games[5] != null && this.games[5].canvas != null)
         {
            this.games[5].canvas.stopTimer();
         }
         if(this.games[6] != null && this.games[6].canvas != null)
         {
            this.games[6].canvas.stopTimer();
         }
         if(this.games[7] != null && this.games[7].canvas != null)
         {
            this.games[7].canvas.stopTimer();
         }
         ChatRoomController.isPlayingChatroomGame = false;
         this.IsInRunMode = false;
         this.disableWalk = false;
         this.sendExitToChatRoomSharedObject();
         if(this.isInMinigame)
         {
            this.curMinigame.clear();
         }
         this.actorTable = new Array();
         this.sortOrder = new Array();
         this.actorMessageTable = new Array();
         this.canvasBackground.removeEventListener(MouseEvent.CLICK,this.mouseDown);
         this.canvasStuff.removeAllChildren();
         this.canvasActor.removeAllChildren();
         this.canvasSpeach.removeAllChildren();
         this.canvasBackground.removeAllChildren();
         this.games = new Array();
         if(Boolean(this.mySharedActor) && Boolean(this.mySharedActor.movieStar) && this.mySharedActor.movieStar.clickItem is BonsterClickItemWrapper)
         {
            (this.mySharedActor.movieStar.clickItem as BonsterClickItemWrapper).destroy();
         }
         this.mySharedActor = null;
         this.closeAnimationSelector();
         this._faceExpressionSelector = null;
         if(this.starGlow.isPlaying)
         {
            this.starGlow.stop();
         }
         if(this.starGlow2.isPlaying)
         {
            this.starGlow2.stop();
         }
         if(this.starGlow3.isPlaying)
         {
            this.starGlow3.stop();
         }
         if(this.starGlow4.isPlaying)
         {
            this.starGlow4.stop();
         }
         if(this.starGlow5.isPlaying)
         {
            this.starGlow5.stop();
         }
         if(this.starGlow6.isPlaying)
         {
            this.starGlow6.stop();
         }
         if(this.starGlow7.isPlaying)
         {
            this.starGlow7.stop();
         }
         if(this.starGlow8.isPlaying)
         {
            this.starGlow8.stop();
         }
         if(Boolean(this.pooTimer) && Boolean(this.pooTimer.running))
         {
            this.pooTimer.stop();
         }
         if(this._publicProfile)
         {
            this._publicProfile.stuffView.removeEventListener(StuffView.ALLITEMSLOADED,this.onAllItemsLoaded);
            this._publicProfile.clearStuffView();
         }
         this.roomId = "";
         MessageCommunicator.sendMessage(MSPEvent.EXITING_CHATROOM,null);
         ChatPermissionManager.instance.removeEventListener(ChatPermissionEvent.CHAT_PERMISSION_UPDATE,this.onChatPermissionUpdate);
         this.isMovieStarLoaded = false;
         this.isStuffViewItemsLoaded = false;
      }
      
      public function set IsInRunMode(param1:Boolean) : void
      {
         this._isInRunMode = param1;
         if(this._isInRunMode)
         {
            this.moveDuration = 2;
         }
         else
         {
            this.moveDuration = 6;
         }
      }
      
      public function moveActor2(param1:Number, param2:Number, param3:Number) : void
      {
         var stopAnimation:Function;
         var sa:SharedActor = null;
         var m:MovieStar = null;
         var turnableClickItem:Object = null;
         var duration:Number = NaN;
         var newScale:Number = NaN;
         var p:Point = null;
         var actorId2:Number = param1;
         var x:Number = param2;
         var y:Number = param3;
         x = this.applyRestrictionX(x);
         sa = this.actorTable[actorId2];
         m = sa.movieStar;
         var actorEmoText:DisplayObject = this.actorMessageTable[actorId2];
         var compensatedY:Number = this.getFigureYFromScreenY(y);
         if(Math.abs(m.x - x) > 1 || Math.abs(m.y - compensatedY) > 1 || this.isGivingAutograph && actorId2 == ActorSession.getActorId())
         {
            stopAnimation = function():void
            {
               var _loc1_:Object = null;
               var _loc2_:SharedActor = null;
               var _loc3_:BonsterClickItemWrapper = null;
               if(isGivingAutograph && actorId2 == ActorSession.getActorId())
               {
                  _loc1_ = actorTable[isGivingAutographToActorId];
                  if(_loc1_ is SharedActor)
                  {
                     _loc2_ = _loc1_ as SharedActor;
                     if(_loc2_.x < mySharedActor.x)
                     {
                        mySharedActor.facingDirection = "L";
                        m.FaceLeft();
                     }
                     else
                     {
                        mySharedActor.facingDirection = "R";
                        m.FaceRight();
                     }
                     selectedFramelabel = "thoumbsup";
                     m.PlayAnimation(selectedFramelabel);
                     sendActorUpdateToRoom();
                     invokeEffectOnFriend(isGivingAutographToActorId,"thoumbsup","FAME");
                     isGivingAutograph = false;
                  }
               }
               else
               {
                  if(checkForNewPet(m.clickItem))
                  {
                     _loc3_ = m.clickItem as BonsterClickItemWrapper;
                     _loc3_.playAnimation(BonsterConstants.ANIMATION_STATIC);
                  }
                  m.stopWalk();
                  m.PlayAnimation(sa.animation);
               }
            };
            turnableClickItem = m.clickItem;
            if(m.x > x)
            {
               if(this.checkForNewPet(turnableClickItem))
               {
                  turnableClickItem.playAnimation(BonsterConstants.ANIMATION_WALKING,true);
                  turnableClickItem.turnLeft();
               }
               m.FaceLeft();
            }
            else if(m.x < x)
            {
               if(this.checkForNewPet(turnableClickItem))
               {
                  turnableClickItem.playAnimation(BonsterConstants.ANIMATION_WALKING,true);
                  turnableClickItem.turnRight();
               }
               m.FaceRight();
            }
            duration = (Math.abs(x - m.x) + Math.abs(compensatedY - m.y)) * this.moveDuration;
            this.m_objAnimationManager.move(m,x,compensatedY,duration,Transitions.LINEAR,RenderMethod.ENTER_FRAME);
            newScale = this.getFigureScaleFromScreenY(y);
            this.m_objAnimationManager.scale(m,newScale * m.getSkinScaleX(),newScale * m.getSkinScaleY(),duration,Transitions.LINEAR,RenderMethod.ENTER_FRAME);
            if(actorEmoText != null)
            {
               p = this.getSpeechBubblePoint(x,compensatedY);
               this.m_objAnimationManager.move(actorEmoText,p.x,p.y + (80 - actorEmoText.height),duration,Transitions.LINEAR,RenderMethod.ENTER_FRAME);
            }
            if(sa.movementTimer != null && Boolean(sa.movementTimer.running))
            {
               sa.movementTimer.stop();
            }
            m.walk();
            sa.animation = m.defaultPoseName();
            sa.movementTimer = new Timer(duration,1);
            sa.movementTimer.addEventListener(TimerEvent.TIMER,stopAnimation);
            sa.movementTimer.start();
         }
      }
      
      public function checkForNewPet(param1:Object) : Boolean
      {
         if(param1 is BonsterClickItemWrapper)
         {
            return true;
         }
         return false;
      }
      
      public function moveActor2StarcoinShooter(param1:Number, param2:Number, param3:Number) : void
      {
         var sa:SharedActor = null;
         var m:MovieStar = null;
         var stopAnimation:Function = null;
         var p:Point = null;
         var actorId2:Number = param1;
         var x:Number = param2;
         var y:Number = param3;
         stopAnimation = function(param1:TimerEvent = null):void
         {
            m.stopWalk();
            m.PlayAnimation(sa.animation);
         };
         x = this.applyRestrictionX(x);
         sa = this.actorTable[actorId2];
         m = sa.movieStar;
         var actorEmoText:DisplayObject = this.actorMessageTable[actorId2];
         var compensatedY:Number = this.getFigureYFromScreenY(y);
         var newScale:Number = this.getFigureScaleFromScreenY(y);
         m.FaceRight();
         m.x = x;
         m.y = compensatedY;
         m.scaleX = newScale * m.getSkinScaleX();
         m.scaleY = newScale * m.getSkinScaleY();
         if(actorEmoText != null)
         {
            p = this.getSpeechBubblePoint(x,compensatedY);
            actorEmoText.x = p.x;
            actorEmoText.y = p.y + (80 - actorEmoText.height);
         }
         sa.animation = MovieStar.DEFAULT_ANIMATION;
         sa.movementTimer = new Timer(starcoinShooterAnimTime,1);
         sa.movementTimer.addEventListener(TimerEvent.TIMER,stopAnimation);
         sa.movementTimer.start();
      }
      
      protected function applyRestrictionX(param1:Number) : Number
      {
         return param1;
      }
      
      protected function applyGameObjectRestrictionX(param1:Number) : Number
      {
         return param1;
      }
      
      protected function applyQuizCanvasPosRestriction(param1:Number) : Number
      {
         return param1;
      }
      
      private function checkForTextAreaCollision() : void
      {
         var _loc3_:Object = null;
         var _loc4_:MovieStar = null;
         var _loc5_:DisplayObject = null;
         var _loc6_:DisplayObject = null;
         var _loc7_:int = 0;
         var _loc1_:DisplayObject = null;
         var _loc2_:Number = this.canvasActor.numChildren - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = this.canvasActor.getChildAt(_loc2_);
            if(_loc3_ is MovieStar)
            {
               _loc4_ = _loc3_ as MovieStar;
               _loc5_ = this.actorMessageTable[_loc4_.actor.ActorId];
               if(!(_loc5_ == null || !_loc5_.visible))
               {
                  if(_loc1_ == null)
                  {
                     _loc1_ = _loc5_;
                  }
                  else
                  {
                     _loc6_ = _loc5_;
                     if(_loc1_.x + _loc1_.width > _loc6_.x && _loc1_.x < _loc6_.x + _loc6_.width)
                     {
                        _loc7_ = _loc1_.y - _loc6_.y;
                        if(_loc6_.y + _loc6_.height + 2 >= _loc1_.y)
                        {
                           _loc6_.y = _loc1_.y - _loc6_.height - 2;
                           if(_loc6_.y < 0)
                           {
                              _loc6_.y = 0;
                           }
                        }
                     }
                     _loc1_ = null;
                     _loc2_--;
                  }
               }
            }
            _loc2_--;
         }
      }
      
      private function SortFiguresAccordingToY() : void
      {
         PropSorter.SortFiguresAccordingToY(this.canvasActor);
         this.checkForTextAreaCollision();
      }
      
      public function sortStuff() : void
      {
         PropSorter.SortFiguresAccordingToY_Fast(this.canvasStuff,true);
      }
      
      private function removeActorFromSortOrder(param1:Number) : void
      {
         var _loc3_:Object = null;
         var _loc4_:MovieStar = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.sortOrder.length)
         {
            _loc3_ = this.sortOrder[_loc2_];
            if(_loc3_ is MovieStar)
            {
               _loc4_ = this.sortOrder[_loc2_];
               if(_loc4_.actor.ActorId == param1)
               {
                  this.sortOrder.splice(_loc2_,1);
                  return;
               }
            }
            _loc2_++;
         }
      }
      
      private function getSpeechBubblePoint(param1:Number, param2:Number) : Point
      {
         var _loc5_:Number = NaN;
         var _loc3_:Number = param1 + 0;
         var _loc4_:Number = param2 - 110;
         if(_loc4_ < 5)
         {
            _loc5_ = -_loc4_ * 2;
            if(_loc5_ > 80)
            {
               _loc5_ = 80;
            }
            _loc3_ += _loc5_;
            _loc4_ = 5;
         }
         if(ChatRoomController.currentRoomPublic == "")
         {
            if(_loc3_ > ChatRoomController.currentRoomSection * StuffView.SPACE_BETWEEN_ROOMS + this.outer.width - 130)
            {
               _loc3_ = ChatRoomController.currentRoomSection * StuffView.SPACE_BETWEEN_ROOMS + this.outer.width - 130;
            }
            else if(_loc3_ < ChatRoomController.currentRoomSection * StuffView.SPACE_BETWEEN_ROOMS + 5)
            {
               _loc3_ = ChatRoomController.currentRoomSection * StuffView.SPACE_BETWEEN_ROOMS + 5;
            }
         }
         else if(_loc3_ > this.canvasBackground.width - 130)
         {
            _loc3_ = this.canvasBackground.width - 130;
         }
         else if(_loc3_ < 5)
         {
            _loc3_ = 5;
         }
         return new Point(_loc3_,_loc4_);
      }
      
      private function talkEnded(param1:Event) : void
      {
         var _loc2_:MovieStar = param1.currentTarget as MovieStar;
         var _loc3_:DisplayObject = this.actorMessageTable[_loc2_.actor.ActorId];
         if(_loc3_ != null)
         {
            _loc3_.visible = false;
         }
      }
      
      private function loadSharedActor(param1:ActorCommunicationVO) : void
      {
         var newActorRemote:MovieStar;
         var compensatedY:Number;
         var onSyncObject:ActorCommunicationVO = param1;
         var actorId2:int = onSyncObject.actorId;
         var posX:int = onSyncObject.posX;
         var posY:int = onSyncObject.posY;
         var sharedActor:SharedActor = new SharedActor();
         var myActorMinimal:ActorMinimal = null;
         if(onSyncObject.compressedActorData != null)
         {
            try
            {
               myActorMinimal = SerializeUtils.uncompressAndDeserialize(onSyncObject.compressedActorData) as ActorMinimal;
            }
            catch(e:Error)
            {
               myActorMinimal = SerializeUtils.deserialize(onSyncObject.compressedActorData) as ActorMinimal;
            }
         }
         this.actorTable[actorId2] = sharedActor;
         sharedActor.actorId = actorId2;
         sharedActor.lastSharedObjectGUID = onSyncObject.soGUID;
         sharedActor.lastSharedObjectAction = onSyncObject.actorAction;
         sharedActor.animation = onSyncObject.animation;
         sharedActor.message = onSyncObject.message;
         sharedActor.faceAnimation = onSyncObject.faceExpresion;
         sharedActor.facingDirection = onSyncObject.facing;
         sharedActor.actor = myActorMinimal;
         newActorRemote = this.friendMovieStarCache[actorId2] as MovieStar;
         if(newActorRemote == null)
         {
            newActorRemote = new MovieStar();
            this.friendMovieStarCache[actorId2] = newActorRemote;
         }
         else
         {
            if(Boolean(newActorRemote) && newActorRemote.clickItem is BonsterClickItemWrapper)
            {
               (newActorRemote.clickItem as BonsterClickItemWrapper).destroy();
            }
            newActorRemote.clickItem = null;
            newActorRemote.synchronizeClothing();
            newActorRemote.synchronizeAppearance();
         }
         newActorRemote.isInChatRoom = true;
         newActorRemote.staticClothes = !this.isInMinigame;
         newActorRemote.scale = this.getFigureScaleFromScreenY(posY);
         compensatedY = this.getFigureYFromScreenY(posY);
         newActorRemote.move(posX,compensatedY);
         newActorRemote.addEventListener(MovieStar.TALK_ENDED,this.talkEnded,false,0,true);
         sharedActor.movieStar = newActorRemote;
         this.loadSharedActorInner(newActorRemote,sharedActor,onSyncObject,myActorMinimal);
      }
      
      private function loadSharedActorInner(param1:MovieStar, param2:SharedActor, param3:ActorCommunicationVO, param4:ActorMinimal) : void
      {
         var actorId2:int = 0;
         var onMovieStarFailLoading:Function = null;
         var onMovieStarLoaded:Function = null;
         var newActorRemote:MovieStar = param1;
         var sharedActor:SharedActor = param2;
         var actorVo:ActorCommunicationVO = param3;
         var myActorMinimal:ActorMinimal = param4;
         onMovieStarFailLoading = function():void
         {
         };
         onMovieStarLoaded = function(param1:MovieStar):void
         {
            canvasActor.addChild(param1);
            param1.startBlinking();
            if(isNaN(sharedActor.x))
            {
               sharedActor.x = actorVo.posX;
               sharedActor.y = actorVo.posY;
            }
            if(actorVo.facing == "L")
            {
               param1.FaceLeft();
            }
            else
            {
               param1.FaceRight();
            }
            var _loc2_:Number = getFigureYFromScreenY(sharedActor.y);
            param1.move(sharedActor.x,_loc2_);
            var _loc3_:Number = getFigureScaleFromScreenY(sharedActor.y);
            param1.scaleX = _loc3_ * param1.getSkinScaleX();
            param1.scaleY = _loc3_ * param1.getSkinScaleY();
            sortOrder.push(param1);
            param1.PlayAnimation(sharedActor.animation);
            var _loc4_:DisplayObject = createEmoText(sharedActor.x,_loc2_);
            canvasSpeach.addChild(_loc4_);
            actorMessageTable[actorId2] = _loc4_;
            if(!param1.isExtra())
            {
               createActorLabel(param1);
            }
            else
            {
               glow.play([param1]);
            }
            addClickItemToActor(param1,actorVo.clickItemIdString);
            if(param1.actor.Moderator == 1 || param1.actor.Moderator == 2)
            {
               moderatorSticker = new MovieStarSafetySticker();
               moderatorSticker.addSticker(param1);
            }
            if(actorVo.client == ConstantsPlatform.APPLICATION_MOBILE)
            {
               new SetMovieStarBadgeCommand(param1).setAsMobile(true);
            }
         };
         actorId2 = actorVo.actorId;
         if(actorId2 == 0)
         {
            LoggingAmfService.Debug("ChatRoom.loadSharedActorInner: Loading actor with id 0.");
         }
         if(myActorMinimal != null)
         {
            newActorRemote.LoadWithAppearanceData(actorId2,myActorMinimal.getAppearanceData() as AppearanceData,onMovieStarLoaded);
         }
         else
         {
            newActorRemote.Load(actorId2,onMovieStarLoaded,1,false,true,false,onMovieStarFailLoading);
         }
      }
      
      public function setMovieStarsVisiblity(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.canvasActor.numChildren)
         {
            if(this.canvasActor.getChildAt(_loc2_) is MovieStar)
            {
               this.canvasActor.getChildAt(_loc2_).visible = param1;
            }
            _loc2_++;
         }
      }
      
      private function createEmoText(param1:Number, param2:Number) : DisplayObject
      {
         var _loc3_:Canvas = new Canvas();
         var _loc4_:Point = this.getSpeechBubblePoint(param1,param2);
         _loc3_.move(_loc4_.x,_loc4_.y);
         _loc3_.setStyle("cornerRadius",10);
         _loc3_.setStyle("backgroundColor","0xFFFFFF");
         _loc3_.setStyle("borderStyle","solid");
         _loc3_.setStyle("backgroundAlpha",1);
         _loc3_.horizontalScrollPolicy = "off";
         _loc3_.verticalScrollPolicy = "off";
         _loc3_.clipContent = false;
         _loc3_.height = 80;
         _loc3_.width = 120;
         _loc3_.visible = false;
         var _loc5_:MSP_EmoticonTextFlowAreaUI = new MSP_EmoticonTextFlowAreaUI();
         _loc5_.height = 80;
         _loc5_.width = 120;
         _loc5_.color = 0;
         _loc5_.padding = 7;
         _loc5_.editable = false;
         _loc5_.maxChars = 100;
         _loc5_.name = "emoText";
         var _loc6_:Image = new MSP_Image();
         _loc6_.source = Config.toAbsoluteURL("img/triangle_lowerleft.png",Config.LOCAL_CDN_URL);
         _loc6_.width = 30;
         _loc6_.height = 15;
         _loc6_.move(30,80);
         _loc6_.name = "triangle";
         _loc3_.addChild(_loc5_);
         _loc3_.addChild(_loc6_);
         return _loc3_;
      }
      
      private function displayMessage(param1:Number, param2:String) : void
      {
         var _loc4_:MSP_EmoticonTextFlowAreaUI = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:SharedActor = null;
         var _loc9_:Point = null;
         var _loc10_:int = 0;
         var _loc3_:Canvas = this.actorMessageTable[param1];
         if(_loc3_ != null)
         {
            if(param2.length > 0)
            {
               _loc4_ = _loc3_.getChildByName("emoText") as MSP_EmoticonTextFlowAreaUI;
               _loc4_.senderId = param1;
               _loc5_ = 1 + param2.length / 14;
               _loc6_ = 4 + 20 * _loc5_;
               if(_loc6_ > 80)
               {
                  _loc6_ = 80;
               }
               _loc3_.height = _loc6_;
               _loc4_.height = _loc6_;
               _loc4_.emoticonText = param2;
               _loc7_ = _loc3_.getChildByName("triangle");
               if(_loc7_ != null)
               {
                  _loc7_.move(30,_loc6_);
               }
               _loc8_ = this.actorTable[param1];
               _loc9_ = this.getSpeechBubblePoint(_loc8_.movieStar.x,_loc8_.movieStar.y);
               _loc10_ = _loc9_.y + (80 - _loc6_);
               if(_loc10_ < 0)
               {
                  _loc10_ = 0;
               }
               _loc3_.move(_loc9_.x,_loc10_);
               _loc3_.visible = true;
            }
         }
      }
      
      private function createActorLabel(param1:MovieStar, param2:Boolean = false) : LinkButton
      {
         var _loc3_:LinkButton = new LinkButton();
         if(param2)
         {
            _loc3_.label = "Computer";
         }
         else
         {
            _loc3_.label = param1.actor.Name;
         }
         _loc3_.height = 25;
         _loc3_.width = 180;
         _loc3_.setStyle("fontSize","18");
         _loc3_.setStyle("textAlign","center");
         if(ActorSession.isAgeRestrictions)
         {
            WhiteListBase.addWordToWhiteList(_loc3_.label);
         }
         if(!param2 && param1.actor.isVip)
         {
            _loc3_.setStyle("color","0xFDD017");
         }
         else
         {
            _loc3_.setStyle("color","0xffffff");
         }
         var _loc4_:Array = new Array();
         var _loc5_:DropShadowFilter = new DropShadowFilter();
         _loc5_.distance = 0;
         _loc4_.push(_loc5_);
         _loc3_.filters = _loc4_;
         param1.addChild(_loc3_);
         _loc3_.move(-70,540);
         _loc3_.scaleX = 1.5;
         _loc3_.scaleY = 1.5;
         _loc3_.name = param1.actor.ActorId.toString();
         if(!param2)
         {
            _loc3_.addEventListener(MouseEvent.CLICK,this.actorClicked);
         }
         return _loc3_;
      }
      
      private function addClickItemToActor(param1:MovieStar, param2:String) : void
      {
         var _loc3_:Boolean = false;
         if(param2 != null && param2 != "")
         {
            _loc3_ = true;
            new AddClickItemToMovieStarCommand(param1).parseClickItemFromString(param2,_loc3_,1.5);
         }
      }
      
      private function actorClicked(param1:MouseEvent) : void
      {
         var _loc2_:Number = NaN;
         if(ChatRoomController.isPlayingChatroomGame)
         {
            _loc2_ = Number(param1.currentTarget.name);
            CharacterContainer.showMyPopUp(_loc2_,param1.stageX,param1.stageY);
         }
      }
      
      protected function onSync(param1:SyncEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:Number = NaN;
         if(this.isExiting)
         {
            return;
         }
         if(this.firstTimeSync)
         {
            this.MakeRoomReadyToUse();
         }
         this.actorsInsideChatroom = new Object();
         for(_loc2_ in this.text_so.data)
         {
            _loc3_ = this.text_so.data[_loc2_];
            if(_loc2_ == "rewardChannel")
            {
               this.actorRewarded(_loc3_);
            }
            else if(_loc2_ == "Game1" || _loc2_ == "Game2" || _loc2_ == "Game5" || _loc2_ == "Game6" || _loc2_ == "Game7")
            {
               this.onSyncGame(_loc3_ as String,_loc2_);
            }
            else if(_loc2_ == "Game8")
            {
               for(_loc4_ in _loc3_)
               {
                  _loc5_ = _loc3_[_loc4_];
                  this.onSyncGame(_loc5_ as String,_loc2_,Number(_loc4_));
               }
            }
            else if(_loc2_ == "MiniGameChannel")
            {
               this.curMinigame.onSyncMiniGame(_loc3_);
            }
            else if(_loc2_.indexOf("ActorClothes") == 0)
            {
               this.syncActorClothing(_loc3_);
            }
            else if(_loc2_ == "video")
            {
               this.onVideoSync(_loc3_);
            }
            else if(_loc2_ == "StarcoinShooterPlaying")
            {
               this.starcoinShooterPlay(_loc3_);
            }
            else if(_loc2_.substr(0,15) == "StarcoinShooter")
            {
               _loc6_ = int(int(_loc2_.substr(16)));
               this.startStarcoinShooter(_loc6_,_loc3_);
            }
            else
            {
               this.onSyncActor(new ActorCommunicationVO(_loc3_));
            }
         }
         if(!this.firstTimeSync && !this.isReconnecting)
         {
            for(_loc7_ in this.actorTable)
            {
               _loc8_ = Number(_loc7_ as Number);
               if(this.actorTable[_loc8_] is SharedActor && _loc8_ != this.actorId)
               {
                  if(this.actorsInsideChatroom[_loc8_] == null)
                  {
                     this.removeActorFromRoom(_loc8_);
                  }
               }
            }
         }
         this.isReconnecting = false;
         this.firstTimeSync = false;
      }
      
      private function getModBlack(param1:String) : String
      {
         if(param1 != null && param1.length > 0)
         {
            return "[blacklisted]: " + param1;
         }
         return "";
      }
      
      private function shouldShowBlack(param1:String, param2:String) : Boolean
      {
         var _loc3_:Boolean = this.actorModel.isModerator;
         var _loc4_:Boolean = !this.stringsEqual(param1,param2);
         var _loc5_:Boolean = param2 != null;
         return _loc3_ && _loc4_ && _loc5_;
      }
      
      private function stringsEqual(param1:String, param2:String) : Boolean
      {
         if(param1 == null && param2 == null)
         {
            return true;
         }
         if(param1 == null || param2 == null)
         {
            return false;
         }
         return param1.toUpperCase() == param2.toUpperCase();
      }
      
      protected function onVideoSync(param1:Object) : void
      {
      }
      
      private function syncActorClothing(param1:Object) : void
      {
         var actorClothesBA:ByteArray = null;
         var stripFirst:Boolean = false;
         var actorClothes:Object = null;
         var actorId:int = 0;
         var actor:SharedActor = null;
         var valueObj:Object = param1;
         try
         {
            actorClothesBA = valueObj.actorClothes;
            stripFirst = Boolean(valueObj.stripFirst);
            actorClothesBA.uncompress();
            actorClothes = SerializeUtils.deserialize(actorClothesBA);
            actorId = int(actorClothes.actorId);
            actor = null;
            actor = this.actorTable[actorId] as SharedActor;
            if(actor != null && actorId != this.mySharedActor.movieStar.actor.ActorId)
            {
               if(actor.movieStar != null)
               {
                  actor.movieStar.setClothesFromData(actorClothes.clothes as Array,actorId,null);
               }
            }
         }
         catch(t:Error)
         {
         }
      }
      
      public function onSyncActor(param1:ActorCommunicationVO) : void
      {
         var _loc3_:SharedActor = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:MovieStar = null;
         var _loc2_:Number = param1.actorId;
         if(param1.actorAction == ChatroomConstants.EXIT && this.actorId == _loc2_)
         {
            return;
         }
         if(param1.actorAction == ChatroomConstants.EXIT && this.actorId != _loc2_)
         {
            this.removeActorFromRoom(_loc2_);
         }
         else if(param1.actorAction == ChatroomConstants.ENTER)
         {
            if(_loc2_ == this.actorId)
            {
               if(this.isReconnecting)
               {
                  this.sendPosition(this.mySharedActor.x,this.mySharedActor.y);
               }
               else
               {
                  this.sendPosition(this.initialX,this.initialY);
               }
               return;
            }
         }
         else
         {
            _loc3_ = this.actorTable[_loc2_] as SharedActor;
            this.actorsInsideChatroom[_loc2_] = true;
            _loc4_ = param1.blacklistedMessage;
            _loc5_ = param1.message;
            _loc6_ = param1.posX;
            _loc7_ = param1.posY;
            _loc8_ = param1.animation;
            _loc9_ = param1.faceExpresion;
            _loc10_ = param1.facing;
            _loc11_ = param1.effect;
            _loc12_ = param1.trickIdx;
            _loc13_ = param1.bonsterAnimation;
            if(this.shouldShowBlack(_loc5_,_loc4_))
            {
               _loc5_ = this.getModBlack(_loc5_);
            }
            else
            {
               _loc5_ = UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromStrings(_loc4_,param1.whitelistedMessage,_loc5_,_loc2_);
            }
            if(_loc3_ == null && _loc2_ != this.actorId)
            {
               this.loadSharedActor(param1);
            }
            else if(_loc3_ != null)
            {
               _loc14_ = "";
               if(_loc3_.lastSharedObjectGUID != null)
               {
                  _loc14_ = _loc3_.lastSharedObjectGUID;
               }
               if(_loc14_ != param1.soGUID)
               {
                  _loc3_.x = _loc6_;
                  _loc3_.y = _loc7_;
                  _loc3_.animation = _loc8_;
                  _loc3_.faceAnimation = _loc9_;
                  _loc3_.facingDirection = _loc10_;
                  _loc3_.message = _loc5_;
                  if(_loc3_.movieStar != null)
                  {
                     _loc15_ = _loc3_.movieStar;
                     if(ActorSession.getActorId() != _loc2_)
                     {
                        _loc15_.PlayAnimation(_loc8_);
                     }
                     if(_loc8_ == starcoinShooterAnim)
                     {
                        this.moveActor2StarcoinShooter(_loc2_,_loc6_,_loc7_);
                     }
                     else
                     {
                        this.moveActor2(_loc2_,_loc6_,_loc7_);
                     }
                     if(ActorSession.getActorId() != _loc2_)
                     {
                        _loc15_.SetFaceExpression(_loc9_);
                     }
                     if(_loc11_ == "MONEY")
                     {
                        DisplayUtils.showMoneyImage("",_loc15_);
                     }
                     else if(_loc11_ == "FAME")
                     {
                        DisplayUtils.showPointImage("",_loc15_);
                     }
                     if(_loc5_ != null)
                     {
                        if(_loc5_.length > 0)
                        {
                           this.displayMessage(_loc2_,_loc5_);
                           _loc15_.talk(5000 + 500 * (_loc5_.length / 5));
                        }
                     }
                     if(_loc12_ >= 0 && _loc2_ != this.actorId && _loc15_.clickItem != null)
                     {
                        if(_loc15_.clickItem is Pet)
                        {
                           (_loc15_.clickItem as Pet).doTrick(_loc12_);
                        }
                     }
                     if(_loc13_ != null && _loc2_ != this.actorId && _loc15_.clickItem != null)
                     {
                        if(_loc15_.clickItem is BonsterClickItemWrapper)
                        {
                           (_loc15_.clickItem as BonsterClickItemWrapper).playAnimation(_loc13_);
                        }
                     }
                  }
                  _loc3_.lastSharedObjectGUID = param1.soGUID;
                  _loc3_.lastSharedObjectAction = param1.actorAction;
               }
            }
         }
      }
      
      private function asyncErrorHandler(param1:AsyncErrorEvent) : void
      {
         Prompt.show(param1.toString(),"An error occured when playing speech");
      }
      
      private function onComDisconnect(param1:MsgEvent) : void
      {
         if(param1.data is Number && param1.data >= 0)
         {
            this.removeActorFromRoom(param1.data);
         }
      }
      
      public function removeActorFromRoom(param1:Number) : void
      {
         var _loc2_:SharedActor = null;
         var _loc3_:MovieStar = null;
         var _loc4_:DisplayObject = null;
         if(this.isInMinigame)
         {
            this.curMinigame.onPlayerLeft(param1);
         }
         if(this.actorTable[param1] != null)
         {
            if(this.actorTable[param1] is SharedActor)
            {
               _loc2_ = this.actorTable[param1] as SharedActor;
               _loc3_ = _loc2_.movieStar;
               if(_loc3_ != null)
               {
                  _loc3_.stopBlinking();
                  if(_loc3_.parent != null)
                  {
                     _loc3_.parent.removeChild(_loc3_);
                  }
               }
               if(this.isInMinigame && this.curMinigame.actorPointsLabels != null)
               {
                  this.curMinigame.actorPointsLabels.removeActorLabel(String(param1));
               }
            }
            this.removeActorFromSortOrder(param1);
            this.actorTable[param1] = null;
         }
         if(this.actorMessageTable[param1] != null)
         {
            _loc4_ = this.actorMessageTable[param1] as DisplayObject;
            _loc4_.parent.removeChild(_loc4_);
            this.actorMessageTable[param1] = null;
         }
      }
      
      private function createMultiplayerBattle(param1:Boolean, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc6_:QuizMultiPlayer = null;
         var _loc7_:BattleMultiPlayer = null;
         var _loc8_:FlashMultiPlayer = null;
         var _loc9_:CatchStarsMultiPlayer = null;
         var _loc10_:FlashMultiPlayerAdvanced = null;
         ChatRoomController.isPlayingChatroomGame = true;
         if(param4 == 2)
         {
            _loc6_ = new QuizMultiPlayer();
            _loc6_.beginnerMovieStar = param1;
            _loc6_.chatRoom = ChatRoomController.chatRoomView;
            _loc6_.me = this.mySharedActor.movieStar;
            _loc6_.oponent = this.actorTable[param2].movieStar;
            _loc6_.awardFameInsteadOfMoney = true;
            this.battle = _loc6_;
         }
         else if(param4 == 3 || param4 == 4)
         {
            _loc7_ = new BattleMultiPlayer();
            _loc7_.beginnerMovieStar = param1;
            _loc7_.battleType = param4;
            _loc7_.chatRoom = ChatRoomController.chatRoomView;
            _loc7_.me = this.mySharedActor.movieStar;
            _loc7_.oponent = this.actorTable[param2].movieStar;
            _loc7_.initAnimations();
            this.battle = _loc7_;
         }
         else if(param4 == 5)
         {
            _loc8_ = new FlashMultiPlayer();
            _loc8_.beginnerMovieStar = param1;
            _loc8_.chatRoom = ChatRoomController.chatRoomView;
            _loc8_.me = this.mySharedActor.movieStar;
            _loc8_.oponent = this.actorTable[param2].movieStar;
            _loc8_.awardFameInsteadOfMoney = true;
            this.battle = _loc8_;
         }
         else if(param4 == 6)
         {
            _loc9_ = new CatchStarsMultiPlayer();
            _loc9_.beginnerMovieStar = param1;
            _loc9_.chatRoom = ChatRoomController.chatRoomView;
            _loc9_.me = this.mySharedActor.movieStar;
            _loc9_.oponent = this.actorTable[param2].movieStar;
            _loc9_.awardFameInsteadOfMoney = true;
            this.battle = _loc9_;
         }
         else if(param4 == 7)
         {
            _loc10_ = new FlashMultiPlayerAdvanced();
            _loc10_.beginnerMovieStar = param1;
            _loc10_.chatRoom = ChatRoomController.chatRoomView;
            _loc10_.me = this.mySharedActor.movieStar;
            _loc10_.oponent = this.actorTable[param2].movieStar;
            _loc10_.awardFameInsteadOfMoney = true;
            this.battle = _loc10_;
         }
         this.canvasSpeach.addChild(this.battle);
         var _loc5_:Number = param3;
         if(this.mySharedActor.movieStar.x > this.actorTable[param2].movieStar.x)
         {
            _loc5_ += 110;
         }
         else
         {
            _loc5_ -= 110;
            if(_loc5_ < 10)
            {
               _loc5_ = 10;
            }
         }
         if(_loc5_ - this.sliderCanvas.horizontalScrollPosition + this.battle.width > this.sliderCanvas.width)
         {
            _loc5_ = this.sliderCanvas.width - this.battle.width + this.sliderCanvas.horizontalScrollPosition - 10;
         }
         this.battle.move(_loc5_,this.mySharedActor.movieStar.y);
      }
      
      private function loadMyActor(param1:Number) : void
      {
         var dummyActor:MovieStar;
         var MovieStarLoaded:Function = null;
         var actorIdNew:Number = param1;
         MovieStarLoaded = function(param1:MovieStar):void
         {
            var _loc3_:Point = null;
            var _loc4_:int = 0;
            if(TamperTechnology.hasActorIdBeenModified(param1.actor.ActorId))
            {
               close();
               return;
            }
            myMovieStar = param1;
            actorMinimal = myMovieStar.actor.createActorMinimalFromActor();
            friendMovieStarCache[actorId] = param1;
            canvasActor.addChild(param1);
            myMovieStar.startBlinking();
            if(!isInMinigame)
            {
               startIdleAnimTimer();
            }
            if(ChatRoomController.currentRoomPublic == "")
            {
               initialX = 150 + 600 * Math.random() + StuffView.SPACE_BETWEEN_ROOMS * ChatRoomController.currentRoomSection;
            }
            else if(isInMinigame)
            {
               _loc3_ = curMinigame.getPlayerLocation(RoomRequester.lastLocationIndex);
               initialX = _loc3_.x;
               initialY = _loc3_.y;
               sliderCanvas.horizontalScrollPosition = 0;
            }
            else if(isInThemeRoom)
            {
               initialX = Math.random() * X_MAX_COORD;
               sliderCanvas.horizontalScrollPosition = 0;
            }
            else
            {
               _loc4_ = (Math.random() - 0.5) * 600;
               initialX = 960 + _loc4_;
               sliderCanvas.horizontalScrollPosition = 500;
            }
            loadMyActorExtras();
            param1.scale = getFigureScaleFromScreenY(initialY);
            param1.move(initialX,getFigureYFromScreenY(initialY));
            myMovieStarIsReady = true;
            param1.preloadAnimation("walk");
            sortOrder.push(param1);
            var _loc2_:DisplayObject = createEmoText(param1.x,param1.y);
            canvasSpeach.addChild(_loc2_);
            actorMessageTable[actorId] = _loc2_;
            createActorLabel(param1);
            if(myClickItemString != "")
            {
               addClickItemToActor(param1,myClickItemString);
               if(!isInMinigame)
               {
                  startPooTimer();
               }
            }
            selectedFramelabel = param1.defaultPoseName();
            selectedFaceExpressionKey = "neutral";
            connectTextSo();
            if(param1.actor.Moderator == 1 || param1.actor.Moderator == 2)
            {
               moderatorSticker = new MovieStarSafetySticker();
               moderatorSticker.addSticker(param1);
            }
            isMovieStarLoaded = true;
            if(isStuffViewItemsLoaded)
            {
               triggerRoomSnapshots();
            }
         };
         this.actorId = actorIdNew;
         this.mySharedActor = new SharedActor();
         this.actorTable[this.actorId] = this.mySharedActor;
         this.defineSoFunctions();
         dummyActor = this.friendMovieStarCache[this.actorId] as MovieStar;
         if(dummyActor == null)
         {
            dummyActor = new MovieStar();
         }
         dummyActor.isInChatRoom = true;
         dummyActor.staticClothes = !this.isInMinigame;
         dummyActor.scale = this.getFigureScaleFromScreenY(this.initialY);
         this.mySharedActor.movieStar = dummyActor;
         dummyActor.addEventListener(MovieStar.TALK_ENDED,this.talkEnded,false,0,true);
         if(this.actorId == 0)
         {
            LoggingAmfService.Debug("ChatRoom.loadMyActor: Loading actor with id 0. (dummyActor.load)");
         }
         if(dummyActor.actor != null)
         {
            if(Boolean(dummyActor) && dummyActor.clickItem is BonsterClickItemWrapper)
            {
               (dummyActor.clickItem as BonsterClickItemWrapper).destroy();
            }
            dummyActor.clickItem = null;
            MovieStarLoaded(dummyActor);
         }
         else
         {
            dummyActor.Load(this.actorId,MovieStarLoaded,2,false,true,true);
         }
      }
      
      protected function loadMyActorExtras() : void
      {
      }
      
      private function connectTextSo(param1:Event = null) : void
      {
         var _loc2_:String = null;
         this.firstTimeSync = true;
         if(param1 != null && param1.type == ConnectionManager.FMS_RECONNECTED)
         {
            this.isReconnecting = true;
         }
         else
         {
            this.isReconnecting = false;
         }
         if(this.text_so == null)
         {
            _loc2_ = RoomRequester.chatServerUri;
            this.text_so = SharedObject.getRemote(this.roomId,_loc2_,!this.isInMinigame);
            this.text_so.addEventListener(SyncEvent.SYNC,this.onSync);
            Main.Instance.addEventListener(ConnectionManager.FMS_RECONNECTED,this.connectTextSo);
         }
         this.text_so.connect(RoomRequester.roomCon);
      }
      
      private function defineSoFunctions() : void
      {
         this.roomConnection.client = new Object();
         this.roomConnection.client.lock = function():void
         {
            controlCanvas.enabled = false;
            lockedText.visible = true;
            textTextLine.text = "";
         };
         this.roomConnection.client.unlock = function():void
         {
            lockedText.visible = false;
            controlCanvas.enabled = true;
         };
         this.roomConnection.client.requestGame = function(param1:String, param2:Number):void
         {
            if(ChatRoomController.isPlayingChatroomGame)
            {
               roomConnection.call("respondGame",null,parseInt(param1),2);
            }
            else
            {
               createMultiplayerBattle(false,parseInt(param1),mySharedActor.x,param2);
            }
         };
         this.roomConnection.client.respondGame = function(param1:Number):void
         {
            battle.respond(param1);
         };
         this.roomConnection.client.setSpecialsService = function(param1:Boolean):void
         {
            setSpecialsService(param1);
         };
         this.roomConnection.client.readyStarcoinShooter = function(param1:int):void
         {
            var enableUser:Function = null;
            var sendDefaultAnim:Function = null;
            var finishTime:int = param1;
            enableUser = function(param1:TimerEvent):void
            {
               disableGeneralActions(false);
               myMovieStar.stopWalk();
               myMovieStar.PlayAnimation(mySharedActor.animation);
               mySharedActor.movementTimer = new Timer(5000,1);
               mySharedActor.movementTimer.addEventListener(TimerEvent.TIMER,sendDefaultAnim);
               mySharedActor.movementTimer.start();
            };
            sendDefaultAnim = function(param1:TimerEvent):void
            {
               if(myMovieStar.currentlyPlayingFrameLabel == MovieStar.DEFAULT_ANIMATION || myMovieStar.currentlyPlayingFrameLabel == myMovieStar.defaultPoseName())
               {
                  selectedFramelabel = myMovieStar.defaultPoseName();
                  sendActorUpdateToRoom();
               }
            };
            if(isInThemeRoom)
            {
               mySharedActor.x = X_MAX_COORD / 2;
               myMovieStar.x = mySharedActor.x;
            }
            else
            {
               mySharedActor.x = canvasActor.width / 2;
               myMovieStar.x = mySharedActor.x;
               sliderCanvas.horizontalScrollPosition = (canvasActor.width - sliderCanvas.width) / 2;
            }
            mySharedActor.facingDirection = "R";
            myMovieStar.FaceRight();
            playStarcoinShooterAnimation();
            roomConnection.call("startStarcoinShooter",null);
            disableGeneralActions(true);
            StarcoinShooterCongratsPopup.show(finishTime);
            mySharedActor.animation = MovieStar.DEFAULT_ANIMATION;
            mySharedActor.movementTimer = new Timer(starcoinShooterAnimTime,1);
            mySharedActor.movementTimer.addEventListener(TimerEvent.TIMER,enableUser);
            mySharedActor.movementTimer.start();
         };
      }
      
      public function sendExitToChatRoomSharedObject() : void
      {
         var _loc1_:ActorCommunicationVO = null;
         if(this.text_so != null)
         {
            _loc1_ = new ActorCommunicationVO();
            _loc1_.soGUID = GUID.create();
            _loc1_.actorId = this.actorId;
            _loc1_.actorAction = ChatroomConstants.EXIT;
            this.communicationHandler.sendStatus(_loc1_);
            callLater(this.clearChatRoomSharedObject);
         }
         else
         {
            this.isExiting = false;
         }
      }
      
      private function clearChatRoomSharedObject() : void
      {
         if(this.text_so != null)
         {
            this.text_so.close();
            this.text_so = null;
            Main.Instance.removeEventListener(ConnectionManager.FMS_RECONNECTED,this.connectTextSo);
         }
         this.isExiting = false;
      }
      
      public function get isInMinigame() : Boolean
      {
         return this.curMinigame != null;
      }
      
      public function get isInThemeRoom() : Boolean
      {
         return this.roomType == ChatRoomType.THEMEROOM;
      }
      
      public function get roomConnection() : NetConnection
      {
         return RoomRequester.roomCon;
      }
      
      private function MakeRoomReadyToUse() : void
      {
         this.roomConnection.call("connectToChatRoom",null,ActorSession.getActorId(),this.roomId);
         var _loc1_:ActorCommunicationVO = new ActorCommunicationVO();
         _loc1_.soGUID = GUID.create();
         _loc1_.actorId = this.actorId;
         _loc1_.actorName = this.actorModel.actorName;
         _loc1_.actorAction = ChatroomConstants.ENTER;
         _loc1_.client = ConstantsPlatform.APPLICATION_WEB;
         _loc1_.clickItemIdString = this.myClickItemString;
         _loc1_.compressedActorData = SerializeUtils.serialize(this.actorMinimal);
         this.communicationHandler.sendStatus(_loc1_);
         this.callLater(this.setUpMinigameIfExists);
      }
      
      private function setUpMinigameIfExists() : void
      {
         var _loc1_:MiniGameType = MiniGameType.getMinigameByRoomStr(this.roomId);
         if(_loc1_ != null)
         {
            this.curMinigame = _loc1_.instance;
            this.curMinigame.initialize(this);
         }
      }
      
      private function sendPosition(param1:Number, param2:Number) : void
      {
         if(!this.sendTimer || !this.sendTimer.running)
         {
            this.sendPositionPos.x = param1;
            this.sendPositionPos.y = param2;
            this.sendTimer = new Timer(1000,1);
            this.sendTimer.addEventListener(TimerEvent.TIMER,this.sendPositionDoActualSend,false,0,true);
            this.sendTimer.start();
         }
      }
      
      private function sendPositionDoActualSend(param1:Event = null) : void
      {
         var _loc2_:ActorCommunicationVO = new ActorCommunicationVO();
         _loc2_.soGUID = GUID.create();
         _loc2_.actorId = this.actorId;
         _loc2_.actorAction = ChatroomConstants.ACTOR_COMMUNICATION;
         _loc2_.posX = this.sendPositionPos.x;
         _loc2_.posY = this.sendPositionPos.y;
         _loc2_.animation = this.selectedFramelabel;
         _loc2_.message = "";
         _loc2_.faceExpresion = this.selectedFaceExpressionKey;
         _loc2_.facing = "R";
         _loc2_.clickItemIdString = this.myClickItemString;
         _loc2_.actorName = this.actorModel.actorName;
         _loc2_.compressedActorData = SerializeUtils.serialize(this.actorMinimal);
         this.communicationHandler.sendStatus(_loc2_);
         this.myRoomReadyToGo = true;
         this.canvasControl.visible = true;
      }
      
      private function sendCurrentPosition() : void
      {
         var _loc1_:ActorCommunicationVO = new ActorCommunicationVO();
         _loc1_.soGUID = GUID.create();
         _loc1_.actorId = this.actorId;
         _loc1_.actorName = this.actorModel.actorName;
         _loc1_.actorAction = ChatroomConstants.ACTOR_COMMUNICATION;
         _loc1_.posX = this.mySharedActor.x;
         _loc1_.posY = this.mySharedActor.y;
         _loc1_.animation = this.selectedFramelabel;
         _loc1_.message = "";
         _loc1_.faceExpresion = this.selectedFaceExpressionKey;
         _loc1_.facing = this.mySharedActor.facingDirection;
         _loc1_.clickItemIdString = this.myClickItemString;
         _loc1_.compressedActorData = SerializeUtils.serialize(this.actorMinimal);
         callLater(this.communicationHandler.sendStatus,[_loc1_]);
      }
      
      private function onClothesChanged(param1:MsgEvent) : void
      {
         var done:Function;
         var evt:MsgEvent = param1;
         if(this.mySharedActor != null && this.mySharedActor.movieStar != null && evt.data != null && evt.data.actorId == this.mySharedActor.movieStar.actor.ActorId)
         {
            done = function():void
            {
               postOutfit(true);
            };
            this.myMovieStar.synchronizeClothing(done);
         }
      }
      
      public function postOutfit(param1:Boolean) : void
      {
         var _loc2_:Object = {
            "clothes":this.mySharedActor.movieStar.getAttachedClothesAsData(),
            "actorId":this.actorId
         };
         var _loc3_:ByteArray = SerializeUtils.serialize(_loc2_);
         _loc3_.compress();
         RoomRequester.roomCon.call("postOutfit",null,this.roomId,this.actorId,_loc3_,param1);
      }
      
      private function getFigureScaleFromScreenY(param1:Number) : Number
      {
         var _loc2_:Number = param1 - this.SCALE_HORIZON_DUMMY;
         return 0.25 + _loc2_ / 1000;
      }
      
      private function getFigureYFromScreenY(param1:Number) : Number
      {
         var _loc2_:Number = this.getFigureScaleFromScreenY(param1);
         return param1 - 560 * _loc2_;
      }
      
      public function mouseDown(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         if(this.myRoomReadyToGo && !this.disableWalk)
         {
            if(this.pooFlag)
            {
               this.roomConnection.call("makeOwnedGame",null,this.roomId,8,this.actorId);
               this.pooFlag = false;
            }
            _loc2_ = mouseX - 25;
            this.gotoCoord(_loc2_ + this.sliderCanvas.horizontalScrollPosition,mouseY);
            this.notIdle();
         }
      }
      
      public function placeMyActorInSpaceBetweenRooms() : void
      {
         this.m_objAnimationManager.removeAll();
         this.myMovieStar.x = StuffView.SPACE_BETWEEN_ROOMS * ChatRoomController.currentRoomSection - (StuffView.SPACE_BETWEEN_ROOMS - this.sliderCanvas.width) / 2;
         var _loc1_:DisplayObject = this.actorMessageTable[ActorSession.getActorId()];
         if(_loc1_ != null)
         {
            _loc1_.x = this.myMovieStar.x;
         }
      }
      
      public function gotoCoord(param1:Number, param2:Number) : void
      {
         var _loc7_:String = null;
         if(this.disableWalk || this.isExiting)
         {
            return;
         }
         if(param2 < this.MIN_CLICKABLE_Y_COORD)
         {
            return;
         }
         var _loc3_:Number = param2;
         if(param2 < this.HORIZON_Y_COORD)
         {
            _loc3_ = this.HORIZON_Y_COORD;
         }
         var _loc4_:Number = param1;
         var _loc5_:int = this.X_MIN_COORD;
         var _loc6_:int = this.X_MAX_COORD;
         if(ChatRoomController.currentRoomPublic == "")
         {
            _loc5_ += ChatRoomController.currentRoomSection * StuffView.SPACE_BETWEEN_ROOMS;
            _loc6_ += ChatRoomController.currentRoomSection * StuffView.SPACE_BETWEEN_ROOMS;
         }
         if(_loc4_ < _loc5_)
         {
            _loc4_ = _loc5_;
         }
         if(_loc4_ > _loc6_)
         {
            _loc4_ = _loc6_;
         }
         if(this.isInMinigame && !this.curMinigame.isPlayingMiniGame)
         {
            if(_loc3_ < this.curMinigame.gamePlayerRect.maxY)
            {
               _loc3_ = Number(this.curMinigame.gamePlayerRect.maxY);
            }
         }
         this.selectedFramelabel = MovieStar.DEFAULT_ANIMATION;
         if(this._animationSelector != null)
         {
            this._animationSelector.selectedAnimationKey = MovieStar.DEFAULT_ANIMATION;
         }
         if(this.mySharedActor.x > _loc4_)
         {
            _loc7_ = "L";
         }
         else if(this.mySharedActor.x < _loc4_)
         {
            _loc7_ = "R";
         }
         else
         {
            _loc7_ = this.mySharedActor.facingDirection;
         }
         if(this.sendTimer)
         {
            this.sendTimer.stop();
         }
         var _loc8_:ActorCommunicationVO = new ActorCommunicationVO();
         _loc8_.soGUID = GUID.create();
         _loc8_.actorId = this.actorId;
         _loc8_.actorAction = ChatroomConstants.ACTOR_COMMUNICATION;
         _loc8_.posX = _loc4_;
         _loc8_.posY = _loc3_;
         _loc8_.animation = this.selectedFramelabel;
         _loc8_.message = "";
         _loc8_.faceExpresion = this.selectedFaceExpressionKey;
         _loc8_.facing = _loc7_;
         _loc8_.clickItemIdString = this.myClickItemString;
         _loc8_.actorName = this.actorModel.actorName;
         _loc8_.compressedActorData = SerializeUtils.serialize(this.actorMinimal);
         this.communicationHandler.sendStatus(_loc8_);
      }
      
      public function close() : void
      {
         if(OldPopupHandler.getInstance().currentMainPopup != this)
         {
            if(Boolean(parent) && Boolean(parent.contains(this)))
            {
               parent.removeChild(this);
               this.Exit();
            }
         }
         WindowStack.removeSpriteViewStackable(this);
         MonsterPopup.closeCurrent();
         OldPopupHandler.getInstance().closeMainPopup();
         this.Exit();
         MessageCommunicator.send(new MsgEvent(MSPEvent.CHATROOM_CLOSED));
      }
      
      private function get animationSelector() : AnimationSelector
      {
         if(this._animationSelector == null)
         {
            this._animationSelector = new AnimationSelector();
            this._animationSelector.reference = this.myMovieStar;
            this._animationSelector.actor = this.myMovieStar.actor;
            this._animationSelector.closeCallback = this.closeAnimationSelector;
            MessageCommunicator.subscribe(SelectorEvent.ANIMATION_SELECTED,this.onAnimationSelectorOk);
            this._animationSelectorOpenend = true;
         }
         return this._animationSelector;
      }
      
      private function get faceExpressionSelector() : FaceExpressionSelector
      {
         if(this._faceExpressionSelector == null)
         {
            this._faceExpressionSelector = new FaceExpressionSelector();
            this._faceExpressionSelector.parentButton = this.btnFaceExpression;
            this._faceExpressionSelector.reference = this.myMovieStar;
            this._faceExpressionSelector.selectedFaceExpressionKey = this.selectedFaceExpressionKey;
            MessageCommunicator.subscribe(SelectorEvent.FACEEXPRESSION_SELECTED,this.onFaceExpressionSelectorOk);
         }
         return this._faceExpressionSelector;
      }
      
      private function onAnimationSelectorOk(param1:SelectorEvent) : void
      {
         if(param1.data == this.myMovieStar && this._animationSelector.selectedAnimationKey != null)
         {
            this._animationSelector.disableSelection();
            if(this.animTimer == null)
            {
               this.animTimer = new Timer(1000,1);
               this.animTimer.addEventListener(TimerEvent.TIMER,this.enableAnimSelector);
            }
            this.animTimer.start();
            this.selectedFramelabel = this._animationSelector.selectedAnimationKey;
            this.myMovieStar.PlayAnimation(this.selectedFramelabel,null,0,null,this._animationSelector.selectedAnimation.LastUpdated);
            this.userSendAnimationInChat();
            MessageCommunicator.send(new ActionEvent(ActionEvent.PLAY_ANIMATION));
            this.notIdle();
         }
      }
      
      private function enableAnimSelector(param1:Event = null) : void
      {
         if(this._animationSelector != null)
         {
            this._animationSelector.enableSelection();
         }
      }
      
      private function onFaceExpressionSelectorOk(param1:SelectorEvent) : void
      {
         if(param1.data == this.myMovieStar && this._faceExpressionSelector.selectedFaceExpressionKey != null)
         {
            this.selectedFaceExpressionKey = this._faceExpressionSelector.selectedFaceExpressionKey;
            this.myMovieStar.faceExpression = this._faceExpressionSelector.selectedFaceExpression;
            this.sendActorUpdateToRoom();
         }
      }
      
      private function animationButtonClick() : void
      {
         if(this.disableButtons)
         {
            return;
         }
         WindowStack.showSpriteAsViewStackable(this.animationSelector,0,70,WindowStack.Z_INFO);
         if(this.animationSelector.selectedAnimationKey == null)
         {
            this.animationSelector.selectedAnimationKey = MovieStar.DEFAULT_ANIMATION;
         }
         if(this._animationSelectorOpenend)
         {
            this._animationSelectorOpenend = false;
         }
         else
         {
            this.animationSelector.animationButtonPressed();
         }
      }
      
      private function closeAnimationSelector() : void
      {
         if(this._animationSelector == null)
         {
            return;
         }
         WindowStack.removeSpriteViewStackable(this.animationSelector);
         this._animationSelector = null;
      }
      
      private function faceexpressionButtonClick() : void
      {
         if(this.disableButtons)
         {
            return;
         }
         this.faceExpressionSelector.close();
         if(this.faceExpressionSelector.closedOnButton == false)
         {
            OldPopupHandler.getInstance().movePopup(this.faceExpressionSelector,1010,360);
            PopUpManager.addPopUp(this.faceExpressionSelector,this,false);
         }
         this.faceExpressionSelector.closedOnButton = false;
      }
      
      private function getGameType(param1:String) : int
      {
         if(param1 == "Game1")
         {
            return 1;
         }
         if(param1 == "Game2")
         {
            return 2;
         }
         if(param1 == "Game3")
         {
            return 3;
         }
         if(param1 == "Game4")
         {
            return 4;
         }
         if(param1 == "Game5")
         {
            return 5;
         }
         if(param1 == "Game6")
         {
            return 6;
         }
         if(param1 == "Game7")
         {
            return 7;
         }
         if(param1 == "Game8")
         {
            return 8;
         }
         return 0;
      }
      
      private function getStarGlow(param1:int) : Sequence
      {
         switch(param1)
         {
            case 1:
               return this.starGlow;
            case 2:
               return this.starGlow2;
            case 3:
               return this.starGlow3;
            case 4:
               return this.starGlow4;
            case 5:
               return this.starGlow5;
            case 6:
               return this.starGlow6;
            case 7:
               return this.starGlow7;
            case 8:
               return this.starGlow8;
            default:
               return null;
         }
      }
      
      private function initOwnedGameObject(param1:String, param2:int, param3:Number) : GameObject
      {
         var _loc4_:GameObject = null;
         if(Boolean(this.games[param2]) && Boolean(this.games[param2][param3]))
         {
            _loc4_ = this.games[param2][param3];
            if(_loc4_.gameId != param1)
            {
               _loc4_.gameId = param1;
            }
         }
         else
         {
            _loc4_ = new GameObject();
            if(!this.games[param2])
            {
               this.games[param2] = new Array();
            }
            _loc4_.gameId = param1;
            _loc4_.gameType = param2;
            _loc4_.owner = param3;
            _loc4_.starGlow = this.getStarGlow(param2);
            this.games[param2][param3] = _loc4_;
         }
         return _loc4_;
      }
      
      private function initGameObject(param1:String, param2:int) : GameObject
      {
         var _loc3_:GameObject = this.games[param2];
         if(_loc3_ == null)
         {
            _loc3_ = new GameObject();
            _loc3_.gameId = param1;
            this.games[param2] = _loc3_;
            _loc3_.starGlow = this.getStarGlow(param2);
         }
         else if(_loc3_.gameId != param1)
         {
            _loc3_.gameId = param1;
         }
         return _loc3_;
      }
      
      private function initGameObjectImagesAndEvents(param1:GameObject) : void
      {
         var MovieStarLoaded:Function;
         var xOff:int = 0;
         var yOff:int = 0;
         var gotoListener:Object = null;
         var im:Image = null;
         var img:DisplayObject = null;
         var wrapper:UIComponent = null;
         var im8:Image = null;
         var actorIdToLoad:int = 0;
         var ms:MovieStar = null;
         var im3:Image = null;
         var im4:Image = null;
         var im5:Image = null;
         var gameObject:GameObject = param1;
         if(gameObject.image == null || gameObject.gameType == 1)
         {
            xOff = 0;
            yOff = 40;
            if(gameObject.gameType == 1)
            {
               gameObject.image = new MSP_Image();
               im = gameObject.image as Image;
               if(gameObject.quizCategory == 0)
               {
                  im.source = Config.toAbsoluteURL("img/32x32/movie.png",Config.LOCAL_CDN_URL);
               }
               else if(gameObject.quizCategory == 1)
               {
                  im.source = Config.toAbsoluteURL("img/32x32/geography_32.png",Config.LOCAL_CDN_URL);
               }
               else if(gameObject.quizCategory == 2)
               {
                  im.source = Config.toAbsoluteURL("img/32x32/basketball_32.png",Config.LOCAL_CDN_URL);
               }
               else if(gameObject.quizCategory == 3)
               {
                  im.source = Config.toAbsoluteURL("img/32x32/project_32.png",Config.LOCAL_CDN_URL);
               }
               gameObject.image.width = 30;
               gameObject.image.height = 30;
            }
            else if(gameObject.gameType == 2)
            {
               img = new CurrencyIconsShared.StarCoinIcon() as DisplayObject;
               wrapper = new UIComponent();
               wrapper.width = img.width = 35;
               wrapper.height = img.height = 30;
               wrapper.addChild(img);
               gameObject.image = wrapper;
            }
            else if(gameObject.gameType == 8)
            {
               gameObject.image = new MSP_Image();
               im8 = gameObject.image as Image;
               im8.source = Config.toAbsoluteURL("img/48x48/poo.png",Config.LOCAL_CDN_URL);
               gameObject.image.width = 30;
               gameObject.image.height = 30;
            }
            else if(gameObject.gameType == 3 || gameObject.gameType == 4)
            {
               MovieStarLoaded = function():void
               {
                  friendMovieStarCache[actorIdToLoad] = ms;
                  createActorLabel(ms,true);
                  ms.PlayAnimation(MovieStar.DEFAULT_ANIMATION);
               };
               actorIdToLoad = 1;
               if(gameObject.gameType == 3)
               {
                  actorIdToLoad = 3;
               }
               else
               {
                  actorIdToLoad = 4;
               }
               ms = this.friendMovieStarCache[actorIdToLoad] as MovieStar;
               if(ms == null)
               {
                  ms = new MovieStar();
               }
               gameObject.image = ms;
               gameObject.ms = ms;
               xOff = 39;
               yOff = 160;
               if(actorIdToLoad == 0)
               {
                  LoggingAmfService.Debug("ChatRoom.onSyncGame: Loading actor with id 0. ");
               }
               if(ms.actor != null)
               {
                  MovieStarLoaded();
               }
               else
               {
                  ms.Load(actorIdToLoad,MovieStarLoaded,1,false,true,true);
               }
            }
            else if(gameObject.gameType == 5)
            {
               gameObject.image = new MSP_Image();
               im3 = gameObject.image as Image;
               im3.source = Config.toAbsoluteURL("img/48x48/blog_48.gif",Config.LOCAL_CDN_URL);
               gameObject.image.width = 30;
               gameObject.image.height = 30;
            }
            else if(gameObject.gameType == 6)
            {
               gameObject.image = new MSP_Image();
               im4 = gameObject.image as Image;
               im4.source = Config.toAbsoluteURL("img/_Favorites.png",Config.LOCAL_CDN_URL);
               gameObject.image.width = 30;
               gameObject.image.height = 30;
            }
            else if(gameObject.gameType == 7)
            {
               gameObject.image = new MSP_Image();
               im5 = gameObject.image as Image;
               im5.source = Config.toAbsoluteURL("img/32x32/flash.png",Config.LOCAL_CDN_URL);
               gameObject.image.width = 30;
               gameObject.image.height = 30;
            }
            gotoListener = new Object();
            gotoListener.gameObject = gameObject;
            gotoListener.xOff = xOff;
            gotoListener.yOff = yOff;
            gotoListener.clickHandler = function(param1:Event = null):void
            {
               gotoCoord(gameObject.image.x + xOff,gameObject.image.y + yOff);
            };
            gameObject.image.addEventListener(MouseEvent.CLICK,gotoListener.clickHandler);
         }
      }
      
      private function onSyncGame(param1:String, param2:String, param3:Number = 0) : void
      {
         var _loc6_:GameObject = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:QuizQuestion = null;
         var _loc13_:Number = NaN;
         var _loc14_:QuizQuestion = null;
         var _loc15_:Number = NaN;
         var _loc16_:Flash = null;
         var _loc17_:Number = NaN;
         var _loc18_:Rain = null;
         var _loc19_:SharedActor = null;
         var _loc20_:int = 0;
         var _loc21_:String = null;
         var _loc22_:Boolean = false;
         var _loc23_:SharedActor = null;
         if(param1 == "")
         {
            return;
         }
         var _loc4_:Array = ChatLogic.extractData(param1);
         if(_loc4_[0] != "7")
         {
            return;
         }
         var _loc5_:String = _loc4_[1];
         var _loc7_:int = this.getGameType(param2);
         if(!_loc7_)
         {
            return;
         }
         if(param3)
         {
            _loc6_ = this.initOwnedGameObject(_loc5_,_loc7_,param3);
         }
         else
         {
            _loc6_ = this.initGameObject(_loc5_,_loc7_);
         }
         _loc6_.gameType = _loc7_;
         _loc6_.isWaitingForServer = false;
         var _loc8_:Number = Number(parseInt(_loc4_[2]));
         if(_loc8_ != _loc6_.gameState)
         {
            _loc6_.gameState = _loc8_;
            if(_loc6_.gameState == 1)
            {
               this.initGameObjectImagesAndEvents(_loc6_);
               this.canvasStuff.addChild(_loc6_.image);
               if(!_loc6_.starGlow.isPlaying)
               {
                  _loc6_.starGlow.play([_loc6_.image]);
               }
               if(_loc7_ == 1)
               {
                  _loc6_.quizCategory = parseInt(_loc4_[5]);
               }
               _loc9_ = int(parseInt(_loc4_[3]));
               _loc10_ = int(parseInt(_loc4_[4]));
               if(this.isInThemeRoom)
               {
                  _loc9_ /= 2;
               }
               _loc6_.image.x = _loc9_;
               if(_loc7_ == 3 || _loc7_ == 4)
               {
                  _loc6_.ms.scale = this.getFigureScaleFromScreenY(_loc10_);
                  _loc10_ = this.getFigureYFromScreenY(_loc10_);
               }
               _loc6_.image.y = _loc10_;
               _loc6_.image.x = this.applyGameObjectRestrictionX(_loc6_.image.x);
               SoundManager.Instance().playSoundEffect(Sounds.POP1);
            }
            else if(_loc6_.gameState == 2)
            {
               _loc11_ = int(parseInt(_loc4_[3]));
               if(_loc6_.image != null && Boolean(this.canvasStuff.contains(_loc6_.image)))
               {
                  _loc6_.starGlow.stop();
                  if(!(_loc7_ == 3 || _loc7_ == 4) || _loc11_ != ActorSession.getActorId())
                  {
                     this.canvasStuff.removeChild(_loc6_.image);
                  }
               }
               if(_loc6_.button != null && Boolean(this.canvasSpeach.contains(_loc6_.button)))
               {
                  this.canvasSpeach.removeChild(_loc6_.button);
               }
               if(_loc11_ == ActorSession.getActorId())
               {
                  if(_loc7_ != 2 && _loc7_ != 8)
                  {
                     ChatRoomController.isPlayingChatroomGame = true;
                  }
                  if(_loc7_ == 1)
                  {
                     this.glow.play([this.mySharedActor.movieStar]);
                     if(_loc6_.canvas == null)
                     {
                        _loc14_ = new QuizQuestion();
                        _loc14_.chatRoom = this;
                        _loc6_.canvas = _loc14_;
                     }
                     _loc12_ = _loc6_.canvas as QuizQuestion;
                     _loc12_.category = _loc6_.quizCategory;
                     this.canvasSpeach.addChild(_loc6_.canvas);
                     _loc13_ = this.mySharedActor.movieStar.x + 40;
                     if(_loc13_ > 550 + this.sliderCanvas.horizontalScrollPosition)
                     {
                        _loc13_ = 550 + this.sliderCanvas.horizontalScrollPosition;
                     }
                     _loc13_ = this.applyQuizCanvasPosRestriction(_loc13_);
                     _loc6_.canvas.move(_loc13_,this.mySharedActor.movieStar.y);
                  }
                  else if(_loc7_ == 2 || _loc7_ == 8)
                  {
                     ChatRoomController.isPlayingChatroomGame = false;
                     this.claimReward(_loc6_.gameId,3,AwardingType.AWARD_TYPE_MONEY,WinSpendTypes.WINSPENDTYPE_GameSinglePlayer,"collect_starcoins");
                     this.clearGame(_loc6_.gameType);
                     if(_loc7_ == 8 && param3 == ActorSession.getActorId())
                     {
                        this.startPooTimer();
                     }
                     if(_loc7_ == 2)
                     {
                        MessageCommunicator.send(new MsgEvent(CareerQuestEvent.USER_CLICKED_BUTTON,CareerQuestsGoToDestinations.COLLECT_STARCOINS_IN_CHAT_ROOM));
                        MessageCommunicator.sendMessage(CareerQuestEvent.OBJECTIVE_PROGRESS,{
                           "progress":1,
                           "name":CareerQuestsGoToDestinations.DO_TASK_PICK_UP_STAR_COINS_IN_CHAT
                        });
                     }
                  }
                  else if(_loc7_ == 5)
                  {
                     this.glow.play([this.mySharedActor.movieStar]);
                     this.starGlow5.stop();
                     if(_loc6_.canvas == null)
                     {
                        _loc16_ = new Flash();
                        _loc16_.chatRoom = this;
                        _loc16_.me = this.mySharedActor.movieStar;
                        _loc16_.gameId = _loc6_.gameId;
                        _loc6_.canvas = _loc16_;
                     }
                     this.canvasSpeach.addChild(_loc6_.canvas);
                     _loc15_ = this.mySharedActor.movieStar.x + 60;
                     if(_loc15_ > 1830)
                     {
                        _loc15_ = 1830;
                     }
                     _loc6_.canvas.move(_loc15_,this.mySharedActor.movieStar.y);
                  }
                  else if(_loc7_ == 6)
                  {
                     this.glow.play([this.mySharedActor.movieStar]);
                     this.starGlow6.stop();
                     if(_loc6_.canvas == null)
                     {
                        _loc18_ = new Rain();
                        _loc18_.chatRoom = this;
                        _loc18_.me = this.mySharedActor.movieStar;
                        _loc18_.gameId = _loc6_.gameId;
                        _loc6_.canvas = _loc18_;
                     }
                     this.canvasSpeach.addChild(_loc6_.canvas);
                     _loc17_ = this.mySharedActor.movieStar.x + 60;
                     if(_loc17_ > 1830)
                     {
                        _loc17_ = 1830;
                     }
                     _loc6_.canvas.move(_loc17_,this.mySharedActor.movieStar.y);
                  }
               }
               else
               {
                  _loc19_ = this.actorTable[_loc11_];
                  if(_loc19_ != null)
                  {
                     if(_loc7_ == 1 || _loc7_ == 3 || _loc7_ == 4)
                     {
                        this.glow.play([_loc19_.movieStar]);
                     }
                  }
               }
            }
            else if(_loc6_.gameState == 3)
            {
               _loc20_ = int(parseInt(_loc4_[3]));
               _loc21_ = _loc4_[4];
               _loc22_ = _loc21_.toUpperCase() == "TRUE";
               if(!SoundManager.Instance().isMuted)
               {
                  if(_loc22_)
                  {
                     SoundManager.Instance().playSoundEffect(Sounds.OHHH);
                  }
                  else
                  {
                     SoundManager.Instance().playSoundEffect(Sounds.UGH);
                  }
               }
               _loc23_ = this.actorTable[_loc20_];
               if(!_loc22_)
               {
                  if(_loc23_ != null)
                  {
                     this.playIncorrect(_loc23_.movieStar);
                  }
               }
               else if(_loc20_ == ActorSession.loggedInActor.ActorId)
               {
                  this.claimReward(_loc6_.gameId,10,AwardingType.AWARD_TYPE_MONEY,WinSpendTypes.WINSPENDTYPE_GameSinglePlayer,"quiz");
                  this.clearGame(_loc6_.gameType);
               }
               else if(_loc23_ != null)
               {
                  this.playCorrect(_loc23_.movieStar,"vejrmoelle",10);
               }
            }
         }
      }
      
      private function onActorDailyAward(param1:MSPDataEvent) : void
      {
         var _loc2_:Object = param1.data;
         if(_loc2_ != null && _loc2_.amount > 0)
         {
            this.playAwardAnimForActor(ActorSession.getActorId(),_loc2_.currencyType,_loc2_.amount);
         }
         else if(_loc2_ != null && _loc2_.amount == -1)
         {
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("GAMES_NO_MORE_WINNING"));
         }
      }
      
      private function playAwardAnimForActor(param1:int, param2:String, param3:int) : void
      {
         var _loc4_:SharedActor = null;
         if(this.actorTable[param1] != null)
         {
            _loc4_ = this.actorTable[param1];
            if(param2 == "fame")
            {
               this.playCorrectFame(_loc4_.movieStar,"vejrmoelle",param3);
            }
            else if(param2 == "money")
            {
               this.playCorrect(_loc4_.movieStar,"vejrmoelle",param3);
            }
         }
      }
      
      private function actorRewarded(param1:Object) : void
      {
         var _loc2_:Number = Number(parseInt(param1.actorId));
         var _loc3_:String = param1.type;
         var _loc4_:int = int(parseInt(param1.amount));
         var _loc5_:String = param1.context;
         if(_loc5_ == "shooter" && this.actorId == _loc2_)
         {
            if(_loc3_ == "fame")
            {
               MangroveAnalytics.registerGamePlay(EntityActionEventConst.ENTITY_SUB1_GAME_CHAT_ROOM_COLLECT,EntityActionEventConst.ENTITY_SUB2_DIAMOND_RIDE,null,_loc4_,0,0);
               ActorValueManager.getInstance().addValue(ActorValueType.FAME,_loc4_,false);
            }
            else if(_loc3_ == "money")
            {
               MangroveAnalytics.registerGamePlay(EntityActionEventConst.ENTITY_SUB1_GAME_CHAT_ROOM_COLLECT,EntityActionEventConst.ENTITY_SUB2_DIAMOND_RIDE,null,0,_loc4_,0);
               ActorValueManager.getInstance().addValue(ActorValueType.STARCOINS,_loc4_,false);
            }
         }
         if(_loc5_ == "shooter" || _loc2_ != this.actorId)
         {
            this.playAwardAnimForActor(_loc2_,_loc3_,_loc4_);
         }
      }
      
      public function playCorrect(param1:MovieStar, param2:String, param3:int) : void
      {
         this.genericCorrect(param1,param2);
         DisplayUtils.showMoneyImage(param3.toString(),param1);
      }
      
      public function genericCorrect(param1:MovieStar, param2:String) : void
      {
         this.glow.play([param1]);
         param1.PlayAnimation(param2);
         param1.SetTempFaceExpression("happy",REWARD_FACE_TIMEOUT);
      }
      
      public function playCorrectFame(param1:MovieStar, param2:String, param3:int) : void
      {
         this.genericCorrect(param1,param2);
         DisplayUtils.showPointImage(param3.toString(),param1);
      }
      
      private function playIncorrect(param1:MovieStar) : void
      {
         this.glow.play([param1]);
         param1.PlayAnimation("takingheadoff");
         param1.SetTempFaceExpression("sad",REWARD_FACE_TIMEOUT);
      }
      
      private function DisplayAllQuizIcons() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:* = undefined;
         var _loc1_:Number = 0;
         while(_loc1_ < this.games.length)
         {
            _loc2_ = _loc1_ + 1;
            if(this.games[_loc2_] != null)
            {
               if(this.games[_loc2_] is Array)
               {
                  for each(_loc3_ in this.games[_loc2_])
                  {
                     this.DisplayQuizIcons(_loc3_);
                  }
               }
               else
               {
                  this.DisplayQuizIcons(this.games[_loc2_]);
               }
            }
            _loc1_++;
         }
      }
      
      private function DisplayQuizIcons(param1:GameObject) : void
      {
         var difX:Number = NaN;
         var difY:Number = NaN;
         var gameListener:Object = null;
         var gameObject:GameObject = param1;
         if(this.myMovieStarIsReady && !gameObject.isWaitingForServer && gameObject.gameState == 1 && !ChatRoomController.isPlayingChatroomGame)
         {
            difX = Number(Math.abs(this.mySharedActor.movieStar.x - gameObject.image.x));
            if(gameObject.gameType == 1 || gameObject.gameType == 2 || gameObject.gameType == 5 || gameObject.gameType == 6 || gameObject.gameType == 7 || gameObject.gameType == 8)
            {
               difY = Number(Math.abs(this.mySharedActor.movieStar.y + 150 - gameObject.image.y));
            }
            else if(gameObject.gameType == 3 || gameObject.gameType == 4)
            {
               difY = Number(Math.abs(this.mySharedActor.movieStar.y - gameObject.image.y));
            }
            if(difX < 40 && difY < 40 && !this.disableButtons)
            {
               if(gameObject.button == null)
               {
                  gameObject.button = new Button();
                  gameObject.button.setStyle("color","0x000000");
                  gameListener = new Object();
                  if(gameObject.gameType == 8)
                  {
                     gameObject.button.label = MSPLocaleManagerWeb.getInstance().getString("CLEAN_POO");
                     gameListener.gameObject = gameObject;
                     gameListener.clickHandler = function(param1:Event = null):void
                     {
                        roomConnection.call("gotItOwned",null,roomId,gameObject.gameType,gameObject.owner,gameObject.gameId);
                        gameObject.isWaitingForServer = true;
                     };
                     gameObject.button.addEventListener(MouseEvent.CLICK,gameListener.clickHandler);
                  }
                  else
                  {
                     switch(gameObject.gameType)
                     {
                        case 1:
                           gameObject.button.label = MSPLocaleManagerWeb.getInstance().getString("TAKE_QUIZ");
                           break;
                        case 2:
                           gameObject.button.label = MSPLocaleManagerWeb.getInstance().getString("COLLECT_COIN");
                           break;
                        case 3:
                           gameObject.button.label = MSPLocaleManagerWeb.getInstance().getString("DANCE_BATTLE");
                           break;
                        case 4:
                           gameObject.button.label = MSPLocaleManagerWeb.getInstance().getString("FIGHT_BATTLE");
                           break;
                        case 5:
                           gameObject.button.label = MSPLocaleManagerWeb.getInstance().getString("SIGN_AUTOGRAPHS");
                           break;
                        case 6:
                           gameObject.button.label = MSPLocaleManagerWeb.getInstance().getString("CATCH_STARS");
                           break;
                        case 7:
                           gameObject.button.label = "Shoot Stalkers";
                     }
                     gameListener.gameObject = gameObject;
                     gameListener.clickHandler = function(param1:Event = null):void
                     {
                        roomConnection.call("gotIt",null,roomId,gameObject.gameType,gameObject.gameId);
                        gameObject.isWaitingForServer = true;
                     };
                     gameObject.button.addEventListener(MouseEvent.CLICK,gameListener.clickHandler);
                  }
               }
               if(!this.canvasSpeach.contains(gameObject.button))
               {
                  this.canvasSpeach.addChild(gameObject.button);
                  if(gameObject.gameType == 1 || gameObject.gameType == 2 || gameObject.gameType == 5 || gameObject.gameType == 6 || gameObject.gameType == 7 || gameObject.gameType == 8)
                  {
                     gameObject.button.move(gameObject.image.x - 30,gameObject.image.y);
                  }
                  else if(gameObject.gameType == 3 || gameObject.gameType == 4)
                  {
                     gameObject.button.move(gameObject.image.x - 20,gameObject.image.y + 80);
                  }
               }
            }
            else if(gameObject.button != null && Boolean(this.canvasSpeach.contains(gameObject.button)))
            {
               this.canvasSpeach.removeChild(gameObject.button);
            }
         }
      }
      
      private function awardResult(param1:ServiceResultData) : void
      {
         var _loc2_:Point = null;
         var _loc3_:MovieStar = null;
         var _loc4_:AwardAmount = null;
         if(param1.Code == 0)
         {
            _loc2_ = new Point(0,0);
            if(RoomRequester.isMinigameType(ChatRoomController.currentRoomPublic))
            {
               _loc2_ = localToGlobal(new Point(980 / 2,500 / 2));
            }
            else
            {
               _loc3_ = this.myMovieStar;
               _loc2_ = _loc3_.localToGlobal(new Point(0 + _loc3_.width / 2,0 + _loc3_.height / 2));
               _loc4_ = param1.Data as AwardAmount;
               AwardVisualizationController.spawnAwards(_loc2_.x,_loc2_.y,_loc4_.Starcoins,_loc4_.Fame,_loc4_.Diamonds,false);
            }
            MessageCommunicator.send(new MSPDataEvent(MSPDataEvent.AWARD_DISTRUBTED));
            MessageCommunicator.sendMessage(MSPEvent.ACHIEVEMENTS_CLEAR_CACHE,null);
         }
      }
      
      public function claimReward(param1:String, param2:Number, param3:int, param4:int, param5:String) : void
      {
         var doReward:Function = null;
         var done:Function = null;
         var claimId:String = param1;
         var amount:Number = param2;
         var type:int = param3;
         var winSpend:int = param4;
         var gameName:String = param5;
         doReward = function(param1:String):void
         {
            var _loc2_:Boolean = param1 != null && param1.toUpperCase() == "TRUE";
            _fmsRewardingActive = {"on":_loc2_};
            RoomRequester.roomCon.call("claimReward",null,ActorSession.getActorId(),RoomRequester.roomId,claimId,amount,_loc2_);
            if(!_loc2_)
            {
               new AwardingAmfService().awardActor(ActorSession.getActorId(),amount,type,winSpend,done);
            }
         };
         done = function(param1:ServiceResultData):void
         {
            var _loc2_:int = 0;
            var _loc3_:int = 0;
            var _loc4_:int = 0;
            if(param1.Code == 0)
            {
               _loc2_ = (param1.Data as AwardAmount).Starcoins;
               _loc3_ = (param1.Data as AwardAmount).Fame;
               _loc4_ = (param1.Data as AwardAmount).Diamonds;
               if(winSpend == WinSpendTypes.WINSPENDTYPE_GameSinglePlayer)
               {
                  MangroveAnalytics.registerGamePlay(EntityActionEventConst.ENTITY_SUB1_GAME_CHAT_ROOM_COLLECT,gameName,null,_loc3_,_loc2_,_loc4_);
               }
               if(_loc2_ > 0)
               {
                  AnalyticsReceiveCurrencyCommand.execute(AnalyticsConstants.EARN_SC_SINGLE_COLLECT_CHATROOM,_loc2_);
               }
               awardResult(param1);
            }
         };
         if(this._fmsRewardingActive == null)
         {
            SessionService.GetAppSetting("FMSRewarding",doReward);
         }
         else
         {
            doReward(this._fmsRewardingActive.on);
         }
      }
      
      public function answer(param1:String, param2:Boolean) : void
      {
         ChatRoomController.isPlayingChatroomGame = false;
         this.canvasSpeach.removeChild(this.games[1].canvas);
         this.roomConnection.call("answer",null,this.roomId,1,[param2],param1);
         this.games[1].isWaitingForServer = true;
      }
      
      public function answer5(param1:String, param2:Number) : void
      {
         ChatRoomController.isPlayingChatroomGame = false;
         this.clearGame(5);
         this.claimReward(param1,param2,AwardingType.AWARD_TYPE_FAME,WinSpendTypes.WINSPENDTYPE_GameSinglePlayer,"sign_autograph");
         this.disableWalk = false;
      }
      
      public function answer6(param1:String, param2:Number) : void
      {
         ChatRoomController.isPlayingChatroomGame = false;
         this.clearGame(6);
         this.claimReward(param1,param2,AwardingType.AWARD_TYPE_MONEY,WinSpendTypes.WINSPENDTYPE_GameSinglePlayer,"catch_stars");
         this.IsInRunMode = false;
      }
      
      public function battleTimedOut(param1:int) : void
      {
         ChatRoomController.isPlayingChatroomGame = false;
         if(this.games == null)
         {
            return;
         }
         if(this.games[param1] != null && this.games[param1].canvas != null && Boolean(this.canvasSpeach.contains(this.games[param1].canvas)))
         {
            this.canvasSpeach.removeChild(this.games[param1].canvas);
         }
         if(this.games[param1] != null && this.games[param1].image != null && Boolean(this.canvasStuff.contains(this.games[param1].image)))
         {
            this.canvasStuff.removeChild(this.games[param1].image);
         }
         this.resetGame(param1);
         this.disableWalk = false;
         this.IsInRunMode = false;
      }
      
      public function resetGame(param1:int) : void
      {
         this.roomConnection.call("resetGame",null,this.roomId,param1);
      }
      
      public function clearGame(param1:int) : void
      {
         this.roomConnection.call("clearGame",null,this.roomId,param1);
      }
      
      public function quizTimedOut() : void
      {
         ChatRoomController.isPlayingChatroomGame = false;
         if(this.games == null)
         {
            return;
         }
         if(this.games[1] != null && this.games[1].canvas != null && Boolean(this.canvasSpeach.contains(this.games[1].canvas)))
         {
            this.canvasSpeach.removeChild(this.games[1].canvas);
         }
      }
      
      private function startPooTimer() : void
      {
         if(this.pooTimer != null)
         {
            this.pooTimer.reset();
            this.pooFlag = false;
         }
         else
         {
            this.pooTimer = new Timer(120000 + Math.random() * 600000,1);
            this.pooTimer.addEventListener(TimerEvent.TIMER,this.doFlagGame,false,0,true);
         }
         this.pooTimer.start();
      }
      
      private function doFlagGame(param1:Event = null) : void
      {
         this.pooFlag = true;
      }
      
      public function getDirectionAngle(param1:int, param2:int) : Number
      {
         var _loc3_:int = mouseX - param1;
         var _loc4_:int = param2 - mouseY;
         return Utils.getDirectionAngle(_loc3_,_loc4_);
      }
      
      public function getDirectionPoint() : Point
      {
         var _loc1_:int = this.mySharedActor.movieStar.x - this.sliderCanvas.horizontalScrollPosition;
         var _loc2_:int = int(this.mySharedActor.movieStar.y);
         var _loc3_:int = mouseX - _loc1_;
         var _loc4_:int = _loc2_ - mouseY;
         return new Point(_loc3_,_loc4_);
      }
      
      public function getMouseX() : int
      {
         return mouseX;
      }
      
      public function getMouseY() : int
      {
         return mouseY;
      }
      
      private function giveAutograph(param1:MsgEvent) : void
      {
         var _loc3_:SharedActor = null;
         this.isGivingAutographToActorId = param1.data as Number;
         var _loc2_:Object = this.actorTable[this.isGivingAutographToActorId];
         if(_loc2_ is SharedActor)
         {
            _loc3_ = _loc2_ as SharedActor;
            if(_loc3_ != null && _loc3_.lastSharedObjectAction != "EXIT")
            {
               this.isGivingAutograph = true;
               if(this.mySharedActor.x < _loc3_.x)
               {
                  this.gotoCoord(_loc3_.x - 50,_loc3_.y);
               }
               else
               {
                  this.gotoCoord(_loc3_.x + 50,_loc3_.y);
               }
            }
         }
      }
      
      private function requestQuizGame(param1:MsgEvent) : void
      {
         this.isGivingAutographToActorId = param1.data as Number;
         this.doRequestGame(this.isGivingAutographToActorId,2);
      }
      
      private function requestDanceBattleGame(param1:MsgEvent) : void
      {
         this.isGivingAutographToActorId = param1.data as Number;
         this.doRequestGame(this.isGivingAutographToActorId,3);
      }
      
      private function requestFightBattleGame(param1:MsgEvent) : void
      {
         this.isGivingAutographToActorId = param1.data as Number;
         this.doRequestGame(this.isGivingAutographToActorId,4);
      }
      
      private function requestFlashBattleGame(param1:MsgEvent) : void
      {
         this.isGivingAutographToActorId = param1.data as Number;
         this.doRequestGame(this.isGivingAutographToActorId,5);
      }
      
      private function requestCatchStarsGame(param1:MsgEvent) : void
      {
         this.isGivingAutographToActorId = param1.data as Number;
         this.doRequestGame(this.isGivingAutographToActorId,6);
      }
      
      private function requestFlashAdvancedBattleGame(param1:MsgEvent) : void
      {
         this.isGivingAutographToActorId = param1.data as Number;
         this.doRequestGame(this.isGivingAutographToActorId,7);
      }
      
      private function doRequestGame(param1:Number, param2:Number) : void
      {
         var _loc4_:SharedActor = null;
         var _loc5_:Number = NaN;
         var _loc3_:Object = this.actorTable[param1];
         if(_loc3_ is SharedActor)
         {
            _loc4_ = _loc3_ as SharedActor;
            if(_loc4_ != null && _loc4_.lastSharedObjectAction != "EXIT" && !isNaN(_loc4_.actorId))
            {
               this.actorIdRequestedGame = _loc4_.actorId;
               this.roomConnection.call("requestGame",null,this.actorId,_loc4_.actorId,param2);
               if(this.mySharedActor.x < _loc4_.x)
               {
                  _loc5_ = _loc4_.x - 50;
               }
               else
               {
                  _loc5_ = _loc4_.x + 50;
               }
               this.createMultiplayerBattle(true,_loc4_.actorId,_loc5_,param2);
               this.gotoCoord(_loc5_,_loc4_.y);
            }
         }
      }
      
      private function clicked_InviteFriendToRoom() : void
      {
         var _loc4_:INotificationObject = null;
         var _loc1_:int = 320;
         var _loc2_:int = 200;
         var _loc3_:Point = this.btn_Invite.parent.localToGlobal(new Point(this.btn_Invite.x,this.btn_Invite.y + this.btn_Invite.height));
         _loc3_ = Main.Instance.mainCanvas.globalToLocal(_loc3_);
         if(!this.isPrivateRoom())
         {
            _loc4_ = NotificationChatromObject.create(ActorSession.getActorId(),ActorSession.loggedInActor.Name,NotificationType.INVITETOCHATROOM.type,ChatRoomController.currentRoomPublic);
         }
         else
         {
            _loc4_ = NotificationChatromObject.create(ActorSession.getActorId(),ActorSession.loggedInActor.Name,NotificationType.INVITETOCHATROOM.type,ChatRoomController.currentRoomActorId + "_room",ChatRoomController.currentRoomName,ChatRoomController.currentRoomActorId,ChatRoomController.currentRoomSection);
         }
         if(this._chatRoomInviter == null)
         {
            this._chatRoomInviter = new ChatRoomInviter(_loc4_);
         }
         if(_loc3_.x > 1210 - _loc2_)
         {
            this._chatRoomInviter.x = 1210 - _loc2_;
         }
         else
         {
            this._chatRoomInviter.x = _loc3_.x;
         }
         this._chatRoomInviter.y = _loc3_.y;
         PopupUtils.showPopupDimensions(this._chatRoomInviter,this._chatRoomInviter.x,this._chatRoomInviter.y,_loc2_,_loc1_);
         MessageCommunicator.send(new ActionEvent(ActionEvent.OPEN_CHAT_ROOM_INVITER));
      }
      
      private function click_AnimWave() : void
      {
         this.myMovieStar.PlayAnimation("wave");
         this.selectedFramelabel = "wave";
         this.userSendAnimationInChat();
      }
      
      private function click_AnimJump() : void
      {
         this.myMovieStar.PlayAnimation("jump2");
         this.selectedFramelabel = "jump2";
         this.userSendAnimationInChat();
      }
      
      private function click_AnimDance() : void
      {
         this.myMovieStar.PlayAnimation("dance4");
         this.selectedFramelabel = "dance4";
         this.userSendAnimationInChat();
      }
      
      public function loveCount(param1:int, param2:Boolean) : void
      {
         this.lovesCount.text = param1.toString();
         if(param2)
         {
            this.likesLoader.visible = this.likesLoader.includeInLayout = true;
            this.likeBtn.visible = this.likeBtn.includeInLayout = false;
         }
         else
         {
            this.likesLoader.visible = this.likesLoader.includeInLayout = false;
            this.likeBtn.visible = this.likeBtn.includeInLayout = true;
         }
      }
      
      private function loveClicked() : Boolean
      {
         var likeAdded:Function = null;
         likeAdded = function(param1:Object):void
         {
            var _loc2_:Point = null;
            if(param1.liked)
            {
               MessageCommunicator.send(new QuestEvent(QuestEvent.SPECIAL_QUEST_UPDATE,{
                  "action":QuestEvent.ACTION_LOVE_ROOM,
                  "increment":1
               }));
               _publicProfile.actorRoom.RoomLikes += 1;
               loveCount(_publicProfile.actorRoom.RoomLikes,false);
               FriendshipManager.getInstance().sendBasicEventToFriend(NotificationType.MYROOM_LIKE.type,_publicProfile.actorId);
               MessageCommunicator.sendMessage(MSPEvent.ACHIEVEMENTS_CLEAR_CACHE,null);
               if(param1.fameEarned > 0)
               {
                  _loc2_ = likeBtn.localToGlobal(new Point(likeBtn.x + likeBtn.width / 2,likeBtn.y + likeBtn.height / 2));
                  AwardVisualizationController.spawnAwards(_loc2_.x,_loc2_.y,0,param1.fameEarned,0,false);
               }
            }
         };
         if(this._publicProfile.actorId != ActorSession.getActorId())
         {
            CommonService.LikeAdd("room",this._publicProfile.actorId,ActorSession.getActorId(),this._publicProfile.actorId,likeAdded);
         }
         return true;
      }
      
      private function get gamesSelector() : GamesSelector
      {
         if(this._gamesSelector == null)
         {
            this._gamesSelector = new GamesSelector();
            this._gamesSelector.parentButton = this.btnGames;
            this._gamesSelector.addEventListener(GamesSelector.OK,this.onGamesSelectorOk);
         }
         return this._gamesSelector;
      }
      
      private function onGamesSelectorOk(param1:Event) : void
      {
         GamesManager.openPlayerSelectorInfo();
      }
      
      private function profileClicked() : void
      {
         ProfileModuleManager.getInstance().showMyProfile(this._publicProfile.actorId);
      }
      
      private function playGamesButtonClick() : void
      {
         if(this.gamesSelector.closedOnButton == false)
         {
            OldPopupHandler.getInstance().movePopup(this.gamesSelector,995,330);
            PopUpManager.addPopUp(this.gamesSelector,this,false);
         }
         this.gamesSelector.closedOnButton = false;
      }
      
      private function click_StarCoinShooter(param1:MouseEvent) : void
      {
         var requestStarcoinShooter:Function = null;
         var e:MouseEvent = param1;
         requestStarcoinShooter = function():void
         {
            roomConnection.call("getStarcoinShooterBags",null);
         };
         StarcoinShooterPopup.show(requestStarcoinShooter);
      }
      
      private function initSpecialsService() : void
      {
         this.showSpecialsService(true);
         this.setSpecialsService(false);
         var _loc1_:String = ServiceUrlUtil.getServiceUrlBase();
         _loc1_ = _loc1_.replace("https","http");
         this.roomConnection.call("initSpecialsService",null,_loc1_);
      }
      
      protected function setSpecialsService(param1:Boolean) : void
      {
         if(this.starcoinShooterButton == null)
         {
            callLater(this.setSpecialsService,[param1]);
            return;
         }
         DisplayObjectUtilities.dim(this.btnStarcoinShooter,param1);
         if(param1)
         {
            DisplayObjectUtilities.buttonizeFrames(this.starcoinShooterButton,this.click_StarCoinShooter);
         }
         else
         {
            DisplayObjectUtilities.unbuttonizeFrames(this.starcoinShooterButton,this.click_StarCoinShooter);
         }
      }
      
      protected function showSpecialsService(param1:Boolean) : void
      {
         this.btnStarcoinShooter.visible = this.btnStarcoinShooter.includeInLayout = param1;
      }
      
      private function startStarcoinShooter(param1:int, param2:Object) : void
      {
         var _loc3_:StarcoinShooter = null;
         if(this.starcoinShooters[param1] == null)
         {
            if(this.isInThemeRoom)
            {
               param2.x /= 2;
            }
            this.starcoinShooters[param1] = new StarcoinShooter(param2);
         }
         else
         {
            _loc3_ = this.starcoinShooters[param1];
            if(_loc3_.gameState != param2.gameState)
            {
               if(_loc3_.setGameState(param2.gameState))
               {
                  delete this.starcoinShooters[param1];
               }
            }
         }
      }
      
      private function starcoinShooterPlay(param1:Object) : void
      {
         var bgLoadDone:Function = null;
         var valueObject:Object = param1;
         bgLoadDone = function(param1:MSP_SWFLoader):void
         {
            starcoinShooterBgLoader = param1;
            if(!canvasBackground.contains(starcoinShooterBgLoader))
            {
               canvasBackground.addChild(starcoinShooterBgLoader);
            }
         };
         if(valueObject.playing == true)
         {
            if(!this._starcoinShooterPlaying)
            {
               this._starcoinShooterPlaying = true;
               this.setSpecialsService(false);
               if(this.starcoinShooterBgLoader != null)
               {
                  bgLoadDone(this.starcoinShooterBgLoader);
               }
               else
               {
                  MSP_SWFLoader.RequestLoad(new RawUrl(starcoinShooterBgUrl),bgLoadDone);
               }
               if(this.selectedFramelabel != starcoinShooterAnim)
               {
                  this.myMovieStar.PlayAnimation("musicvideo_2011_hiphopdance5_mf");
                  this.selectedFramelabel = "musicvideo_2011_hiphopdance5_mf";
                  this.sendActorUpdateToRoom();
               }
            }
         }
         else
         {
            if(this.starcoinShooterBgLoader != null && Boolean(this.canvasBackground.contains(this.starcoinShooterBgLoader)))
            {
               this.canvasBackground.removeChild(this.starcoinShooterBgLoader);
            }
            this.setSpecialsService(true);
            this._starcoinShooterPlaying = false;
         }
      }
      
      public function get starcoinShooterPlaying() : Boolean
      {
         return this._starcoinShooterPlaying;
      }
      
      private function playStarcoinShooterAnimation() : void
      {
         this.myMovieStar.PlayAnimation(starcoinShooterAnim);
         this.selectedFramelabel = starcoinShooterAnim;
         this.sendActorUpdateToRoom();
      }
      
      private function disableGeneralActions(param1:Boolean) : void
      {
         this.disableButtons = this.disableWalk = param1;
         var _loc2_:Boolean = !param1;
         this.btnWave.enabled = _loc2_;
         this.btnJump.enabled = _loc2_;
         this.btnDance.enabled = _loc2_;
         this.btnAnimations.enabled = _loc2_;
         this.btnFaceExpression.enabled = _loc2_;
         this.btnGames.enabled = _loc2_;
      }
      
      protected function textTextLineContainerCreationComplete(param1:FlexEvent) : void
      {
         FlashInstanceUtils.loadFlashInstanceNew(new RawUrl("swf/messaging/InputArea.swf"),this.loadDone);
      }
      
      private function loadDone(param1:MSP_FlashLoader) : void
      {
         this.textBackground = (param1.content as MovieClip).InputArea as MovieClip;
         this.textBackground.width = 452;
         this.textBackground.height = 22;
         this.textTextLine.defaultTextFormat = new TextFormat("Arial");
         this.textTextLine.maxChars = 60;
         this.textTextLine.width = this.textTextLineContainer.width;
         this.textTextLine.height = this.textTextLineContainer.height;
         this.textTextLine.addEventListener(KeyboardEvent.KEY_UP,this.textLineActivity,false,0,true);
         this.textTextLineContainer.addChild(this.textBackground);
         this.textTextLineContainer.addChild(this.textTextLine);
         this.textTextLineContainer.addEventListener(MouseEvent.ROLL_OUT,this.mouseOut,false,0,true);
         this.textTextLineContainer.addEventListener(MouseEvent.ROLL_OVER,this.mouseOver,false,0,true);
         if(this.actorModel.isModerator && !this.actorModel.isModeratorHidden)
         {
            this.textTextLineContainer.mouseChildren = false;
            this.textTextLineContainer.mouseEnabled = false;
            this.textTextLineContainer.transform.colorTransform = ColorFilterUtilities.getTint(0,0.5);
            this.textTextLine.text = "Moderators are not allowed to chat.";
         }
         else
         {
            this.textTextLineContainer.mouseChildren = true;
            this.textTextLineContainer.mouseEnabled = true;
            this.textTextLineContainer.transform.colorTransform = new ColorTransform();
            this.textTextLine.text = "Chat";
         }
      }
      
      private function mouseOver(param1:Event) : void
      {
         this.setInputFieldState("hover");
      }
      
      private function mouseOut(param1:Event) : void
      {
         this.setInputFieldState("normal");
      }
      
      private function setInputFieldState(param1:String, param2:Boolean = false) : void
      {
         if(this.textBackground != null && (param2 || this.textBackground.currentFrameLabel != "down"))
         {
            this.textBackground.gotoAndStop(param1);
         }
      }
      
      protected function fontColorButtonContainerCreationComplete(param1:FlexEvent) : void
      {
         this._fontColorButton.width = this.fontColorButtonContainer.width;
         this._fontColorButton.height = this.fontColorButtonContainer.height;
         InputUtils.mapFontFunctions(this,this.colorSelectedCallback);
         this.fontColorButtonContainer.addChild(this._fontColorButton);
         MSP_ToolTipManager.add(this.fontColorButton,MSPLocaleManagerWeb.getInstance().getString("MESSAGING_COLOR_TOOLTIP"));
      }
      
      protected function emoticonButtonContainerCreationComplete(param1:FlexEvent) : void
      {
         this._emoticonButton.buttonMode = true;
         this._emoticonButton.addChild(MessagingIcons.createIcon(MessagingIcons.ICON_EMOTICON));
         InputUtils.mapInput(this,this.chatFilteringHandler.sendTextToFriends);
         InputUtils.mapEmoticonFunctions(this,null,0);
         this.emoticonButtonContainer.addChild(this._emoticonButton);
         this._emoticonButton.width = this.emoticonButtonContainer.width;
         this._emoticonButton.height = this.emoticonButtonContainer.height;
         MSP_ToolTipManager.add(this.emoticonBtn,MSPLocaleManagerWeb.getInstance().getString("INSERT_A_SMILEY"));
      }
      
      private function colorSelectedCallback(param1:uint) : void
      {
         var _loc2_:TextFormat = this.textTextLine.defaultTextFormat;
         _loc2_.color = param1;
         this.textTextLine.defaultTextFormat = _loc2_;
         this.textTextLine.setTextFormat(_loc2_);
         this.fontColor = param1;
      }
      
      public function get fontColorButton() : Sprite
      {
         return this._fontColorButton;
      }
      
      public function get emoticonBtn() : Sprite
      {
         return this._emoticonButton;
      }
      
      public function get textArea() : TextFieldInputRestricted
      {
         return this.textTextLine;
      }
      
      private function startIdleAnimTimer(param1:Boolean = true) : void
      {
         this.stopIdleAnimTimer();
         if(param1)
         {
            this.idleAnimTimer = new Timer(this.LONG_ANIM_TIME);
         }
         else
         {
            this.idleAnimTimer = new Timer(this.SHORT_ANIM_TIME);
         }
         this.idleAnimTimer.addEventListener(TimerEvent.TIMER,this.startInnerIdleAnimTimer);
         this.idleAnimTimer.start();
      }
      
      private function stopIdleAnimTimer() : void
      {
         if(this.idleAnimTimer != null)
         {
            this.idleAnimTimer.stop();
            this.idleAnimTimer.removeEventListener(TimerEvent.TIMER,this.startInnerIdleAnimTimer);
         }
         this.stopInnerIdleAnimTimer();
      }
      
      private function notIdle(param1:Boolean = true) : void
      {
         this.startIdleAnimTimer(param1);
         this.stopInnerIdleAnimTimer();
      }
      
      private function stopInnerIdleAnimTimer() : void
      {
         if(this.innerIdleAnimTimer != null)
         {
            this.innerIdleAnimTimer.stop();
            this.innerIdleAnimTimer.removeEventListener(TimerEvent.TIMER,this.playRandomAnimation);
            this.innerIdleAnimTimer = null;
         }
      }
      
      private function startInnerIdleAnimTimer(param1:TimerEvent) : void
      {
         this.stopInnerIdleAnimTimer();
         this.innerIdleAnimTimer = new Timer(Math.random() * 5000,1);
         this.innerIdleAnimTimer.addEventListener(TimerEvent.TIMER,this.playRandomAnimation);
         this.innerIdleAnimTimer.start();
      }
      
      private function playRandomAnimation(param1:TimerEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         this.stopInnerIdleAnimTimer();
         if(this.mySharedActor != null)
         {
            if(!this.myMovieStar.isAnimating)
            {
               _loc2_ = Math.random() * this.RANDOM_ANIMATIONS.length;
               _loc3_ = _loc2_ / 1;
               this.selectedFramelabel = this.RANDOM_ANIMATIONS[_loc3_];
               this.myMovieStar.PlayAnimation(this.selectedFramelabel);
               this.sendActorUpdateToRoom();
            }
            this.notIdle(false);
         }
         else
         {
            this.stopIdleAnimTimer();
         }
      }
      
      protected function textLineActivity(param1:KeyboardEvent) : void
      {
         this.notIdle();
      }
      
      private function onChatPermissionUpdate(param1:Event) : void
      {
         if(!ChatPermissionManager.instance.isPermitted)
         {
            this.close();
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("CHAT_NOT_ALLOWED_DESC",[DateUtils.msToHrsMinsSecsString(ChatPermissionManager.instance.getSecondsRemaining() * 1000)]));
         }
      }
      
      private function enteringSwrveEvent() : void
      {
         AnalyticsTimer.forceSendMessages(this.getSwrveNames(),AnalyticsTimer.ENTER_TIMER,true);
         MangroveFeatureTracker.registerFeatureOpen(this.getMangroveFeatureName(),this.getMangroveSubFeatureName());
      }
      
      private function leavingSwrveEvent(param1:Event = null) : void
      {
         AnalyticsTimer.forceSendMessages(this.getSwrveNames(),AnalyticsTimer.EXIT_TIMER,true);
         MangroveFeatureTracker.registerFeatureClose(this.getMangroveFeatureName(),this.getMangroveSubFeatureName());
         this.removeLeavingSwrveEventListener();
      }
      
      private function getSwrveNames() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:String = null;
         if(this.isInChat && this.roomType != null)
         {
            if(this.roomType.ident == ChatRoomType.BEACH.ident)
            {
               _loc2_ = TimeSpentConstants.FEATURE_CHAT_BEACH;
            }
            else if(this.roomType.ident == ChatRoomType.PARK.ident)
            {
               _loc2_ = TimeSpentConstants.FEATURE_CHAT_PETPARK;
            }
            else if(this.roomType.ident == ChatRoomType.CAFE.ident)
            {
               _loc2_ = TimeSpentConstants.FEATURE_CHAT_CAFE;
            }
            else if(this.roomType.ident == ChatRoomType.SKATEPARK.ident)
            {
               _loc2_ = TimeSpentConstants.FEATURE_CHAT_SKATEPARK;
            }
            else if(this.roomType.ident == ChatRoomType.SCHOOL.ident)
            {
               _loc2_ = TimeSpentConstants.FEATURE_CHAT_HIGHSCHOOL;
            }
            else if(this.roomType.ident == ChatRoomType.MALL.ident)
            {
               _loc2_ = TimeSpentConstants.FEATURE_CHAT_MALL;
            }
            else if(this.roomType.ident == ChatRoomType.CLUB.ident)
            {
               _loc2_ = TimeSpentConstants.FEATURE_CHAT_VIPCLUB;
            }
            else if(this.roomType.ident == ChatRoomType.VIDEO_CHATROOM.ident)
            {
               _loc2_ = TimeSpentConstants.FEATURE_CHAT_CINEMA;
            }
            else if(this.roomType.ident == ChatRoomType.THEMEROOM.ident)
            {
               _loc2_ = TimeSpentConstants.FEATURE_CHAT_THEMEROOM;
            }
            _loc1_ = [TimeSpentConstants.FEATURE_CHAT,_loc2_];
         }
         else if(this.isInMinigame && this.minigameType != null)
         {
            if(this.minigameType == MiniGameType.QUIZ_MINIGAME)
            {
               _loc2_ = TimeSpentConstants.FEATURE_GAMES_QUIZ;
            }
            else if(this.minigameType == MiniGameType.DRESSUP_MINIGAME)
            {
               _loc2_ = TimeSpentConstants.FEATURE_GAMES_DRESSUP;
            }
            else if(this.minigameType == MiniGameType.CASTING_MINIGAME)
            {
               _loc2_ = TimeSpentConstants.FEATURE_GAMES_CASTING;
            }
            else if(this.minigameType == MiniGameType.CRAZYWORD_MINIGAME)
            {
               _loc2_ = TimeSpentConstants.FEATURE_GAMES_CRAZYCARDS;
            }
            else if(this.minigameType == MiniGameType.CATWALK_MINIGAME)
            {
               _loc2_ = TimeSpentConstants.FEATURE_GAMES_CATWALK;
            }
            _loc1_ = [TimeSpentConstants.FEATURE_GAMES,_loc2_];
         }
         else if(this.isInMyRoom)
         {
            _loc2_ = TimeSpentConstants.FEATURE_MYROOM_VIEW;
            _loc1_ = [_loc2_];
         }
         return _loc1_;
      }
      
      private function getMangroveFeatureName() : String
      {
         if(this.isInChat && this.roomType != null)
         {
            return FeatureUsage.FEATURE_CHAT;
         }
         if(this.isInMinigame && this.minigameType != null)
         {
            return FeatureUsage.FEATURE_GAME;
         }
         if(this.isInMyRoom)
         {
            return FeatureUsage.FEATURE_MY_ROOM;
         }
         return null;
      }
      
      private function getMangroveSubFeatureName() : String
      {
         var _loc1_:String = null;
         if(this.roomType != null)
         {
            if(this.roomType.ident == ChatRoomType.BEACH.ident)
            {
               _loc1_ = FeatureUsage.FEATURE_SUB1_BEACH;
            }
            else if(this.roomType.ident == ChatRoomType.PARK.ident)
            {
               _loc1_ = FeatureUsage.FEATURE_SUB1_PET_PARK;
            }
            else if(this.roomType.ident == ChatRoomType.CAFE.ident)
            {
               _loc1_ = FeatureUsage.FEATURE_SUB1_CAFE;
            }
            else if(this.roomType.ident == ChatRoomType.SKATEPARK.ident)
            {
               _loc1_ = FeatureUsage.FEATURE_SUB1_SKATE_PARK;
            }
            else if(this.roomType.ident == ChatRoomType.MALL.ident)
            {
               _loc1_ = FeatureUsage.FEATURE_SUB1_MALL;
            }
            else if(this.roomType.ident == ChatRoomType.CLUB.ident)
            {
               _loc1_ = FeatureUsage.FEATURE_SUB1_VIP_CLUB;
            }
            else if(this.roomType.ident == ChatRoomType.VIDEO_CHATROOM.ident)
            {
               _loc1_ = FeatureUsage.FEATURE_SUB1_CINEMA;
            }
            else if(this.roomType.ident == ChatRoomType.THEMEROOM.ident)
            {
               _loc1_ = FeatureUsage.FEATURE_SUB1_THEME;
            }
         }
         else if(this.minigameType != null)
         {
            if(this.minigameType == MiniGameType.QUIZ_MINIGAME)
            {
               _loc1_ = FeatureUsage.FEATURE_SUB1_QUIZ;
            }
            else if(this.minigameType == MiniGameType.DRESSUP_MINIGAME)
            {
               _loc1_ = FeatureUsage.FEATURE_SUB1_DRESS_UP;
            }
            else if(this.minigameType == MiniGameType.CASTING_MINIGAME)
            {
               _loc1_ = FeatureUsage.FEATURE_SUB1_CASTING;
            }
            else if(this.minigameType == MiniGameType.CRAZYWORD_MINIGAME)
            {
               _loc1_ = FeatureUsage.FEATURE_SUB1_CRAZY_CARDS;
            }
            else if(this.minigameType == MiniGameType.CATWALK_MINIGAME)
            {
               _loc1_ = FeatureUsage.FEATURE_SUB1_CATWALK;
            }
         }
         else
         {
            _loc1_ = FeatureUsage.FEATURE_SUB1_VIEWER;
         }
         return _loc1_;
      }
      
      public function removeLeavingSwrveEventListener() : void
      {
         this.removeEventListener(Event.REMOVED_FROM_STAGE,this.leavingSwrveEvent);
         this.isInChat = false;
         this.isInMyRoom = false;
      }
      
      private function triggerRoomSnapshots() : void
      {
         var _loc1_:ILoaderUrl = null;
         var _loc2_:MSP_FlashLoader = null;
         if(FeatureToggle.getFeatureActive(FeatureToggle.SAVE_SNAPSHOT_ON_ENTER_ROOM) && !this.hasAlreadyTriggeredSnapshot)
         {
            _loc1_ = new SnapshotUrl(this.actorId,EntityTypeType.ROOM_PROFILE,EntityTypeType.EntityTypeAsString(EntityTypeType.ROOM_PROFILE));
            _loc2_ = new MSP_FlashLoader(true,false);
            _loc2_.addEventListener(Event.COMPLETE,this.loadSnapshotComplete);
            _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.loadSnapshotFailed);
            _loc2_.LoadUrl(_loc1_);
            this.hasAlreadyTriggeredSnapshot = true;
         }
      }
      
      private function loadSnapshotComplete(param1:Event) : void
      {
      }
      
      private function loadSnapshotFailed(param1:Event) : void
      {
         this.saveRoomSnapshots();
      }
      
      private function saveRoomSnapshots() : void
      {
         var _loc1_:ByteArray = null;
         var _loc2_:ByteArray = null;
         var _loc3_:ByteArray = null;
         this.setMovieStarsVisiblity(false);
         _loc1_ = generateChatRoomSnapshotByteArray(ChatroomConstants.PROFILE_SNAPSHOT_WIDTH,ChatroomConstants.PROFILE_SNAPSHOT_HEIGHT,this._publicProfile.stuffView,[this._publicProfile.stuffView,this.canvasActor]);
         this.setMovieStarsVisiblity(true);
         _loc2_ = generateChatRoomSnapshotByteArray(ChatroomConstants.MEDIUM_SNAPSHOT_WIDTH,ChatroomConstants.MEDIUM_SNAPSHOT_HEIGHT,this._publicProfile.stuffView,[this._publicProfile.stuffView,this.canvasActor]);
         _loc3_ = generateChatRoomSnapshotByteArray(ChatroomConstants.SMALL_SNAPSHOT_WIDTH,ChatroomConstants.SMALL_SNAPSHOT_HEIGHT,this._publicProfile.stuffView,[this._publicProfile.stuffView,this.canvasActor]);
         SnapshotUtils.saveSnapshotNew(ActorSession.getActorId(),EntityTypeType.EntityTypeAsString(EntityTypeType.ROOM),[ActorSession.getActorId()],_loc3_,"jpg");
         SnapshotUtils.saveSnapshotNew(ActorSession.getActorId(),EntityTypeType.EntityTypeAsString(EntityTypeType.ROOM_MEDIUM),[ActorSession.getActorId()],_loc2_,"jpg");
         SnapshotUtils.saveSnapshotNew(ActorSession.getActorId(),EntityTypeType.EntityTypeAsString(EntityTypeType.ROOM_PROFILE),[ActorSession.getActorId()],_loc1_,"jpg");
      }
      
      private function _ChatRoom_Sequence1_i() : Sequence
      {
         var _loc1_:Sequence = null;
         _loc1_ = new Sequence();
         _loc1_.repeatCount = 1;
         _loc1_.children = [this._ChatRoom_Glow1_c(),this._ChatRoom_Glow2_c()];
         this.glow = _loc1_;
         BindingManager.executeBindings(this,"glow",this.glow);
         return _loc1_;
      }
      
      private function _ChatRoom_Glow1_c() : Glow
      {
         var _loc1_:Glow = null;
         _loc1_ = new Glow();
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.blurXFrom = 20;
         _loc1_.blurXTo = 40;
         _loc1_.blurYFrom = 20;
         _loc1_.blurYTo = 40;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      private function _ChatRoom_Glow2_c() : Glow
      {
         var _loc1_:Glow = null;
         _loc1_ = new Glow();
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         _loc1_.blurXFrom = 40;
         _loc1_.blurXTo = 20;
         _loc1_.blurYFrom = 40;
         _loc1_.blurYTo = 20;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      private function _ChatRoom_Sequence2_i() : Sequence
      {
         var _loc1_:Sequence = null;
         _loc1_ = new Sequence();
         _loc1_.repeatCount = 1;
         _loc1_.children = [this._ChatRoom_Glow3_c(),this._ChatRoom_Glow4_c()];
         this.starGlow = _loc1_;
         BindingManager.executeBindings(this,"starGlow",this.starGlow);
         return _loc1_;
      }
      
      private function _ChatRoom_Glow3_c() : Glow
      {
         var _loc1_:Glow = null;
         _loc1_ = new Glow();
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.blurXFrom = 20;
         _loc1_.blurXTo = 40;
         _loc1_.blurYFrom = 20;
         _loc1_.blurYTo = 40;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      private function _ChatRoom_Glow4_c() : Glow
      {
         var _loc1_:Glow = null;
         _loc1_ = new Glow();
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         _loc1_.blurXFrom = 40;
         _loc1_.blurXTo = 20;
         _loc1_.blurYFrom = 40;
         _loc1_.blurYTo = 20;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      private function _ChatRoom_Sequence3_i() : Sequence
      {
         var _loc1_:Sequence = null;
         _loc1_ = new Sequence();
         _loc1_.repeatCount = 1;
         _loc1_.children = [this._ChatRoom_Glow5_c(),this._ChatRoom_Glow6_c()];
         this.starGlow2 = _loc1_;
         BindingManager.executeBindings(this,"starGlow2",this.starGlow2);
         return _loc1_;
      }
      
      private function _ChatRoom_Glow5_c() : Glow
      {
         var _loc1_:Glow = null;
         _loc1_ = new Glow();
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.blurXFrom = 20;
         _loc1_.blurXTo = 40;
         _loc1_.blurYFrom = 20;
         _loc1_.blurYTo = 40;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      private function _ChatRoom_Glow6_c() : Glow
      {
         var _loc1_:Glow = null;
         _loc1_ = new Glow();
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         _loc1_.blurXFrom = 40;
         _loc1_.blurXTo = 20;
         _loc1_.blurYFrom = 40;
         _loc1_.blurYTo = 20;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      private function _ChatRoom_Sequence4_i() : Sequence
      {
         var _loc1_:Sequence = null;
         _loc1_ = new Sequence();
         _loc1_.repeatCount = 1;
         _loc1_.children = [this._ChatRoom_Glow7_c(),this._ChatRoom_Glow8_c()];
         this.starGlow3 = _loc1_;
         BindingManager.executeBindings(this,"starGlow3",this.starGlow3);
         return _loc1_;
      }
      
      private function _ChatRoom_Glow7_c() : Glow
      {
         var _loc1_:Glow = null;
         _loc1_ = new Glow();
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.blurXFrom = 20;
         _loc1_.blurXTo = 40;
         _loc1_.blurYFrom = 20;
         _loc1_.blurYTo = 40;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      private function _ChatRoom_Glow8_c() : Glow
      {
         var _loc1_:Glow = null;
         _loc1_ = new Glow();
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         _loc1_.blurXFrom = 40;
         _loc1_.blurXTo = 20;
         _loc1_.blurYFrom = 40;
         _loc1_.blurYTo = 20;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      private function _ChatRoom_Sequence5_i() : Sequence
      {
         var _loc1_:Sequence = null;
         _loc1_ = new Sequence();
         _loc1_.repeatCount = 1;
         _loc1_.children = [this._ChatRoom_Glow9_c(),this._ChatRoom_Glow10_c()];
         this.starGlow4 = _loc1_;
         BindingManager.executeBindings(this,"starGlow4",this.starGlow4);
         return _loc1_;
      }
      
      private function _ChatRoom_Glow9_c() : Glow
      {
         var _loc1_:Glow = null;
         _loc1_ = new Glow();
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.blurXFrom = 20;
         _loc1_.blurXTo = 40;
         _loc1_.blurYFrom = 20;
         _loc1_.blurYTo = 40;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      private function _ChatRoom_Glow10_c() : Glow
      {
         var _loc1_:Glow = null;
         _loc1_ = new Glow();
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         _loc1_.blurXFrom = 40;
         _loc1_.blurXTo = 20;
         _loc1_.blurYFrom = 40;
         _loc1_.blurYTo = 20;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      private function _ChatRoom_Sequence6_i() : Sequence
      {
         var _loc1_:Sequence = null;
         _loc1_ = new Sequence();
         _loc1_.repeatCount = 1;
         _loc1_.children = [this._ChatRoom_Glow11_c(),this._ChatRoom_Glow12_c()];
         this.starGlow5 = _loc1_;
         BindingManager.executeBindings(this,"starGlow5",this.starGlow5);
         return _loc1_;
      }
      
      private function _ChatRoom_Glow11_c() : Glow
      {
         var _loc1_:Glow = null;
         _loc1_ = new Glow();
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.blurXFrom = 20;
         _loc1_.blurXTo = 40;
         _loc1_.blurYFrom = 20;
         _loc1_.blurYTo = 40;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      private function _ChatRoom_Glow12_c() : Glow
      {
         var _loc1_:Glow = null;
         _loc1_ = new Glow();
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         _loc1_.blurXFrom = 40;
         _loc1_.blurXTo = 20;
         _loc1_.blurYFrom = 40;
         _loc1_.blurYTo = 20;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      private function _ChatRoom_Sequence7_i() : Sequence
      {
         var _loc1_:Sequence = null;
         _loc1_ = new Sequence();
         _loc1_.repeatCount = 1;
         _loc1_.children = [this._ChatRoom_Glow13_c(),this._ChatRoom_Glow14_c()];
         this.starGlow6 = _loc1_;
         BindingManager.executeBindings(this,"starGlow6",this.starGlow6);
         return _loc1_;
      }
      
      private function _ChatRoom_Glow13_c() : Glow
      {
         var _loc1_:Glow = null;
         _loc1_ = new Glow();
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.blurXFrom = 20;
         _loc1_.blurXTo = 40;
         _loc1_.blurYFrom = 20;
         _loc1_.blurYTo = 40;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      private function _ChatRoom_Glow14_c() : Glow
      {
         var _loc1_:Glow = null;
         _loc1_ = new Glow();
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         _loc1_.blurXFrom = 40;
         _loc1_.blurXTo = 20;
         _loc1_.blurYFrom = 40;
         _loc1_.blurYTo = 20;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      private function _ChatRoom_Sequence8_i() : Sequence
      {
         var _loc1_:Sequence = null;
         _loc1_ = new Sequence();
         _loc1_.repeatCount = 1;
         _loc1_.children = [this._ChatRoom_Glow15_c(),this._ChatRoom_Glow16_c()];
         this.starGlow7 = _loc1_;
         BindingManager.executeBindings(this,"starGlow7",this.starGlow7);
         return _loc1_;
      }
      
      private function _ChatRoom_Glow15_c() : Glow
      {
         var _loc1_:Glow = null;
         _loc1_ = new Glow();
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.blurXFrom = 20;
         _loc1_.blurXTo = 40;
         _loc1_.blurYFrom = 20;
         _loc1_.blurYTo = 40;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      private function _ChatRoom_Glow16_c() : Glow
      {
         var _loc1_:Glow = null;
         _loc1_ = new Glow();
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         _loc1_.blurXFrom = 40;
         _loc1_.blurXTo = 20;
         _loc1_.blurYFrom = 40;
         _loc1_.blurYTo = 20;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      private function _ChatRoom_Sequence9_i() : Sequence
      {
         var _loc1_:Sequence = null;
         _loc1_ = new Sequence();
         _loc1_.repeatCount = 1;
         _loc1_.children = [this._ChatRoom_Glow17_c(),this._ChatRoom_Glow18_c()];
         this.starGlow8 = _loc1_;
         BindingManager.executeBindings(this,"starGlow8",this.starGlow8);
         return _loc1_;
      }
      
      private function _ChatRoom_Glow17_c() : Glow
      {
         var _loc1_:Glow = null;
         _loc1_ = new Glow();
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.blurXFrom = 20;
         _loc1_.blurXTo = 40;
         _loc1_.blurYFrom = 20;
         _loc1_.blurYTo = 40;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      private function _ChatRoom_Glow18_c() : Glow
      {
         var _loc1_:Glow = null;
         _loc1_ = new Glow();
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         _loc1_.blurXFrom = 40;
         _loc1_.blurXTo = 20;
         _loc1_.blurYFrom = 40;
         _loc1_.blurYTo = 20;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      public function ___ChatRoom_ViewComponentCanvas1_addedToStage(param1:Event) : void
      {
         this.onAddedToStage(param1);
      }
      
      public function ___ChatRoom_ViewComponentCanvas1_initialize(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function __sliderCanvas_creationComplete(param1:FlexEvent) : void
      {
         this.onCreation();
      }
      
      public function __btn_Invite_click(param1:MouseEvent) : void
      {
         this.clicked_InviteFriendToRoom();
      }
      
      public function __textTextLineContainer_creationComplete(param1:FlexEvent) : void
      {
         this.textTextLineContainerCreationComplete(param1);
      }
      
      public function __textTextLineContainer_focusIn(param1:FocusEvent) : void
      {
         this.focusIn_textline();
      }
      
      public function __textTextLineContainer_focusOut(param1:FocusEvent) : void
      {
         this.focusOut_textline();
      }
      
      public function __fontColorButtonContainer_creationComplete(param1:FlexEvent) : void
      {
         this.fontColorButtonContainerCreationComplete(param1);
      }
      
      public function __emoticonButtonContainer_creationComplete(param1:FlexEvent) : void
      {
         this.emoticonButtonContainerCreationComplete(param1);
      }
      
      public function __likeBtn_click(param1:MouseEvent) : void
      {
         this.loveClicked();
      }
      
      public function ___ChatRoom_MSP_ClickImage2_click(param1:MouseEvent) : void
      {
         this.profileClicked();
      }
      
      public function __btnWave_click(param1:MouseEvent) : void
      {
         this.click_AnimWave();
      }
      
      public function __btnJump_click(param1:MouseEvent) : void
      {
         this.click_AnimJump();
      }
      
      public function __btnDance_click(param1:MouseEvent) : void
      {
         this.click_AnimDance();
      }
      
      public function __btnAnimations_click(param1:MouseEvent) : void
      {
         this.animationButtonClick();
      }
      
      public function __btnFaceExpression_click(param1:MouseEvent) : void
      {
         this.faceexpressionButtonClick();
      }
      
      public function __btnGames_click(param1:MouseEvent) : void
      {
         this.playGamesButtonClick();
      }
      
      public function ___ChatRoom_CloseButton1_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      private function _ChatRoom_bindingsSetup() : Array
      {
         var result:Array = null;
         result = [];
         result[0] = new Binding(this,function():Object
         {
            return ChatRoom.SWF_URL_INVITE;
         },null,"btn_Invite.source");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = MSPLocaleManagerWeb.getInstance().getString("INVITE_FRIENDS");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btn_Invite.toolTip");
         result[2] = new Binding(this,function():Object
         {
            return ChatRoom.SWF_URL_COUNTER;
         },null,"likesLoader.source");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = MSPLocaleManagerWeb.getInstance().getString("LIKES");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"likesLoader.toolTip");
         result[4] = new Binding(this,function():Object
         {
            return ChatRoom.SWF_URL_LOVEIT;
         },null,"likeBtn.source");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = MSPLocaleManagerWeb.getInstance().getString("LIKES");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"lovesCount.toolTip");
         result[6] = new Binding(this,function():Object
         {
            return ChatRoom.SWF_URL_MYPROFILE;
         },null,"_ChatRoom_MSP_ClickImage2.source");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = MSPLocaleManagerWeb.getInstance().getString("PROFILE");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_ChatRoom_MSP_ClickImage2.toolTip");
         result[8] = new Binding(this,function():Object
         {
            return ChatRoom.SWF_URL_WAVE;
         },null,"btnWave.source");
         result[9] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = MSPLocaleManagerWeb.getInstance().getString("WAVE");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnWave.toolTip");
         result[10] = new Binding(this,function():Object
         {
            return ChatRoom.SWF_URL_JUMP;
         },null,"btnJump.source");
         result[11] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = MSPLocaleManagerWeb.getInstance().getString("JUMP");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnJump.toolTip");
         result[12] = new Binding(this,function():Object
         {
            return ChatRoom.SWF_URL_DANCE;
         },null,"btnDance.source");
         result[13] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = MSPLocaleManagerWeb.getInstance().getString("DANCE");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnDance.toolTip");
         result[14] = new Binding(this,function():Object
         {
            return ChatRoom.SWF_URL_ANIMLIST;
         },null,"btnAnimations.source");
         result[15] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = MSPLocaleManagerWeb.getInstance().getString("ANIMATIONS");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnAnimations.toolTip");
         result[16] = new Binding(this,function():Object
         {
            return ChatRoom.SWF_URL_FACE;
         },null,"btnFaceExpression.source");
         result[17] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = MSPLocaleManagerWeb.getInstance().getString("FACE_EXPRESSIONS");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnFaceExpression.toolTip");
         result[18] = new Binding(this,function():Object
         {
            return ChatRoom.SWF_URL_GAME;
         },null,"btnGames.source");
         result[19] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = MSPLocaleManagerWeb.getInstance().getString("PLAY_GAME");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnGames.toolTip");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get LoveAndCommentsContainer() : HBox
      {
         return this._1114030728LoveAndCommentsContainer;
      }
      
      public function set LoveAndCommentsContainer(param1:HBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1114030728LoveAndCommentsContainer;
         if(_loc2_ !== param1)
         {
            this._1114030728LoveAndCommentsContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"LoveAndCommentsContainer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnAnimations() : MSP_ClickImage
      {
         return this._1316383979btnAnimations;
      }
      
      public function set btnAnimations(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1316383979btnAnimations;
         if(_loc2_ !== param1)
         {
            this._1316383979btnAnimations = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnAnimations",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnDance() : MSP_ClickImage
      {
         return this._2082937527btnDance;
      }
      
      public function set btnDance(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2082937527btnDance;
         if(_loc2_ !== param1)
         {
            this._2082937527btnDance = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnDance",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnFaceExpression() : MSP_ClickImage
      {
         return this._1720930735btnFaceExpression;
      }
      
      public function set btnFaceExpression(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1720930735btnFaceExpression;
         if(_loc2_ !== param1)
         {
            this._1720930735btnFaceExpression = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnFaceExpression",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnGames() : MSP_ClickImage
      {
         return this._2085707205btnGames;
      }
      
      public function set btnGames(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2085707205btnGames;
         if(_loc2_ !== param1)
         {
            this._2085707205btnGames = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnGames",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnJump() : MSP_ClickImage
      {
         return this._205936810btnJump;
      }
      
      public function set btnJump(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._205936810btnJump;
         if(_loc2_ !== param1)
         {
            this._205936810btnJump = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnJump",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnStarcoinShooter() : UIComponent
      {
         return this._764673619btnStarcoinShooter;
      }
      
      public function set btnStarcoinShooter(param1:UIComponent) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._764673619btnStarcoinShooter;
         if(_loc2_ !== param1)
         {
            this._764673619btnStarcoinShooter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnStarcoinShooter",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnWave() : MSP_ClickImage
      {
         return this._206305141btnWave;
      }
      
      public function set btnWave(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._206305141btnWave;
         if(_loc2_ !== param1)
         {
            this._206305141btnWave = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnWave",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btn_Invite() : MSP_ClickImage
      {
         return this._2049440364btn_Invite;
      }
      
      public function set btn_Invite(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2049440364btn_Invite;
         if(_loc2_ !== param1)
         {
            this._2049440364btn_Invite = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btn_Invite",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get canvasActor() : Canvas
      {
         return this._1900815491canvasActor;
      }
      
      public function set canvasActor(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1900815491canvasActor;
         if(_loc2_ !== param1)
         {
            this._1900815491canvasActor = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canvasActor",_loc2_,param1));
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
      public function get canvasControl() : Canvas
      {
         return this._790582501canvasControl;
      }
      
      public function set canvasControl(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._790582501canvasControl;
         if(_loc2_ !== param1)
         {
            this._790582501canvasControl = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canvasControl",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get canvasSpeach() : Canvas
      {
         return this._1731131734canvasSpeach;
      }
      
      public function set canvasSpeach(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1731131734canvasSpeach;
         if(_loc2_ !== param1)
         {
            this._1731131734canvasSpeach = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canvasSpeach",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get canvasStuff() : Canvas
      {
         return this._1883684996canvasStuff;
      }
      
      public function set canvasStuff(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1883684996canvasStuff;
         if(_loc2_ !== param1)
         {
            this._1883684996canvasStuff = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canvasStuff",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get chatRoomSelect() : ChatRoomSelector
      {
         return this._1295020847chatRoomSelect;
      }
      
      public function set chatRoomSelect(param1:ChatRoomSelector) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1295020847chatRoomSelect;
         if(_loc2_ !== param1)
         {
            this._1295020847chatRoomSelect = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"chatRoomSelect",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get controlCanvas() : Canvas
      {
         return this._408587541controlCanvas;
      }
      
      public function set controlCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._408587541controlCanvas;
         if(_loc2_ !== param1)
         {
            this._408587541controlCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"controlCanvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get emoticonButtonContainer() : UIComponent
      {
         return this._407017993emoticonButtonContainer;
      }
      
      public function set emoticonButtonContainer(param1:UIComponent) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._407017993emoticonButtonContainer;
         if(_loc2_ !== param1)
         {
            this._407017993emoticonButtonContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"emoticonButtonContainer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fontColorButtonContainer() : UIComponent
      {
         return this._398505595fontColorButtonContainer;
      }
      
      public function set fontColorButtonContainer(param1:UIComponent) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._398505595fontColorButtonContainer;
         if(_loc2_ !== param1)
         {
            this._398505595fontColorButtonContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fontColorButtonContainer",_loc2_,param1));
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
      public function get hboxselector() : HBox
      {
         return this._760634046hboxselector;
      }
      
      public function set hboxselector(param1:HBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._760634046hboxselector;
         if(_loc2_ !== param1)
         {
            this._760634046hboxselector = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"hboxselector",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lblCaption() : Label
      {
         return this._676681552lblCaption;
      }
      
      public function set lblCaption(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._676681552lblCaption;
         if(_loc2_ !== param1)
         {
            this._676681552lblCaption = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lblCaption",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get likeBtn() : MSP_AnimatedStateButton
      {
         return this._174103365likeBtn;
      }
      
      public function set likeBtn(param1:MSP_AnimatedStateButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._174103365likeBtn;
         if(_loc2_ !== param1)
         {
            this._174103365likeBtn = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"likeBtn",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get likesLoader() : MSP_SWFLoader
      {
         return this._1114809071likesLoader;
      }
      
      public function set likesLoader(param1:MSP_SWFLoader) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1114809071likesLoader;
         if(_loc2_ !== param1)
         {
            this._1114809071likesLoader = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"likesLoader",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lockedText() : Label
      {
         return this._1392072535lockedText;
      }
      
      public function set lockedText(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1392072535lockedText;
         if(_loc2_ !== param1)
         {
            this._1392072535lockedText = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lockedText",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lovesCount() : Label
      {
         return this._513172914lovesCount;
      }
      
      public function set lovesCount(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._513172914lovesCount;
         if(_loc2_ !== param1)
         {
            this._513172914lovesCount = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lovesCount",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get outer() : Canvas
      {
         return this._106111099outer;
      }
      
      public function set outer(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._106111099outer;
         if(_loc2_ !== param1)
         {
            this._106111099outer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"outer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get selectorCanvas() : Canvas
      {
         return this._1173402135selectorCanvas;
      }
      
      public function set selectorCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1173402135selectorCanvas;
         if(_loc2_ !== param1)
         {
            this._1173402135selectorCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"selectorCanvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get sliderCanvas() : Canvas
      {
         return this._1684008345sliderCanvas;
      }
      
      public function set sliderCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1684008345sliderCanvas;
         if(_loc2_ !== param1)
         {
            this._1684008345sliderCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sliderCanvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get starGlow() : Sequence
      {
         return this._1315469055starGlow;
      }
      
      public function set starGlow(param1:Sequence) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1315469055starGlow;
         if(_loc2_ !== param1)
         {
            this._1315469055starGlow = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"starGlow",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get starGlow2() : Sequence
      {
         return this._2124835091starGlow2;
      }
      
      public function set starGlow2(param1:Sequence) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2124835091starGlow2;
         if(_loc2_ !== param1)
         {
            this._2124835091starGlow2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"starGlow2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get starGlow3() : Sequence
      {
         return this._2124835092starGlow3;
      }
      
      public function set starGlow3(param1:Sequence) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2124835092starGlow3;
         if(_loc2_ !== param1)
         {
            this._2124835092starGlow3 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"starGlow3",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get starGlow4() : Sequence
      {
         return this._2124835093starGlow4;
      }
      
      public function set starGlow4(param1:Sequence) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2124835093starGlow4;
         if(_loc2_ !== param1)
         {
            this._2124835093starGlow4 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"starGlow4",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get starGlow5() : Sequence
      {
         return this._2124835094starGlow5;
      }
      
      public function set starGlow5(param1:Sequence) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2124835094starGlow5;
         if(_loc2_ !== param1)
         {
            this._2124835094starGlow5 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"starGlow5",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get starGlow6() : Sequence
      {
         return this._2124835095starGlow6;
      }
      
      public function set starGlow6(param1:Sequence) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2124835095starGlow6;
         if(_loc2_ !== param1)
         {
            this._2124835095starGlow6 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"starGlow6",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get starGlow7() : Sequence
      {
         return this._2124835096starGlow7;
      }
      
      public function set starGlow7(param1:Sequence) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2124835096starGlow7;
         if(_loc2_ !== param1)
         {
            this._2124835096starGlow7 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"starGlow7",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get starGlow8() : Sequence
      {
         return this._2124835097starGlow8;
      }
      
      public function set starGlow8(param1:Sequence) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2124835097starGlow8;
         if(_loc2_ !== param1)
         {
            this._2124835097starGlow8 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"starGlow8",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get textTextLineContainer() : UIComponent
      {
         return this._817382675textTextLineContainer;
      }
      
      public function set textTextLineContainer(param1:UIComponent) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._817382675textTextLineContainer;
         if(_loc2_ !== param1)
         {
            this._817382675textTextLineContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"textTextLineContainer",_loc2_,param1));
            }
         }
      }
   }
}

