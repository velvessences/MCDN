package com.moviestarplanet.frontpage
{
   import com.moviestarplanet.Components.MSP_ClickImage;
   import com.moviestarplanet.Components.MSP_ItemContainer;
   import com.moviestarplanet.Components.MultiColorPanel;
   import com.moviestarplanet.Components.ViewComponent.ViewComponentCanvas;
   import com.moviestarplanet.Components.ViewComponent.ViewComponentViewStack;
   import com.moviestarplanet.Forms.MSP_ComboBox;
   import com.moviestarplanet.actorservice.service.ActorAmfServiceForWeb;
   import com.moviestarplanet.actorsession.ActorIdHash;
   import com.moviestarplanet.advertisement.AdvertisementWrapper;
   import com.moviestarplanet.advertisement.TrafficTracking;
   import com.moviestarplanet.amf.TicketGenerator;
   import com.moviestarplanet.analytics.AnalyticsSendEventCommand;
   import com.moviestarplanet.analytics.GoogleAnalyticsTracker;
   import com.moviestarplanet.analytics.SwrveSetupCommand;
   import com.moviestarplanet.analytics.constants.AnalyticsConstants;
   import com.moviestarplanet.analytics.timer.MangroveFeatureUsageTimer;
   import com.moviestarplanet.body.Body;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.clientcensor.BlackListUtil;
   import com.moviestarplanet.color.ColorCollections;
   import com.moviestarplanet.color.ColorUtils;
   import com.moviestarplanet.configurations.AppSettings;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.configurations.FeatureToggle;
   import com.moviestarplanet.configurations.TermsConditions;
   import com.moviestarplanet.connections.LogoutHandler;
   import com.moviestarplanet.core.controller.commands.BrowseToMovieStarPlanetCommand;
   import com.moviestarplanet.core.controller.commands.startupcommands.EnterApplicationCommand;
   import com.moviestarplanet.createuser.NewUserState;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   import com.moviestarplanet.logging.services.loggingservice.LoggingAmfService;
   import com.moviestarplanet.mangroveanalytics.configuration.MangroveConfig;
   import com.moviestarplanet.mangroveanalytics.configuration.MangroveConfigureBasicInfoCommand;
   import com.moviestarplanet.math.NumberUtils;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.moviestar.MovieStar;
   import com.moviestarplanet.moviestar.MovieStarDragonBone;
   import com.moviestarplanet.moviestar.controller.CheckClothingCommand;
   import com.moviestarplanet.moviestar.controller.SaveMovieStarSnapshotCommand;
   import com.moviestarplanet.moviestar.service.MovieStarService;
   import com.moviestarplanet.moviestar.valueObjects.Actor;
   import com.moviestarplanet.moviestar.valueObjects.ActorClothesRel;
   import com.moviestarplanet.moviestar.valueObjects.ActorClothesRel2;
   import com.moviestarplanet.moviestar.valueObjects.Cloth;
   import com.moviestarplanet.moviestar.valueObjects.Eye;
   import com.moviestarplanet.moviestar.valueObjects.FacePart;
   import com.moviestarplanet.moviestar.valueObjects.Mouth;
   import com.moviestarplanet.moviestar.valueObjects.Nose;
   import com.moviestarplanet.moviestar.valueObjects.RegisterNewUserData;
   import com.moviestarplanet.piggybank.service.PiggyBankAmountManager;
   import com.moviestarplanet.progressbar.HideProgressBarCommand;
   import com.moviestarplanet.progressbar.ShowProgressBarCommand;
   import com.moviestarplanet.services.userservice.UserAmfServiceWeb;
   import com.moviestarplanet.services.userservice.valueObjects.CreateNewUserStatus;
   import com.moviestarplanet.userbehavior.valueObjects.EvaluateResponse;
   import com.moviestarplanet.usersession.valueobjects.ActorDetails;
   import com.moviestarplanet.usersession.valueobjects.NewActorCreationData;
   import com.moviestarplanet.utils.ColorMap;
   import com.moviestarplanet.utils.FlashUtils;
   import com.moviestarplanet.utils.IItem;
   import com.moviestarplanet.utils.ItemBox;
   import com.moviestarplanet.utils.MSP_SWFLoader;
   import com.moviestarplanet.utils.Utils;
   import com.moviestarplanet.utils.ValidationUtilities;
   import com.moviestarplanet.utils.loader.ContentUrl;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.window.loading.LoadingProgressBarAS;
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
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Alert;
   import mx.controls.Button;
   import mx.controls.CheckBox;
   import mx.controls.ColorPicker;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.Text;
   import mx.controls.TextArea;
   import mx.controls.TextInput;
   import mx.core.IFlexModuleFactory;
   import mx.core.INavigatorContent;
   import mx.core.IToolTip;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Glow;
   import mx.effects.Rotate;
   import mx.effects.Sequence;
   import mx.effects.Zoom;
   import mx.events.ColorPickerEvent;
   import mx.events.FlexEvent;
   import mx.events.IndexChangedEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.ToolTipManager;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class RegisterNewUserComponent extends ViewComponentCanvas implements IBindingClient
   {
      
      private static var txtValidateUserNameErrorTip:IToolTip;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      public static const TEXT_BACKGROUND_COLOR_INVALID:String = "#888888";
      
      public static const TEXT_BACKGROUND_COLOR_VALID:String = "#6EA479";
      
      public static const MOVIESTARLOADED:String = "MOVIESTARLOADED";
      
      private static var alreadyCustomized:Boolean = false;
      
      public var _RegisterNewUserComponent_Button4:Button;
      
      public var _RegisterNewUserComponent_Label11:Label;
      
      public var _RegisterNewUserComponent_Label2:Label;
      
      public var _RegisterNewUserComponent_Label4:Label;
      
      public var _RegisterNewUserComponent_Label5:Label;
      
      public var _RegisterNewUserComponent_Label6:Label;
      
      public var _RegisterNewUserComponent_Label7:Label;
      
      public var _RegisterNewUserComponent_Label8:Label;
      
      public var _RegisterNewUserComponent_Text1:Text;
      
      public var _RegisterNewUserComponent_Text2:Text;
      
      private var _1332194002background:Image;
      
      private var _591378835bottomsView:MSP_ItemContainer;
      
      private var _62188164btnAccept:Button;
      
      private var _117924854btnCancel:Button;
      
      private var _732180895btnRandomizeFemale:Button;
      
      private var _492176798btnRandomizeMale:Button;
      
      private var _1066962247btnViewBottoms:MSP_ClickImage;
      
      private var _1319735010btnViewFace:MSP_ClickImage;
      
      private var _1249449774btnViewFootwear:MSP_ClickImage;
      
      private var _1319675229btnViewHair:MSP_ClickImage;
      
      private var _1319337922btnViewSkin:MSP_ClickImage;
      
      private var _1319304065btnViewTops:MSP_ClickImage;
      
      private var _11548985buttonBox:HBox;
      
      private var _1275269217colorPanel:MultiColorPanel;
      
      private var _340055790colorPickerSkin:ColorPicker;
      
      private var _2038157615comboBirthMonth:MSP_ComboBox;
      
      private var _620283822comboBirthYear:MSP_ComboBox;
      
      private var _1186698273errorTipRotateEffect:Rotate;
      
      private var _1034625303errorTipZoomEffect:Zoom;
      
      private var _496766626faceView:MSP_ItemContainer;
      
      private var _1891486414footwearView:MSP_ItemContainer;
      
      private var _3175821glow:Sequence;
      
      private var _128799321hairView:MSP_ItemContainer;
      
      private var _762012836headwearView:MSP_ItemContainer;
      
      private var _1560030921imgCaptcha:Image;
      
      private var _3315003lbl1:Label;
      
      private var _515902689lblErrorHeader:Label;
      
      private var _280359110lblStartByclickingSkin:Label;
      
      private var _1736395745leftcanvas:Canvas;
      
      private var _1703153366mainViewStack:ViewComponentViewStack;
      
      private var _1073967584maleBottomsView:MSP_ItemContainer;
      
      private var _1623006159maleFaceView:MSP_ItemContainer;
      
      private var _328131551maleFootwearView:MSP_ItemContainer;
      
      private var _997440212maleHairView:MSP_ItemContainer;
      
      private var _1313336495maleHeadwearView:MSP_ItemContainer;
      
      private var _177804976maleTopsView:MSP_ItemContainer;
      
      private var _1641788370okButton:Button;
      
      private var _1868008609panelBirthday:VBox;
      
      private var _1931895387plsWait1:LoadingProgressBarAS;
      
      private var _1070713074refferalCheckBox:CheckBox;
      
      private var _1895537513refferalLabel:Label;
      
      private var _908625034refferalName:TextInput;
      
      private var _207346110skinColorPanel:Canvas;
      
      private var _2143653314skinView:Canvas;
      
      private var _2044454740termsText:TextArea;
      
      private var _948434557topsView:MSP_ItemContainer;
      
      private var _947144214txtCaptcha:TextInput;
      
      private var _957985894txtPassword1:TextInput;
      
      private var _957985895txtPassword2:TextInput;
      
      private var _487866214txtUsername:TextInput;
      
      private var _1113736597userInfoPanel:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public var movieStar:MovieStar;
      
      private var isRestrictedServer:Boolean;
      
      private var txtUserNameErrorTip:IToolTip;
      
      private var txtFriendUserNameErrorTip:IToolTip;
      
      private var captchaRequired:Boolean;
      
      private var nextKey:Number = -1;
      
      private var captchaErrorTip:IToolTip;
      
      private const actorX:int = 710;
      
      private const actorY:int = 75;
      
      private const FACEPART_TYPE_EYES:String = "eyes";
      
      private const FACEPART_TYPE_NOSE:String = "nose";
      
      private const FACEPART_TYPE_MOUTH:String = "mouth";
      
      private const REGNEWUSER_FEMALE:int = 1;
      
      private const REGNEWUSER_MALE:int = 2;
      
      private const REGNEWUSER_UNISEX:int = 3;
      
      private var validationEnabled:Boolean = true;
      
      private var _currentSkin:String;
      
      private var isGirl:Boolean = false;
      
      private var _loadingProgressBar:LoadingProgressBarAS;
      
      private var _maleMovieStar:MovieStar;
      
      private var _femaleMovieStar:MovieStar;
      
      private var timer:Timer;
      
      private var animations:Array;
      
      private var lastAnim:String;
      
      private var standTick:Boolean = true;
      
      private var skinMovieStars:Array;
      
      private var _isBusy:Boolean;
      
      private var lastSkin:String = null;
      
      private var previousUserNameTxt:String;
      
      private var selectionBeginIndex:int;
      
      private var txtPassword1ErrorTip:IToolTip = null;
      
      private var txtBirthMonthErrorTip:IToolTip = null;
      
      private var txtBirthYearErrorTip:IToolTip = null;
      
      private var txtPassword2ErrorTip:IToolTip = null;
      
      private var _selectedItem:ItemBox;
      
      private var isFirstClearColorPanel:Boolean = true;
      
      private var _maleData:RegisterNewUserDataObject;
      
      private var _femaleData:RegisterNewUserDataObject;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function RegisterNewUserComponent()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":ViewComponentCanvas,
            "events":{"creationComplete":"___RegisterNewUserComponent_ViewComponentCanvas1_creationComplete"},
            "stylesFactory":function():void
            {
               this.backgroundAlpha = 0.5;
            },
            "propertiesFactory":function():Object
            {
               return {
                  "width":1240,
                  "height":720,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Image,
                     "id":"background",
                     "propertiesFactory":function():Object
                     {
                        return {"percentWidth":100};
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"leftcanvas",
                     "stylesFactory":function():void
                     {
                        this.backgroundAlpha = 0;
                        this.backgroundColor = 0;
                        this.borderStyle = "solid";
                        this.borderThickness = 0;
                        this.cornerRadius = 10;
                        this.disabledColor = 0;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":10,
                           "y":10,
                           "width":1220,
                           "height":700,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Canvas,
                              "stylesFactory":function():void
                              {
                                 this.backgroundAlpha = 0.5;
                                 this.backgroundColor = 65793;
                                 this.borderStyle = "solid";
                                 this.borderThickness = 0;
                                 this.cornerRadius = 10;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":0,
                                    "y":0,
                                    "width":426,
                                    "height":700
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":HBox,
                              "id":"buttonBox",
                              "stylesFactory":function():void
                              {
                                 this.backgroundAlpha = 0;
                                 this.disabledOverlayAlpha = 0;
                                 this.horizontalAlign = "center";
                                 this.paddingLeft = 10;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":10,
                                    "y":128,
                                    "width":417,
                                    "enabled":false,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"btnViewSkin",
                                       "events":{"click":"__btnViewSkin_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "width":48,
                                             "height":48,
                                             "isRectangularHitbox":true
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"btnViewFace",
                                       "events":{"click":"__btnViewFace_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "width":48,
                                             "height":48,
                                             "isRectangularHitbox":true
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"btnViewHair",
                                       "events":{"click":"__btnViewHair_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "width":48,
                                             "height":48,
                                             "isRectangularHitbox":true
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"btnViewTops",
                                       "events":{"click":"__btnViewTops_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "width":48,
                                             "height":48,
                                             "isRectangularHitbox":true
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"btnViewBottoms",
                                       "events":{"click":"__btnViewBottoms_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "width":48,
                                             "height":48,
                                             "isRectangularHitbox":true
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"btnViewFootwear",
                                       "events":{"click":"__btnViewFootwear_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "width":48,
                                             "height":48,
                                             "isRectangularHitbox":true
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":ViewComponentViewStack,
                              "id":"mainViewStack",
                              "stylesFactory":function():void
                              {
                                 this.backgroundAlpha = 0;
                                 this.backgroundColor = 16711165;
                                 this.borderStyle = "solid";
                                 this.borderThickness = 0;
                                 this.cornerRadius = 10;
                                 this.fontSize = 10;
                                 this.fontStyle = "normal";
                                 this.paddingLeft = 10;
                                 this.paddingTop = 30;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":0,
                                    "y":184,
                                    "width":426,
                                    "height":420,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"skinView",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "percentHeight":100,
                                             "verticalScrollPolicy":"off",
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"lblStartByclickingSkin",
                                                "stylesFactory":function():void
                                                {
                                                   this.fontSize = 12;
                                                   this.fontWeight = "bold";
                                                   this.textAlign = "center";
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "x":10,
                                                      "y":0,
                                                      "width":390
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":LoadingProgressBarAS,
                                                "id":"plsWait1",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "x":196,
                                                      "y":200,
                                                      "width":220,
                                                      "fontSize":14
                                                   };
                                                }
                                             })]
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ItemContainer,
                                       "id":"faceView",
                                       "events":{"creationComplete":"__faceView_creationComplete"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":0,
                                             "y":51,
                                             "width":424,
                                             "height":367,
                                             "HideNavigatonButtons":true,
                                             "PageSize":9,
                                             "ResetLoadingOnExit":false
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ItemContainer,
                                       "id":"hairView",
                                       "events":{"creationComplete":"__hairView_creationComplete"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":0,
                                             "y":51,
                                             "width":424,
                                             "height":367,
                                             "HideNavigatonButtons":true,
                                             "PageSize":9,
                                             "ResetLoadingOnExit":false
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ItemContainer,
                                       "id":"topsView",
                                       "events":{"creationComplete":"__topsView_creationComplete"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":0,
                                             "y":51,
                                             "width":424,
                                             "height":367,
                                             "HideNavigatonButtons":true,
                                             "PageSize":9,
                                             "ResetLoadingOnExit":false
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ItemContainer,
                                       "id":"bottomsView",
                                       "events":{"creationComplete":"__bottomsView_creationComplete"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":0,
                                             "y":51,
                                             "width":424,
                                             "height":367,
                                             "HideNavigatonButtons":true,
                                             "PageSize":9,
                                             "ResetLoadingOnExit":false
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ItemContainer,
                                       "id":"footwearView",
                                       "events":{"creationComplete":"__footwearView_creationComplete"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":0,
                                             "y":51,
                                             "width":424,
                                             "height":367,
                                             "HideNavigatonButtons":true,
                                             "PageSize":9,
                                             "ResetLoadingOnExit":false
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ItemContainer,
                                       "id":"headwearView",
                                       "events":{"creationComplete":"__headwearView_creationComplete"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":0,
                                             "y":51,
                                             "width":424,
                                             "height":367,
                                             "HideNavigatonButtons":true,
                                             "PageSize":9,
                                             "ResetLoadingOnExit":false
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ItemContainer,
                                       "id":"maleFaceView",
                                       "events":{"creationComplete":"__maleFaceView_creationComplete"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":0,
                                             "y":51,
                                             "width":424,
                                             "height":367,
                                             "HideNavigatonButtons":true,
                                             "PageSize":9,
                                             "ResetLoadingOnExit":false
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ItemContainer,
                                       "id":"maleHairView",
                                       "events":{"creationComplete":"__maleHairView_creationComplete"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":0,
                                             "y":51,
                                             "width":424,
                                             "height":367,
                                             "HideNavigatonButtons":true,
                                             "PageSize":9,
                                             "ResetLoadingOnExit":false
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ItemContainer,
                                       "id":"maleTopsView",
                                       "events":{"creationComplete":"__maleTopsView_creationComplete"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":0,
                                             "y":51,
                                             "width":424,
                                             "height":367,
                                             "HideNavigatonButtons":true,
                                             "PageSize":9,
                                             "ResetLoadingOnExit":false
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ItemContainer,
                                       "id":"maleBottomsView",
                                       "events":{"creationComplete":"__maleBottomsView_creationComplete"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":0,
                                             "y":51,
                                             "width":424,
                                             "height":367,
                                             "HideNavigatonButtons":true,
                                             "PageSize":9,
                                             "ResetLoadingOnExit":false
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ItemContainer,
                                       "id":"maleFootwearView",
                                       "events":{"creationComplete":"__maleFootwearView_creationComplete"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":0,
                                             "y":51,
                                             "width":424,
                                             "height":367,
                                             "HideNavigatonButtons":true,
                                             "PageSize":9,
                                             "ResetLoadingOnExit":false
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ItemContainer,
                                       "id":"maleHeadwearView",
                                       "events":{"creationComplete":"__maleHeadwearView_creationComplete"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":0,
                                             "y":51,
                                             "width":424,
                                             "height":367,
                                             "HideNavigatonButtons":true,
                                             "PageSize":9,
                                             "ResetLoadingOnExit":false
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":MultiColorPanel,
                              "id":"colorPanel",
                              "stylesFactory":function():void
                              {
                                 this.backgroundAlpha = 0.04;
                                 this.backgroundColor = 16711422;
                                 this.borderColor = 16645887;
                                 this.borderStyle = "solid";
                                 this.borderThickness = 0;
                                 this.cornerRadius = 10;
                                 this.paddingTop = 10;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":10,
                                    "y":612,
                                    "width":426,
                                    "height":76,
                                    "useGenericLabels":true,
                                    "horizontalScrollPolicy":"off",
                                    "verticalScrollPolicy":"off"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"skinColorPanel",
                              "stylesFactory":function():void
                              {
                                 this.backgroundAlpha = 0.04;
                                 this.backgroundColor = 16513529;
                                 this.borderColor = 16645887;
                                 this.borderStyle = "solid";
                                 this.borderThickness = 0;
                                 this.cornerRadius = 10;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":10,
                                    "y":612,
                                    "width":426,
                                    "height":76,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"_RegisterNewUserComponent_Label2",
                                       "stylesFactory":function():void
                                       {
                                          this.fontSize = 14;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "left":10,
                                             "top":10,
                                             "width":137
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":ColorPicker,
                                       "id":"colorPickerSkin",
                                       "events":{"change":"__colorPickerSkin_change"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "left":155,
                                             "top":11,
                                             "width":40,
                                             "enabled":false,
                                             "showTextField":false,
                                             "styleName":"MPSSkinColorPicker"
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"lbl1",
                              "stylesFactory":function():void
                              {
                                 this.fontSize = 24;
                                 this.fontWeight = "bold";
                                 this.textAlign = "center";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":10,
                                    "y":20,
                                    "width":426
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"btnRandomizeFemale",
                              "events":{"click":"__btnRandomizeFemale_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":56,
                                    "y":76,
                                    "width":160,
                                    "height":23,
                                    "styleName":"createUserButton"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"btnRandomizeMale",
                              "events":{"click":"__btnRandomizeMale_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":224,
                                    "y":76,
                                    "width":160,
                                    "height":23,
                                    "styleName":"createUserButton"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"okButton",
                              "events":{"click":"__okButton_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":1020,
                                    "y":630,
                                    "width":140,
                                    "height":35,
                                    "styleName":"createUserButton"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"_RegisterNewUserComponent_Button4",
                              "events":{"click":"___RegisterNewUserComponent_Button4_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":1080,
                                    "y":641,
                                    "width":90,
                                    "height":22,
                                    "styleName":"createUserButton"
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"userInfoPanel",
                     "stylesFactory":function():void
                     {
                        this.backgroundAlpha = 0.5;
                        this.backgroundColor = 65793;
                        this.borderStyle = "solid";
                        this.borderThickness = 0;
                        this.cornerRadius = 10;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "x":944,
                           "y":10,
                           "width":286,
                           "height":700,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":TextInput,
                              "id":"txtUsername",
                              "events":{
                                 "change":"__txtUsername_change",
                                 "valueCommit":"__txtUsername_valueCommit"
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "y":106,
                                    "left":20,
                                    "right":20,
                                    "enabled":false,
                                    "maxChars":30
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":TextInput,
                              "id":"txtPassword1",
                              "events":{"valueCommit":"__txtPassword1_valueCommit"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "y":181,
                                    "left":20,
                                    "right":20,
                                    "displayAsPassword":true,
                                    "enabled":false,
                                    "maxChars":30
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":TextInput,
                              "id":"txtPassword2",
                              "events":{"valueCommit":"__txtPassword2_valueCommit"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "y":256,
                                    "left":20,
                                    "right":20,
                                    "displayAsPassword":true,
                                    "enabled":false,
                                    "maxChars":30
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"_RegisterNewUserComponent_Label4",
                              "stylesFactory":function():void
                              {
                                 this.fontWeight = "bold";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":20,
                                    "y":230,
                                    "width":198
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"_RegisterNewUserComponent_Label5",
                              "stylesFactory":function():void
                              {
                                 this.fontWeight = "bold";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":20,
                                    "y":80,
                                    "width":198
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"_RegisterNewUserComponent_Label6",
                              "stylesFactory":function():void
                              {
                                 this.fontWeight = "bold";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":20,
                                    "y":155,
                                    "width":198
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"_RegisterNewUserComponent_Label7",
                              "stylesFactory":function():void
                              {
                                 this.textAlign = "right";
                                 this.color = 13421772;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":20,
                                    "y":128,
                                    "width":248
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"_RegisterNewUserComponent_Label8",
                              "stylesFactory":function():void
                              {
                                 this.textAlign = "right";
                                 this.color = 13421772;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":20,
                                    "y":203,
                                    "width":248
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "stylesFactory":function():void
                              {
                                 this.fontWeight = "bold";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":20,
                                    "y":304,
                                    "width":106,
                                    "text":"Country:"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":VBox,
                              "id":"panelBirthday",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":20,
                                    "y":320,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Text,
                                       "id":"_RegisterNewUserComponent_Text1",
                                       "stylesFactory":function():void
                                       {
                                          this.fontWeight = "bold";
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {"width":246};
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":HBox,
                                       "propertiesFactory":function():Object
                                       {
                                          return {"childDescriptors":[new UIComponentDescriptor({
                                             "type":MSP_ComboBox,
                                             "id":"comboBirthMonth",
                                             "propertiesFactory":function():Object
                                             {
                                                return {"width":140};
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":MSP_ComboBox,
                                             "id":"comboBirthYear",
                                             "propertiesFactory":function():Object
                                             {
                                                return {"width":100};
                                             }
                                          })]};
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Image,
                              "id":"imgCaptcha",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":20,
                                    "y":390,
                                    "width":200,
                                    "height":40,
                                    "smoothBitmapContent":true,
                                    "trustContent":true
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":TextInput,
                              "id":"txtCaptcha",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":20,
                                    "y":470,
                                    "width":100,
                                    "enabled":true,
                                    "maxChars":10
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":CheckBox,
                              "id":"refferalCheckBox",
                              "events":{"click":"__refferalCheckBox_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":20,
                                    "y":454,
                                    "width":154,
                                    "label":"Invited by a friend?",
                                    "enabled":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":TextInput,
                              "id":"refferalName",
                              "events":{"valueCommit":"__refferalName_valueCommit"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":20,
                                    "y":500,
                                    "width":244
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"refferalLabel",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":20,
                                    "y":479,
                                    "width":256,
                                    "text":"Enter friends name and get $200 starcoins"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"btnAccept",
                              "events":{"click":"__btnAccept_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":20,
                                    "y":670,
                                    "width":246,
                                    "height":23,
                                    "enabled":false,
                                    "styleName":"createUserButton",
                                    "toolTip":"Start using your moviestar"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"_RegisterNewUserComponent_Label11",
                              "stylesFactory":function():void
                              {
                                 this.fontSize = 24;
                                 this.fontWeight = "bold";
                                 this.textAlign = "center";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":10,
                                    "y":20,
                                    "width":256
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"lblErrorHeader",
                              "stylesFactory":function():void
                              {
                                 this.color = 16711680;
                                 this.fontSize = 12;
                                 this.fontWeight = "bold";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":30,
                                    "y":66,
                                    "width":198
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"btnCancel",
                              "events":{"click":"__btnCancel_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "x":154,
                                    "bottom":10,
                                    "width":95,
                                    "height":23,
                                    "enabled":true,
                                    "styleName":"createUserButton",
                                    "toolTip":"Exit without creating a moviestar"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Text,
                              "id":"_RegisterNewUserComponent_Text2",
                              "stylesFactory":function():void
                              {
                                 this.fontWeight = "bold";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":20,
                                    "y":610,
                                    "width":246
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":TextArea,
                              "id":"termsText",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":20,
                                    "y":511,
                                    "width":246,
                                    "height":80,
                                    "editable":false,
                                    "wordWrap":true
                                 };
                              }
                           })]
                        };
                     }
                  })]
               };
            }
         });
         this.animations = ["Wave","talk","sing2","Handgesture1","Handgesture2","Handgesture3","I am Cool"];
         this.skinMovieStars = new Array();
         this._maleData = new RegisterNewUserDataObject();
         this._femaleData = new RegisterNewUserDataObject();
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         bindings = this._RegisterNewUserComponent_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_com_moviestarplanet_frontpage_RegisterNewUserComponentWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return RegisterNewUserComponent[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.width = 1240;
         this.height = 720;
         this.horizontalCenter = 0;
         this._RegisterNewUserComponent_Rotate1_i();
         this._RegisterNewUserComponent_Zoom1_i();
         this._RegisterNewUserComponent_Sequence1_i();
         this.addEventListener("creationComplete",this.___RegisterNewUserComponent_ViewComponentCanvas1_creationComplete);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function ValidateUserNameTextInput(param1:TextInput, param2:IToolTip, param3:Function, param4:Button = null) : void
      {
         var validationCallback:Function = null;
         var txtUsername:TextInput = param1;
         var errorToolTip:IToolTip = param2;
         var callback:Function = param3;
         var btnAccept:Button = param4;
         validationCallback = function(param1:String, param2:EvaluateResponse = null):void
         {
            if(param1)
            {
               if(btnAccept)
               {
                  btnAccept.enabled = false;
               }
               txtValidateUserNameErrorTip = Utils.ShowErrorTip(txtUsername,MSPLocaleManagerWeb.getInstance().getString(param1));
               errorToolTip = txtValidateUserNameErrorTip;
               txtUsername.setStyle("backgroundColor",TEXT_BACKGROUND_COLOR_INVALID);
               if(callback != null)
               {
                  callback(false,param2);
               }
            }
            else
            {
               if(btnAccept)
               {
                  btnAccept.enabled = true;
               }
               destroyTip(txtValidateUserNameErrorTip);
               txtUsername.setStyle("backgroundColor",TEXT_BACKGROUND_COLOR_VALID);
               errorToolTip = null;
               if(callback != null)
               {
                  callback(true,param2);
               }
            }
         };
         if(txtValidateUserNameErrorTip != null)
         {
            destroyTip(txtValidateUserNameErrorTip);
         }
         txtValidateUserNameErrorTip = null;
         destroyTip(errorToolTip);
         if(btnAccept)
         {
            btnAccept.enabled = false;
         }
         ValidationUtilities.ValidateEntireName(txtUsername.text,validationCallback);
      }
      
      private static function destroyTip(param1:IToolTip) : void
      {
         if(param1 != null && param1.parent != null)
         {
            ToolTipManager.destroyToolTip(param1);
         }
      }
      
      public static function sendAnalyticsEvent(param1:String) : void
      {
         var _loc2_:String = AnalyticsConstants.CHARACTER_CREATION_FUNNEL + "." + param1;
         var _loc3_:Object = {"Step":param1};
         if(alreadyCustomized && param1 == AnalyticsConstants.CHARACTER_CREATION_STEP2)
         {
            return;
         }
         if(param1 == AnalyticsConstants.CHARACTER_CREATION_STEP2)
         {
            alreadyCustomized = true;
         }
         AnalyticsSendEventCommand.execute(_loc2_,_loc3_);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         RegisterNewUserComponent._watcherSetupUtil = param1;
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
            this.backgroundAlpha = 0.5;
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function EnableAll() : void
      {
         GoogleAnalyticsTracker.getInstance().trackPageview("/ChooseClothes");
         this.okButton.visible = true;
         this.buttonBox.visible = true;
         this.txtPassword1.enabled = true;
         this.txtPassword2.enabled = true;
         this.txtUsername.enabled = true;
         this.refferalCheckBox.enabled = NewUserState.invitedByActorID != -1;
         this.colorPickerSkin.enabled = true;
         this.buttonBox.enabled = true;
         this.btnAccept.enabled = true;
         this.btnViewHair.enabled = true;
         this.btnViewSkin.enabled = true;
         this.btnViewFace.enabled = true;
      }
      
      private function DisableAll() : void
      {
         this.txtPassword1.enabled = false;
         this.txtPassword2.enabled = false;
         this.txtUsername.enabled = false;
         this.refferalCheckBox.enabled = false;
         this.colorPickerSkin.enabled = false;
         this.buttonBox.enabled = false;
         this.btnAccept.enabled = false;
         this.btnViewHair.enabled = false;
         this.btnViewSkin.enabled = false;
      }
      
      override public function Enter() : void
      {
         this.txtUserNameErrorTip = null;
         this.txtFriendUserNameErrorTip = null;
         this.txtPassword1ErrorTip = null;
         this.txtPassword2ErrorTip = null;
         this.txtBirthMonthErrorTip = null;
         this.txtBirthYearErrorTip = null;
         this.validationEnabled = false;
         this.txtUsername.text = "";
         this.txtPassword1.text = "";
         this.txtPassword2.text = "";
         this.txtPassword1.errorString = null;
         this.txtPassword2.errorString = null;
         this.txtUsername.errorString = null;
         this.validationEnabled = true;
         this.ClearColorPanel();
         this.PlayAnimations();
         BlackListUtil.getInstance().prepareUnwantedWordsRegex();
         try
         {
            TrafficTracking.ClickNewUser();
         }
         catch(e:Error)
         {
            LoggingAmfService.Error(e.message);
         }
      }
      
      override public function Exit() : void
      {
         if(this.timer != null)
         {
            this.timer.stop();
         }
         this.timer = null;
         if(this.movieStar != null)
         {
            this.movieStar.StopAll();
         }
         this.destroyAllErrorTips();
      }
      
      public function dispose() : void
      {
         if(initialized)
         {
            this.destroyAllErrorTips();
         }
      }
      
      private function OnCreationComplete(param1:Event) : void
      {
         var views:Array;
         var eventDispathcher:EventDispatcher = null;
         var done:Function = null;
         var msp_itemcontainer:MSP_ItemContainer = null;
         var event:Event = param1;
         done = function(param1:RegisterNewUserData):void
         {
            var done:Function = null;
            var data:RegisterNewUserData = param1;
            done = function():void
            {
               plsWait1.visible = false;
               btnRandomizeMale.visible = true;
               btnRandomizeFemale.visible = true;
               GoogleAnalyticsTracker.getInstance().trackPageview("/RegisterNewUser");
            };
            MapData(data,_maleData,_femaleData);
            LoadSkins(done);
         };
         GoogleAnalyticsTracker.getInstance().trackPageview("/ChooseGender");
         this.termsText.htmlText = TermsConditions.getInstance().getTermsConditionsHtml();
         this.plsWait1.visible = true;
         this.btnCancel.enabled = true;
         views = [this.skinView,this.faceView,this.hairView,this.topsView,this.bottomsView,this.footwearView,this.headwearView,this.maleFaceView,this.maleHairView,this.maleTopsView,this.maleBottomsView,this.maleFootwearView,this.maleHeadwearView];
         for each(eventDispathcher in views)
         {
            msp_itemcontainer = eventDispathcher as MSP_ItemContainer;
            if(msp_itemcontainer != null)
            {
               msp_itemcontainer.VerticalGap = 10;
            }
            eventDispathcher.addEventListener(MSP_ItemContainer.PAGE_CHANGED,this.ClearColorPanel,false,0,true);
         }
         this.mainViewStack.addEventListener(IndexChangedEvent.CHANGE,this.ClearColorPanel,false,0,true);
         this.colorPickerSkin.dataProvider = ColorCollections.OLDSkin;
         this.colorPanel.ColorChangedCallBack = this.colorPanelColorChanged;
         this.populateBirthComboBoxes();
         MovieStarService.getInstance().LoadDataForRegisterNewUser(done);
         this.isRestrictedServer = this.panelBirthday.visible = Config.IsServerRestricted();
         sendAnalyticsEvent(AnalyticsConstants.CHARACTER_CREATION_STEP1);
      }
      
      private function populateBirthComboBoxes() : void
      {
         var _loc1_:Array = new Array();
         _loc1_.push({
            "label":MSPLocaleManagerWeb.getInstance().getString("MONTH"),
            "data":-1
         });
         _loc1_.push({
            "label":MSPLocaleManagerWeb.getInstance().getString("JANUARY"),
            "data":1
         });
         _loc1_.push({
            "label":MSPLocaleManagerWeb.getInstance().getString("FEBRUARY"),
            "data":2
         });
         _loc1_.push({
            "label":MSPLocaleManagerWeb.getInstance().getString("MARCH"),
            "data":3
         });
         _loc1_.push({
            "label":MSPLocaleManagerWeb.getInstance().getString("APRIL"),
            "data":4
         });
         _loc1_.push({
            "label":MSPLocaleManagerWeb.getInstance().getString("MAY"),
            "data":5
         });
         _loc1_.push({
            "label":MSPLocaleManagerWeb.getInstance().getString("JUNE"),
            "data":6
         });
         _loc1_.push({
            "label":MSPLocaleManagerWeb.getInstance().getString("JULY"),
            "data":7
         });
         _loc1_.push({
            "label":MSPLocaleManagerWeb.getInstance().getString("AUGUST"),
            "data":8
         });
         _loc1_.push({
            "label":MSPLocaleManagerWeb.getInstance().getString("SEPTEMBER"),
            "data":9
         });
         _loc1_.push({
            "label":MSPLocaleManagerWeb.getInstance().getString("OCTOBER"),
            "data":10
         });
         _loc1_.push({
            "label":MSPLocaleManagerWeb.getInstance().getString("NOVEMBER"),
            "data":11
         });
         _loc1_.push({
            "label":MSPLocaleManagerWeb.getInstance().getString("DECEMBER"),
            "data":12
         });
         this.comboBirthMonth.dataProvider = _loc1_;
         this.comboBirthMonth.selectedIndex = 0;
         this.comboBirthMonth.dropdownHieght = 150;
         var _loc2_:Array = new Array();
         var _loc3_:int = int(new Date().getFullYear());
         var _loc4_:int = _loc3_ - 4;
         var _loc5_:int = _loc3_ - 18;
         var _loc6_:* = _loc4_;
         while(_loc6_ > _loc5_)
         {
            _loc2_.push({
               "label":_loc6_.toString(),
               "data":_loc6_
            });
            _loc6_--;
         }
         _loc2_ = _loc2_.reverse();
         _loc2_.unshift({
            "label":MSPLocaleManagerWeb.getInstance().getString("YEAR"),
            "data":-1
         });
         this.comboBirthYear.dropdownHieght = 150;
         this.comboBirthYear.dataProvider = _loc2_;
         this.comboBirthYear.selectedIndex = 0;
      }
      
      private function onFemaleFaceViewComplete(param1:Event) : void
      {
         this.faceView.BeginUpdate();
         this.faceView.PagedItems = [];
         this.LoadFacePartItems(this._femaleData.eyes,this.FACEPART_TYPE_EYES,this.faceView);
         this.LoadFacePartItems(this._femaleData.noses,this.FACEPART_TYPE_NOSE,this.faceView);
         this.LoadFacePartItems(this._femaleData.mouths,this.FACEPART_TYPE_MOUTH,this.faceView);
         this.faceView.EndUpdate();
      }
      
      private function onFemaleHairViewComplete(param1:Event) : void
      {
         this.LoadClothContainer(this.hairView,this._femaleData.hair);
      }
      
      private function onFemaleBottomsViewComplete(param1:Event) : void
      {
         this.LoadClothContainer(this.bottomsView,this._femaleData.bottoms);
      }
      
      private function onFemaleTopsViewComplete(param1:Event) : void
      {
         this.LoadClothContainer(this.topsView,this._femaleData.tops);
      }
      
      private function onFemaleFootwearViewComplete(param1:Event) : void
      {
         this.LoadClothContainer(this.footwearView,this._femaleData.footwear);
      }
      
      private function onFemaleHeadwearViewComplete(param1:Event) : void
      {
         this.LoadClothContainer(this.headwearView,this._femaleData.headwear);
      }
      
      private function onMaleFaceViewComplete(param1:Event) : void
      {
         this.maleFaceView.BeginUpdate();
         this.maleFaceView.PagedItems = [];
         this.LoadFacePartItems(this._maleData.eyes,this.FACEPART_TYPE_EYES,this.maleFaceView);
         this.LoadFacePartItems(this._maleData.noses,this.FACEPART_TYPE_NOSE,this.maleFaceView);
         this.LoadFacePartItems(this._maleData.mouths,this.FACEPART_TYPE_MOUTH,this.maleFaceView);
         this.maleFaceView.EndUpdate();
      }
      
      private function onMaleHairViewComplete(param1:Event) : void
      {
         this.LoadClothContainer(this.maleHairView,this._maleData.hair);
      }
      
      private function onMaleBottomsViewComplete(param1:Event) : void
      {
         this.LoadClothContainer(this.maleBottomsView,this._maleData.bottoms);
      }
      
      private function onMaleTopsViewComplete(param1:Event) : void
      {
         this.LoadClothContainer(this.maleTopsView,this._maleData.tops);
      }
      
      private function onMaleFootwearViewComplete(param1:Event) : void
      {
         this.LoadClothContainer(this.maleFootwearView,this._maleData.footwear);
      }
      
      private function onMaleHeadwearViewComplete(param1:Event) : void
      {
         this.LoadClothContainer(this.maleHeadwearView,this._maleData.headwear);
      }
      
      private function get currentSkin() : String
      {
         return this._currentSkin;
      }
      
      private function set currentSkin(param1:String) : void
      {
         if(this._currentSkin != param1)
         {
            this._currentSkin = param1;
            this.mainViewStack.selectedChild = this.skinView;
         }
      }
      
      private function showView(param1:String) : void
      {
         switch(param1)
         {
            case "face":
               this.mainViewStack.selectedChild = this.currentSkin == "femaleskin" ? this.faceView : this.maleFaceView;
               break;
            case "hair":
               this.mainViewStack.selectedChild = this.currentSkin == "femaleskin" ? this.hairView : this.maleHairView;
               break;
            case "tops":
               this.mainViewStack.selectedChild = this.currentSkin == "femaleskin" ? this.topsView : this.maleTopsView;
               break;
            case "bottoms":
               this.mainViewStack.selectedChild = this.currentSkin == "femaleskin" ? this.bottomsView : this.maleBottomsView;
               break;
            case "headwear":
               this.mainViewStack.selectedChild = this.currentSkin == "femaleskin" ? this.headwearView : this.maleHeadwearView;
               break;
            case "footwear":
               this.mainViewStack.selectedChild = this.currentSkin == "femaleskin" ? this.footwearView : this.maleFootwearView;
         }
      }
      
      private function randomizeAvatar(param1:Boolean) : void
      {
         var skin:String = null;
         var done:Function = null;
         var isFemale:Boolean = param1;
         done = function():void
         {
            skinColorPanel.visible = true;
            btnRandomizeMale.enabled = true;
            btnRandomizeFemale.enabled = true;
            isBusy = false;
            sendAnalyticsEvent(AnalyticsConstants.CHARACTER_CREATION_STEP2);
         };
         if(this.isBusy)
         {
            return;
         }
         this.isBusy = true;
         this.isGirl = isFemale;
         this.ClearColorPanel();
         this.btnRandomizeMale.enabled = false;
         this.btnRandomizeFemale.enabled = false;
         if(isFemale)
         {
            skin = "femaleskin";
         }
         else
         {
            skin = "maleskin";
         }
         this.LoadActor(skin,done,true);
      }
      
      private function btnRandomizeFemaleClicked(param1:MouseEvent) : void
      {
         this.randomizeAvatar(true);
      }
      
      private function btnRandomizeMaleClicked(param1:MouseEvent) : void
      {
         this.randomizeAvatar(false);
      }
      
      private function LoadItemMovieClipWithDefaultColors(param1:ContentUrl, param2:Function = null) : void
      {
         var loadDone:Function = null;
         var url:ContentUrl = param1;
         var doneCallBack:Function = param2;
         loadDone = function(param1:MSP_SWFLoader):void
         {
            var mc:MovieClip;
            var gotoAndStopDone:Function = null;
            var loader:MSP_SWFLoader = param1;
            gotoAndStopDone = function(param1:MovieClip):void
            {
               ColorMap.SetColorsOnMovieClip(param1,colorPickerSkin.selectedColor,null,false);
               if(doneCallBack != null)
               {
                  doneCallBack(param1);
               }
            };
            loader.visible = false;
            mc = loader.content as MovieClip;
            if(mc == null)
            {
               LoggingAmfService.Error("RegisterNewUserComponent:LoadItem : item with url " + url + " was not a movieclip or did not exist");
            }
            else
            {
               FlashUtils.GotoAndStopAndWaitForCompletion(mc,2,gotoAndStopDone);
            }
         };
         MSP_SWFLoader.RequestLoad(url,loadDone);
      }
      
      private function PutOnRandomCloth(param1:MovieStar, param2:ArrayCollection, param3:Function) : void
      {
         var cloth:Cloth = null;
         var done:Function = null;
         var ms:MovieStar = param1;
         var clothes:ArrayCollection = param2;
         var donecallback:Function = param3;
         done = function(param1:MovieClip):void
         {
            var _loc2_:ActorClothesRel = new ActorClothesRel();
            _loc2_.ActorClothesRelId = nextKey--;
            _loc2_.ActorId = ms.actor.ActorId;
            _loc2_.Cloth = cloth;
            _loc2_.ClothesId = cloth.ClothesId;
            _loc2_.IsWearing = 1;
            _loc2_.Color = ColorUtils.GetColorStringFromColorScheme(cloth.ColorScheme);
            _loc2_.x = 0;
            _loc2_.y = 0;
            ms.PutOnCloth(_loc2_);
            donecallback();
         };
         cloth = clothes.getItemAt(NumberUtils.random(0,clothes.length - 1)) as Cloth;
         this.LoadItemMovieClipWithDefaultColors(new ContentUrl(cloth.path,ContentUrl.CLOTH),done);
      }
      
      private function AttachRandomEyes(param1:MovieStar, param2:ArrayCollection, param3:Function) : void
      {
         var _loc4_:Eye = param2.getItemAt(NumberUtils.random(0,param2.length - 1)) as Eye;
         param1.actor.Eye = _loc4_;
         param1.LoadFacePart(_loc4_.SWFLocation,_loc4_.type,param3,_loc4_.DefaultColors,_loc4_.DragonBone);
      }
      
      private function AttachRandomNose(param1:MovieStar, param2:ArrayCollection, param3:Function) : void
      {
         var _loc4_:Nose = param2.getItemAt(NumberUtils.random(0,param2.length - 1)) as Nose;
         param1.actor.Nose = _loc4_;
         param1.LoadFacePart(_loc4_.SWFLocation,_loc4_.type,param3,null,false);
      }
      
      private function AttachRandomMouth(param1:MovieStar, param2:ArrayCollection, param3:Function) : void
      {
         var _loc4_:Mouth = param2.getItemAt(NumberUtils.random(0,param2.length - 1)) as Mouth;
         param1.actor.Mouth = _loc4_;
         param1.LoadFacePart(_loc4_.SWFLocation,_loc4_.type,param3,null,false);
      }
      
      private function RandomizeSkinColor() : void
      {
         this.colorPickerSkin.selectedIndex = NumberUtils.random(7,ColorCollections.OLDSkin.length - 2);
      }
      
      private function get loadingProgressBar() : LoadingProgressBarAS
      {
         if(this._loadingProgressBar == null)
         {
            this._loadingProgressBar = new LoadingProgressBarAS();
            this._loadingProgressBar.x = 762;
            this._loadingProgressBar.y = 354;
         }
         return this._loadingProgressBar;
      }
      
      public function get maleMovieStar() : MovieStar
      {
         if(this._maleMovieStar == null)
         {
            this._maleMovieStar = this.createMovieStar();
            this._maleMovieStar.y += 20;
            this._maleMovieStar.x -= 10;
         }
         return this._maleMovieStar;
      }
      
      public function get femaleMovieStar() : MovieStar
      {
         if(this._femaleMovieStar == null)
         {
            this._femaleMovieStar = this.createMovieStar();
         }
         return this._femaleMovieStar;
      }
      
      private function createMovieStar() : MovieStar
      {
         var _loc1_:MovieStar = new MovieStar(Body.MODE_CLICK);
         _loc1_.movieStarPopupEnabled = false;
         _loc1_.scale = 1.05;
         _loc1_.x = this.actorX;
         _loc1_.y = this.actorY;
         return _loc1_;
      }
      
      private function LoadActor(param1:String, param2:Function, param3:Boolean = false) : void
      {
         var actor:Actor;
         var mymovieStar:MovieStar;
         var MovieStarLoadDone:Function = null;
         var skin:String = param1;
         var doneCallBack:Function = param2;
         var useRandom:Boolean = param3;
         MovieStarLoadDone = function(param1:MovieStar):void
         {
            var doneCount:int = 0;
            var done:Function = null;
            var ms:MovieStar = param1;
            done = function():void
            {
               ++doneCount;
               if(doneCount == 7)
               {
                  allDone();
               }
            };
            var allDone:Function = function():void
            {
               removeChild(loadingProgressBar);
               EnableAll();
               movieStar.visible = true;
               timer.start();
               doneCallBack();
            };
            doneCount = 0;
            ms.StripAll();
            if(useRandom)
            {
               RandomizeSkinColor();
            }
            ms.skinColor = colorPickerSkin.selectedColor;
            if(useRandom)
            {
               RandomizeSkinColor();
               AttachRandomEyes(ms,skin == "femaleskin" ? _femaleData.eyes : _maleData.eyes,done);
               AttachRandomNose(ms,skin == "femaleskin" ? _femaleData.noses : _maleData.noses,done);
               AttachRandomMouth(ms,skin == "femaleskin" ? _femaleData.mouths : _maleData.mouths,done);
               PutOnRandomCloth(ms,skin == "femaleskin" ? _femaleData.tops : _maleData.tops,done);
               PutOnRandomCloth(ms,skin == "femaleskin" ? _femaleData.bottoms : _maleData.bottoms,done);
               PutOnRandomCloth(ms,skin == "femaleskin" ? _femaleData.footwear : _maleData.footwear,done);
               PutOnRandomCloth(ms,skin == "femaleskin" ? _femaleData.hair : _maleData.hair,done);
            }
            else
            {
               allDone();
            }
         };
         this.timer.reset();
         this.currentSkin = skin;
         actor = Actor.CreateEmptyActor(skin == "femaleskin" ? 1 : 2);
         actor.SkinSWF = skin;
         mymovieStar = this.createMovieStar();
         if(!useRandom)
         {
            if(skin == "femaleskin" && Boolean(this.skinMovieStars[0].isFemale()))
            {
               mymovieStar.cloneFrom(this.skinMovieStars[0],null);
            }
            else if(skin == "femaleskin")
            {
               mymovieStar.cloneFrom(this.skinMovieStars[1],null);
            }
            else if(skin != "femaleskin" && !this.skinMovieStars[0].isFemale())
            {
               mymovieStar.cloneFrom(this.skinMovieStars[0],null);
            }
            else if(skin != "femaleskin")
            {
               mymovieStar.cloneFrom(this.skinMovieStars[1],null);
            }
         }
         mymovieStar.visible = false;
         if(this.movieStar != null && this.movieStar.parent == this)
         {
            removeChild(this.movieStar);
         }
         this.movieStar = mymovieStar;
         addChild(this.movieStar);
         addChild(this.loadingProgressBar);
         if(!this.movieStar.isLoaded)
         {
            this.movieStar.LoadActorData(actor,MovieStarLoadDone,false,true);
         }
         else
         {
            MovieStarLoadDone(this.movieStar);
         }
      }
      
      private function PlayAnimations() : void
      {
         this.onTick();
         this.timer = new Timer(5000);
         this.timer.addEventListener(TimerEvent.TIMER,this.onTick,false,0,true);
         this.timer.start();
      }
      
      public function onTick(param1:TimerEvent = null) : void
      {
         var _loc2_:String = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this.movieStar != null)
         {
            _loc2_ = MovieStar.DEFAULT_ANIMATION;
            if(!this.standTick)
            {
               do
               {
                  _loc3_ = Number(this.animations.length);
                  _loc4_ = NumberUtils.random(0,_loc3_ - 1);
                  _loc2_ = this.animations[_loc4_];
               }
               while(_loc2_ == this.lastAnim);
               this.lastAnim = _loc2_;
            }
            this.standTick = !this.standTick;
            this.movieStar.PlayAnimation(_loc2_);
         }
      }
      
      private function LoadSkins(param1:Function) : void
      {
         var doneLoadingActor:Function;
         var skinNames:Array = null;
         var doneCount:int = 0;
         var skin:String = null;
         var emptyActorId:int = 0;
         var actor:Actor = null;
         var skinMovieStar:MovieStar = null;
         var doneCallback:Function = param1;
         skinNames = ["femaleskin","maleskin"];
         var i:int = 0;
         doneCount = 0;
         for each(skin in skinNames)
         {
            doneLoadingActor = function(param1:MovieStar):void
            {
               var doneRandomization:int = 0;
               var thisMovieStar:MovieStar = null;
               var done:Function = null;
               var skinMovieStar:MovieStar = param1;
               done = function():void
               {
                  ++doneRandomization;
                  if(doneRandomization >= 4)
                  {
                     characterDone();
                  }
               };
               var characterDone:Function = function():void
               {
                  var _loc1_:MovieStar = null;
                  MessageCommunicator.subscribe(MSPEvent.MOVIESTAR_CLICKED,skinClicked);
                  skinMovieStars.push(thisMovieStar);
                  ++doneCount;
                  if(doneCount >= skinNames.length)
                  {
                     plsWait1.visible = false;
                     for each(_loc1_ in skinMovieStars)
                     {
                        _loc1_.visible = true;
                     }
                  }
                  doneCallback();
               };
               doneRandomization = 0;
               thisMovieStar = skinMovieStar;
               if(thisMovieStar.actor.SkinSWF == "femaleskin")
               {
                  PutOnRandomCloth(skinMovieStar,_femaleData.tops,done);
                  PutOnRandomCloth(skinMovieStar,_femaleData.bottoms,done);
                  PutOnRandomCloth(skinMovieStar,_femaleData.footwear,done);
                  PutOnRandomCloth(skinMovieStar,_femaleData.hair,done);
               }
               else
               {
                  PutOnRandomCloth(skinMovieStar,_maleData.tops,done);
                  PutOnRandomCloth(skinMovieStar,_maleData.bottoms,done);
                  PutOnRandomCloth(skinMovieStar,_maleData.footwear,done);
                  PutOnRandomCloth(skinMovieStar,_maleData.hair,done);
               }
            };
            emptyActorId = skin == "femaleskin" ? 1 : 2;
            actor = Actor.CreateEmptyActor(emptyActorId);
            actor.ActorId = -emptyActorId;
            actor.SkinSWF = skin;
            actor.Eye = skin == "femaleskin" ? this._femaleData.eyes[Math.random() * this._femaleData.eyes.length] : this._maleData.eyes[Math.random() * this._maleData.eyes.length];
            actor.Nose = skin == "femaleskin" ? this._femaleData.noses[Math.random() * this._femaleData.noses.length] : this._maleData.noses[Math.random() * this._maleData.noses.length];
            actor.Mouth = skin == "femaleskin" ? this._femaleData.mouths[Math.random() * this._femaleData.mouths.length] : this._maleData.mouths[0];
            skinMovieStar = new MovieStar();
            skinMovieStar.movieStarPopupEnabled = false;
            skinMovieStar.scale = 0.6;
            skinMovieStar.LoadActorData(actor,doneLoadingActor,false,true);
            skinMovieStar.y = 50;
            skinMovieStar.x = 70 + 170 * i;
            if(this.colorPickerSkin != null)
            {
               this.colorPickerSkin.selectedIndex = 12;
            }
            skinMovieStar.skinColor = this.colorPickerSkin.selectedColor;
            skinMovieStar.visible = false;
            this.skinView.addChild(skinMovieStar);
            i++;
         }
      }
      
      private function skinClicked(param1:MsgEvent) : void
      {
         var skinMovieStar:MovieStar;
         var loadActorDone:Function = null;
         var event:MsgEvent = param1;
         loadActorDone = function():void
         {
            btnRandomizeFemale.enabled = true;
            btnRandomizeMale.enabled = true;
            isBusy = false;
            sendAnalyticsEvent(AnalyticsConstants.CHARACTER_CREATION_STEP2);
         };
         if(this.isBusy)
         {
            return;
         }
         this.isBusy = true;
         this.skinColorPanel.visible = true;
         this.lblStartByclickingSkin.visible = false;
         skinMovieStar = MovieStar(event.data);
         if(this.currentSkin != null && this.currentSkin == skinMovieStar.actor.SkinSWF)
         {
            this.ClearColorPanel();
            this.isBusy = false;
            return;
         }
         this.currentSkin = skinMovieStar.actor.SkinSWF;
         this.btnRandomizeFemale.enabled = false;
         this.btnRandomizeMale.enabled = false;
         this.LoadActor(this.currentSkin,loadActorDone);
      }
      
      private function get isBusy() : Boolean
      {
         return this._isBusy;
      }
      
      private function set isBusy(param1:Boolean) : void
      {
         this._isBusy = param1;
      }
      
      private function LoadFacePartItems(param1:ArrayCollection, param2:String, param3:MSP_ItemContainer) : void
      {
         var swfPath:String = null;
         var eyesMovieClipLoaded:Function = null;
         var counter:int = 0;
         var facePartLoaderDictionary:Dictionary = null;
         var eye:Eye = null;
         var item:Object = null;
         var url:String = null;
         var itemBox:ItemBox = null;
         var items:ArrayCollection = param1;
         var type:String = param2;
         var container:MSP_ItemContainer = param3;
         eyesMovieClipLoaded = function(param1:FacePart, param2:MovieClip):void
         {
            var _loc3_:MovieStarDragonBone = facePartLoaderDictionary[param1] as MovieStarDragonBone;
            _loc3_.colorizePart(Eye.TYPE,param1.DefaultColors,"front");
            param2.x = param2.width / 2;
            param2.y = param2.height / 2;
            var _loc4_:ItemBox = new ItemBox(null,100,100,false);
            _loc4_.info.facePartLoader = _loc3_;
            _loc4_.info.type = type;
            _loc4_.info.facepart = param1;
            _loc4_.info.skinColor = colorPickerSkin.selectedColor;
            _loc4_.addEventListener(MouseEvent.CLICK,ItemClickListener,false,0,true);
            var _loc5_:UIComponent = new UIComponent();
            _loc5_.width = _loc5_.height = 100;
            _loc5_.addChild(param2);
            _loc4_.addDisplayObject(_loc5_);
            container.addChild(_loc4_);
            facePartLoaderDictionary[param1] = null;
         };
         if(type == this.FACEPART_TYPE_EYES)
         {
            counter = items.length;
            facePartLoaderDictionary = new Dictionary();
            for each(eye in items)
            {
               facePartLoaderDictionary[eye] = new MovieStarDragonBone();
               (facePartLoaderDictionary[eye] as MovieStarDragonBone).getFrontEyesMovieClip(eye,eyesMovieClipLoaded);
            }
         }
         else
         {
            switch(type)
            {
               case this.FACEPART_TYPE_NOSE:
                  swfPath = "noses/";
                  break;
               case this.FACEPART_TYPE_MOUTH:
                  swfPath = "mouths/";
            }
            for each(item in items)
            {
               url = swfPath + item.SWF;
               itemBox = new ItemBox(new ContentUrl(url,ContentUrl.FACEPART),100,100,false);
               itemBox.info.type = type;
               itemBox.info.facepart = item;
               itemBox.info.skinColor = this.colorPickerSkin.selectedColor;
               itemBox.addEventListener(MouseEvent.CLICK,this.ItemClickListener,false,0,true);
               container.addChild(itemBox);
            }
         }
      }
      
      private function ItemClickListener(param1:MouseEvent) : void
      {
         this.skinColorPanel.visible = false;
         var _loc2_:ItemBox = ItemBox(param1.currentTarget);
         this.SetSelectedItem(_loc2_);
      }
      
      private function BeginUpdateAll(param1:Array) : void
      {
         var _loc3_:MSP_ItemContainer = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = MSP_ItemContainer(param1[_loc2_]);
            _loc3_.BeginUpdate();
            _loc2_++;
         }
      }
      
      private function EndUpdateAll(param1:Array) : void
      {
         var _loc3_:MSP_ItemContainer = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = MSP_ItemContainer(param1[_loc2_]);
            _loc3_.EndUpdate();
            _loc2_++;
         }
      }
      
      private function GetTargetContainer(param1:Cloth) : MSP_ItemContainer
      {
         switch(param1.ClothesCategoryId)
         {
            case 1:
               return this.hairView;
            case 2:
               return this.topsView;
            case 3:
               return this.bottomsView;
            case 5:
               return this.hairView;
            case 6:
               return this.topsView;
            case 7:
               return this.topsView;
            case 8:
               return this.bottomsView;
            case 9:
               return this.bottomsView;
            case 10:
               return this.footwearView;
            case 11:
               return this.footwearView;
            case 12:
               return this.footwearView;
            case 13:
               return this.headwearView;
            case 14:
               return this.headwearView;
            case 15:
               return this.headwearView;
            default:
               return null;
         }
      }
      
      private function IsValid() : Boolean
      {
         return this.txtPassword1ErrorTip == null && this.txtPassword2ErrorTip == null && this.txtUserNameErrorTip == null && this.txtBirthMonthErrorTip == null && this.txtBirthYearErrorTip == null && (!this.refferalCheckBox.selected || this.txtFriendUserNameErrorTip == null);
      }
      
      public function destroyAllErrorTips() : void
      {
         destroyTip(this.txtUserNameErrorTip);
         destroyTip(this.txtFriendUserNameErrorTip);
         destroyTip(this.txtPassword1ErrorTip);
         destroyTip(this.txtPassword2ErrorTip);
         destroyTip(this.txtBirthMonthErrorTip);
         destroyTip(this.txtBirthYearErrorTip);
         destroyTip(this.captchaErrorTip);
      }
      
      public function userNameValueCommit(param1:Event) : void
      {
         if(this.validationEnabled)
         {
            this.validateUserName(this.txtUsername,null);
            GoogleAnalyticsTracker.getInstance().trackPageview("/UserNameOK");
         }
      }
      
      public function onUserNameChange(param1:Event) : void
      {
         if(txtValidateUserNameErrorTip != null)
         {
            destroyTip(txtValidateUserNameErrorTip);
         }
         if(ValidationUtilities.userNameCharactersValid(this.txtUsername.text) && ValidationUtilities.userNamePatternValid(this.txtUsername.text,true))
         {
            this.previousUserNameTxt = this.txtUsername.text;
            this.selectionBeginIndex = this.txtUsername.selectionBeginIndex;
         }
         else
         {
            this.txtUsername.text = this.previousUserNameTxt;
            this.txtUsername.selectionBeginIndex = this.selectionBeginIndex;
            this.txtUsername.selectionEndIndex = this.selectionBeginIndex;
         }
      }
      
      public function friendUserNameValueCommit(param1:Event) : void
      {
         if(this.validationEnabled)
         {
            this.validateFriendUserName(this.refferalName,null);
         }
      }
      
      public function passwordValueCommit(param1:Event) : void
      {
         if(this.validationEnabled)
         {
            this.validatePassword(this.txtPassword1,this.txtPassword2);
            GoogleAnalyticsTracker.getInstance().trackPageview("/PasswordOK");
         }
      }
      
      public function retypedPasswordValueCommit(param1:Event) : void
      {
         if(this.validationEnabled)
         {
            this.validateRetypedPassword(this.txtPassword1,this.txtPassword2);
            GoogleAnalyticsTracker.getInstance().trackPageview("/RetypePasswordOK");
         }
      }
      
      private function validateUserName(param1:TextInput, param2:Function) : void
      {
         ValidateUserNameTextInput(param1,this.txtUserNameErrorTip,param2,this.btnAccept);
      }
      
      private function validateFriendUserName(param1:TextInput, param2:Function) : void
      {
         if(this.txtFriendUserNameErrorTip != null)
         {
            ToolTipManager.destroyToolTip(this.txtFriendUserNameErrorTip);
            this.txtFriendUserNameErrorTip = null;
         }
         if(this.refferalName.text.length == 0)
         {
            this.txtFriendUserNameErrorTip = Utils.ShowErrorTip(this.refferalName,"Please enter friends user name.");
            if(param2 != null)
            {
               param2();
            }
            return;
         }
         if(NewUserState.invitedByActorID == -1)
         {
            this.txtFriendUserNameErrorTip = Utils.ShowErrorTip(this.refferalName,"Username does not exist.");
         }
         if(param2 != null)
         {
            param2();
         }
      }
      
      private function validatePassword(param1:TextInput, param2:TextInput) : void
      {
         if(this.txtPassword1ErrorTip != null)
         {
            ToolTipManager.destroyToolTip(this.txtPassword1ErrorTip);
            this.txtPassword1ErrorTip = null;
         }
         if(this.txtPassword2ErrorTip != null)
         {
            ToolTipManager.destroyToolTip(this.txtPassword2ErrorTip);
            this.txtPassword2ErrorTip = null;
         }
         var _loc3_:String = ValidationUtilities.ValidatePassword(param1.text,this.txtUsername.text);
         if(_loc3_)
         {
            this.txtPassword1ErrorTip = Utils.ShowErrorTip(param1,MSPLocaleManagerWeb.getInstance().getString(_loc3_));
            param1.setStyle("backgroundColor",TEXT_BACKGROUND_COLOR_INVALID);
         }
         else
         {
            param1.setStyle("backgroundColor",TEXT_BACKGROUND_COLOR_VALID);
         }
      }
      
      private function validateBirthMonth() : void
      {
         if(this.txtBirthMonthErrorTip != null)
         {
            ToolTipManager.destroyToolTip(this.txtBirthMonthErrorTip);
            this.txtBirthMonthErrorTip = null;
         }
         if(this.comboBirthMonth.selectedItem != null && this.comboBirthMonth.selectedItem.data == -1)
         {
            this.txtBirthMonthErrorTip = Utils.ShowErrorTip(this.comboBirthMonth,MSPLocaleManagerWeb.getInstance().getString("SELECT_MONTH"));
            return;
         }
      }
      
      private function validateBirthYear() : void
      {
         if(this.txtBirthYearErrorTip != null)
         {
            ToolTipManager.destroyToolTip(this.txtBirthYearErrorTip);
            this.txtBirthYearErrorTip = null;
         }
         if(this.comboBirthYear.selectedItem != null && this.comboBirthYear.selectedItem.data == -1)
         {
            this.txtBirthYearErrorTip = Utils.ShowErrorTip(this.comboBirthYear,MSPLocaleManagerWeb.getInstance().getString("SELECT_YEAR"));
            return;
         }
      }
      
      private function validateRetypedPassword(param1:TextInput, param2:TextInput) : void
      {
         if(this.txtPassword2ErrorTip != null)
         {
            ToolTipManager.destroyToolTip(this.txtPassword2ErrorTip);
            this.txtPassword2ErrorTip = null;
         }
         var _loc3_:String = ValidationUtilities.ValidateRetypedPass(param1.text,param2.text);
         if(_loc3_)
         {
            this.txtPassword2ErrorTip = Utils.ShowErrorTip(param2,MSPLocaleManagerWeb.getInstance().getString(_loc3_));
            param2.setStyle("backgroundColor",TEXT_BACKGROUND_COLOR_INVALID);
         }
         else
         {
            param2.setStyle("backgroundColor",TEXT_BACKGROUND_COLOR_VALID);
         }
      }
      
      private function btnCancelClicked(param1:MouseEvent) : void
      {
         if(this.btnCancel.enabled)
         {
            this.btnCancel.enabled = false;
            LogoutHandler.getInstance().shutDown();
            new BrowseToMovieStarPlanetCommand().execute();
         }
      }
      
      private function cleanAfterFailedRegistration(param1:Boolean) : void
      {
         this.btnAccept.enabled = true;
         new HideProgressBarCommand().execute();
         enabled = true;
         if(param1)
         {
            this.displayCaptcha();
         }
      }
      
      private function displayCaptcha() : void
      {
         this.imgCaptcha.visible = true;
         this.txtCaptcha.visible = true;
         if(this.captchaErrorTip != null)
         {
            destroyTip(this.captchaErrorTip);
         }
         this.captchaErrorTip = Utils.ShowErrorTip(this.imgCaptcha,MSPLocaleManagerWeb.getInstance().getString("VALIDATE_CAPTCHA_REQUIRED"));
      }
      
      private function hideCaptcha() : void
      {
         destroyTip(this.captchaErrorTip);
         this.imgCaptcha.visible = false;
         this.txtCaptcha.visible = false;
      }
      
      private function generateCaptcha() : void
      {
         this.imgCaptcha.source = "";
         this.imgCaptcha.source = Config.webserverPath + "/Utils/Captcha/CaptchaGenerator.ashx";
         this.txtCaptcha.text = "";
      }
      
      private function createAccount() : void
      {
         var tempProtectedResponse:EvaluateResponse = null;
         var validateOtherFields:Function = null;
         var validateFriendUserNameDone:Function = null;
         validateOtherFields = function(param1:Boolean, param2:EvaluateResponse):void
         {
            tempProtectedResponse = param2;
            validatePassword(txtPassword1,txtPassword2);
            validateRetypedPassword(txtPassword1,txtPassword2);
            if(isRestrictedServer)
            {
               validateBirthMonth();
               validateBirthYear();
            }
            if(refferalCheckBox.selected)
            {
               validateFriendUserName(refferalName,validateFriendUserNameDone);
            }
            else
            {
               validateFriendUserNameDone();
            }
         };
         validateFriendUserNameDone = function():void
         {
            var _loc1_:Boolean = IsValid();
            if(_loc1_)
            {
               destroyAllErrorTips();
            }
            moreValidationDone(_loc1_);
         };
         var moreValidationDone:Function = function(param1:Boolean):void
         {
            var newActorCreationData:NewActorCreationData;
            var serviceDone:Function = null;
            var isValid:Boolean = param1;
            serviceDone = function(param1:CreateNewUserStatus):void
            {
               var saveBirthInfoDone:Function;
               var actor:ActorDetails = null;
               var month:int = 0;
               var year:int = 0;
               var createNewUserStatus:CreateNewUserStatus = param1;
               var continueRegister:Function = function():void
               {
                  var minTimeFeatureUsage:int;
                  GoogleAnalyticsTracker.getInstance().trackPageview("/NewUserCreated");
                  MangroveConfig.setupUserContext(createNewUserStatus.ticket);
                  new MangroveConfigureBasicInfoCommand().execute();
                  minTimeFeatureUsage = int(int(AppSettings.getInstance().getSetting(AppSettings.MANGROVE_FEATURE_USAGE_MIN_T)));
                  MangroveFeatureUsageTimer.getInstance().setup(minTimeFeatureUsage);
                  new SaveMovieStarSnapshotCommand(movieStar).saveSnapshots(actor.ActorId);
                  new HideProgressBarCommand().execute();
                  if(!SerializeUtils.checkHash("wiurh2i" + actor.ActorId.toString(),ActorIdHash.asString))
                  {
                     Alert.show("Failed creating new user. Please write to support@moviestarplanet.com.","Cannot create new user");
                     LoggingAmfService.Debug("Failed creating new user. SECAIDHC V2. " + actor.ActorId.toString());
                     return;
                  }
                  SwrveSetupCommand.newActor = true;
                  sendAnalyticsEvent(AnalyticsConstants.CHARACTER_CREATION_STEP4);
                  try
                  {
                     TrafficTracking.CreateNewUser();
                  }
                  catch(e:Error)
                  {
                     LoggingAmfService.Error(e.message);
                  }
                  MessageCommunicator.unscribe(MSPEvent.MOVIESTAR_CLICKED,skinClicked);
                  dispose();
                  new EnterApplicationCommand().execute(actor,true,NewUserState.invitedByActorID);
               };
               if(createNewUserStatus == null)
               {
                  cleanAfterFailedRegistration(false);
                  return;
               }
               actor = createNewUserStatus.actor;
               if(actor.ActorId == -1)
               {
                  new HideProgressBarCommand().execute();
                  Alert.show("This computer has been locked out of MovieStarPlanet.\n\nTo unlock this computer please write to support@moviestarplanet.com.","Cannot create new user");
                  return;
               }
               if(actor.ActorId == -2)
               {
                  enabled = true;
                  btnAccept.enabled = true;
                  new HideProgressBarCommand().execute();
                  txtUserNameErrorTip = Utils.ShowErrorTip(txtUsername,MSPLocaleManagerWeb.getInstance().getString("ALREADY_USED"));
                  return;
               }
               if(actor.ActorId == -100)
               {
                  cleanAfterFailedRegistration(true);
                  captchaRequired = true;
                  generateCaptcha();
                  displayCaptcha();
                  return;
               }
               actor.setAmsSecurityHash(createNewUserStatus.amsHash);
               ActorIdHash.asString = createNewUserStatus.hDetails;
               FeatureToggle.setActiveFeatures(createNewUserStatus.features);
               PiggyBankAmountManager.init(actor);
               if(createNewUserStatus.adCountryMap != null)
               {
                  AdvertisementWrapper.getInstance().setup(Main.Instance as DisplayObjectContainer,createNewUserStatus.adCountryMap.toArray(),createNewUserStatus.actor.isVip,createNewUserStatus.actor.isFemale,createNewUserStatus.actor.ActorId);
               }
               if(isRestrictedServer)
               {
                  saveBirthInfoDone = function(param1:int):void
                  {
                     if(param1 == 1)
                     {
                        continueRegister();
                     }
                  };
                  month = int(parseInt(comboBirthMonth.selectedItem.data.toString()));
                  year = int(parseInt(comboBirthYear.selectedItem.data.toString()));
                  ActorAmfServiceForWeb.saveBirthInfo(TicketGenerator.createTicketHeader().Ticket,month,year,saveBirthInfoDone);
               }
               else
               {
                  continueRegister();
               }
            };
            if(!isWearingMinimumClothing())
            {
               isValid = false;
               Prompt.show(MSPLocaleManagerWeb.getInstance().getString("MUST_WEAR_CLOTHES"));
            }
            if(isValid == false)
            {
               btnAccept.enabled = true;
               return;
            }
            GoogleAnalyticsTracker.getInstance().trackPageview("/ValidateDone");
            enabled = false;
            new ShowProgressBarCommand().execute(MSPLocaleManagerWeb.getInstance().getString("LOGGING_IN"));
            ActorSession.actorPassword = txtPassword1.text;
            newActorCreationData = new NewActorCreationData(ActorDetails.newFromActor(movieStar.actor,txtUsername.text,NewUserState.invitedByActorID),createClothesList(),txtPassword1.text);
            UserAmfServiceWeb.CreateNewUser(newActorCreationData,tempProtectedResponse,serviceDone);
         };
         this.btnAccept.enabled = false;
         GoogleAnalyticsTracker.getInstance().trackPageview("/AcceptConditions");
         this.validateUserName(this.txtUsername,validateOtherFields);
         tempProtectedResponse = null;
      }
      
      private function createClothesList() : Array
      {
         var _loc3_:ActorClothesRel = null;
         var _loc4_:ActorClothesRel2 = null;
         var _loc1_:Array = new Array();
         var _loc2_:Array = this.movieStar.GetAttachedClothes();
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = ActorClothesRel2.CreateActorClothesRel2(_loc3_);
            _loc1_.push(_loc4_);
         }
         return _loc1_;
      }
      
      private function btnAcceptClicked(param1:MouseEvent) : void
      {
         var done:Function = null;
         var event:MouseEvent = param1;
         done = function(param1:Boolean, param2:EvaluateResponse = null):void
         {
            var validationDone:Function;
            var isValid:Boolean = param1;
            var protectedName:EvaluateResponse = param2;
            if(isValid)
            {
               if(captchaRequired)
               {
                  validationDone = function(param1:Boolean):void
                  {
                     if(param1 == false)
                     {
                        generateCaptcha();
                        displayCaptcha();
                     }
                     else
                     {
                        hideCaptcha();
                        createAccountIfWearingMinimumClothingOrShowError();
                     }
                  };
                  if(captchaErrorTip != null)
                  {
                     destroyTip(captchaErrorTip);
                  }
                  ActorAmfServiceForWeb.validateCaptcha(txtCaptcha.text,validationDone);
               }
               else
               {
                  createAccountIfWearingMinimumClothingOrShowError();
               }
            }
         };
         this.validateUserName(this.txtUsername,done);
      }
      
      private function createAccountIfWearingMinimumClothingOrShowError() : void
      {
         if(this.isWearingMinimumClothing())
         {
            this.createAccount();
         }
         else
         {
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("MUST_WEAR_CLOTHES"));
         }
      }
      
      private function isWearingMinimumClothing() : Boolean
      {
         return new CheckClothingCommand(this.movieStar).isWearingMinimumClothing();
      }
      
      private function ClothesClickListener(param1:MouseEvent) : void
      {
         var _loc2_:ItemBox = ItemBox(param1.currentTarget);
         this.SetSelectedItem(_loc2_);
      }
      
      private function SetSelectedItem(param1:ItemBox) : void
      {
         if(param1 == null || param1.IsLoaded)
         {
            this._selectedItem = param1;
            this.UpdateSelectedItem(this._selectedItem);
            this.UpdateColorPanelForSelectedItem();
         }
      }
      
      private function ClearColorPanel(param1:Event = null) : void
      {
         var _loc2_:Boolean = this.mainViewStack.selectedChild == this.skinView;
         if(_loc2_)
         {
            this.colorPanel.visible = false;
            this.skinColorPanel.visible = !this.isFirstClearColorPanel;
         }
         else
         {
            this.skinColorPanel.visible = false;
            this.colorPanel.visible = true;
         }
         this.colorPanel.SetData(null);
         this.isFirstClearColorPanel = false;
      }
      
      private function UpdateColorPanelForSelectedItem() : void
      {
         var _loc1_:MSP_SWFLoader = null;
         var _loc2_:MovieClip = null;
         if(this._selectedItem == null)
         {
            this.colorPanel.SetData(null);
            return;
         }
         _loc1_ = this._selectedItem.GetLoader();
         _loc2_ = MovieClip(_loc1_.content);
         if(_loc2_ != null)
         {
            this.colorPanel.SetData(_loc2_.colorMap as Array);
         }
         else if(this._selectedItem.info.facePartLoader != null)
         {
            this.colorPanel.setFacePartData(this._selectedItem.info.facepart.DefaultColors);
         }
      }
      
      private function UpdateSelectedItem(param1:ItemBox, param2:Boolean = true, param3:String = "") : void
      {
         var _loc4_:MSP_SWFLoader = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Cloth = null;
         var _loc7_:Boolean = false;
         var _loc8_:ActorClothesRel = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:Boolean = false;
         if(param1 != null)
         {
            _loc4_ = param1.GetLoader();
            _loc5_ = MovieClip(_loc4_.content);
            _loc6_ = Cloth(param1.info.cloth);
            _loc7_ = _loc6_ != null;
            if(_loc7_)
            {
               _loc8_ = new ActorClothesRel();
               _loc8_.ActorClothesRelId = this.nextKey--;
               _loc8_.ActorId = this.movieStar.actor.ActorId;
               _loc8_.Cloth = _loc6_;
               _loc8_.ClothesId = _loc6_.ClothesId;
               _loc8_.IsWearing = 1;
               _loc8_.Color = ColorMap.GetColorsOnMovieClip(_loc5_);
               _loc8_.x = 0;
               _loc8_.y = 0;
               if(this.movieStar.isWearingCloth(_loc6_) && param2)
               {
                  this.movieStar.TakeOffConflictingCloths(_loc6_);
               }
               else
               {
                  this.movieStar.PutOnCloth(_loc8_);
               }
            }
            else
            {
               _loc11_ = false;
               switch(param1.info.type)
               {
                  case this.FACEPART_TYPE_EYES:
                     this.movieStar.actor.Eye = Eye(param1.info.facepart);
                     if(param3 != "")
                     {
                        (param1.info.facePartLoader as MovieStarDragonBone).colorizePart(Eye.TYPE,param3,"front");
                        _loc9_ = param3;
                     }
                     else
                     {
                        _loc9_ = this.movieStar.actor.Eye.DefaultColors;
                     }
                     _loc11_ = true;
                     _loc10_ = this.movieStar.actor.Eye.SWFLocation;
                     break;
                  case this.FACEPART_TYPE_NOSE:
                     this.movieStar.actor.Nose = Nose(param1.info.facepart);
                     _loc10_ = this.movieStar.actor.Nose.SWFLocation;
                     _loc9_ = ColorMap.GetColorsOnMovieClip(_loc5_);
                     break;
                  case this.FACEPART_TYPE_MOUTH:
                     this.movieStar.actor.Mouth = Mouth(param1.info.facepart);
                     _loc10_ = this.movieStar.actor.Mouth.SWFLocation;
                     _loc9_ = ColorMap.GetColorsOnMovieClip(_loc5_);
               }
               this.movieStar.LoadFacePart(_loc10_,param1.info.type,null,_loc9_,_loc11_);
            }
         }
      }
      
      private function colorPickerSkinChanged(param1:Event = null) : void
      {
         var _loc3_:IItem = null;
         var _loc4_:MovieStar = null;
         var _loc5_:MSP_SWFLoader = null;
         var _loc6_:Object = null;
         var _loc2_:uint = uint(this.colorPickerSkin.selectedColor);
         this.movieStar.skinColor = _loc2_;
         for each(_loc3_ in this.faceView.GetItems())
         {
            if(_loc3_.Loader != null)
            {
               _loc5_ = _loc3_.Loader;
               ColorMap.ApplyColorMap(ColorMap.GetContentColorMap(_loc5_.content),_loc2_);
            }
            else
            {
               _loc6_ = _loc3_["info"];
               if(_loc6_ != null)
               {
                  _loc6_.skinColor = _loc2_;
               }
            }
         }
         for each(_loc4_ in this.skinMovieStars)
         {
            _loc4_.skinColor = _loc2_;
         }
      }
      
      private function colorPanelColorChanged(param1:MultiColorPanel) : void
      {
         this.UpdateSelectedItem(this._selectedItem,false,param1.getColorString());
      }
      
      private function okClicked() : void
      {
         var result:Object = null;
         if(!this.isWearingMinimumClothing())
         {
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("MUST_WEAR_CLOTHES"));
            return;
         }
         GoogleAnalyticsTracker.getInstance().trackPageview("/EnterInfo");
         try
         {
            try
            {
               result = ExternalInterface.call("trackBuildingCharacter",this.isGirl);
            }
            catch(e:Error)
            {
            }
            TrafficTracking.BuildingCharacter(this.isGirl);
         }
         catch(e:Error)
         {
            LoggingAmfService.Error(e.message);
         }
         this.leftcanvas.width = 917;
         this.userInfoPanel.visible = true;
         if(NewUserState.invitedByUserName != null)
         {
            this.refferalCheckBox.selected = true;
            this.referralChecked();
            this.refferalCheckBox.enabled = false;
            this.refferalName.text = NewUserState.invitedByUserName;
            this.refferalName.enabled = false;
         }
         this.txtUsername.setFocus();
         sendAnalyticsEvent(AnalyticsConstants.CHARACTER_CREATION_STEP3);
      }
      
      private function referralChecked() : void
      {
         if(!this.refferalCheckBox.selected)
         {
            this.refferalLabel.visible = false;
            this.refferalName.visible = false;
            this.refferalName.text = "";
            destroyTip(this.txtFriendUserNameErrorTip);
            this.txtFriendUserNameErrorTip = null;
         }
      }
      
      private function LoadClothContainer(param1:MSP_ItemContainer, param2:ArrayCollection) : void
      {
         var _loc3_:Cloth = null;
         var _loc4_:ItemBox = null;
         param1.BeginUpdate();
         param1.PagedItems = [];
         for each(_loc3_ in param2)
         {
            _loc4_ = new ItemBox(new ContentUrl(_loc3_.path,ContentUrl.CLOTH),100,100,false,null,false,true,_loc3_.ColorScheme);
            _loc4_.info.cloth = _loc3_;
            _loc4_.addEventListener(MouseEvent.CLICK,this.ItemClickListener,false,0,true);
            param1.addChild(_loc4_);
         }
         param1.EndUpdate();
      }
      
      private function MapData(param1:RegisterNewUserData, param2:RegisterNewUserDataObject, param3:RegisterNewUserDataObject) : void
      {
         var eye:Eye = null;
         var nose:Nose = null;
         var mouth:Mouth = null;
         var cloth:Cloth = null;
         var fieldName:String = null;
         var data:RegisterNewUserData = param1;
         var _maleData:RegisterNewUserDataObject = param2;
         var _femaleData:RegisterNewUserDataObject = param3;
         try
         {
            for each(eye in data.eyes)
            {
               switch(eye.RegNewUser)
               {
                  case this.REGNEWUSER_UNISEX:
                     _maleData.eyes.addItem(eye);
                     _femaleData.eyes.addItem(eye);
                     break;
                  case this.REGNEWUSER_FEMALE:
                     _femaleData.eyes.addItem(eye);
                     break;
                  case this.REGNEWUSER_MALE:
                     _maleData.eyes.addItem(eye);
               }
            }
            for each(nose in data.noses)
            {
               switch(nose.RegNewUser)
               {
                  case this.REGNEWUSER_UNISEX:
                     _maleData.noses.addItem(nose);
                     _femaleData.noses.addItem(nose);
                     break;
                  case this.REGNEWUSER_FEMALE:
                     _femaleData.noses.addItem(nose);
                     break;
                  case this.REGNEWUSER_MALE:
                     _maleData.noses.addItem(nose);
               }
            }
            for each(mouth in data.mouths)
            {
               switch(mouth.RegNewUser)
               {
                  case this.REGNEWUSER_UNISEX:
                     _maleData.mouths.addItem(mouth);
                     _femaleData.mouths.addItem(mouth);
                     break;
                  case this.REGNEWUSER_FEMALE:
                     _femaleData.mouths.addItem(mouth);
                     break;
                  case this.REGNEWUSER_MALE:
                     _maleData.mouths.addItem(mouth);
               }
            }
            var _loc5_:int = 0;
            var _loc6_:* = data.clothes;
            loop3:
            while(true)
            {
               for each(cloth in _loc6_)
               {
                  switch(cloth.ClothesCategoryId)
                  {
                     case 1:
                     case 5:
                        fieldName = "hair";
                        break;
                     case 2:
                     case 6:
                     case 7:
                        fieldName = "tops";
                        break;
                     case 3:
                     case 8:
                     case 9:
                     case 60:
                     case 61:
                        fieldName = "bottoms";
                        break;
                     case 10:
                     case 11:
                     case 12:
                     case 70:
                     case 71:
                        fieldName = "footwear";
                        break;
                     case 13:
                     case 14:
                     case 15:
                        fieldName = "headwear";
                        break;
                     default:
                        break loop3;
                  }
                  switch(cloth.RegNewUser)
                  {
                     case this.REGNEWUSER_FEMALE:
                        ArrayCollection(_femaleData[fieldName]).addItem(cloth);
                        break;
                     case this.REGNEWUSER_MALE:
                        ArrayCollection(_maleData[fieldName]).addItem(cloth);
                        break;
                     case this.REGNEWUSER_UNISEX:
                        ArrayCollection(_femaleData[fieldName]).addItem(cloth);
                        ArrayCollection(_maleData[fieldName]).addItem(cloth);
                  }
               }
            }
            throw new Error("Unsupported clothes category : " + cloth.ClothesCategoryId + ", ClothId = " + cloth.ClothesId);
         }
         catch(e:Error)
         {
            LoggingAmfService.Error(e.message);
            throw e;
         }
      }
      
      private function _RegisterNewUserComponent_Rotate1_i() : Rotate
      {
         var _loc1_:Rotate = new Rotate();
         this.errorTipRotateEffect = _loc1_;
         BindingManager.executeBindings(this,"errorTipRotateEffect",this.errorTipRotateEffect);
         return _loc1_;
      }
      
      private function _RegisterNewUserComponent_Zoom1_i() : Zoom
      {
         var _loc1_:Zoom = new Zoom();
         this.errorTipZoomEffect = _loc1_;
         BindingManager.executeBindings(this,"errorTipZoomEffect",this.errorTipZoomEffect);
         return _loc1_;
      }
      
      private function _RegisterNewUserComponent_Sequence1_i() : Sequence
      {
         var _loc1_:Sequence = new Sequence();
         _loc1_.repeatCount = 1;
         _loc1_.children = [this._RegisterNewUserComponent_Glow1_c(),this._RegisterNewUserComponent_Glow2_c()];
         this.glow = _loc1_;
         BindingManager.executeBindings(this,"glow",this.glow);
         return _loc1_;
      }
      
      private function _RegisterNewUserComponent_Glow1_c() : Glow
      {
         var _loc1_:Glow = new Glow();
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.blurXFrom = 20;
         _loc1_.blurXTo = 40;
         _loc1_.blurYFrom = 20;
         _loc1_.blurYTo = 40;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      private function _RegisterNewUserComponent_Glow2_c() : Glow
      {
         var _loc1_:Glow = new Glow();
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         _loc1_.blurXFrom = 40;
         _loc1_.blurXTo = 20;
         _loc1_.blurYFrom = 40;
         _loc1_.blurYTo = 20;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      public function ___RegisterNewUserComponent_ViewComponentCanvas1_creationComplete(param1:FlexEvent) : void
      {
         this.OnCreationComplete(param1);
      }
      
      public function __btnViewSkin_click(param1:MouseEvent) : void
      {
         this.mainViewStack.selectedChild = this.skinView;
      }
      
      public function __btnViewFace_click(param1:MouseEvent) : void
      {
         this.showView("face");
      }
      
      public function __btnViewHair_click(param1:MouseEvent) : void
      {
         this.showView("hair");
      }
      
      public function __btnViewTops_click(param1:MouseEvent) : void
      {
         this.showView("tops");
      }
      
      public function __btnViewBottoms_click(param1:MouseEvent) : void
      {
         this.showView("bottoms");
      }
      
      public function __btnViewFootwear_click(param1:MouseEvent) : void
      {
         this.showView("footwear");
      }
      
      public function __faceView_creationComplete(param1:FlexEvent) : void
      {
         this.onFemaleFaceViewComplete(param1);
      }
      
      public function __hairView_creationComplete(param1:FlexEvent) : void
      {
         this.onFemaleHairViewComplete(param1);
      }
      
      public function __topsView_creationComplete(param1:FlexEvent) : void
      {
         this.onFemaleTopsViewComplete(param1);
      }
      
      public function __bottomsView_creationComplete(param1:FlexEvent) : void
      {
         this.onFemaleBottomsViewComplete(param1);
      }
      
      public function __footwearView_creationComplete(param1:FlexEvent) : void
      {
         this.onFemaleFootwearViewComplete(param1);
      }
      
      public function __headwearView_creationComplete(param1:FlexEvent) : void
      {
         this.onFemaleHeadwearViewComplete(param1);
      }
      
      public function __maleFaceView_creationComplete(param1:FlexEvent) : void
      {
         this.onMaleFaceViewComplete(param1);
      }
      
      public function __maleHairView_creationComplete(param1:FlexEvent) : void
      {
         this.onMaleHairViewComplete(param1);
      }
      
      public function __maleTopsView_creationComplete(param1:FlexEvent) : void
      {
         this.onMaleTopsViewComplete(param1);
      }
      
      public function __maleBottomsView_creationComplete(param1:FlexEvent) : void
      {
         this.onMaleBottomsViewComplete(param1);
      }
      
      public function __maleFootwearView_creationComplete(param1:FlexEvent) : void
      {
         this.onMaleFootwearViewComplete(param1);
      }
      
      public function __maleHeadwearView_creationComplete(param1:FlexEvent) : void
      {
         this.onMaleHeadwearViewComplete(param1);
      }
      
      public function __colorPickerSkin_change(param1:ColorPickerEvent) : void
      {
         this.colorPickerSkinChanged(param1);
      }
      
      public function __btnRandomizeFemale_click(param1:MouseEvent) : void
      {
         this.btnRandomizeFemaleClicked(param1);
      }
      
      public function __btnRandomizeMale_click(param1:MouseEvent) : void
      {
         this.btnRandomizeMaleClicked(param1);
      }
      
      public function __okButton_click(param1:MouseEvent) : void
      {
         this.okClicked();
      }
      
      public function ___RegisterNewUserComponent_Button4_click(param1:MouseEvent) : void
      {
         this.btnCancelClicked(param1);
      }
      
      public function __txtUsername_change(param1:Event) : void
      {
         this.onUserNameChange(param1);
      }
      
      public function __txtUsername_valueCommit(param1:FlexEvent) : void
      {
         this.userNameValueCommit(param1);
      }
      
      public function __txtPassword1_valueCommit(param1:FlexEvent) : void
      {
         this.passwordValueCommit(param1);
      }
      
      public function __txtPassword2_valueCommit(param1:FlexEvent) : void
      {
         this.retypedPasswordValueCommit(param1);
      }
      
      public function __refferalCheckBox_click(param1:MouseEvent) : void
      {
         this.referralChecked();
      }
      
      public function __refferalName_valueCommit(param1:FlexEvent) : void
      {
         this.friendUserNameValueCommit(param1);
      }
      
      public function __btnAccept_click(param1:MouseEvent) : void
      {
         this.btnAcceptClicked(param1);
      }
      
      public function __btnCancel_click(param1:MouseEvent) : void
      {
         this.btnCancelClicked(param1);
      }
      
      private function _RegisterNewUserComponent_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("img/create_new_user_bg.swf",Config.LOCAL_CDN_URL);
         },null,"background.source");
         result[1] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/Icons/Register/GenderIcon.swf",Config.LOCAL_CDN_URL);
         },null,"btnViewSkin.source");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("MALE_FEMALE");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnViewSkin.toolTip");
         result[3] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/Icons/Register/HeadsIcon.swf",Config.LOCAL_CDN_URL);
         },null,"btnViewFace.source");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("CHANGE_EYE_MOUTH");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnViewFace.toolTip");
         result[5] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/Icons/Register/HairIcon.swf",Config.LOCAL_CDN_URL);
         },null,"btnViewHair.source");
         result[6] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("SELECT_HAIR");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnViewHair.toolTip");
         result[7] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/Icons/Register/TopsIcon.swf",Config.LOCAL_CDN_URL);
         },null,"btnViewTops.source");
         result[8] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("SELECT_TOPS");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnViewTops.toolTip");
         result[9] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/Icons/Register/BottomsIcon.swf",Config.LOCAL_CDN_URL);
         },null,"btnViewBottoms.source");
         result[10] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("SELECT_BOTTOMS");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnViewBottoms.toolTip");
         result[11] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/Icons/Register/ShoesIcon.swf",Config.LOCAL_CDN_URL);
         },null,"btnViewFootwear.source");
         result[12] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("SELECT_FOOTWEAR");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnViewFootwear.toolTip");
         result[13] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("START_BY");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"lblStartByclickingSkin.text");
         result[14] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("LOADING_PLEASE");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"plsWait1.label");
         result[15] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("SKIN_COLOR");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_RegisterNewUserComponent_Label2.text");
         result[16] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("STEP1");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"lbl1.text");
         result[17] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("RANDOM_GIRL");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnRandomizeFemale.label");
         result[18] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("CREATE_RANDOM_FEMALE");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnRandomizeFemale.toolTip");
         result[19] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("RANDOM_BOY");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnRandomizeMale.label");
         result[20] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("CREATE_RANDOM_MALE");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnRandomizeMale.toolTip");
         result[21] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("OK_DONE");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"okButton.label");
         result[22] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("CANCEL");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_RegisterNewUserComponent_Button4.label");
         result[23] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("RETYPE_PASSWORD");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_RegisterNewUserComponent_Label4.text");
         result[24] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("USERNAME");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_RegisterNewUserComponent_Label5.text");
         result[25] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("PASSWORD");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_RegisterNewUserComponent_Label6.text");
         result[26] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("NEW_USER_DO_NOT_USE_REAL_NAME") || "";
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_RegisterNewUserComponent_Label7.text");
         result[27] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("NEW_USER_DO_NOT_SHARE_PASSWORD") || "";
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_RegisterNewUserComponent_Label8.text");
         result[28] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("BORN_WHEN");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_RegisterNewUserComponent_Text1.text");
         result[29] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("CREATE_ACCOUNT");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnAccept.label");
         result[30] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("STEP2");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_RegisterNewUserComponent_Label11.text");
         result[31] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("CORRECT_ERRORS");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"lblErrorHeader.text");
         result[32] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("CANCEL");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnCancel.label");
         result[33] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("TERMS1");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_RegisterNewUserComponent_Text2.text");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get background() : Image
      {
         return this._1332194002background;
      }
      
      public function set background(param1:Image) : void
      {
         var _loc2_:Object = this._1332194002background;
         if(_loc2_ !== param1)
         {
            this._1332194002background = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"background",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bottomsView() : MSP_ItemContainer
      {
         return this._591378835bottomsView;
      }
      
      public function set bottomsView(param1:MSP_ItemContainer) : void
      {
         var _loc2_:Object = this._591378835bottomsView;
         if(_loc2_ !== param1)
         {
            this._591378835bottomsView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bottomsView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnAccept() : Button
      {
         return this._62188164btnAccept;
      }
      
      public function set btnAccept(param1:Button) : void
      {
         var _loc2_:Object = this._62188164btnAccept;
         if(_loc2_ !== param1)
         {
            this._62188164btnAccept = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnAccept",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnCancel() : Button
      {
         return this._117924854btnCancel;
      }
      
      public function set btnCancel(param1:Button) : void
      {
         var _loc2_:Object = this._117924854btnCancel;
         if(_loc2_ !== param1)
         {
            this._117924854btnCancel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnCancel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnRandomizeFemale() : Button
      {
         return this._732180895btnRandomizeFemale;
      }
      
      public function set btnRandomizeFemale(param1:Button) : void
      {
         var _loc2_:Object = this._732180895btnRandomizeFemale;
         if(_loc2_ !== param1)
         {
            this._732180895btnRandomizeFemale = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnRandomizeFemale",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnRandomizeMale() : Button
      {
         return this._492176798btnRandomizeMale;
      }
      
      public function set btnRandomizeMale(param1:Button) : void
      {
         var _loc2_:Object = this._492176798btnRandomizeMale;
         if(_loc2_ !== param1)
         {
            this._492176798btnRandomizeMale = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnRandomizeMale",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnViewBottoms() : MSP_ClickImage
      {
         return this._1066962247btnViewBottoms;
      }
      
      public function set btnViewBottoms(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._1066962247btnViewBottoms;
         if(_loc2_ !== param1)
         {
            this._1066962247btnViewBottoms = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnViewBottoms",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnViewFace() : MSP_ClickImage
      {
         return this._1319735010btnViewFace;
      }
      
      public function set btnViewFace(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._1319735010btnViewFace;
         if(_loc2_ !== param1)
         {
            this._1319735010btnViewFace = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnViewFace",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnViewFootwear() : MSP_ClickImage
      {
         return this._1249449774btnViewFootwear;
      }
      
      public function set btnViewFootwear(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._1249449774btnViewFootwear;
         if(_loc2_ !== param1)
         {
            this._1249449774btnViewFootwear = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnViewFootwear",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnViewHair() : MSP_ClickImage
      {
         return this._1319675229btnViewHair;
      }
      
      public function set btnViewHair(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._1319675229btnViewHair;
         if(_loc2_ !== param1)
         {
            this._1319675229btnViewHair = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnViewHair",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnViewSkin() : MSP_ClickImage
      {
         return this._1319337922btnViewSkin;
      }
      
      public function set btnViewSkin(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._1319337922btnViewSkin;
         if(_loc2_ !== param1)
         {
            this._1319337922btnViewSkin = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnViewSkin",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnViewTops() : MSP_ClickImage
      {
         return this._1319304065btnViewTops;
      }
      
      public function set btnViewTops(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._1319304065btnViewTops;
         if(_loc2_ !== param1)
         {
            this._1319304065btnViewTops = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnViewTops",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get buttonBox() : HBox
      {
         return this._11548985buttonBox;
      }
      
      public function set buttonBox(param1:HBox) : void
      {
         var _loc2_:Object = this._11548985buttonBox;
         if(_loc2_ !== param1)
         {
            this._11548985buttonBox = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buttonBox",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get colorPanel() : MultiColorPanel
      {
         return this._1275269217colorPanel;
      }
      
      public function set colorPanel(param1:MultiColorPanel) : void
      {
         var _loc2_:Object = this._1275269217colorPanel;
         if(_loc2_ !== param1)
         {
            this._1275269217colorPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"colorPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get colorPickerSkin() : ColorPicker
      {
         return this._340055790colorPickerSkin;
      }
      
      public function set colorPickerSkin(param1:ColorPicker) : void
      {
         var _loc2_:Object = this._340055790colorPickerSkin;
         if(_loc2_ !== param1)
         {
            this._340055790colorPickerSkin = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"colorPickerSkin",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get comboBirthMonth() : MSP_ComboBox
      {
         return this._2038157615comboBirthMonth;
      }
      
      public function set comboBirthMonth(param1:MSP_ComboBox) : void
      {
         var _loc2_:Object = this._2038157615comboBirthMonth;
         if(_loc2_ !== param1)
         {
            this._2038157615comboBirthMonth = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"comboBirthMonth",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get comboBirthYear() : MSP_ComboBox
      {
         return this._620283822comboBirthYear;
      }
      
      public function set comboBirthYear(param1:MSP_ComboBox) : void
      {
         var _loc2_:Object = this._620283822comboBirthYear;
         if(_loc2_ !== param1)
         {
            this._620283822comboBirthYear = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"comboBirthYear",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get errorTipRotateEffect() : Rotate
      {
         return this._1186698273errorTipRotateEffect;
      }
      
      public function set errorTipRotateEffect(param1:Rotate) : void
      {
         var _loc2_:Object = this._1186698273errorTipRotateEffect;
         if(_loc2_ !== param1)
         {
            this._1186698273errorTipRotateEffect = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"errorTipRotateEffect",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get errorTipZoomEffect() : Zoom
      {
         return this._1034625303errorTipZoomEffect;
      }
      
      public function set errorTipZoomEffect(param1:Zoom) : void
      {
         var _loc2_:Object = this._1034625303errorTipZoomEffect;
         if(_loc2_ !== param1)
         {
            this._1034625303errorTipZoomEffect = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"errorTipZoomEffect",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get faceView() : MSP_ItemContainer
      {
         return this._496766626faceView;
      }
      
      public function set faceView(param1:MSP_ItemContainer) : void
      {
         var _loc2_:Object = this._496766626faceView;
         if(_loc2_ !== param1)
         {
            this._496766626faceView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"faceView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get footwearView() : MSP_ItemContainer
      {
         return this._1891486414footwearView;
      }
      
      public function set footwearView(param1:MSP_ItemContainer) : void
      {
         var _loc2_:Object = this._1891486414footwearView;
         if(_loc2_ !== param1)
         {
            this._1891486414footwearView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"footwearView",_loc2_,param1));
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
         var _loc2_:Object = this._3175821glow;
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
      public function get hairView() : MSP_ItemContainer
      {
         return this._128799321hairView;
      }
      
      public function set hairView(param1:MSP_ItemContainer) : void
      {
         var _loc2_:Object = this._128799321hairView;
         if(_loc2_ !== param1)
         {
            this._128799321hairView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"hairView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get headwearView() : MSP_ItemContainer
      {
         return this._762012836headwearView;
      }
      
      public function set headwearView(param1:MSP_ItemContainer) : void
      {
         var _loc2_:Object = this._762012836headwearView;
         if(_loc2_ !== param1)
         {
            this._762012836headwearView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"headwearView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get imgCaptcha() : Image
      {
         return this._1560030921imgCaptcha;
      }
      
      public function set imgCaptcha(param1:Image) : void
      {
         var _loc2_:Object = this._1560030921imgCaptcha;
         if(_loc2_ !== param1)
         {
            this._1560030921imgCaptcha = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"imgCaptcha",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lbl1() : Label
      {
         return this._3315003lbl1;
      }
      
      public function set lbl1(param1:Label) : void
      {
         var _loc2_:Object = this._3315003lbl1;
         if(_loc2_ !== param1)
         {
            this._3315003lbl1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lbl1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lblErrorHeader() : Label
      {
         return this._515902689lblErrorHeader;
      }
      
      public function set lblErrorHeader(param1:Label) : void
      {
         var _loc2_:Object = this._515902689lblErrorHeader;
         if(_loc2_ !== param1)
         {
            this._515902689lblErrorHeader = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lblErrorHeader",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lblStartByclickingSkin() : Label
      {
         return this._280359110lblStartByclickingSkin;
      }
      
      public function set lblStartByclickingSkin(param1:Label) : void
      {
         var _loc2_:Object = this._280359110lblStartByclickingSkin;
         if(_loc2_ !== param1)
         {
            this._280359110lblStartByclickingSkin = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lblStartByclickingSkin",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get leftcanvas() : Canvas
      {
         return this._1736395745leftcanvas;
      }
      
      public function set leftcanvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._1736395745leftcanvas;
         if(_loc2_ !== param1)
         {
            this._1736395745leftcanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"leftcanvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get mainViewStack() : ViewComponentViewStack
      {
         return this._1703153366mainViewStack;
      }
      
      public function set mainViewStack(param1:ViewComponentViewStack) : void
      {
         var _loc2_:Object = this._1703153366mainViewStack;
         if(_loc2_ !== param1)
         {
            this._1703153366mainViewStack = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mainViewStack",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get maleBottomsView() : MSP_ItemContainer
      {
         return this._1073967584maleBottomsView;
      }
      
      public function set maleBottomsView(param1:MSP_ItemContainer) : void
      {
         var _loc2_:Object = this._1073967584maleBottomsView;
         if(_loc2_ !== param1)
         {
            this._1073967584maleBottomsView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"maleBottomsView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get maleFaceView() : MSP_ItemContainer
      {
         return this._1623006159maleFaceView;
      }
      
      public function set maleFaceView(param1:MSP_ItemContainer) : void
      {
         var _loc2_:Object = this._1623006159maleFaceView;
         if(_loc2_ !== param1)
         {
            this._1623006159maleFaceView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"maleFaceView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get maleFootwearView() : MSP_ItemContainer
      {
         return this._328131551maleFootwearView;
      }
      
      public function set maleFootwearView(param1:MSP_ItemContainer) : void
      {
         var _loc2_:Object = this._328131551maleFootwearView;
         if(_loc2_ !== param1)
         {
            this._328131551maleFootwearView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"maleFootwearView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get maleHairView() : MSP_ItemContainer
      {
         return this._997440212maleHairView;
      }
      
      public function set maleHairView(param1:MSP_ItemContainer) : void
      {
         var _loc2_:Object = this._997440212maleHairView;
         if(_loc2_ !== param1)
         {
            this._997440212maleHairView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"maleHairView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get maleHeadwearView() : MSP_ItemContainer
      {
         return this._1313336495maleHeadwearView;
      }
      
      public function set maleHeadwearView(param1:MSP_ItemContainer) : void
      {
         var _loc2_:Object = this._1313336495maleHeadwearView;
         if(_loc2_ !== param1)
         {
            this._1313336495maleHeadwearView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"maleHeadwearView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get maleTopsView() : MSP_ItemContainer
      {
         return this._177804976maleTopsView;
      }
      
      public function set maleTopsView(param1:MSP_ItemContainer) : void
      {
         var _loc2_:Object = this._177804976maleTopsView;
         if(_loc2_ !== param1)
         {
            this._177804976maleTopsView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"maleTopsView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get okButton() : Button
      {
         return this._1641788370okButton;
      }
      
      public function set okButton(param1:Button) : void
      {
         var _loc2_:Object = this._1641788370okButton;
         if(_loc2_ !== param1)
         {
            this._1641788370okButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"okButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get panelBirthday() : VBox
      {
         return this._1868008609panelBirthday;
      }
      
      public function set panelBirthday(param1:VBox) : void
      {
         var _loc2_:Object = this._1868008609panelBirthday;
         if(_loc2_ !== param1)
         {
            this._1868008609panelBirthday = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"panelBirthday",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get plsWait1() : LoadingProgressBarAS
      {
         return this._1931895387plsWait1;
      }
      
      public function set plsWait1(param1:LoadingProgressBarAS) : void
      {
         var _loc2_:Object = this._1931895387plsWait1;
         if(_loc2_ !== param1)
         {
            this._1931895387plsWait1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"plsWait1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get refferalCheckBox() : CheckBox
      {
         return this._1070713074refferalCheckBox;
      }
      
      public function set refferalCheckBox(param1:CheckBox) : void
      {
         var _loc2_:Object = this._1070713074refferalCheckBox;
         if(_loc2_ !== param1)
         {
            this._1070713074refferalCheckBox = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"refferalCheckBox",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get refferalLabel() : Label
      {
         return this._1895537513refferalLabel;
      }
      
      public function set refferalLabel(param1:Label) : void
      {
         var _loc2_:Object = this._1895537513refferalLabel;
         if(_loc2_ !== param1)
         {
            this._1895537513refferalLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"refferalLabel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get refferalName() : TextInput
      {
         return this._908625034refferalName;
      }
      
      public function set refferalName(param1:TextInput) : void
      {
         var _loc2_:Object = this._908625034refferalName;
         if(_loc2_ !== param1)
         {
            this._908625034refferalName = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"refferalName",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get skinColorPanel() : Canvas
      {
         return this._207346110skinColorPanel;
      }
      
      public function set skinColorPanel(param1:Canvas) : void
      {
         var _loc2_:Object = this._207346110skinColorPanel;
         if(_loc2_ !== param1)
         {
            this._207346110skinColorPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"skinColorPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get skinView() : Canvas
      {
         return this._2143653314skinView;
      }
      
      public function set skinView(param1:Canvas) : void
      {
         var _loc2_:Object = this._2143653314skinView;
         if(_loc2_ !== param1)
         {
            this._2143653314skinView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"skinView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get termsText() : TextArea
      {
         return this._2044454740termsText;
      }
      
      public function set termsText(param1:TextArea) : void
      {
         var _loc2_:Object = this._2044454740termsText;
         if(_loc2_ !== param1)
         {
            this._2044454740termsText = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"termsText",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get topsView() : MSP_ItemContainer
      {
         return this._948434557topsView;
      }
      
      public function set topsView(param1:MSP_ItemContainer) : void
      {
         var _loc2_:Object = this._948434557topsView;
         if(_loc2_ !== param1)
         {
            this._948434557topsView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"topsView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtCaptcha() : TextInput
      {
         return this._947144214txtCaptcha;
      }
      
      public function set txtCaptcha(param1:TextInput) : void
      {
         var _loc2_:Object = this._947144214txtCaptcha;
         if(_loc2_ !== param1)
         {
            this._947144214txtCaptcha = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtCaptcha",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtPassword1() : TextInput
      {
         return this._957985894txtPassword1;
      }
      
      public function set txtPassword1(param1:TextInput) : void
      {
         var _loc2_:Object = this._957985894txtPassword1;
         if(_loc2_ !== param1)
         {
            this._957985894txtPassword1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtPassword1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtPassword2() : TextInput
      {
         return this._957985895txtPassword2;
      }
      
      public function set txtPassword2(param1:TextInput) : void
      {
         var _loc2_:Object = this._957985895txtPassword2;
         if(_loc2_ !== param1)
         {
            this._957985895txtPassword2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtPassword2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtUsername() : TextInput
      {
         return this._487866214txtUsername;
      }
      
      public function set txtUsername(param1:TextInput) : void
      {
         var _loc2_:Object = this._487866214txtUsername;
         if(_loc2_ !== param1)
         {
            this._487866214txtUsername = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtUsername",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get userInfoPanel() : Canvas
      {
         return this._1113736597userInfoPanel;
      }
      
      public function set userInfoPanel(param1:Canvas) : void
      {
         var _loc2_:Object = this._1113736597userInfoPanel;
         if(_loc2_ !== param1)
         {
            this._1113736597userInfoPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"userInfoPanel",_loc2_,param1));
            }
         }
      }
   }
}

