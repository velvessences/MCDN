package com.moviestarplanet.Forms
{
   import com.moviestarplanet.Components.CloseButton;
   import com.moviestarplanet.Components.GradientCanvas;
   import com.moviestarplanet.admin.valueobjects.Report;
   import com.moviestarplanet.chatCommunicator.chatHelpers.configuration.InputLocations;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.services.actorservice.ActorService;
   import com.moviestarplanet.userbehavior.utils.ReportAbuseUtils;
   import com.moviestarplanet.userbehavior.utils.chatfilter.userbehaviorcontrol.UserBehaviorControl;
   import com.moviestarplanet.utils.AbuseCategory;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.window.stack.WindowStack;
   import com.moviestarplanet.window.stack.WindowStackableInterface;
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
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.RadioButton;
   import mx.controls.RadioButtonGroup;
   import mx.controls.TextArea;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class NewReport extends GradientCanvas implements WindowStackableInterface, IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      public var _NewReport_Label1:Label;
      
      public var _NewReport_RadioButton1:RadioButton;
      
      public var _NewReport_RadioButton2:RadioButton;
      
      public var _NewReport_RadioButton3:RadioButton;
      
      public var _NewReport_RadioButton4:RadioButton;
      
      public var _NewReport_RadioButton5:RadioButton;
      
      public var _NewReport_RadioButton6:RadioButton;
      
      public var _NewReport_RadioButton7:RadioButton;
      
      public var _NewReport_RadioButton8:RadioButton;
      
      public var _NewReport_RadioButton9:RadioButton;
      
      private var _1990131276cancelButton:Button;
      
      private var _954925063message:TextArea;
      
      private var _915226267reasonGroup:RadioButtonGroup;
      
      private var _713510sendButton:Button;
      
      private var _115837283subheadline1:Label;
      
      private var _115837282subheadline2:Label;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public var reportedActorId:Number;
      
      public var entityId:int = 0;
      
      public var entityType:int = 0;
      
      public var isEntity:Boolean;
      
      public var nameOrTitle:String;
      
      mx_internal var _NewReport_StylesInit_done:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function NewReport()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":GradientCanvas,
            "events":{"creationComplete":"___NewReport_GradientCanvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {
                  "width":646,
                  "height":332,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":CloseButton,
                     "events":{"click":"___NewReport_CloseButton1_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "right":10,
                           "top":10
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"_NewReport_Label1",
                     "stylesFactory":function():void
                     {
                        this.color = 16777215;
                        this.fontSize = 18;
                        this.fontWeight = "bold";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":30,
                           "y":21,
                           "width":488
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"subheadline1",
                     "stylesFactory":function():void
                     {
                        this.color = 16777215;
                        this.fontSize = 12;
                        this.fontWeight = "bold";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":30,
                           "y":56,
                           "width":602
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"subheadline2",
                     "stylesFactory":function():void
                     {
                        this.color = 16777215;
                        this.fontSize = 12;
                        this.fontWeight = "bold";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":30,
                           "y":171,
                           "width":602
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":HBox,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":30,
                           "y":79,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":VBox,
                              "propertiesFactory":function():Object
                              {
                                 return {"childDescriptors":[new UIComponentDescriptor({
                                    "type":RadioButton,
                                    "id":"_NewReport_RadioButton1",
                                    "events":{"click":"___NewReport_RadioButton1_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "groupName":"reasonGroup",
                                          "styleName":"radioColors"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":RadioButton,
                                    "id":"_NewReport_RadioButton2",
                                    "events":{"click":"___NewReport_RadioButton2_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "groupName":"reasonGroup",
                                          "styleName":"radioColors"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":RadioButton,
                                    "id":"_NewReport_RadioButton3",
                                    "events":{"click":"___NewReport_RadioButton3_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "groupName":"reasonGroup",
                                          "styleName":"radioColors"
                                       };
                                    }
                                 })]};
                              }
                           }),new UIComponentDescriptor({
                              "type":VBox,
                              "propertiesFactory":function():Object
                              {
                                 return {"childDescriptors":[new UIComponentDescriptor({
                                    "type":RadioButton,
                                    "id":"_NewReport_RadioButton4",
                                    "events":{"click":"___NewReport_RadioButton4_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "groupName":"reasonGroup",
                                          "styleName":"radioColors"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":RadioButton,
                                    "id":"_NewReport_RadioButton5",
                                    "events":{"click":"___NewReport_RadioButton5_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "groupName":"reasonGroup",
                                          "styleName":"radioColors"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":RadioButton,
                                    "id":"_NewReport_RadioButton6",
                                    "events":{"click":"___NewReport_RadioButton6_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "groupName":"reasonGroup",
                                          "styleName":"radioColors"
                                       };
                                    }
                                 })]};
                              }
                           }),new UIComponentDescriptor({
                              "type":VBox,
                              "propertiesFactory":function():Object
                              {
                                 return {"childDescriptors":[new UIComponentDescriptor({
                                    "type":RadioButton,
                                    "id":"_NewReport_RadioButton7",
                                    "events":{"click":"___NewReport_RadioButton7_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "groupName":"reasonGroup",
                                          "styleName":"radioColors"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":RadioButton,
                                    "id":"_NewReport_RadioButton8",
                                    "events":{"click":"___NewReport_RadioButton8_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "groupName":"reasonGroup",
                                          "styleName":"radioColors"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":RadioButton,
                                    "id":"_NewReport_RadioButton9",
                                    "events":{"click":"___NewReport_RadioButton9_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "groupName":"reasonGroup",
                                          "styleName":"radioColors"
                                       };
                                    }
                                 })]};
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":TextArea,
                     "id":"message",
                     "events":{
                        "keyUp":"__message_keyUp",
                        "change":"__message_change"
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":30,
                           "y":193,
                           "width":585,
                           "height":85,
                           "maxChars":100
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"cancelButton",
                     "events":{"click":"__cancelButton_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":487,
                           "y":287,
                           "width":128
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"sendButton",
                     "events":{"click":"__sendButton_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":340,
                           "y":287,
                           "enabled":false,
                           "width":139
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
         bindings = this._NewReport_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_com_moviestarplanet_Forms_NewReportWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return NewReport[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.width = 646;
         this.height = 332;
         this.styleName = "blackOverlay";
         this._NewReport_RadioButtonGroup1_i();
         this.addEventListener("creationComplete",this.___NewReport_GradientCanvas1_creationComplete);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         NewReport._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         mx_internal::_NewReport_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function onCreationComplete() : void
      {
         this.message.setFocus();
         this.subheadline1.text = this.nameOrTitle == null ? MSPLocaleManagerWeb.getInstance().getString("REASON_FOR_REPORTING") : MSPLocaleManagerWeb.getInstance().getString("REASON_FOR_REPORTING_NAME",[this.nameOrTitle]);
         this.subheadline2.text = this.isEntity ? MSPLocaleManagerWeb.getInstance().getString("EXPLAIN_REPORT_CONTENT") : MSPLocaleManagerWeb.getInstance().getString("EXPLAIN_REPORT_USER");
      }
      
      private function sendReport() : void
      {
         this.sendButton.enabled = false;
         if(ActorSession.getActorId() == this.reportedActorId && this.entityType != InputLocations.LOC_YOUTUBE)
         {
            return;
         }
         var _loc1_:Report = new Report();
         _loc1_.ReportId = 0;
         _loc1_.ComplainerActorId = ActorSession.getActorId();
         _loc1_.ReportedActorId = this.reportedActorId;
         _loc1_.Comment = this.message.text;
         _loc1_.EntityId = this.entityId;
         _loc1_.EntityType = this.entityType;
         _loc1_.HandledByActorId = 0;
         _loc1_.HandledStatus = 0;
         _loc1_.CategoryId = int(this.reasonGroup.selectedValue);
         ActorService.NewReport(_loc1_,this.reportSend);
         UserBehaviorControl.getInstance().reportAbuse(_loc1_.ComplainerActorId,_loc1_.ReportedActorId,ReportAbuseUtils.getCategoryString(_loc1_.CategoryId),_loc1_.Comment);
      }
      
      private function messageChange() : void
      {
         if(this.message.text.length > 600)
         {
            this.message.text = this.message.text.substring(0,600);
         }
         this.keyUp();
      }
      
      private function keyUp() : void
      {
         if(this.message.text.length > 0 && this.reasonGroup.selectedValue != null)
         {
            this.sendButton.enabled = true;
         }
         else
         {
            this.sendButton.enabled = false;
         }
      }
      
      public function reportSend(param1:Event = null) : void
      {
         Prompt.show(MSPLocaleManagerWeb.getInstance().getString("REPORT_SENT_AND"),MSPLocaleManagerWeb.getInstance().getString("REPORT_SENT"),4,null,this.exit);
      }
      
      public function exit(param1:Event = null) : void
      {
         WindowStack.removeViewStackable(this);
      }
      
      private function _NewReport_RadioButtonGroup1_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         _loc1_.initialized(this,"reasonGroup");
         this.reasonGroup = _loc1_;
         BindingManager.executeBindings(this,"reasonGroup",this.reasonGroup);
         return _loc1_;
      }
      
      public function ___NewReport_GradientCanvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      public function ___NewReport_CloseButton1_click(param1:MouseEvent) : void
      {
         this.exit();
      }
      
      public function ___NewReport_RadioButton1_click(param1:MouseEvent) : void
      {
         this.keyUp();
      }
      
      public function ___NewReport_RadioButton2_click(param1:MouseEvent) : void
      {
         this.keyUp();
      }
      
      public function ___NewReport_RadioButton3_click(param1:MouseEvent) : void
      {
         this.keyUp();
      }
      
      public function ___NewReport_RadioButton4_click(param1:MouseEvent) : void
      {
         this.keyUp();
      }
      
      public function ___NewReport_RadioButton5_click(param1:MouseEvent) : void
      {
         this.keyUp();
      }
      
      public function ___NewReport_RadioButton6_click(param1:MouseEvent) : void
      {
         this.keyUp();
      }
      
      public function ___NewReport_RadioButton7_click(param1:MouseEvent) : void
      {
         this.keyUp();
      }
      
      public function ___NewReport_RadioButton8_click(param1:MouseEvent) : void
      {
         this.keyUp();
      }
      
      public function ___NewReport_RadioButton9_click(param1:MouseEvent) : void
      {
         this.keyUp();
      }
      
      public function __message_keyUp(param1:KeyboardEvent) : void
      {
         this.keyUp();
      }
      
      public function __message_change(param1:Event) : void
      {
         this.messageChange();
      }
      
      public function __cancelButton_click(param1:MouseEvent) : void
      {
         this.exit();
      }
      
      public function __sendButton_click(param1:MouseEvent) : void
      {
         this.sendReport();
      }
      
      private function _NewReport_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("REPORT_BAD");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_NewReport_Label1.text");
         result[1] = new Binding(this,function():Object
         {
            return AbuseCategory.ABUSE_CATEGORY_LANGUAGE;
         },null,"_NewReport_RadioButton1.value");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("ABUSE_CATEGORY_LANGUAGE");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_NewReport_RadioButton1.label");
         result[3] = new Binding(this,function():Object
         {
            return AbuseCategory.ABUSE_CATEGORY_SEXUAL;
         },null,"_NewReport_RadioButton2.value");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("ABUSE_CATEGORY_SEXUAL");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_NewReport_RadioButton2.label");
         result[5] = new Binding(this,function():Object
         {
            return AbuseCategory.ABUSE_CATEGORY_THREATS;
         },null,"_NewReport_RadioButton3.value");
         result[6] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("ABUSE_CATEGORY_THREATS");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_NewReport_RadioButton3.label");
         result[7] = new Binding(this,function():Object
         {
            return AbuseCategory.ABUSE_CATEGORY_PASSWORD;
         },null,"_NewReport_RadioButton4.value");
         result[8] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("ABUSE_CATEGORY_PASSWORD");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_NewReport_RadioButton4.label");
         result[9] = new Binding(this,function():Object
         {
            return AbuseCategory.ABUSE_CATEGORY_CHAINLETTERS;
         },null,"_NewReport_RadioButton5.value");
         result[10] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("ABUSE_CATEGORY_CHAINLETTERS");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_NewReport_RadioButton5.label");
         result[11] = new Binding(this,function():Object
         {
            return AbuseCategory.ABUSE_CATEGORY_CHEATS;
         },null,"_NewReport_RadioButton6.value");
         result[12] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("ABUSE_CATEGORY_CHEATS");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_NewReport_RadioButton6.label");
         result[13] = new Binding(this,function():Object
         {
            return AbuseCategory.ABUSE_CATEGORY_PERSONALINFO;
         },null,"_NewReport_RadioButton7.value");
         result[14] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("ABUSE_CATEGORY_PERSONALINFO");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_NewReport_RadioButton7.label");
         result[15] = new Binding(this,function():Object
         {
            return AbuseCategory.ABUSE_CATEGORY_IMPERSONATE;
         },null,"_NewReport_RadioButton8.value");
         result[16] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("ABUSE_CATEGORY_IMPERSONATE");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_NewReport_RadioButton8.label");
         result[17] = new Binding(this,function():Object
         {
            return AbuseCategory.ABUSE_CATEGORY_OTHER;
         },null,"_NewReport_RadioButton9.value");
         result[18] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("ABUSE_CATEGORY_OTHER");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_NewReport_RadioButton9.label");
         result[19] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("CANCEL");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"cancelButton.label");
         result[20] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("SEND_REPORT");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"sendButton.label");
         return result;
      }
      
      mx_internal function _NewReport_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         var conditions:Array = null;
         var condition:CSSCondition = null;
         var selector:CSSSelector = null;
         if(mx_internal::_NewReport_StylesInit_done)
         {
            return;
         }
         mx_internal::_NewReport_StylesInit_done = true;
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","radioColors");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         style = styleManager.getStyleDeclaration(".radioColors");
         if(!style)
         {
            style = new CSSStyleDeclaration(selector,styleManager);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.textSelectedColor = 8947848;
               this.textRollOverColor = 11184810;
            };
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cancelButton() : Button
      {
         return this._1990131276cancelButton;
      }
      
      public function set cancelButton(param1:Button) : void
      {
         var _loc2_:Object = this._1990131276cancelButton;
         if(_loc2_ !== param1)
         {
            this._1990131276cancelButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cancelButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get message() : TextArea
      {
         return this._954925063message;
      }
      
      public function set message(param1:TextArea) : void
      {
         var _loc2_:Object = this._954925063message;
         if(_loc2_ !== param1)
         {
            this._954925063message = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"message",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get reasonGroup() : RadioButtonGroup
      {
         return this._915226267reasonGroup;
      }
      
      public function set reasonGroup(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = this._915226267reasonGroup;
         if(_loc2_ !== param1)
         {
            this._915226267reasonGroup = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"reasonGroup",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get sendButton() : Button
      {
         return this._713510sendButton;
      }
      
      public function set sendButton(param1:Button) : void
      {
         var _loc2_:Object = this._713510sendButton;
         if(_loc2_ !== param1)
         {
            this._713510sendButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sendButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get subheadline1() : Label
      {
         return this._115837283subheadline1;
      }
      
      public function set subheadline1(param1:Label) : void
      {
         var _loc2_:Object = this._115837283subheadline1;
         if(_loc2_ !== param1)
         {
            this._115837283subheadline1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"subheadline1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get subheadline2() : Label
      {
         return this._115837282subheadline2;
      }
      
      public function set subheadline2(param1:Label) : void
      {
         var _loc2_:Object = this._115837282subheadline2;
         if(_loc2_ !== param1)
         {
            this._115837282subheadline2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"subheadline2",_loc2_,param1));
            }
         }
      }
   }
}

