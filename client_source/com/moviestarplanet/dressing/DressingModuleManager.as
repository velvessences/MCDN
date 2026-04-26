package com.moviestarplanet.dressing
{
   import com.moviestarplanet.Module.AbstractFlashModuleManager;
   import com.moviestarplanet.Module.IFlashModule;
   import com.moviestarplanet.model.ActorModel;
   
   public class DressingModuleManager extends AbstractFlashModuleManager
   {
      
      private static var instance:DressingModuleManager;
      
      public function DressingModuleManager(param1:SingletonEnforcer)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : DressingModuleManager
      {
         if(instance == null)
         {
            instance = new DressingModuleManager(new SingletonEnforcer());
         }
         return instance;
      }
      
      override protected function get moduleName() : String
      {
         return "DressingModule";
      }
      
      private function getDressingModule(param1:Function) : void
      {
         var moduleComplete:Function;
         var callback:Function = param1;
         var module:IFlashModule = getModule();
         if(module == null)
         {
            moduleComplete = function():void
            {
               initModule();
               callback(IDressingModule(getModule()));
            };
            loadModule(moduleComplete);
         }
         else
         {
            callback(IDressingModule(module));
         }
      }
      
      private function initModule() : void
      {
         (getModule() as IDressingModule).setActorModel(ActorModel.getInstance());
      }
      
      public function openDressingRoom(param1:Number = 0, param2:Function = null, param3:Boolean = false) : void
      {
         var moduleLoaded:Function = null;
         var ActorId:Number = param1;
         var ClothesChangedCallback:Function = param2;
         var comingFromLooksOverview:Boolean = param3;
         moduleLoaded = function(param1:IDressingModule):void
         {
            param1.openDressingRoom(ActorId,ClothesChangedCallback,comingFromLooksOverview);
         };
         this.getDressingModule(moduleLoaded);
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
