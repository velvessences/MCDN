package com.moviestarplanet.Components
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.media.valueobjects.Animation;
   import com.moviestarplanet.media.valueobjects.Background;
   import com.moviestarplanet.media.valueobjects.Music;
   import com.moviestarplanet.services.shopcontentservice.valueObjects.Tag;
   import com.moviestarplanet.services.spendingservice.TagAMFManager;
   import com.moviestarplanet.services.upload.AMFUploadService;
   import com.moviestarplanet.services.wrappers.ThemeManagerService;
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
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.TitleWindow;
   import mx.controls.Button;
   import mx.controls.CheckBox;
   import mx.controls.ComboBox;
   import mx.controls.Label;
   import mx.controls.TextInput;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.CloseEvent;
   import mx.events.FlexEvent;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import mx.styles.*;
   
   public class TreeBasedShopEditor extends TitleWindow
   {
      
      public static const E_ITEMSAVED:String = "E_ITEMSAVED";
      
      private var _206185977btnSave:Button;
      
      private var _631516241cb_isDeleted:CheckBox;
      
      private var _340822070cb_isNew:CheckBox;
      
      private var _340828851cb_isVIP:CheckBox;
      
      private var _612302036comboTag:ComboBox;
      
      private var _11526949comboTheme:ComboBox;
      
      private var _912637256lblStatus:Label;
      
      private var _1026763729txtDiscount:TextInput;
      
      private var _18811031txtFilename:TextInput;
      
      private var _878708453txtName:TextInput;
      
      private var _1565808264txtPriceDiamonds:TextInput;
      
      private var _1814772535txtPriceSC:TextInput;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":TitleWindow,
         "events":{
            "creationComplete":"___TreeBasedShopEditor_TitleWindow1_creationComplete",
            "close":"___TreeBasedShopEditor_TitleWindow1_close"
         },
         "stylesFactory":function():void
         {
            this.backgroundAlpha = 1;
         },
         "propertiesFactory":function():Object
         {
            return {
               "width":436,
               "height":340,
               "childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.color = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "text":"Name",
                                 "left":10,
                                 "top":9
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "left":10,
                                 "top":35,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function():void
                                    {
                                       this.color = 0;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"text":"Price SC"};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"txtPriceSC",
                                    "events":{"change":"__txtPriceSC_change"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {"width":70};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function():void
                                    {
                                       this.color = 0;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"text":"Price Diamonds"};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"txtPriceDiamonds",
                                    "events":{"change":"__txtPriceDiamonds_change"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {"width":70};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.color = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "text":"Sale",
                                 "left":10,
                                 "top":62
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.color = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "text":"Filename",
                                 "left":10,
                                 "top":87
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.color = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "text":"Is VIP",
                                 "left":10,
                                 "top":116
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.color = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "text":"Is deleted",
                                 "left":10,
                                 "top":139
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.color = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "text":"Is New",
                                 "left":10,
                                 "top":164
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.color = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "text":"Theme",
                                 "left":10,
                                 "top":192
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.color = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "text":"Tag",
                                 "left":10,
                                 "top":220
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"btnSave",
                           "events":{"click":"__btnSave_click"},
                           "stylesFactory":function():void
                           {
                              this.color = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "enabled":false,
                                 "label":"Save",
                                 "left":302,
                                 "bottom":8
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"txtName",
                           "events":{"change":"__txtName_change"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":290,
                                 "left":82,
                                 "top":8
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"txtDiscount",
                           "events":{"change":"__txtDiscount_change"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":290,
                                 "left":82,
                                 "top":61
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"txtFilename",
                           "stylesFactory":function():void
                           {
                              this.textDecoration = "underline";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":290,
                                 "left":82,
                                 "top":87,
                                 "editable":false
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "id":"lblStatus",
                           "stylesFactory":function():void
                           {
                              this.color = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":228,
                                 "left":66,
                                 "bottom":8
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":CheckBox,
                           "id":"cb_isVIP",
                           "events":{"change":"__cb_isVIP_change"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":80,
                                 "y":116
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":CheckBox,
                           "id":"cb_isDeleted",
                           "events":{"change":"__cb_isDeleted_change"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":80,
                                 "y":139
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":CheckBox,
                           "id":"cb_isNew",
                           "events":{"change":"__cb_isNew_change"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":80,
                                 "y":164
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":ComboBox,
                           "id":"comboTheme",
                           "events":{"change":"__comboTheme_change"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":198,
                                 "selectedIndex":0,
                                 "left":82,
                                 "top":190
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":ComboBox,
                           "id":"comboTag",
                           "events":{"change":"__comboTag_change"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":198,
                                 "selectedIndex":0,
                                 "left":82,
                                 "top":218
                              };
                           }
                        })]
                     };
                  }
               })]
            };
         }
      });
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _item:Object;
      
      private var _uploadServiceInst:AMFUploadService;
      
      public function TreeBasedShopEditor()
      {
         super();
         mx_internal::_document = this;
         this.width = 436;
         this.height = 340;
         this.showCloseButton = true;
         this.title = "Item Editor";
         this.addEventListener("creationComplete",this.___TreeBasedShopEditor_TitleWindow1_creationComplete);
         this.addEventListener("close",this.___TreeBasedShopEditor_TitleWindow1_close);
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
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function get item() : Object
      {
         return this._item;
      }
      
      public function set item(param1:Object) : void
      {
         this._item = param1;
         this.updateUI();
      }
      
      private function populateTags(param1:Array) : void
      {
         var _loc5_:Tag = null;
         var _loc6_:String = null;
         var _loc2_:Object = new Object();
         var _loc3_:int = 0;
         var _loc4_:Array = new Array();
         _loc4_.push({
            "label":"-- Select a Tag --",
            "data":-1
         });
         for each(_loc5_ in param1)
         {
            if(_loc2_[_loc5_.TagGroup] == null)
            {
               _loc2_[_loc5_.TagGroup] = _loc5_.TagGroup;
               _loc4_.push({
                  "label":"==" + _loc5_.TagGroup + "==",
                  "key":-1
               });
            }
            _loc6_ = MSPLocaleManagerWeb.getInstance().getString(_loc5_.TagName);
            if(_loc6_ == "null" || _loc6_ == "" || _loc6_.indexOf("#MISSING_LOCALE_") == 0)
            {
               _loc6_ = _loc5_.TagName;
            }
            _loc4_.push({
               "label":_loc6_,
               "data":_loc5_.TagId
            });
         }
         this.comboTag.dataProvider = _loc4_;
         _loc3_ = 0;
         while(_loc3_ < this.comboTag.dataProvider.length)
         {
            if(this._item.TagId == this.comboTag.dataProvider[_loc3_].data)
            {
               this.comboTag.selectedIndex = _loc3_;
               break;
            }
            _loc3_++;
         }
      }
      
      private function populateThemes(param1:ArrayCollection) : void
      {
         var _loc4_:String = null;
         var _loc2_:int = 0;
         var _loc3_:Array = new Array();
         _loc3_.push({
            "label":"-- no Theme --",
            "data":-1
         });
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc4_ = param1[_loc2_].Name + " (";
            if(param1[_loc2_].Type == 0)
            {
               _loc4_ += "Normal";
            }
            else if(param1[_loc2_].Type == 1)
            {
               _loc4_ += "Gift/VIP";
            }
            _loc4_ += ")";
            _loc3_.push({
               "label":_loc4_,
               "data":param1[_loc2_].ThemeID
            });
            _loc2_++;
         }
         this.comboTheme.dataProvider = _loc3_;
         if(this.item is Animation)
         {
            ThemeManagerService.RetrieveThemeID(0,this._item.AnimationId,this.setTheme);
         }
         else if(this.item is Background)
         {
            ThemeManagerService.RetrieveThemeID(1,this._item.BackgroundId,this.setTheme);
         }
      }
      
      private function setTheme(param1:int) : void
      {
         if(param1 == -1)
         {
            return;
         }
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.comboTheme.dataProvider.length)
         {
            if(param1 == this.comboTheme.dataProvider[_loc2_].data)
            {
               this.comboTheme.selectedIndex = _loc2_;
               break;
            }
            _loc2_++;
         }
      }
      
      private function updateUI() : void
      {
         if(!initialized)
         {
            return;
         }
         if(this.item == null)
         {
            return;
         }
         this.txtName.text = this.item.Name;
         this.txtPriceSC.text = this.item.Price.toString();
         this.txtPriceDiamonds.text = this.item.DiamondsPrice.toString();
         this.txtDiscount.text = this.item.Discount.toString();
         this.cb_isVIP.selected = this.item.Vip == 2;
         this.cb_isNew.selected = this.item.isNew == 2;
         this.cb_isDeleted.selected = this.item.Deleted == 1;
         this.btnSave.enabled = false;
         this.lblStatus.text = "";
         if(this.item is Animation)
         {
            this.txtFilename.text = this.item.FrameLabel;
         }
         else if(this.item is Background)
         {
            this.txtFilename.text = this.item.url;
         }
         ThemeManagerService.GetAllThemes(this.populateThemes);
         if(this.item is Background)
         {
            TagAMFManager.getBackgroundTags(this.populateTags);
         }
         else
         {
            this.comboTag.visible = false;
         }
      }
      
      private function close() : void
      {
         PopUpManager.removePopUp(this);
      }
      
      private function onChange() : void
      {
         this.btnSave.enabled = true;
      }
      
      private function onChangeDiamonds() : void
      {
         this.onChange();
         this.txtPriceSC.text = "0";
      }
      
      private function onChangeSC() : void
      {
         this.onChange();
         this.txtPriceDiamonds.text = "0";
      }
      
      private function onSaveClick() : void
      {
         var done:Function;
         var price:Number = NaN;
         var discount:Number = NaN;
         var animation:Animation = null;
         var music:Music = null;
         var background:Background = null;
         this.txtPriceSC.errorString = null;
         this.txtPriceDiamonds.errorString = null;
         this.btnSave.enabled = false;
         if(this.item != null)
         {
            done = function():void
            {
               lblStatus.text = "Saved";
               dispatchEvent(new Event(E_ITEMSAVED));
               MessageCommunicator.sendMessage(MSPEvent.RELOAD_TREEBASED_SHOP,null);
            };
            this.lblStatus.text = "Saving...";
            this.item.Name = this.txtName.text;
            price = Number(parseInt(this.txtPriceSC.text));
            if(isNaN(price))
            {
               this.txtPriceSC.errorString = "Not a number";
               return;
            }
            this.item.Price = price;
            price = Number(parseInt(this.txtPriceDiamonds.text));
            if(isNaN(price))
            {
               this.txtPriceDiamonds.errorString = "Not a number";
               return;
            }
            this.item.DiamondsPrice = price;
            discount = Number(parseInt(this.txtDiscount.text));
            if(isNaN(discount))
            {
               this.txtDiscount.errorString = "Not a number";
               return;
            }
            this.item.Discount = discount;
            this.item.Vip = this.cb_isVIP.selected ? 2 : 0;
            this.item.isNew = this.cb_isNew.selected ? 2 : 0;
            this.item.Deleted = this.cb_isDeleted.selected ? 1 : 0;
            animation = this.item as Animation;
            music = this.item as Music;
            background = this.item as Background;
            if(animation != null)
            {
               this.uploadServiceInst.updateAnimation(animation,this.comboTheme.selectedItem.data,done);
            }
            if(background != null)
            {
               if(this.comboTag.selectedItem.data == -1)
               {
                  this.lblStatus.text = "Must select a tag";
                  return;
               }
               background.TagId = this.comboTag.selectedItem.data;
               this.uploadServiceInst.updateBackground(background,this.comboTheme.selectedItem.data,done);
            }
            if(music != null)
            {
               this.uploadServiceInst.updateMusic(music,done);
            }
         }
      }
      
      private function get uploadServiceInst() : AMFUploadService
      {
         if(this._uploadServiceInst == null)
         {
            this._uploadServiceInst = new AMFUploadService();
         }
         return this._uploadServiceInst;
      }
      
      public function ___TreeBasedShopEditor_TitleWindow1_creationComplete(param1:FlexEvent) : void
      {
         this.updateUI();
      }
      
      public function ___TreeBasedShopEditor_TitleWindow1_close(param1:CloseEvent) : void
      {
         this.close();
      }
      
      public function __txtPriceSC_change(param1:Event) : void
      {
         this.onChangeSC();
      }
      
      public function __txtPriceDiamonds_change(param1:Event) : void
      {
         this.onChangeDiamonds();
      }
      
      public function __btnSave_click(param1:MouseEvent) : void
      {
         this.onSaveClick();
      }
      
      public function __txtName_change(param1:Event) : void
      {
         this.onChange();
      }
      
      public function __txtDiscount_change(param1:Event) : void
      {
         this.onChange();
      }
      
      public function __cb_isVIP_change(param1:Event) : void
      {
         this.onChange();
      }
      
      public function __cb_isDeleted_change(param1:Event) : void
      {
         this.onChange();
      }
      
      public function __cb_isNew_change(param1:Event) : void
      {
         this.onChange();
      }
      
      public function __comboTheme_change(param1:ListEvent) : void
      {
         this.onChange();
      }
      
      public function __comboTag_change(param1:ListEvent) : void
      {
         this.onChange();
      }
      
      [Bindable(event="propertyChange")]
      public function get btnSave() : Button
      {
         return this._206185977btnSave;
      }
      
      public function set btnSave(param1:Button) : void
      {
         var _loc2_:Object = this._206185977btnSave;
         if(_loc2_ !== param1)
         {
            this._206185977btnSave = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnSave",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cb_isDeleted() : CheckBox
      {
         return this._631516241cb_isDeleted;
      }
      
      public function set cb_isDeleted(param1:CheckBox) : void
      {
         var _loc2_:Object = this._631516241cb_isDeleted;
         if(_loc2_ !== param1)
         {
            this._631516241cb_isDeleted = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cb_isDeleted",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cb_isNew() : CheckBox
      {
         return this._340822070cb_isNew;
      }
      
      public function set cb_isNew(param1:CheckBox) : void
      {
         var _loc2_:Object = this._340822070cb_isNew;
         if(_loc2_ !== param1)
         {
            this._340822070cb_isNew = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cb_isNew",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cb_isVIP() : CheckBox
      {
         return this._340828851cb_isVIP;
      }
      
      public function set cb_isVIP(param1:CheckBox) : void
      {
         var _loc2_:Object = this._340828851cb_isVIP;
         if(_loc2_ !== param1)
         {
            this._340828851cb_isVIP = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cb_isVIP",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get comboTag() : ComboBox
      {
         return this._612302036comboTag;
      }
      
      public function set comboTag(param1:ComboBox) : void
      {
         var _loc2_:Object = this._612302036comboTag;
         if(_loc2_ !== param1)
         {
            this._612302036comboTag = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"comboTag",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get comboTheme() : ComboBox
      {
         return this._11526949comboTheme;
      }
      
      public function set comboTheme(param1:ComboBox) : void
      {
         var _loc2_:Object = this._11526949comboTheme;
         if(_loc2_ !== param1)
         {
            this._11526949comboTheme = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"comboTheme",_loc2_,param1));
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
      public function get txtDiscount() : TextInput
      {
         return this._1026763729txtDiscount;
      }
      
      public function set txtDiscount(param1:TextInput) : void
      {
         var _loc2_:Object = this._1026763729txtDiscount;
         if(_loc2_ !== param1)
         {
            this._1026763729txtDiscount = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtDiscount",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtFilename() : TextInput
      {
         return this._18811031txtFilename;
      }
      
      public function set txtFilename(param1:TextInput) : void
      {
         var _loc2_:Object = this._18811031txtFilename;
         if(_loc2_ !== param1)
         {
            this._18811031txtFilename = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtFilename",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtName() : TextInput
      {
         return this._878708453txtName;
      }
      
      public function set txtName(param1:TextInput) : void
      {
         var _loc2_:Object = this._878708453txtName;
         if(_loc2_ !== param1)
         {
            this._878708453txtName = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtName",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtPriceDiamonds() : TextInput
      {
         return this._1565808264txtPriceDiamonds;
      }
      
      public function set txtPriceDiamonds(param1:TextInput) : void
      {
         var _loc2_:Object = this._1565808264txtPriceDiamonds;
         if(_loc2_ !== param1)
         {
            this._1565808264txtPriceDiamonds = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtPriceDiamonds",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtPriceSC() : TextInput
      {
         return this._1814772535txtPriceSC;
      }
      
      public function set txtPriceSC(param1:TextInput) : void
      {
         var _loc2_:Object = this._1814772535txtPriceSC;
         if(_loc2_ !== param1)
         {
            this._1814772535txtPriceSC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtPriceSC",_loc2_,param1));
            }
         }
      }
   }
}

