package com.moviestarplanet.valueObjects
{
   import com.adobe.fiber.core.model_internal;
   import com.adobe.fiber.services.IFiberManagingService;
   import com.adobe.fiber.valueobjects.IValueObject;
   import flash.events.EventDispatcher;
   import mx.collections.ArrayCollection;
   import mx.events.PropertyChangeEvent;
   
   use namespace model_internal;
   
   public class _Super_NewsUpdate extends EventDispatcher implements IValueObject
   {
      
      private static var emptyArray:Array = new Array();
      
      model_internal var _dminternal_model:_NewsUpdateEntityMetadata;
      
      model_internal var _changedObjects:ArrayCollection = new ArrayCollection();
      
      private var _internal_NewsId:int;
      
      private var _internal__Date:Date;
      
      private var _internal_Headline:String;
      
      private var _internal_Description:String;
      
      private var _internal_SWF:String;
      
      private var _internal_ScrapBlogId:int;
      
      private var _internal_SnapshotPath:String;
      
      model_internal var _cacheInitialized_isValid:Boolean = false;
      
      model_internal var _changeWatcherArray:Array = new Array();
      
      model_internal var _isValid:Boolean;
      
      model_internal var _invalidConstraints:Array = new Array();
      
      model_internal var _validationFailureMessages:Array = new Array();
      
      private var _managingService:IFiberManagingService;
      
      public function _Super_NewsUpdate()
      {
         super();
         this._model = new _NewsUpdateEntityMetadata(this);
      }
      
      model_internal static function initRemoteClassAliasSingle(param1:Class) : void
      {
      }
      
      model_internal static function initRemoteClassAliasAllRelated() : void
      {
      }
      
      public function getChangedObjects() : Array
      {
         this._changedObjects.addItemAt(this,0);
         return this._changedObjects.source;
      }
      
      public function clearChangedObjects() : void
      {
         this._changedObjects.removeAll();
      }
      
      [Bindable(event="propertyChange")]
      public function get NewsId() : int
      {
         return this._internal_NewsId;
      }
      
      [Bindable(event="propertyChange")]
      public function get _Date() : Date
      {
         return this._internal__Date;
      }
      
      [Bindable(event="propertyChange")]
      public function get Headline() : String
      {
         return this._internal_Headline;
      }
      
      [Bindable(event="propertyChange")]
      public function get Description() : String
      {
         return this._internal_Description;
      }
      
      [Bindable(event="propertyChange")]
      public function get SWF() : String
      {
         return this._internal_SWF;
      }
      
      [Bindable(event="propertyChange")]
      public function get ScrapBlogId() : int
      {
         return this._internal_ScrapBlogId;
      }
      
      [Bindable(event="propertyChange")]
      public function get SnapshotPath() : String
      {
         return this._internal_SnapshotPath;
      }
      
      public function clearAssociations() : void
      {
      }
      
      public function set NewsId(param1:int) : void
      {
         var _loc2_:int = this._internal_NewsId;
         if(_loc2_ !== param1)
         {
            this._internal_NewsId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"NewsId",_loc2_,this._internal_NewsId));
         }
      }
      
      public function set _Date(param1:Date) : void
      {
         var _loc2_:Date = this._internal__Date;
         if(_loc2_ !== param1)
         {
            this._internal__Date = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_Date",_loc2_,this._internal__Date));
         }
      }
      
      public function set Headline(param1:String) : void
      {
         var _loc2_:String = this._internal_Headline;
         if(_loc2_ !== param1)
         {
            this._internal_Headline = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"Headline",_loc2_,this._internal_Headline));
         }
      }
      
      public function set Description(param1:String) : void
      {
         var _loc2_:String = this._internal_Description;
         if(_loc2_ !== param1)
         {
            this._internal_Description = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"Description",_loc2_,this._internal_Description));
         }
      }
      
      public function set SWF(param1:String) : void
      {
         var _loc2_:String = this._internal_SWF;
         if(_loc2_ !== param1)
         {
            this._internal_SWF = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"SWF",_loc2_,this._internal_SWF));
         }
      }
      
      public function set ScrapBlogId(param1:int) : void
      {
         var _loc2_:int = this._internal_ScrapBlogId;
         if(_loc2_ !== param1)
         {
            this._internal_ScrapBlogId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ScrapBlogId",_loc2_,this._internal_ScrapBlogId));
         }
      }
      
      public function set SnapshotPath(param1:String) : void
      {
         var _loc2_:String = this._internal_SnapshotPath;
         if(_loc2_ !== param1)
         {
            this._internal_SnapshotPath = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"SnapshotPath",_loc2_,this._internal_SnapshotPath));
         }
      }
      
      model_internal function calculateIsValid() : Boolean
      {
         var _loc1_:Array = new Array();
         var _loc2_:Array = new Array();
         var _loc3_:Boolean = true;
         this._cacheInitialized_isValid = true;
         this.invalidConstraints_der = _loc1_;
         this.validationFailureMessages_der = _loc2_;
         return _loc1_.length == 0 && _loc3_;
      }
      
      model_internal function set isValid_der(param1:Boolean) : void
      {
         var _loc2_:Boolean = this._isValid;
         if(_loc2_ !== param1)
         {
            this._isValid = param1;
            this._model.fireChangeEvent("isValid",_loc2_,this._isValid);
         }
      }
      
      [Bindable(event="propertyChange")]
      [Transient]
      public function get _model() : _NewsUpdateEntityMetadata
      {
         return this._dminternal_model;
      }
      
      public function set _model(param1:_NewsUpdateEntityMetadata) : void
      {
         var _loc2_:_NewsUpdateEntityMetadata = this._dminternal_model;
         if(_loc2_ !== param1)
         {
            this._dminternal_model = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_model",_loc2_,this._dminternal_model));
         }
      }
      
      public function set managingService(param1:IFiberManagingService) : void
      {
         this._managingService = param1;
      }
      
      model_internal function set invalidConstraints_der(param1:Array) : void
      {
         var _loc2_:Array = this._invalidConstraints;
         if(_loc2_ !== param1 && (_loc2_.length > 0 || param1.length > 0))
         {
            this._invalidConstraints = param1;
            this._model.fireChangeEvent("invalidConstraints",_loc2_,this._invalidConstraints);
         }
      }
      
      model_internal function set validationFailureMessages_der(param1:Array) : void
      {
         var _loc2_:Array = this._validationFailureMessages;
         if(_loc2_ !== param1 && (_loc2_.length > 0 || param1.length > 0))
         {
            this._validationFailureMessages = param1;
            this._model.fireChangeEvent("validationFailureMessages",_loc2_,this._validationFailureMessages);
         }
      }
   }
}

