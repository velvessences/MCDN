package com.moviestarplanet.valueObjects
{
   import com.adobe.fiber.core.model_internal;
   import com.adobe.fiber.services.IFiberManagingService;
   import com.adobe.fiber.valueobjects.IValueObject;
   import flash.events.EventDispatcher;
   import mx.collections.ArrayCollection;
   import mx.events.PropertyChangeEvent;
   
   use namespace model_internal;
   
   public class _Super_ClipArtTypeObject extends EventDispatcher implements IValueObject
   {
      
      private static var emptyArray:Array = new Array();
      
      model_internal var _dminternal_model:_ClipArtTypeObjectEntityMetadata;
      
      model_internal var _changedObjects:ArrayCollection = new ArrayCollection();
      
      private var _internal_id:int;
      
      private var _internal_name:String;
      
      model_internal var _cacheInitialized_isValid:Boolean = false;
      
      model_internal var _changeWatcherArray:Array = new Array();
      
      model_internal var _isValid:Boolean;
      
      model_internal var _invalidConstraints:Array = new Array();
      
      model_internal var _validationFailureMessages:Array = new Array();
      
      private var _managingService:IFiberManagingService;
      
      public function _Super_ClipArtTypeObject()
      {
         super();
         this._model = new _ClipArtTypeObjectEntityMetadata(this);
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
      public function get id() : int
      {
         return this._internal_id;
      }
      
      [Bindable(event="propertyChange")]
      public function get name() : String
      {
         return this._internal_name;
      }
      
      public function clearAssociations() : void
      {
      }
      
      public function set id(param1:int) : void
      {
         var _loc2_:int = this._internal_id;
         if(_loc2_ !== param1)
         {
            this._internal_id = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"id",_loc2_,this._internal_id));
         }
      }
      
      public function set name(param1:String) : void
      {
         var _loc2_:String = this._internal_name;
         if(_loc2_ !== param1)
         {
            this._internal_name = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"name",_loc2_,this._internal_name));
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
      public function get _model() : _ClipArtTypeObjectEntityMetadata
      {
         return this._dminternal_model;
      }
      
      public function set _model(param1:_ClipArtTypeObjectEntityMetadata) : void
      {
         var _loc2_:_ClipArtTypeObjectEntityMetadata = this._dminternal_model;
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

