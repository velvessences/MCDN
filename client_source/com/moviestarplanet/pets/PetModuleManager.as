package com.moviestarplanet.pets
{
   import com.moviestarplanet.Module.AbstractFlashModuleManager;
   import com.moviestarplanet.Module.IFlashModule;
   
   public class PetModuleManager extends AbstractFlashModuleManager implements IPetModuleManager
   {
      
      private static var instance:PetModuleManager;
      
      public function PetModuleManager(param1:SingletonEnforcer)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : PetModuleManager
      {
         if(instance == null)
         {
            instance = new PetModuleManager(new SingletonEnforcer());
         }
         return instance;
      }
      
      public function openPetPopup(param1:int, param2:Number, param3:Number, param4:Object) : void
      {
         var moduleLoaded:Function = null;
         var actorBonsterRelId:int = param1;
         var xCoord:Number = param2;
         var yCoord:Number = param3;
         var referencePet:Object = param4;
         moduleLoaded = function(param1:IPetModule):void
         {
            (getModule() as IPetModule).openPetPopUp(actorBonsterRelId,xCoord,yCoord,referencePet);
         };
         this.getPetModule(moduleLoaded);
      }
      
      override protected function get moduleName() : String
      {
         return "PetModule";
      }
      
      private function getPetModule(param1:Function) : void
      {
         var moduleComplete:Function;
         var callback:Function = param1;
         var module:IFlashModule = getModule();
         if(module == null)
         {
            moduleComplete = function():void
            {
               callback(IPetModule(getModule()));
            };
            loadModule(moduleComplete);
         }
         else
         {
            callback(IPetModule(module));
         }
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
