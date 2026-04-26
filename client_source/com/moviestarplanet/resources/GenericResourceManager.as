package com.moviestarplanet.resources
{
   import flash.utils.Dictionary;
   
   public class GenericResourceManager
   {
      
      private static var instance:GenericResourceManager = new GenericResourceManager();
      
      private var resources:Dictionary = new Dictionary();
      
      private var counters:Dictionary = new Dictionary();
      
      public function GenericResourceManager()
      {
         super();
         if(instance)
         {
            throw new Error("Generic ResourceManager is a singleton. Use the static functions available instead.");
         }
      }
      
      public static function addResource(param1:String, param2:ResourceWrapper) : void
      {
         instance.addResourceInternal(param1,param2);
      }
      
      public static function removeResource(param1:String) : void
      {
         instance.removeResourceIntenal(param1);
      }
      
      public static function hasResource(param1:String) : Boolean
      {
         return instance.hasResourceInternal(param1);
      }
      
      public static function getResource(param1:String) : ResourceWrapper
      {
         return instance.getResourceInternal(param1);
      }
      
      internal static function subscribe(param1:String, param2:Object) : void
      {
         instance.subscribeIntenal(param1,param2);
      }
      
      public static function isSubscribed(param1:String, param2:Object) : Boolean
      {
         return instance.isComponentSubscribed(param1,param2);
      }
      
      internal static function unsubscribe(param1:String, param2:Object) : void
      {
         instance.unsubscribeInternal(param1,param2);
      }
      
      internal static function subscriptionsLeft(param1:String) : int
      {
         return instance.subscriptionsLeftInternal(param1);
      }
      
      public static function showUsageList() : String
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc1_:String = "\n";
         for(_loc2_ in instance.resources)
         {
            _loc3_ = instance.resources[_loc2_];
            _loc4_ = _loc2_ as String;
            if(instance.counters[_loc4_] != null)
            {
               _loc1_ += (instance.counters[_loc4_] as Array).length + " of " + _loc2_ + "\n";
            }
         }
         return _loc1_;
      }
      
      public static function showUnusedLoadedDefinitionsList() : String
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc1_:String = "\n";
         for(_loc2_ in instance.resources)
         {
            _loc3_ = instance.resources[_loc2_];
            _loc4_ = _loc2_ as String;
            if(instance.counters[_loc4_] == null)
            {
               _loc1_ += _loc2_ + "\n";
            }
         }
         return _loc1_;
      }
      
      private function hasResourceInternal(param1:String) : Boolean
      {
         if(this.resources[param1] != null)
         {
            return true;
         }
         return false;
      }
      
      private function addResourceInternal(param1:String, param2:ResourceWrapper) : void
      {
         if(this.resources[param1] != null)
         {
            throw new Error("you have already added a resource with this key: " + param1);
         }
         this.resources[param1] = param2;
      }
      
      private function getResourceInternal(param1:String) : ResourceWrapper
      {
         return this.resources[param1];
      }
      
      private function removeResourceIntenal(param1:String) : void
      {
         if(this.subscriptionsLeftInternal(param1) > 0)
         {
            throw new Error("subscriptions left need to be 0 before you can remove this from memory");
         }
         delete this.resources[param1];
      }
      
      private function subscribeIntenal(param1:String, param2:Object) : void
      {
         if(this.counters[param1] == null)
         {
            this.counters[param1] = new Array();
         }
         (this.counters[param1] as Array).push(param2);
      }
      
      private function unsubscribeInternal(param1:String, param2:Object) : void
      {
         var _loc3_:Array = this.counters[param1] as Array;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc3_[_loc4_] == param2)
            {
               _loc3_.splice(_loc4_,1);
               break;
            }
            _loc4_++;
         }
         if(_loc3_.length == 0)
         {
            delete this.counters[param1];
         }
      }
      
      public function isComponentSubscribed(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = this.counters[param1] as Array;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc3_[_loc4_] == param2)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      private function subscriptionsLeftInternal(param1:String) : int
      {
         if(this.counters[param1] == null)
         {
            return 0;
         }
         return (this.counters[param1] as Array).length;
      }
   }
}

