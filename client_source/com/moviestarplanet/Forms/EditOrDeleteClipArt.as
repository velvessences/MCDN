package com.moviestarplanet.Forms
{
   import com.moviestarplanet.Components.CloseButton;
   import com.moviestarplanet.Components.GradientCanvas;
   import com.moviestarplanet.Components.TitleBar;
   import com.moviestarplanet.Forms.upload.FileUploader;
   import com.moviestarplanet.scrapitems.valueobjects.ClipArt;
   import com.moviestarplanet.scrapitems.valueobjects.ClipArtCategory;
   import com.moviestarplanet.services.upload.AMFUploadService;
   import com.moviestarplanet.utils.DateUtils;
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
   import mx.controls.Alert;
   import mx.controls.Button;
   import mx.controls.CheckBox;
   import mx.controls.HRule;
   import mx.controls.Label;
   import mx.controls.SWFLoader;
   import mx.controls.Text;
   import mx.controls.TextInput;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.CloseEvent;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.CursorManager;
   import mx.styles.*;
   
   public class EditOrDeleteClipArt extends GradientCanvas
   {
      
      private var _105044998btnBrowse:Button;
      
      private var _150190887btnDelete:Button;
      
      private var _206185977btnSave:Button;
      
      private var _812176233cbox_new:CheckBox;
      
      private var _812184038cbox_vip:CheckBox;
      
      private var _1480344859currentlabel:Text;
      
      private var _1067352181diamondPriceInput:TextInput;
      
      private var _1388763476newlabel:Text;
      
      private var _1483662335priceInput:TextInput;
      
      private var _879765950statuslabel:Label;
      
      private var _1337002167swfcurrent:SWFLoader;
      
      private var _889568290swfnew:SWFLoader;
      
      private var _1870028133titleBar:TitleBar;
      
      private var _1453919731txt_sort:TextInput;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":GradientCanvas,
         "events":{"creationComplete":"___EditOrDeleteClipArt_GradientCanvas1_creationComplete"},
         "propertiesFactory":function():Object
         {
            return {
               "width":600,
               "height":550,
               "childDescriptors":[new UIComponentDescriptor({
                  "type":TitleBar,
                  "id":"titleBar",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Edit ClipArt",
                        "top":0,
                        "left":0,
                        "right":0
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":CloseButton,
                  "events":{"click":"___EditOrDeleteClipArt_CloseButton1_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "right":10,
                        "top":5
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "id":"btnDelete",
                  "events":{"click":"__btnDelete_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Delete ClipArt",
                        "top":509,
                        "left":247,
                        "visible":true
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "id":"btnBrowse",
                  "events":{"click":"__btnBrowse_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Browse For Replacement File",
                        "top":109,
                        "left":24
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Label,
                  "stylesFactory":function():void
                  {
                     this.fontSize = 15;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "text":"Replace SWF of ClipArt",
                        "x":24,
                        "y":47
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Text,
                  "id":"currentlabel",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "text":"Current SWF",
                        "right":22,
                        "top":38
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":SWFLoader,
                  "id":"swfcurrent",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "height":150,
                        "width":150,
                        "x":428,
                        "y":55
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":SWFLoader,
                  "id":"swfnew",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "height":150,
                        "width":150,
                        "x":428,
                        "y":240
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Text,
                  "id":"newlabel",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "text":"New SWF",
                        "right":22,
                        "top":223,
                        "visible":false
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":HRule,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "y":433,
                        "x":24,
                        "width":554,
                        "height":16
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Label,
                  "stylesFactory":function():void
                  {
                     this.fontSize = 15;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "text":"Delete ClipArt",
                        "x":24,
                        "y":460
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Label,
                  "id":"statuslabel",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "y":135,
                        "x":26
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":TextInput,
                  "id":"txt_sort",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "y":175,
                        "x":28,
                        "width":50
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Label,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "text":"Sort order",
                        "y":177,
                        "x":86
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Label,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "top":205,
                        "left":30,
                        "text":"Price:"
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":TextInput,
                  "id":"priceInput",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "top":205,
                        "right":300
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Label,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "top":235,
                        "left":30,
                        "text":"DiamondPrice:"
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":TextInput,
                  "id":"diamondPriceInput",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "top":235,
                        "right":300
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":CheckBox,
                  "id":"cbox_vip",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"VIP",
                        "y":265,
                        "x":28
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":CheckBox,
                  "id":"cbox_new",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"New",
                        "y":283,
                        "x":28
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "id":"btnSave",
                  "events":{"click":"__btnSave_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Save",
                        "top":329,
                        "right":518,
                        "width":54
                     };
                  }
               })]
            };
         }
      });
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public var clipArtToEditOrDelete:ClipArt;
      
      private var subpath:String;
      
      private var fileselected:Boolean = false;
      
      private var _fileReference:FileReference;
      
      private var _uploadService:AMFUploadService;
      
      public function EditOrDeleteClipArt()
      {
         super();
         mx_internal::_document = this;
         this.width = 600;
         this.height = 550;
         this.styleName = "blackOverlay";
         this.addEventListener("creationComplete",this.___EditOrDeleteClipArt_GradientCanvas1_creationComplete);
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
      
      private function close() : void
      {
         parent.removeChild(this);
      }
      
      private function onCreationComplete() : void
      {
         var _loc1_:String = ClipArtCategory.clipArtCategorySubPaths[this.clipArtToEditOrDelete.ClipArtCategoryId] + "/";
         if(_loc1_ != null)
         {
            this.subpath = "clipart/" + _loc1_;
            this.swfcurrent.load(DateUtils.addDateParamToUrl(this.subpath + this.clipArtToEditOrDelete.Filename));
            this.currentlabel.text = "Current SWF: " + this.clipArtToEditOrDelete.Filename;
         }
         else
         {
            Alert.show("Could not get the paths.","Error",4);
         }
         this.cbox_vip.selected = this.clipArtToEditOrDelete.Vip > 0;
         this.cbox_new.selected = this.clipArtToEditOrDelete.isNew > 0;
         this.txt_sort.text = this.clipArtToEditOrDelete.SortOrder.toString();
         this.priceInput.text = this.clipArtToEditOrDelete.Price.toString();
         this.diamondPriceInput.text = this.clipArtToEditOrDelete.DiamondsPrice.toString();
      }
      
      private function btnDeleteClick() : void
      {
         var done:Function = null;
         done = function(param1:int):void
         {
            if(param1 == 0)
            {
               Alert.show("ClipArt successfully deleted.","ClipArt Deleted",4);
            }
            else if(param1 == 1)
            {
               Alert.show("Could not delete ClipArt.","Delete Error",4);
            }
            else if(param1 == 2)
            {
               Alert.show("The item was deleted from the game, but the filename could not be found." + clipArtToEditOrDelete.Filename + " in " + subpath,"Delete",4);
            }
         };
         this.uploadService.deleteClipArt(this.clipArtToEditOrDelete,this.subpath,done);
      }
      
      private function btnBrowseClick() : void
      {
         this.fileReference.browse([new FileFilter("*.swf;*.jpg;*.gif;*.png","*.swf;*.jpg;*.gif;*.png")]);
      }
      
      public function get fileReference() : FileReference
      {
         if(this._fileReference == null)
         {
            this._fileReference = new FileReference();
            this._fileReference.addEventListener(IOErrorEvent.IO_ERROR,this.fileReferenceError,false,0,true);
            this._fileReference.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.fileReferenceHttpError,false,0,true);
            this._fileReference.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.fileReferenceSecurityError,false,0,true);
            this._fileReference.addEventListener(Event.SELECT,this.fileReferenceFileSelected,false,0,true);
            this._fileReference.addEventListener(Event.COMPLETE,this.fileReferenceFileUploaded,false,0,true);
         }
         return this._fileReference;
      }
      
      private function fileReferenceFileSelected(param1:Event) : void
      {
         this.statuslabel.text = "File selected: " + this.fileReference.name;
         this.fileselected = true;
      }
      
      private function btnSaveClick() : void
      {
         var done:Function;
         var doUpload:Function;
         if(this.fileselected)
         {
            done = function(param1:Boolean):void
            {
               var closeHandler:Function;
               var fileExistsOnServer:Boolean = param1;
               CursorManager.removeBusyCursor();
               if(fileExistsOnServer)
               {
                  closeHandler = function(param1:CloseEvent):void
                  {
                     if(param1.detail == Alert.YES)
                     {
                        doUpload();
                     }
                  };
                  Alert.show("Overwrite existing file?","Overwrite?",Alert.YES | Alert.NO,null,closeHandler);
               }
               else
               {
                  doUpload();
               }
            };
            doUpload = function():void
            {
               var _loc1_:FileUploader = new FileUploader();
               _loc1_.upload(fileReference,subpath);
               statuslabel.text = "Uploading...";
            };
            CursorManager.setBusyCursor();
            new AMFUploadService().fileExistsCheck(this.subpath + this.fileReference.name,done);
         }
         else
         {
            this.saveData();
         }
      }
      
      private function fileReferenceFileUploaded(param1:Event) : void
      {
         if(this.fileReference.name != null && this.fileReference.name != "")
         {
            this.clipArtToEditOrDelete.Filename = this.fileReference.name;
         }
         this.saveData();
      }
      
      private function saveData() : void
      {
         var price:int = 0;
         var diamondsPrice:int = 0;
         var done:Function = null;
         done = function(param1:int):void
         {
            if(param1 == 0)
            {
               statuslabel.text = "Edit Done";
               swfnew.load(DateUtils.addDateParamToUrl(subpath + clipArtToEditOrDelete.Filename));
               newlabel.visible = true;
               newlabel.text = "New SWF: " + clipArtToEditOrDelete.Filename;
            }
            else if(param1 == 1)
            {
               Alert.show("Error while trying to edit clipart.","Could not edit",4);
            }
            else if(param1 == 2)
            {
               Alert.show("The item was edited, but the old file could not be deleted." + clipArtToEditOrDelete.Filename + " in " + subpath,"Delete",4);
            }
         };
         if(this.priceInput.text == "")
         {
            price = 0;
         }
         else
         {
            price = int(int(this.priceInput.text));
         }
         if(this.diamondPriceInput.text == "")
         {
            diamondsPrice = 0;
         }
         else
         {
            diamondsPrice = int(int(this.diamondPriceInput.text));
         }
         this.uploadService.editClipArt(this.clipArtToEditOrDelete,this.subpath,this.txt_sort.text,this.cbox_vip.selected,this.cbox_new.selected,price,diamondsPrice,done);
      }
      
      private function get uploadService() : AMFUploadService
      {
         if(this._uploadService == null)
         {
            this._uploadService = new AMFUploadService();
         }
         return this._uploadService;
      }
      
      private function fileReferenceError(param1:IOErrorEvent) : void
      {
         Alert.show("Error uploading file \'" + this.fileReference.name + "\'.\n" + param1.text,"Upload error");
      }
      
      private function fileReferenceHttpError(param1:HTTPStatusEvent) : void
      {
         Alert.show("HTTP error uploading file \'" + this.fileReference.name + "\'.\nHTTP status:" + param1.status,"Upload error");
      }
      
      private function fileReferenceSecurityError(param1:SecurityErrorEvent) : void
      {
         Alert.show("Security error uploading file \'" + this.fileReference.name + "\'.\n" + param1.text,"Upload error");
      }
      
      public function ___EditOrDeleteClipArt_GradientCanvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      public function ___EditOrDeleteClipArt_CloseButton1_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      public function __btnDelete_click(param1:MouseEvent) : void
      {
         this.btnDeleteClick();
      }
      
      public function __btnBrowse_click(param1:MouseEvent) : void
      {
         this.btnBrowseClick();
      }
      
      public function __btnSave_click(param1:MouseEvent) : void
      {
         this.btnSaveClick();
      }
      
      [Bindable(event="propertyChange")]
      public function get btnBrowse() : Button
      {
         return this._105044998btnBrowse;
      }
      
      public function set btnBrowse(param1:Button) : void
      {
         var _loc2_:Object = this._105044998btnBrowse;
         if(_loc2_ !== param1)
         {
            this._105044998btnBrowse = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnBrowse",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnDelete() : Button
      {
         return this._150190887btnDelete;
      }
      
      public function set btnDelete(param1:Button) : void
      {
         var _loc2_:Object = this._150190887btnDelete;
         if(_loc2_ !== param1)
         {
            this._150190887btnDelete = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnDelete",_loc2_,param1));
            }
         }
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
      public function get cbox_new() : CheckBox
      {
         return this._812176233cbox_new;
      }
      
      public function set cbox_new(param1:CheckBox) : void
      {
         var _loc2_:Object = this._812176233cbox_new;
         if(_loc2_ !== param1)
         {
            this._812176233cbox_new = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cbox_new",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cbox_vip() : CheckBox
      {
         return this._812184038cbox_vip;
      }
      
      public function set cbox_vip(param1:CheckBox) : void
      {
         var _loc2_:Object = this._812184038cbox_vip;
         if(_loc2_ !== param1)
         {
            this._812184038cbox_vip = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cbox_vip",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get currentlabel() : Text
      {
         return this._1480344859currentlabel;
      }
      
      public function set currentlabel(param1:Text) : void
      {
         var _loc2_:Object = this._1480344859currentlabel;
         if(_loc2_ !== param1)
         {
            this._1480344859currentlabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"currentlabel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get diamondPriceInput() : TextInput
      {
         return this._1067352181diamondPriceInput;
      }
      
      public function set diamondPriceInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._1067352181diamondPriceInput;
         if(_loc2_ !== param1)
         {
            this._1067352181diamondPriceInput = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"diamondPriceInput",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get newlabel() : Text
      {
         return this._1388763476newlabel;
      }
      
      public function set newlabel(param1:Text) : void
      {
         var _loc2_:Object = this._1388763476newlabel;
         if(_loc2_ !== param1)
         {
            this._1388763476newlabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"newlabel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get priceInput() : TextInput
      {
         return this._1483662335priceInput;
      }
      
      public function set priceInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._1483662335priceInput;
         if(_loc2_ !== param1)
         {
            this._1483662335priceInput = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"priceInput",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get statuslabel() : Label
      {
         return this._879765950statuslabel;
      }
      
      public function set statuslabel(param1:Label) : void
      {
         var _loc2_:Object = this._879765950statuslabel;
         if(_loc2_ !== param1)
         {
            this._879765950statuslabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statuslabel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get swfcurrent() : SWFLoader
      {
         return this._1337002167swfcurrent;
      }
      
      public function set swfcurrent(param1:SWFLoader) : void
      {
         var _loc2_:Object = this._1337002167swfcurrent;
         if(_loc2_ !== param1)
         {
            this._1337002167swfcurrent = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"swfcurrent",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get swfnew() : SWFLoader
      {
         return this._889568290swfnew;
      }
      
      public function set swfnew(param1:SWFLoader) : void
      {
         var _loc2_:Object = this._889568290swfnew;
         if(_loc2_ !== param1)
         {
            this._889568290swfnew = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"swfnew",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get titleBar() : TitleBar
      {
         return this._1870028133titleBar;
      }
      
      public function set titleBar(param1:TitleBar) : void
      {
         var _loc2_:Object = this._1870028133titleBar;
         if(_loc2_ !== param1)
         {
            this._1870028133titleBar = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"titleBar",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txt_sort() : TextInput
      {
         return this._1453919731txt_sort;
      }
      
      public function set txt_sort(param1:TextInput) : void
      {
         var _loc2_:Object = this._1453919731txt_sort;
         if(_loc2_ !== param1)
         {
            this._1453919731txt_sort = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txt_sort",_loc2_,param1));
            }
         }
      }
   }
}

