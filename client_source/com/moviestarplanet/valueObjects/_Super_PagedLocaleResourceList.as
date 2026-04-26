package com.moviestarplanet.valueObjects
{
   import com.adobe.fiber.core.model_internal;
   import com.adobe.fiber.services.IFiberManagingService;
   import com.adobe.fiber.valueobjects.IValueObject;
   import flash.events.EventDispatcher;
   import mx.collections.ArrayCollection;
   import mx.events.PropertyChangeEvent;
   
   use namespace model_internal;
   
   public class _Super_PagedLocaleResourceList extends EventDispatcher implements IValueObject
   {
      
      private static var emptyArray:Array = new Array();
      
      model_internal var _dminternal_model:_PagedLocaleResourceListEntityMetadata;
      
      model_internal var _changedObjects:ArrayCollection = new ArrayCollection();
      
      private var _internal_totalRecords:int;
      
      private var _internal_pageindex:int;
      
      private var _internal_pagesize:int;
      
      private var _internal_items:ArrayCollection;
      
      model_internal var _internal_items_leaf:LocaleResourceList;
      
      model_internal var _cacheInitialized_isValid:Boolean = false;
      
      model_internal var _changeWatcherArray:Array = new Array();
      
      model_internal var _isValid:Boolean;
      
      model_internal var _invalidConstraints:Array = new Array();
      
      model_internal var _validationFailureMessages:Array = new Array();
      
      private var _managingService:IFiberManagingService;
      
      public function _Super_PagedLocaleResourceList()
      {
         super();
         this._model = new _PagedLocaleResourceListEntityMetadata(this);
      }
      
      model_internal static function initRemoteClassAliasSingle(param1:Class) : void
      {
      }
      
      model_internal static function initRemoteClassAliasAllRelated() : void
      {
         LocaleResourceList.initRemoteClassAliasSingleChild();
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
      public function get totalRecords() : int
      {
         return this._internal_totalRecords;
      }
      
      [Bindable(event="propertyChange")]
      public function get pageindex() : int
      {
         return this._internal_pageindex;
      }
      
      [Bindable(event="propertyChange")]
      public function get pagesize() : int
      {
         return this._internal_pagesize;
      }
      
      [Bindable(event="propertyChange")]
      public function get items() : ArrayCollection
      {
         return this._internal_items;
      }
      
      public function clearAssociations() : void
      {
      }
      
      public function set totalRecords(param1:int) : void
      {
         var _loc2_:int = this._internal_totalRecords;
         if(_loc2_ !== param1)
         {
            this._internal_totalRecords = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"totalRecords",_loc2_,this._internal_totalRecords));
         }
      }
      
      public function set pageindex(param1:int) : void
      {
         var _loc2_:int = this._internal_pageindex;
         if(_loc2_ !== param1)
         {
            this._internal_pageindex = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"pageindex",_loc2_,this._internal_pageindex));
         }
      }
      
      public function set pagesize(param1:int) : void
      {
         var _loc2_:int = this._internal_pagesize;
         if(_loc2_ !== param1)
         {
            this._internal_pagesize = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"pagesize",_loc2_,this._internal_pagesize));
         }
      }
      
      public function set items(param1:*) : void
      {
         var _loc2_:ArrayCollection = this._internal_items;
         if(_loc2_ !== param1)
         {
            if(param1 is ArrayCollection)
            {
               this._internal_items = param1;
            }
            else if(param1 is Array)
            {
               this._internal_items = new ArrayCollection(param1);
            }
            else
            {
               if(param1 != null)
               {
                  throw new Error("value of items must be a collection");
               }
               this._internal_items = null;
            }
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"items",_loc2_,this._internal_items));
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
      public function get _model() : _PagedLocaleResourceListEntityMetadata
      {
         return this._dminternal_model;
      }
      
      public function set _model(param1:_PagedLocaleResourceListEntityMetadata) : void
      {
         var _loc2_:_PagedLocaleResourceListEntityMetadata = this._dminternal_model;
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

