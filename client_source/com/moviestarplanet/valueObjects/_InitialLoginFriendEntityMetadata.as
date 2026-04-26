package com.moviestarplanet.valueObjects
{
   import com.adobe.fiber.core.model_internal;
   import com.adobe.fiber.styles.IStyle;
   import com.adobe.fiber.styles.Style;
   import com.adobe.fiber.valueobjects.AbstractEntityMetadata;
   import com.adobe.fiber.valueobjects.AvailablePropertyIterator;
   import com.adobe.fiber.valueobjects.IPropertyIterator;
   import mx.events.PropertyChangeEvent;
   
   use namespace model_internal;
   
   internal class _InitialLoginFriendEntityMetadata extends AbstractEntityMetadata
   {
      
      model_internal static var collectionBaseMap:Object;
      
      model_internal static var dependentsOnMap:Object;
      
      model_internal static var propertyTypeMap:Object;
      
      private static var emptyArray:Array = new Array();
      
      model_internal static var allProperties:Array = new Array("actorId","name","friendType","level","membershipTimeoutDate","recentLogin");
      
      model_internal static var allAssociationProperties:Array = new Array();
      
      model_internal static var allRequiredProperties:Array = new Array();
      
      model_internal static var allAlwaysAvailableProperties:Array = new Array("actorId","name","friendType","level","membershipTimeoutDate","recentLogin");
      
      model_internal static var guardedProperties:Array = new Array();
      
      model_internal static var dataProperties:Array = new Array("actorId","name","friendType","level","membershipTimeoutDate","recentLogin");
      
      model_internal static var sourceProperties:Array = emptyArray;
      
      model_internal static var nonDerivedProperties:Array = new Array("actorId","name","friendType","level","membershipTimeoutDate","recentLogin");
      
      model_internal static var derivedProperties:Array = new Array();
      
      model_internal static var collectionProperties:Array = new Array();
      
      model_internal static var entityName:String = "InitialLoginFriend";
      
      model_internal static var dependedOnServices:Array = new Array();
      
      model_internal static var _nullStyle:Style = new Style();
      
      model_internal var _instance:_Super_InitialLoginFriend;
      
      public function _InitialLoginFriendEntityMetadata(param1:_Super_InitialLoginFriend)
      {
         super();
         if(model_internal::dependentsOnMap == null)
         {
            model_internal::dependentsOnMap = new Object();
            model_internal::dependentsOnMap["actorId"] = new Array();
            model_internal::dependentsOnMap["name"] = new Array();
            model_internal::dependentsOnMap["friendType"] = new Array();
            model_internal::dependentsOnMap["level"] = new Array();
            model_internal::dependentsOnMap["membershipTimeoutDate"] = new Array();
            model_internal::dependentsOnMap["recentLogin"] = new Array();
            model_internal::collectionBaseMap = new Object();
         }
         model_internal::propertyTypeMap = new Object();
         model_internal::propertyTypeMap["actorId"] = "int";
         model_internal::propertyTypeMap["name"] = "String";
         model_internal::propertyTypeMap["friendType"] = "int";
         model_internal::propertyTypeMap["level"] = "int";
         model_internal::propertyTypeMap["membershipTimeoutDate"] = "Date";
         model_internal::propertyTypeMap["recentLogin"] = "Boolean";
         this._instance = param1;
      }
      
      override public function getEntityName() : String
      {
         return entityName;
      }
      
      override public function getProperties() : Array
      {
         return allProperties;
      }
      
      override public function getAssociationProperties() : Array
      {
         return allAssociationProperties;
      }
      
      override public function getRequiredProperties() : Array
      {
         return allRequiredProperties;
      }
      
      override public function getDataProperties() : Array
      {
         return dataProperties;
      }
      
      public function getSourceProperties() : Array
      {
         return sourceProperties;
      }
      
      public function getNonDerivedProperties() : Array
      {
         return nonDerivedProperties;
      }
      
      override public function getGuardedProperties() : Array
      {
         return guardedProperties;
      }
      
      override public function getUnguardedProperties() : Array
      {
         return allAlwaysAvailableProperties;
      }
      
      override public function getDependants(param1:String) : Array
      {
         if(nonDerivedProperties.indexOf(param1) == -1)
         {
            throw new Error(param1 + " is not a data property of entity InitialLoginFriend");
         }
         return dependentsOnMap[param1] as Array;
      }
      
      override public function getDependedOnServices() : Array
      {
         return dependedOnServices;
      }
      
      override public function getCollectionProperties() : Array
      {
         return collectionProperties;
      }
      
      override public function getCollectionBase(param1:String) : String
      {
         if(collectionProperties.indexOf(param1) == -1)
         {
            throw new Error(param1 + " is not a collection property of entity InitialLoginFriend");
         }
         return collectionBaseMap[param1];
      }
      
      override public function getPropertyType(param1:String) : String
      {
         if(allProperties.indexOf(param1) == -1)
         {
            throw new Error(param1 + " is not a property of InitialLoginFriend");
         }
         return propertyTypeMap[param1];
      }
      
      override public function getAvailableProperties() : IPropertyIterator
      {
         return new AvailablePropertyIterator(this);
      }
      
      override public function getValue(param1:String) : *
      {
         if(allProperties.indexOf(param1) == -1)
         {
            throw new Error(param1 + " does not exist for entity InitialLoginFriend");
         }
         return this._instance[param1];
      }
      
      override public function setValue(param1:String, param2:*) : void
      {
         if(nonDerivedProperties.indexOf(param1) == -1)
         {
            throw new Error(param1 + " is not a modifiable property of entity InitialLoginFriend");
         }
         this._instance[param1] = param2;
      }
      
      override public function getMappedByProperty(param1:String) : String
      {
         var _loc2_:String = param1;
         switch(0)
         {
         }
         return null;
      }
      
      override public function getPropertyLength(param1:String) : int
      {
         var _loc2_:String = param1;
         switch(0)
         {
         }
         return 0;
      }
      
      override public function isAvailable(param1:String) : Boolean
      {
         if(allProperties.indexOf(param1) == -1)
         {
            throw new Error(param1 + " does not exist for entity InitialLoginFriend");
         }
         if(allAlwaysAvailableProperties.indexOf(param1) != -1)
         {
            return true;
         }
         var _loc2_:String = param1;
         switch(0)
         {
         }
         return true;
      }
      
      override public function getIdentityMap() : Object
      {
         return new Object();
      }
      
      [Bindable(event="propertyChange")]
      override public function get invalidConstraints() : Array
      {
         if(this._instance._cacheInitialized_isValid)
         {
            return this._instance._invalidConstraints;
         }
         this._instance._isValid = this._instance.calculateIsValid();
         return this._instance._invalidConstraints;
      }
      
      [Bindable(event="propertyChange")]
      override public function get validationFailureMessages() : Array
      {
         if(this._instance._cacheInitialized_isValid)
         {
            return this._instance._validationFailureMessages;
         }
         this._instance._isValid = this._instance.calculateIsValid();
         return this._instance._validationFailureMessages;
      }
      
      override public function getDependantInvalidConstraints(param1:String) : Array
      {
         var currentlyInvalid:Array;
         var filterFunc:Function;
         var dependants:Array = null;
         var propertyName:String = param1;
         dependants = this.getDependants(propertyName);
         if(dependants.length == 0)
         {
            return emptyArray;
         }
         currentlyInvalid = this.invalidConstraints;
         if(currentlyInvalid.length == 0)
         {
            return emptyArray;
         }
         filterFunc = function(param1:*, param2:int, param3:Array):Boolean
         {
            return dependants.indexOf(param1) > -1;
         };
         return currentlyInvalid.filter(filterFunc);
      }
      
      [Bindable(event="propertyChange")]
      public function get isValid() : Boolean
      {
         if(this._instance._cacheInitialized_isValid)
         {
            return this._instance._isValid;
         }
         this._instance._isValid = this._instance.calculateIsValid();
         return this._instance._isValid;
      }
      
      [Bindable(event="propertyChange")]
      public function get isActorIdAvailable() : Boolean
      {
         return true;
      }
      
      [Bindable(event="propertyChange")]
      public function get isNameAvailable() : Boolean
      {
         return true;
      }
      
      [Bindable(event="propertyChange")]
      public function get isFriendTypeAvailable() : Boolean
      {
         return true;
      }
      
      [Bindable(event="propertyChange")]
      public function get isLevelAvailable() : Boolean
      {
         return true;
      }
      
      [Bindable(event="propertyChange")]
      public function get isMembershipTimeoutDateAvailable() : Boolean
      {
         return true;
      }
      
      [Bindable(event="propertyChange")]
      public function get isRecentLoginAvailable() : Boolean
      {
         return true;
      }
      
      model_internal function fireChangeEvent(param1:String, param2:Object, param3:Object) : void
      {
         this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,param1,param2,param3));
      }
      
      [Bindable(event="propertyChange")]
      public function get actorIdStyle() : Style
      {
         return _nullStyle;
      }
      
      [Bindable(event="propertyChange")]
      public function get nameStyle() : Style
      {
         return _nullStyle;
      }
      
      [Bindable(event="propertyChange")]
      public function get friendTypeStyle() : Style
      {
         return _nullStyle;
      }
      
      [Bindable(event="propertyChange")]
      public function get levelStyle() : Style
      {
         return _nullStyle;
      }
      
      [Bindable(event="propertyChange")]
      public function get membershipTimeoutDateStyle() : Style
      {
         return _nullStyle;
      }
      
      [Bindable(event="propertyChange")]
      public function get recentLoginStyle() : Style
      {
         return _nullStyle;
      }
      
      override public function getStyle(param1:String) : IStyle
      {
         var _loc2_:String = param1;
         switch(0)
         {
         }
         return null;
      }
      
      override public function getPropertyValidationFailureMessages(param1:String) : Array
      {
         var _loc2_:String = param1;
         switch(0)
         {
         }
         return emptyArray;
      }
   }
}

