package com.moviestarplanet.Components.postcard
{
   import com.moviestarplanet.Components.CloseButton;
   import com.moviestarplanet.Components.GradientCanvas;
   import com.moviestarplanet.Components.TitleBar;
   import com.moviestarplanet.Components.popup.PrivacyPolicy;
   import com.moviestarplanet.configurations.PrivacyPolicyConfig;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.services.commonservice.CommonAmfWebService;
   import com.moviestarplanet.utils.Utils;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.window.loading.LoadingProgressBarAS;
   import com.moviestarplanet.window.stack.WindowStack;
   import com.moviestarplanet.window.stack.WindowStackableInterface;
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
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.Text;
   import mx.controls.TextInput;
   import mx.core.IFlexModuleFactory;
   import mx.core.IToolTip;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.ToolTipManager;
   import mx.styles.*;
   import mx.utils.Base64Encoder;
   
   use namespace mx_internal;
   
   public class SendContentAsMailPopup extends GradientCanvas implements WindowStackableInterface, IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      private static var emailRegEx:RegExp = /^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
      
      public var _SendContentAsMailPopup_Label1:Label;
      
      private var _206189572btnSend:Button;
      
      private var _912637256lblStatus:Label;
      
      private var _801230270lblTitle:TitleBar;
      
      private var _1593303116policyLink:Text;
      
      private var _1131509414progressBar:LoadingProgressBarAS;
      
      private var _1472440162txt_UserEmail:TextInput;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _contentId:Number;
      
      private var _contentType:Number;
      
      private var _contentName:String;
      
      private var emailErrorTip:IToolTip = null;
      
      private var nameErrorTip:IToolTip = null;
      
      private var friendNameErrorTip:IToolTip = null;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function SendContentAsMailPopup()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":GradientCanvas,
            "events":{"creationComplete":"___SendContentAsMailPopup_GradientCanvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {
                  "width":614,
                  "height":232,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":TitleBar,
                     "id":"lblTitle",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "top":0,
                           "left":0,
                           "right":0
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":CloseButton,
                     "events":{"click":"___SendContentAsMailPopup_CloseButton1_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "right":10,
                           "top":5
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":TextInput,
                     "id":"txt_UserEmail",
                     "events":{"change":"__txt_UserEmail_change"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "top":110,
                           "left":171.5,
                           "right":13.5
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"_SendContentAsMailPopup_Label1",
                     "stylesFactory":function():void
                     {
                        this.color = 16777215;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "top":111,
                           "left":10
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"btnSend",
                     "events":{"click":"__btnSend_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":70,
                           "top":200,
                           "right":13.5
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":LoadingProgressBarAS,
                     "id":"progressBar",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "height":40,
                           "visible":false,
                           "width":585,
                           "bottom":10,
                           "left":10,
                           "fontSize":14
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"lblStatus",
                     "stylesFactory":function():void
                     {
                        this.fontSize = 14;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "bottom":10,
                           "height":20,
                           "horizontalCenter":0
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Text,
                     "id":"policyLink",
                     "events":{"click":"__policyLink_click"},
                     "stylesFactory":function():void
                     {
                        this.color = 15658734;
                        this.textDecoration = "underline";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "useHandCursor":true,
                           "mouseChildren":false,
                           "buttonMode":true,
                           "left":10,
                           "bottom":20
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
         bindings = this._SendContentAsMailPopup_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_com_moviestarplanet_Components_postcard_SendContentAsMailPopupWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return SendContentAsMailPopup[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.width = 614;
         this.height = 232;
         this.styleName = "blackOverlay";
         this.addEventListener("creationComplete",this.___SendContentAsMailPopup_GradientCanvas1_creationComplete);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         SendContentAsMailPopup._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function set contentId(param1:Number) : void
      {
         this._contentId = param1;
      }
      
      public function set contentType(param1:Number) : void
      {
         this._contentType = param1;
      }
      
      public function set contentName(param1:String) : void
      {
         this._contentName = param1;
      }
      
      private function onCreationComplete() : void
      {
         switch(this._contentType)
         {
            case 7:
               this.lblTitle.label = MSPLocaleManagerWeb.getInstance().getString("SENDCONTENT_SEND_ARTBOOK_EMAIL");
               break;
            default:
               this.lblTitle.label = "contentType not supported";
         }
      }
      
      private function destroyToolTips() : void
      {
         if(this.emailErrorTip != null)
         {
            ToolTipManager.destroyToolTip(this.emailErrorTip);
            this.emailErrorTip = null;
         }
      }
      
      private function sendClicked() : void
      {
         var matchResult:Array;
         var encoder:Base64Encoder;
         var paramUrl:String = null;
         var done:Function = null;
         done = function():void
         {
            progressBar.visible = false;
            lblStatus.visible = true;
            txt_UserEmail.text = "";
            btnSend.enabled = true;
         };
         if(this.btnSend.enabled == false)
         {
            return;
         }
         this.btnSend.enabled = false;
         this.destroyToolTips();
         matchResult = this.txt_UserEmail.text.match(emailRegEx);
         if(matchResult == null || matchResult.length == 0)
         {
            this.emailErrorTip = Utils.ShowErrorTip(this.txt_UserEmail,MSPLocaleManagerWeb.getInstance().getString("SEND_MM_EMAIL_ERROR_TT"));
            this.btnSend.enabled = true;
            return;
         }
         paramUrl = "viewContentType=" + this._contentType + ";viewContentId=" + this._contentId;
         encoder = new Base64Encoder();
         encoder.insertNewLines = false;
         encoder.encode(paramUrl);
         CommonAmfWebService.sendContentEmail(this.txt_UserEmail.text,ActorSession.loggedInActor.Name,this._contentType,this._contentId,encoder.toString(),done);
         this.progressBar.visible = true;
         this.lblStatus.visible = false;
      }
      
      private function close() : void
      {
         this.destroyToolTips();
         WindowStack.removeViewStackable(this);
      }
      
      private function onChange() : void
      {
         this.destroyToolTips();
      }
      
      public function ___SendContentAsMailPopup_GradientCanvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      public function ___SendContentAsMailPopup_CloseButton1_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      public function __txt_UserEmail_change(param1:Event) : void
      {
         this.onChange();
      }
      
      public function __btnSend_click(param1:MouseEvent) : void
      {
         this.sendClicked();
      }
      
      public function __policyLink_click(param1:MouseEvent) : void
      {
         PrivacyPolicy.show();
      }
      
      private function _SendContentAsMailPopup_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("SEND_MOVIE_AS_MAIL");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"lblTitle.label");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("FRIENDS_EMAIL");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SendContentAsMailPopup_Label1.text");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("SEND");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnSend.label");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("SENDING_MAIL");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"progressBar.label");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("SENDCONTENT_EMAIL_SENT");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"lblStatus.text");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("PRIVACY_POLICY");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"policyLink.text");
         result[6] = new Binding(this,function():Boolean
         {
            return PrivacyPolicyConfig.shouldShowPrivacyPolicy();
         },null,"policyLink.visible");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnSend() : Button
      {
         return this._206189572btnSend;
      }
      
      public function set btnSend(param1:Button) : void
      {
         var _loc2_:Object = this._206189572btnSend;
         if(_loc2_ !== param1)
         {
            this._206189572btnSend = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnSend",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lblStatus() : Label
      {
         return this._912637256lblStatus;
      }
      
      public function set lblStatus(param1:Label) : void
      {
         var _loc2_:Object = this._912637256lblStatus;
         if(_loc2_ !== param1)
         {
            this._912637256lblStatus = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lblStatus",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lblTitle() : TitleBar
      {
         return this._801230270lblTitle;
      }
      
      public function set lblTitle(param1:TitleBar) : void
      {
         var _loc2_:Object = this._801230270lblTitle;
         if(_loc2_ !== param1)
         {
            this._801230270lblTitle = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lblTitle",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get policyLink() : Text
      {
         return this._1593303116policyLink;
      }
      
      public function set policyLink(param1:Text) : void
      {
         var _loc2_:Object = this._1593303116policyLink;
         if(_loc2_ !== param1)
         {
            this._1593303116policyLink = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"policyLink",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get progressBar() : LoadingProgressBarAS
      {
         return this._1131509414progressBar;
      }
      
      public function set progressBar(param1:LoadingProgressBarAS) : void
      {
         var _loc2_:Object = this._1131509414progressBar;
         if(_loc2_ !== param1)
         {
            this._1131509414progressBar = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"progressBar",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txt_UserEmail() : TextInput
      {
         return this._1472440162txt_UserEmail;
      }
      
      public function set txt_UserEmail(param1:TextInput) : void
      {
         var _loc2_:Object = this._1472440162txt_UserEmail;
         if(_loc2_ !== param1)
         {
            this._1472440162txt_UserEmail = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txt_UserEmail",_loc2_,param1));
            }
         }
      }
   }
}

