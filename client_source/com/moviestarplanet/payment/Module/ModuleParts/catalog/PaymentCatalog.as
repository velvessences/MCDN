package com.moviestarplanet.payment.Module.ModuleParts.catalog
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.payment.Module.ModuleParts.paymentmethods.BOKUPaymentMethod;
   import com.moviestarplanet.payment.Module.ModuleParts.paymentmethods.BasePaymentMethod;
   import com.moviestarplanet.payment.Module.ModuleParts.paymentmethods.DIBSPaymentMethod;
   import com.moviestarplanet.payment.Module.ModuleParts.paymentmethods.GCPaymentMethod;
   import com.moviestarplanet.payment.PaymentProvider;
   import com.moviestarplanet.payment.valueobject.PaymentMethodDescriptor;
   import flash.net.registerClassAlias;
   import flash.utils.getDefinitionByName;
   import mx.collections.ArrayCollection;
   
   public class PaymentCatalog
   {
      
      private static const ALL_KEYS:Array = ["1000","2000","3000","6000","14000","36000","42000","2001","3001","6001","14001","36001","42001","2010","2020","2030","2040","6010","6020","6030","6040","14010","14020","14030","14040","30010","30020","30030","42010","42020","42030","42040","90010","90020","90030"];
      
      private static const BOKUPaymentMethod_ALIAS:* = registerClassAlias("BOKUPaymentMethod",BOKUPaymentMethod);
      
      private static const DIBSPaymentMethod_ALIAS:* = registerClassAlias("DIBSPaymentMethod",DIBSPaymentMethod);
      
      private static const GCPaymentMethod_ALIAS:* = registerClassAlias("GCPaymentMethod",GCPaymentMethod);
      
      private static var regularMethodCache:Object = new Object();
      
      private static var upgradeMethodCache:Object = new Object();
      
      public function PaymentCatalog()
      {
         super();
      }
      
      public static function loadPaymentMethods(param1:String, param2:Function = null) : void
      {
         var done:Function = null;
         var country:String = param1;
         var callback:Function = param2;
         done = function(param1:ArrayCollection):void
         {
            var _loc2_:PaymentMethodDescriptor = null;
            var _loc3_:Class = null;
            var _loc4_:BasePaymentMethod = null;
            var _loc5_:Number = NaN;
            resetMethodCache();
            for each(_loc2_ in param1)
            {
               if(_loc2_.provider.indexOf("|") != -1)
               {
                  _loc5_ = 0;
                  if(ActorSession != null)
                  {
                     _loc5_ = ActorSession.getActorId();
                  }
                  if(_loc5_ < 0)
                  {
                     _loc5_ = 0;
                  }
                  _loc2_.provider = _loc2_.provider.split("|")[_loc5_ % 2];
               }
               _loc3_ = getDefinitionByName("com.moviestarplanet.payment.Module.ModuleParts.paymentmethods." + _loc2_.provider) as Class;
               _loc4_ = new _loc3_(_loc2_);
               addPaymentMethod(regularMethodCache,_loc4_,_loc2_.keys.length > 0 ? _loc2_.keys.toArray() : ALL_KEYS);
               if(_loc2_.upgrade)
               {
                  addPaymentMethod(upgradeMethodCache,_loc4_,_loc2_.keys.length > 0 ? _loc2_.keys.toArray() : ALL_KEYS);
               }
            }
            if(callback != null)
            {
               callback(regularMethodCache);
            }
         };
         new PaymentProvider().GetPaymentMethods(country,done);
      }
      
      private static function resetMethodCache() : void
      {
         var _loc1_:String = null;
         for each(_loc1_ in ALL_KEYS)
         {
            regularMethodCache[_loc1_] = new Array();
            upgradeMethodCache[_loc1_] = new Array();
         }
      }
      
      private static function addPaymentMethod(param1:Object, param2:BasePaymentMethod, param3:Array) : void
      {
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         for each(_loc4_ in param3)
         {
            if(ActorSession != null && ActorSession.isAgeRestrictions)
            {
               _loc5_ = param1[_loc4_] as Array;
               _loc6_ = 0;
               while(_loc6_ < _loc5_.length)
               {
                  if((_loc5_[_loc6_] as BasePaymentMethod).methodName == "Mobile")
                  {
                     _loc5_.splice(_loc6_,1);
                     break;
                  }
                  _loc6_++;
               }
            }
            (param1[_loc4_] as Array).push(param2);
         }
      }
      
      public static function getPaymentMethods(param1:String, param2:String, param3:Boolean, param4:Function) : void
      {
         var methodsLoaded:Function = null;
         var key:String = param1;
         var country:String = param2;
         var upgrade:Boolean = param3;
         var callback:Function = param4;
         methodsLoaded = function():void
         {
            var _loc1_:Object = getCache(upgrade);
            checkCache(_loc1_,key);
            callback(_loc1_[key]);
         };
         if(getCache(upgrade)[key] == null)
         {
            loadPaymentMethods(country,methodsLoaded);
         }
         else
         {
            methodsLoaded();
         }
      }
      
      private static function getCache(param1:Boolean) : Object
      {
         return param1 ? upgradeMethodCache : regularMethodCache;
      }
      
      private static function checkCache(param1:Object, param2:Object) : void
      {
         if(!param1.hasOwnProperty(param2))
         {
            MessageCommunicator.sendMessage(MSPEvent.ERROR_ALERT,"key: " + param2 + " not found in PaymentCatalog");
         }
      }
   }
}

