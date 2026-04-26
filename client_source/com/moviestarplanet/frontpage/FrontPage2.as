package com.moviestarplanet.frontpage
{
   import com.moviestarplanet.Certificate.forms.CertificateAdvertisementFrontpage;
   import com.moviestarplanet.Components.FlagComboBoxItemRenderer;
   import com.moviestarplanet.Components.MSP_ComboBox2;
   import com.moviestarplanet.Components.MSP_Image;
   import com.moviestarplanet.Components.ViewComponent.ViewComponentCanvas;
   import com.moviestarplanet.Forms.Help.Help;
   import com.moviestarplanet.advertisement.TrafficTracking;
   import com.moviestarplanet.configurations.AppSettings;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.configurations.TrusteConfig;
   import com.moviestarplanet.core.controller.commands.SetupRestrictionCommand;
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   import com.moviestarplanet.look.service.LookAMFService;
   import com.moviestarplanet.look.valueobjects.Look;
   import com.moviestarplanet.moviestar.MovieStar;
   import com.moviestarplanet.services.wrappers.SessionService;
   import com.moviestarplanet.utils.URLOpener;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
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
   import mx.containers.HBox;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.LinkButton;
   import mx.core.ClassFactory;
   import mx.core.IFlexModuleFactory;
   import mx.core.ScrollPolicy;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class FrontPage2 extends ViewComponentCanvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      private static var currentYear:Number = new Date().getFullYear();
      
      private var _545760136TRUSTeLogo:MSP_Image;
      
      public var _FrontPage2_Label1:Label;
      
      public var _FrontPage2_LinkButton1:LinkButton;
      
      public var _FrontPage2_LinkButton2:LinkButton;
      
      public var _FrontPage2_LinkButton3:LinkButton;
      
      public var _FrontPage2_LinkButton4:LinkButton;
      
      public var _FrontPage2_LinkButton5:LinkButton;
      
      public var _FrontPage2_LinkButton6:LinkButton;
      
      public var _FrontPage2_LinkButton7:LinkButton;
      
      public var _FrontPage2_LinkButton8:LinkButton;
      
      public var _FrontPage2_LinkButton9:LinkButton;
      
      private var _1412425466actorCountLabel:Label;
      
      private var _2089742340advertisementContainer:Box;
      
      private var _1332194002background:FrontpageBackground;
      
      private var _828233202ceopLogo:MSP_Image;
      
      private var _1630946923countrySelector:MSP_ComboBox2;
      
      private var _980252989countrySelector2:MSP_ComboBox2;
      
      private var _100318062imgCN:Image;
      
      private var _2022732194loginBox:LoginBox;
      
      private var _1075670645movieCountLabel:Label;
      
      private var _345533424shopLink:LinkButton;
      
      private var _2084495257sidLogo:MSP_Image;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var hasEntered:Boolean;
      
      private var loggedIn:Boolean;
      
      private var slides:Array;
      
      private var slideNumber:Number = -1;
      
      private var cornerMoviestar:MovieStar;
      
      private var animationTimer:Timer;
      
      private var webshopLinkURL:String;
      
      private var animationNameList:Vector.<String>;
      
      mx_internal var _FrontPage2_StylesInit_done:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function FrontPage2()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":ViewComponentCanvas,
            "events":{"creationComplete":"___FrontPage2_ViewComponentCanvas1_creationComplete"},
            "stylesFactory":function():void
            {
               this.backgroundAlpha = 0;
               this.backgroundColor = 14466493;
               this.borderColor = 12040892;
            },
            "propertiesFactory":function():Object
            {
               return {
                  "width":1240,
                  "height":720,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":FrontpageBackground,
                     "id":"background",
                     "events":{"complete":"__background_complete"},
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 16711680;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":-3,
                           "y":0
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":LoginBox,
                     "id":"loginBox"
                  }),new UIComponentDescriptor({
                     "type":MSP_ComboBox2,
                     "id":"countrySelector",
                     "events":{"change":"__countrySelector_change"},
                     "stylesFactory":function():void
                     {
                        this.alternatingItemColors = [6867401];
                        this.fillAlphas = [1,1];
                        this.fillColors = [10744048,6867401];
                        this.selectionColor = 10744048;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":875,
                           "y":145,
                           "width":164,
                           "increaseH":0,
                           "increaseW":16,
                           "itemRenderer":_FrontPage2_ClassFactory1_c(),
                           "tabFocusEnabled":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":MSP_ComboBox2,
                     "id":"countrySelector2",
                     "events":{"change":"__countrySelector2_change"},
                     "stylesFactory":function():void
                     {
                        this.alternatingItemColors = [6867401];
                        this.fillAlphas = [1,1];
                        this.rollOverColor = 10744048;
                        this.fillColors = [6867401,1415074];
                        this.dropdownStyleName = "comboBoxStyle";
                        this.selectionColor = 10744048;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":875,
                           "y":344,
                           "width":164,
                           "increaseH":0,
                           "increaseW":16,
                           "itemRenderer":_FrontPage2_ClassFactory2_c(),
                           "tabFocusEnabled":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":MSP_Image,
                     "id":"sidLogo",
                     "events":{
                        "click":"__sidLogo_click",
                        "complete":"__sidLogo_complete"
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "x":1060,
                           "y":570,
                           "width":120,
                           "buttonMode":true,
                           "scaleContent":true,
                           "smoothBitmapContent":true,
                           "useHandCursor":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":MSP_Image,
                     "id":"ceopLogo",
                     "events":{"complete":"__ceopLogo_complete"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "x":900,
                           "y":570,
                           "width":120,
                           "scaleContent":true,
                           "smoothBitmapContent":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":MSP_Image,
                     "id":"TRUSTeLogo",
                     "events":{
                        "click":"__TRUSTeLogo_click",
                        "complete":"__TRUSTeLogo_complete"
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "x":900,
                           "y":570,
                           "width":120,
                           "buttonMode":true,
                           "scaleContent":true,
                           "smoothBitmapContent":true,
                           "useHandCursor":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Box,
                     "id":"advertisementContainer",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":480,
                           "y":540,
                           "childDescriptors":[new UIComponentDescriptor({"type":CertificateAdvertisementFrontpage})]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":HBox,
                     "stylesFactory":function():void
                     {
                        this.horizontalAlign = "center";
                        this.horizontalGap = 25;
                        this.verticalAlign = "middle";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "left":10,
                           "right":10,
                           "bottom":0,
                           "height":30,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":LinkButton,
                              "id":"_FrontPage2_LinkButton1",
                              "events":{"click":"___FrontPage2_LinkButton1_click"},
                              "stylesFactory":function():void
                              {
                                 this.color = 15524863;
                                 this.fontSize = 12;
                                 this.fontWeight = "normal";
                                 this.themeColor = 12427206;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {"tabFocusEnabled":false};
                              }
                           }),new UIComponentDescriptor({
                              "type":LinkButton,
                              "id":"_FrontPage2_LinkButton2",
                              "events":{"click":"___FrontPage2_LinkButton2_click"},
                              "stylesFactory":function():void
                              {
                                 this.color = 15524863;
                                 this.fontSize = 12;
                                 this.fontWeight = "normal";
                                 this.themeColor = 12427206;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {"tabFocusEnabled":false};
                              }
                           }),new UIComponentDescriptor({
                              "type":LinkButton,
                              "id":"_FrontPage2_LinkButton3",
                              "events":{"click":"___FrontPage2_LinkButton3_click"},
                              "stylesFactory":function():void
                              {
                                 this.color = 15524863;
                                 this.fontSize = 12;
                                 this.fontWeight = "normal";
                                 this.themeColor = 12427206;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {"tabFocusEnabled":false};
                              }
                           }),new UIComponentDescriptor({
                              "type":LinkButton,
                              "id":"_FrontPage2_LinkButton4",
                              "events":{"click":"___FrontPage2_LinkButton4_click"},
                              "stylesFactory":function():void
                              {
                                 this.color = 15524863;
                                 this.fontSize = 12;
                                 this.fontWeight = "normal";
                                 this.themeColor = 12427206;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {"tabFocusEnabled":false};
                              }
                           }),new UIComponentDescriptor({
                              "type":LinkButton,
                              "id":"_FrontPage2_LinkButton5",
                              "events":{"click":"___FrontPage2_LinkButton5_click"},
                              "stylesFactory":function():void
                              {
                                 this.color = 16573439;
                                 this.fontSize = 12;
                                 this.fontWeight = "normal";
                                 this.themeColor = 12427206;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {"tabFocusEnabled":false};
                              }
                           }),new UIComponentDescriptor({
                              "type":LinkButton,
                              "id":"_FrontPage2_LinkButton6",
                              "events":{"click":"___FrontPage2_LinkButton6_click"},
                              "stylesFactory":function():void
                              {
                                 this.color = 15524863;
                                 this.fontSize = 12;
                                 this.fontWeight = "normal";
                                 this.themeColor = 12427206;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {"tabFocusEnabled":false};
                              }
                           }),new UIComponentDescriptor({
                              "type":LinkButton,
                              "id":"_FrontPage2_LinkButton7",
                              "events":{"click":"___FrontPage2_LinkButton7_click"},
                              "stylesFactory":function():void
                              {
                                 this.color = 15524863;
                                 this.fontSize = 12;
                                 this.fontWeight = "normal";
                                 this.themeColor = 12427206;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {"tabFocusEnabled":false};
                              }
                           }),new UIComponentDescriptor({
                              "type":LinkButton,
                              "id":"_FrontPage2_LinkButton8",
                              "events":{"click":"___FrontPage2_LinkButton8_click"},
                              "stylesFactory":function():void
                              {
                                 this.color = 15524863;
                                 this.fontSize = 12;
                                 this.fontWeight = "normal";
                                 this.themeColor = 12427206;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {"tabFocusEnabled":false};
                              }
                           }),new UIComponentDescriptor({
                              "type":LinkButton,
                              "id":"_FrontPage2_LinkButton9",
                              "events":{"click":"___FrontPage2_LinkButton9_click"},
                              "stylesFactory":function():void
                              {
                                 this.color = 15524863;
                                 this.fontSize = 12;
                                 this.fontWeight = "normal";
                                 this.themeColor = 12427206;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {"tabFocusEnabled":false};
                              }
                           }),new UIComponentDescriptor({
                              "type":LinkButton,
                              "events":{"click":"___FrontPage2_LinkButton10_click"},
                              "stylesFactory":function():void
                              {
                                 this.color = 15524863;
                                 this.fontSize = 12;
                                 this.fontWeight = "normal";
                                 this.themeColor = 12427206;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "label":"Corporate",
                                    "tabFocusEnabled":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":LinkButton,
                              "id":"shopLink",
                              "events":{"click":"__shopLink_click"},
                              "stylesFactory":function():void
                              {
                                 this.color = 15524863;
                                 this.fontSize = 12;
                                 this.fontWeight = "bold";
                                 this.themeColor = 12427206;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {"tabFocusEnabled":false};
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"_FrontPage2_Label1",
                              "stylesFactory":function():void
                              {
                                 this.color = 15524863;
                                 this.fontSize = 12;
                                 this.fontWeight = "normal";
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"actorCountLabel",
                     "stylesFactory":function():void
                     {
                        this.color = 5453402;
                        this.fontWeight = "bold";
                        this.textAlign = "center";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "x":1054,
                           "y":299,
                           "width":134,
                           "includeInLayout":false,
                           "text":""
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"movieCountLabel",
                     "stylesFactory":function():void
                     {
                        this.color = 5453402;
                        this.fontWeight = "bold";
                        this.textAlign = "center";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "x":1054,
                           "y":319,
                           "width":134,
                           "includeInLayout":false,
                           "text":""
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Image,
                     "id":"imgCN",
                     "events":{"click":"__imgCN_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":1111,
                           "y":637,
                           "buttonMode":true,
                           "useHandCursor":true
                        };
                     }
                  })]
               };
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         bindings = this._FrontPage2_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_com_moviestarplanet_frontpage_FrontPage2WatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return FrontPage2[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.width = 1240;
         this.height = 720;
         this.clipContent = true;
         this.addEventListener("creationComplete",this.___FrontPage2_ViewComponentCanvas1_creationComplete);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function GetUrlParam(param1:String) : String
      {
         var paramPairs:Array = null;
         var pair:String = null;
         var param:Array = null;
         var key:String = param1;
         var browserUrl:String = ExternalInterface.call("eval","document.location.href");
         try
         {
            paramPairs = browserUrl.split("?")[1].split("&");
            for each(pair in paramPairs)
            {
               param = pair.split("=");
               if(param[0] == key && param[1] != null)
               {
                  return param[1];
               }
            }
         }
         catch(e:Error)
         {
            return null;
         }
         return null;
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         FrontPage2._watcherSetupUtil = param1;
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
            this.backgroundAlpha = 0;
            this.backgroundColor = 14466493;
            this.borderColor = 12040892;
         };
         mx_internal::_FrontPage2_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function OnCreationComplete(param1:Event) : void
      {
         SessionService.GetAppSetting(AppSettings.GIFT_CERTIFICATE_ENABLED,this.appSettingGiftCertificateCallback);
         this.Enter();
         this.ShowHelpPopupIfRequested();
         this.LoadServerType();
         var _loc2_:Array = Config.GetFlagLanguageDomains;
         this.countrySelector.dataProvider = _loc2_;
         this.countrySelector.rowCount = _loc2_.length;
         this.countrySelector2.dataProvider = _loc2_;
         this.countrySelector2.configureDropDown(ScrollPolicy.ON,10);
         var _loc3_:Number = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(_loc2_[_loc4_].isCurrent)
            {
               this.countrySelector.selectedIndex = _loc4_;
               this.countrySelector2.selectedIndex = _loc4_;
            }
            _loc4_++;
         }
         this.shopLinkCompleteHandler();
         TrafficTracking.FrontPageOpened();
         this.animationNameList = Vector.<String>(["frenchgarden_2013_proposal_dg","beating heart","collegesports_2012_cheerleading4_mf","carnivallove_2012_mustache_dg","halloween_2011_blackkisses","ukuleleguitar","dance1","ponymagic_2014_pose_mf","fly_2014_takeoffselfie_dg","valentines_2014_fireworkkiss_dg","shuffleparty_2012_lol_nd","bubblegum"]);
      }
      
      private function countrySelectorChanged(param1:Event) : void
      {
         var _loc2_:Object = param1.currentTarget.selectedItem;
         var _loc3_:String = _loc2_.redirectUrl as String;
         navigateToURL(new URLRequest(_loc3_),"_self");
      }
      
      private function backgroundLoaded(param1:Event) : void
      {
         if(this.loggedIn)
         {
            this.dispose();
         }
         else
         {
            this.loginBox.assignButtons(this.background.getLoginButton(),this.background.getSignUpButton());
            this.loginBox.setFocusOnInputFields();
            this.loadCornerMoviestar();
         }
      }
      
      override public function Enter() : void
      {
         if(this.hasEntered)
         {
            return;
         }
         this.hasEntered = true;
         var _loc1_:String = Config.GetCartoonNetworkLink;
         if(_loc1_ != null && _loc1_ != "")
         {
            this.imgCN.visible = true;
            this.imgCN.enabled = true;
         }
         else
         {
            this.imgCN.visible = false;
            this.imgCN.enabled = false;
         }
      }
      
      override public function Exit() : void
      {
         if(this.animationTimer != null)
         {
            this.animationTimer.stop();
         }
         this.animationTimer = null;
         if(this.background != null)
         {
            this.background.destroy();
         }
      }
      
      public function loggedInNow() : void
      {
         this.loggedIn = true;
         this.dispose();
      }
      
      private function dispose() : void
      {
         this.loginBox.destroy();
         this.loginBox = null;
         if(this.background != null)
         {
            this.background.destroy();
            this.background = null;
         }
         if(this.animationTimer != null)
         {
            this.animationTimer.stop();
            this.animationTimer = null;
         }
         if(this.cornerMoviestar)
         {
            this.cornerMoviestar.destroy();
            this.cornerMoviestar = null;
         }
         removeChildren();
      }
      
      private function LoadServerType() : void
      {
         var doneGetAppSetting:Function = null;
         doneGetAppSetting = function(param1:String):void
         {
            if(param1 != null)
            {
               param1 = param1.toLowerCase();
               if(param1 == "restricted")
               {
                  Config.SetServerRestricted(true);
               }
               else if(param1 == "unrestricted")
               {
                  Config.SetServerRestricted(false);
               }
            }
            new SetupRestrictionCommand().execute();
         };
         SessionService.GetAppSetting("ServerType",doneGetAppSetting);
      }
      
      private function ShowHelpPopupIfRequested() : void
      {
         var _loc1_:String = GetUrlParam("action");
         if(_loc1_ == "showHelp")
         {
            this.showHelp();
         }
      }
      
      private function loadCornerMoviestar() : void
      {
         var LookLoaded:Function = null;
         var MovieStarLoaded:Function = null;
         LookLoaded = function(param1:Object):void
         {
            var _loc3_:Object = null;
            var _loc4_:Array = null;
            var _loc5_:int = 0;
            var _loc6_:Number = NaN;
            var _loc2_:Look = Look(param1);
            if(_loc2_ != null && _loc2_.LookId != 0)
            {
               _loc3_ = SerializeUtils.deserialize(_loc2_.LookData);
               CreateMovieStar();
               cornerMoviestar.LoadWithAppearanceData(_loc2_.ActorId,_loc3_,MovieStarLoaded);
            }
            else
            {
               _loc4_ = Config.IsRunningLocally ? [1,3] : [1,3,270,271,274,275,83417,83420,83421,83422,83424,83424,83427,278,279,341,342,343,344,345,414,415,416,417,418,419,420,422,424,426];
               _loc5_ = Math.random() * _loc4_.length;
               _loc6_ = Number(_loc4_[_loc5_]);
               CreateMovieStar();
               cornerMoviestar.Load(_loc6_,MovieStarLoaded,1,false,true);
            }
         };
         var CreateMovieStar:Function = function():void
         {
            cornerMoviestar = new MovieStar();
            cornerMoviestar.movieStarPopupEnabled = false;
            cornerMoviestar.scale = 0.55;
            cornerMoviestar.x = 110;
            cornerMoviestar.y = 350;
            addChild(cornerMoviestar);
         };
         MovieStarLoaded = function(param1:MovieStar):void
         {
            playRandomAnimation(param1);
            param1.addEventListener(MouseEvent.CLICK,moviestarClicked,false,0,true);
            animationTimer = new Timer(3000,9999999999);
            animationTimer.addEventListener(TimerEvent.TIMER,playNextAnimation,false,0,true);
            animationTimer.start();
         };
         new LookAMFService().GetRandomLookByLikes(10,LookLoaded);
         this.background.startLoadingSlides();
         this.loginBox.setFocusOnInputFields();
      }
      
      private function playNextAnimation(param1:Event) : void
      {
         if(this.cornerMoviestar != null)
         {
            this.playRandomAnimation(this.cornerMoviestar);
         }
      }
      
      private function moviestarClicked(param1:Event) : void
      {
         this.playRandomAnimation(param1.currentTarget as MovieStar);
      }
      
      private function playRandomAnimation(param1:MovieStar) : void
      {
         var _loc2_:int = int(Math.floor(Math.random() * this.animationNameList.length));
         param1.PlayAnimation(this.animationNameList[_loc2_]);
      }
      
      private function showPage(param1:String) : void
      {
         URLOpener.ChangePage(param1,"_blank");
      }
      
      private function showContactPage() : void
      {
         var _loc1_:String = AppSettings.getInstance().getSetting(AppSettings.HELP_CENTER_LINK);
         if(_loc1_ == null || _loc1_ == "")
         {
            this.showPage(Config.InfoMap.contact);
         }
         else
         {
            this.showPage(_loc1_);
         }
      }
      
      private function showPageWebShop() : void
      {
         URLOpener.ChangePage(this.webshopLinkURL,"_blank");
      }
      
      private function showHelp() : void
      {
         var _loc1_:String = AppSettings.getInstance().getSetting(AppSettings.HELP_CENTER_LINK);
         if(_loc1_ == null || _loc1_ == "")
         {
            Help.open(Main.Instance.mainCanvas.applicationViewStack.FrontPageView,new Rectangle((1240 - 980) / 2,(720 - 500) / 2,980,500));
         }
         else
         {
            this.showPage(_loc1_);
         }
      }
      
      private function cartoonNetworkClick() : void
      {
         URLOpener.ChangePage("http://" + Config.GetCartoonNetworkLink,"_blank");
      }
      
      private function safetyInternetDayClickHandler(param1:MouseEvent) : void
      {
         URLOpener.ChangePage("http://www.saferinternetday.org/web/moviestarplanet-aps/home","_blank");
      }
      
      private function sidLogoCompleteHandler(param1:Event) : void
      {
         var appSettingCallback:Function = null;
         var event:Event = param1;
         appSettingCallback = function(param1:String):void
         {
            sidLogo.visible = param1 == "true";
         };
         SessionService.GetAppSetting("ShowSIDLogo",appSettingCallback);
      }
      
      private function ceopLogoCompleteHandler(param1:Event) : void
      {
         var appSettingCallback:Function = null;
         var event:Event = param1;
         appSettingCallback = function(param1:String):void
         {
            ceopLogo.visible = param1 == "true";
         };
         SessionService.GetAppSetting("ShowCEOPLogo",appSettingCallback);
      }
      
      private function TRUSTeLogoClickHandler(param1:MouseEvent) : void
      {
         URLOpener.ChangePage(TrusteConfig.TRUSTE_URL,"_blank");
      }
      
      private function TRUSTeLogoCompleteHandler(param1:Event) : void
      {
         if(Config.GetCountry == "com")
         {
            this.TRUSTeLogo.visible = true;
         }
      }
      
      private function shopLinkCompleteHandler() : void
      {
         this.shopLink.visible = false;
         this.shopLink.includeInLayout = false;
         SessionService.GetAppSetting("showwebshoplink",this.appSettingWebShopCallback);
      }
      
      private function appSettingWebShopCallback(param1:String) : void
      {
         if(param1)
         {
            this.shopLink.includeInLayout = this.shopLink.visible = true;
            this.webshopLinkURL = param1;
         }
         else
         {
            this.shopLink.includeInLayout = this.shopLink.visible = false;
         }
      }
      
      private function appSettingGiftCertificateCallback(param1:String) : void
      {
         if(param1)
         {
            this.advertisementContainer.visible = param1 == "true";
         }
         else
         {
            this.advertisementContainer.visible = false;
         }
      }
      
      public function ___FrontPage2_ViewComponentCanvas1_creationComplete(param1:FlexEvent) : void
      {
         this.OnCreationComplete(param1);
      }
      
      public function __background_complete(param1:Event) : void
      {
         this.backgroundLoaded(param1);
      }
      
      private function _FrontPage2_ClassFactory1_c() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         _loc1_.generator = FlagComboBoxItemRenderer;
         return _loc1_;
      }
      
      public function __countrySelector_change(param1:ListEvent) : void
      {
         this.countrySelectorChanged(param1);
      }
      
      private function _FrontPage2_ClassFactory2_c() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         _loc1_.generator = FlagComboBoxItemRenderer;
         return _loc1_;
      }
      
      public function __countrySelector2_change(param1:ListEvent) : void
      {
         this.countrySelectorChanged(param1);
      }
      
      public function __sidLogo_click(param1:MouseEvent) : void
      {
         this.safetyInternetDayClickHandler(param1);
      }
      
      public function __sidLogo_complete(param1:Event) : void
      {
         this.sidLogoCompleteHandler(param1);
      }
      
      public function __ceopLogo_complete(param1:Event) : void
      {
         this.ceopLogoCompleteHandler(param1);
      }
      
      public function __TRUSTeLogo_click(param1:MouseEvent) : void
      {
         this.TRUSTeLogoClickHandler(param1);
      }
      
      public function __TRUSTeLogo_complete(param1:Event) : void
      {
         this.TRUSTeLogoCompleteHandler(param1);
      }
      
      public function ___FrontPage2_LinkButton1_click(param1:MouseEvent) : void
      {
         this.showPage(Config.InfoMap.about);
      }
      
      public function ___FrontPage2_LinkButton2_click(param1:MouseEvent) : void
      {
         this.showPage(Config.InfoMap.parents);
      }
      
      public function ___FrontPage2_LinkButton3_click(param1:MouseEvent) : void
      {
         this.showPage(Config.InfoMap.userGuide);
      }
      
      public function ___FrontPage2_LinkButton4_click(param1:MouseEvent) : void
      {
         this.showPage(Config.InfoMap.safety);
      }
      
      public function ___FrontPage2_LinkButton5_click(param1:MouseEvent) : void
      {
         this.showPage(Config.InfoMap.privacyPolicy);
      }
      
      public function ___FrontPage2_LinkButton6_click(param1:MouseEvent) : void
      {
         this.showPage(Config.InfoMap.termsConditions);
      }
      
      public function ___FrontPage2_LinkButton7_click(param1:MouseEvent) : void
      {
         this.showHelp();
      }
      
      public function ___FrontPage2_LinkButton8_click(param1:MouseEvent) : void
      {
         this.showContactPage();
      }
      
      public function ___FrontPage2_LinkButton9_click(param1:MouseEvent) : void
      {
         this.showPage("http://apps.moviestarplanet.com/");
      }
      
      public function ___FrontPage2_LinkButton10_click(param1:MouseEvent) : void
      {
         this.showPage(Config.corporateSiteURL);
      }
      
      public function __shopLink_click(param1:MouseEvent) : void
      {
         this.showPageWebShop();
      }
      
      public function __imgCN_click(param1:MouseEvent) : void
      {
         this.cartoonNetworkClick();
      }
      
      private function _FrontPage2_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("img/safety/SID_2015_logo.jpg",Config.LOCAL_CDN_URL);
         },null,"sidLogo.source");
         result[1] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("img/safety/ceoplogo2.png",Config.LOCAL_CDN_URL);
         },null,"ceopLogo.source");
         result[2] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("img/safety/TRUSTeSeal.png",Config.LOCAL_CDN_URL);
         },null,"TRUSTeLogo.source");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("ABOUT");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_FrontPage2_LinkButton1.label");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("PARENTS");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_FrontPage2_LinkButton2.label");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("USER_GUIDE");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_FrontPage2_LinkButton3.label");
         result[6] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("SAFETY");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_FrontPage2_LinkButton4.label");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("PRIVACY_POLICY");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_FrontPage2_LinkButton5.label");
         result[8] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("TERMS_CONDITIONS");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_FrontPage2_LinkButton6.label");
         result[9] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("HELP");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_FrontPage2_LinkButton7.label");
         result[10] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("CONTACT");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_FrontPage2_LinkButton8.label");
         result[11] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("MSP_APPS");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_FrontPage2_LinkButton9.label");
         result[12] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("WEBSHOP");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"shopLink.label");
         result[13] = new Binding(this,function():String
         {
            var _loc1_:* = "© " + MSPLocaleManagerWeb.getInstance().getString("BRAND_NAME") + " " + currentYear;
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_FrontPage2_Label1.text");
         result[14] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("img/CN-logo.png",Config.LOCAL_CDN_URL);
         },null,"imgCN.source");
         return result;
      }
      
      mx_internal function _FrontPage2_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         var conditions:Array = null;
         var condition:CSSCondition = null;
         var selector:CSSSelector = null;
         if(mx_internal::_FrontPage2_StylesInit_done)
         {
            return;
         }
         mx_internal::_FrontPage2_StylesInit_done = true;
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","comboBoxStyle");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         style = styleManager.getStyleDeclaration(".comboBoxStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(selector,styleManager);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.verticalScrollBarStyleName = "dropDownScrollbarStyle";
            };
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","dropDownScrollbarStyle");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         style = styleManager.getStyleDeclaration(".dropDownScrollbarStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(selector,styleManager);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.themeColor = 1415074;
               this.fillColors = [1415074,6867401];
               this.trackColors = [1415074,6867401];
            };
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get TRUSTeLogo() : MSP_Image
      {
         return this._545760136TRUSTeLogo;
      }
      
      public function set TRUSTeLogo(param1:MSP_Image) : void
      {
         var _loc2_:Object = this._545760136TRUSTeLogo;
         if(_loc2_ !== param1)
         {
            this._545760136TRUSTeLogo = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"TRUSTeLogo",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get actorCountLabel() : Label
      {
         return this._1412425466actorCountLabel;
      }
      
      public function set actorCountLabel(param1:Label) : void
      {
         var _loc2_:Object = this._1412425466actorCountLabel;
         if(_loc2_ !== param1)
         {
            this._1412425466actorCountLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"actorCountLabel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get advertisementContainer() : Box
      {
         return this._2089742340advertisementContainer;
      }
      
      public function set advertisementContainer(param1:Box) : void
      {
         var _loc2_:Object = this._2089742340advertisementContainer;
         if(_loc2_ !== param1)
         {
            this._2089742340advertisementContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"advertisementContainer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get background() : FrontpageBackground
      {
         return this._1332194002background;
      }
      
      public function set background(param1:FrontpageBackground) : void
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
      public function get ceopLogo() : MSP_Image
      {
         return this._828233202ceopLogo;
      }
      
      public function set ceopLogo(param1:MSP_Image) : void
      {
         var _loc2_:Object = this._828233202ceopLogo;
         if(_loc2_ !== param1)
         {
            this._828233202ceopLogo = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ceopLogo",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get countrySelector() : MSP_ComboBox2
      {
         return this._1630946923countrySelector;
      }
      
      public function set countrySelector(param1:MSP_ComboBox2) : void
      {
         var _loc2_:Object = this._1630946923countrySelector;
         if(_loc2_ !== param1)
         {
            this._1630946923countrySelector = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"countrySelector",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get countrySelector2() : MSP_ComboBox2
      {
         return this._980252989countrySelector2;
      }
      
      public function set countrySelector2(param1:MSP_ComboBox2) : void
      {
         var _loc2_:Object = this._980252989countrySelector2;
         if(_loc2_ !== param1)
         {
            this._980252989countrySelector2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"countrySelector2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get imgCN() : Image
      {
         return this._100318062imgCN;
      }
      
      public function set imgCN(param1:Image) : void
      {
         var _loc2_:Object = this._100318062imgCN;
         if(_loc2_ !== param1)
         {
            this._100318062imgCN = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"imgCN",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get loginBox() : LoginBox
      {
         return this._2022732194loginBox;
      }
      
      public function set loginBox(param1:LoginBox) : void
      {
         var _loc2_:Object = this._2022732194loginBox;
         if(_loc2_ !== param1)
         {
            this._2022732194loginBox = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"loginBox",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get movieCountLabel() : Label
      {
         return this._1075670645movieCountLabel;
      }
      
      public function set movieCountLabel(param1:Label) : void
      {
         var _loc2_:Object = this._1075670645movieCountLabel;
         if(_loc2_ !== param1)
         {
            this._1075670645movieCountLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"movieCountLabel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get shopLink() : LinkButton
      {
         return this._345533424shopLink;
      }
      
      public function set shopLink(param1:LinkButton) : void
      {
         var _loc2_:Object = this._345533424shopLink;
         if(_loc2_ !== param1)
         {
            this._345533424shopLink = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"shopLink",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get sidLogo() : MSP_Image
      {
         return this._2084495257sidLogo;
      }
      
      public function set sidLogo(param1:MSP_Image) : void
      {
         var _loc2_:Object = this._2084495257sidLogo;
         if(_loc2_ !== param1)
         {
            this._2084495257sidLogo = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sidLogo",_loc2_,param1));
            }
         }
      }
   }
}

