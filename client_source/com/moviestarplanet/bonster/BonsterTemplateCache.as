package com.moviestarplanet.bonster
{
   import com.moviestarplanet.bonster.valueobjects.BonsterTemplateObject;
   import flash.utils.Dictionary;
   
   public class BonsterTemplateCache
   {
      
      private static var _instance:BonsterTemplateCache = null;
      
      private var _data:Dictionary = new Dictionary();
      
      public function BonsterTemplateCache(param1:SingletonEnforcer)
      {
         super();
      }
      
      public static function get instance() : BonsterTemplateCache
      {
         if(_instance == null)
         {
            _instance = new BonsterTemplateCache(new SingletonEnforcer());
         }
         return _instance;
      }
      
      public function getTemplate(param1:int) : BonsterTemplateObject
      {
         if(param1 in this._data)
         {
            return this._data[param1];
         }
         return null;
      }
      
      public function setTemplate(param1:BonsterTemplateObject) : void
      {
         this._data[param1.BonsterTemplateId] = param1;
      }
      
      public function getAllTemplates() : Dictionary
      {
         return this._data;
      }
   }
}

class SingletonEnforcer
{
   
   public function SingletonEnforcer()
   {
      super();
   }
}
