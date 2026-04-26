package com.adobe.fiber.valueobjects
{
   import com.adobe.fiber.styles.IStyle;
   import flash.events.EventDispatcher;
   import mx.resources.ResourceManager;
   
   public class AbstractEntityMetadata extends EventDispatcher implements IModelType, IModelInstance
   {
      
      public static const AdobePatentID_B932:String = "AdobePatentID=\"B932\"";
      
      public static const AdobePatentID_B1056:String = "AdobePatentID=\"B1056\"";
      
      public function AbstractEntityMetadata()
      {
         super();
      }
      
      public function getValue(param1:String) : *
      {
         var _loc2_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["getValue"]);
         throw new Error(_loc2_);
      }
      
      public function getCollectionBase(param1:String) : String
      {
         var _loc2_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["getCollectionBase"]);
         throw new Error(_loc2_);
      }
      
      public function isAvailable(param1:String) : Boolean
      {
         var _loc2_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["isAvailable"]);
         throw new Error(_loc2_);
      }
      
      public function getIdentityMap() : Object
      {
         var _loc1_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["getIdentityMap"]);
         throw new Error(_loc1_);
      }
      
      public function getStyle(param1:String) : IStyle
      {
         var _loc2_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["getStyle"]);
         throw new Error(_loc2_);
      }
      
      public function getEntityName() : String
      {
         var _loc1_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["getEntityName"]);
         throw new Error(_loc1_);
      }
      
      public function getDependedOnServices() : Array
      {
         var _loc1_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["getDependedOnServices"]);
         throw new Error(_loc1_);
      }
      
      public function getPropertyLength(param1:String) : int
      {
         var _loc2_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["getPropertyLength"]);
         throw new Error(_loc2_);
      }
      
      public function getDependants(param1:String) : Array
      {
         var _loc2_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["getDependants"]);
         throw new Error(_loc2_);
      }
      
      public function get invalidConstraints() : Array
      {
         var _loc1_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["invalidConstraints"]);
         throw new Error(_loc1_);
      }
      
      public function getMappedByProperty(param1:String) : String
      {
         var _loc2_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["getMappedByProperty"]);
         throw new Error(_loc2_);
      }
      
      public function getAssociationProperties() : Array
      {
         var _loc1_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["getAssociationProperties"]);
         throw new Error(_loc1_);
      }
      
      public function getGuardedProperties() : Array
      {
         var _loc1_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["getGuardedProperties"]);
         throw new Error(_loc1_);
      }
      
      public function getDependantInvalidConstraints(param1:String) : Array
      {
         var _loc2_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["getDependantInvalidConstraints"]);
         throw new Error(_loc2_);
      }
      
      public function getPropertyType(param1:String) : String
      {
         var _loc2_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["getPropertyType"]);
         throw new Error(_loc2_);
      }
      
      public function getAvailableProperties() : IPropertyIterator
      {
         var _loc1_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["getAvailableProperties"]);
         throw new Error(_loc1_);
      }
      
      public function getCollectionProperties() : Array
      {
         var _loc1_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["getCollectionProperties"]);
         throw new Error(_loc1_);
      }
      
      public function getProperties() : Array
      {
         var _loc1_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["getProperties"]);
         throw new Error(_loc1_);
      }
      
      public function getUnguardedProperties() : Array
      {
         var _loc1_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["getUnguardedProperties"]);
         throw new Error(_loc1_);
      }
      
      public function getPropertyValidationFailureMessages(param1:String) : Array
      {
         var _loc2_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["getPropertyValidationFailureMessages"]);
         throw new Error(_loc2_);
      }
      
      public function setValue(param1:String, param2:*) : void
      {
         var _loc3_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["setValue"]);
         throw new Error(_loc3_);
      }
      
      public function getDataProperties() : Array
      {
         var _loc1_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["getDataProperties"]);
         throw new Error(_loc1_);
      }
      
      public function getRequiredProperties() : Array
      {
         var _loc1_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["getRequiredProperties"]);
         throw new Error(_loc1_);
      }
      
      public function get validationFailureMessages() : Array
      {
         var _loc1_:String = ResourceManager.getInstance().getString("fiber","notImplemented",["validationFailureMessages"]);
         throw new Error(_loc1_);
      }
   }
}

