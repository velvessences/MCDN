package com.adobe.fiber.valueobjects
{
   import com.adobe.fiber.styles.IStyle;
   
   public interface IModelInstance
   {
      
      function getStyle(param1:String) : IStyle;
      
      function getDependantInvalidConstraints(param1:String) : Array;
      
      function getAvailableProperties() : IPropertyIterator;
      
      function get invalidConstraints() : Array;
      
      function getIdentityMap() : Object;
      
      function getPropertyValidationFailureMessages(param1:String) : Array;
      
      function getValue(param1:String) : *;
      
      function get validationFailureMessages() : Array;
      
      function setValue(param1:String, param2:*) : void;
      
      function isAvailable(param1:String) : Boolean;
   }
}

