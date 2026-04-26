package com.moviestarplanet.valueObjects
{
   import com.adobe.fiber.core.model_internal;
   import com.adobe.fiber.services.IFiberManagingService;
   import com.adobe.fiber.valueobjects.IValueObject;
   import flash.events.EventDispatcher;
   import mx.collections.ArrayCollection;
   import mx.events.PropertyChangeEvent;
   
   use namespace model_internal;
   
   public class _Super_InitialLoginFriend extends EventDispatcher implements IValueObject
   {
      
      private static var emptyArray:Array = new Array();
      
      model_internal var _dminternal_model:_InitialLoginFriendEntityMetadata;
      
      model_internal var _changedObjects:ArrayCollection = new ArrayCollection();
      
      private var _internal_actorId:int;
      
      private var _internal_name:String;
      
      private var _internal_friendType:int;
      
      private var _internal_level:int;
      
      private var _internal_membershipTimeoutDate:Date;
      
      private var _internal_recentLogin:Boolean;
      
      model_internal var _cacheInitialized_isValid:Boolean = false;
      
      model_internal var _changeWatcherArray:Array = new Array();
      
      model_internal var _isValid:Boolean;
      
      model_internal var _invalidConstraints:Array = new Array();
      
      model_internal var _validationFailureMessages:Array = new Array();
      
      private var _managingService:IFiberManagingService;
      
      public function _Super_InitialLoginFriend()
      {
         super();
         this._model = new _InitialLoginFriendEntityMetadata(this);
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
      public function get actorId() : int
      {
         return this._internal_actorId;
      }
      
      [Bindable(event="propertyChange")]
      public function get name() : String
      {
         return this._internal_name;
      }
      
      [Bindable(event="propertyChange")]
      public function get friendType() : int
      {
         return this._internal_friendType;
      }
      
      [Bindable(event="propertyChange")]
      public function get level() : int
      {
         return this._internal_level;
      }
      
      [Bindable(event="propertyChange")]
      public function get membershipTimeoutDate() : Date
      {
         return this._internal_membershipTimeoutDate;
      }
      
      [Bindable(event="propertyChange")]
      public function get recentLogin() : Boolean
      {
         return this._internal_recentLogin;
      }
      
      public function clearAssociations() : void
      {
      }
      
      public function set actorId(param1:int) : void
      {
         var _loc2_:int = this._internal_actorId;
         if(_loc2_ !== param1)
         {
            this._internal_actorId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"actorId",_loc2_,this._internal_actorId));
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
      
      public function set friendType(param1:int) : void
      {
         var _loc2_:int = this._internal_friendType;
         if(_loc2_ !== param1)
         {
            this._internal_friendType = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"friendType",_loc2_,this._internal_friendType));
         }
      }
      
      public function set level(param1:int) : void
      {
         var _loc2_:int = this._internal_level;
         if(_loc2_ !== param1)
         {
            this._internal_level = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"level",_loc2_,this._internal_level));
         }
      }
      
      public function set membershipTimeoutDate(param1:Date) : void
      {
         var _loc2_:Date = this._internal_membershipTimeoutDate;
         if(_loc2_ !== param1)
         {
            this._internal_membershipTimeoutDate = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"membershipTimeoutDate",_loc2_,this._internal_membershipTimeoutDate));
         }
      }
      
      public function set recentLogin(param1:Boolean) : void
      {
         var _loc2_:Boolean = this._internal_recentLogin;
         if(_loc2_ !== param1)
         {
            this._internal_recentLogin = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"recentLogin",_loc2_,this._internal_recentLogin));
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
      public function get _model() : _InitialLoginFriendEntityMetadata
      {
         return this._dminternal_model;
      }
      
      public function set _model(param1:_InitialLoginFriendEntityMetadata) : void
      {
         var _loc2_:_InitialLoginFriendEntityMetadata = this._dminternal_model;
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

