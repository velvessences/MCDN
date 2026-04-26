package com.adobe.fiber.valueobjects
{
   public interface IModelType
   {
      
      function getGuardedProperties() : Array;
      
      function getEntityName() : String;
      
      function getCollectionBase(param1:String) : String;
      
      function getCollectionProperties() : Array;
      
      function getUnguardedProperties() : Array;
      
      function getProperties() : Array;
      
      function getDependedOnServices() : Array;
      
      function getDependants(param1:String) : Array;
      
      function getRequiredProperties() : Array;
      
      function getPropertyLength(param1:String) : int;
      
      function getDataProperties() : Array;
      
      function getMappedByProperty(param1:String) : String;
      
      function getAssociationProperties() : Array;
   }
}

