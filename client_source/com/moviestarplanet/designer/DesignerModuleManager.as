package com.moviestarplanet.designer
{
   import com.moviestarplanet.Module.AbstractFlashModuleManager;
   import com.moviestarplanet.Module.IFlashModule;
   import com.moviestarplanet.model.ActorModel;
   import com.moviestarplanet.scrapitems.service.ClipArtAMFService;
   
   public class DesignerModuleManager extends AbstractFlashModuleManager
   {
      
      private static var instance:DesignerModuleManager;
      
      public function DesignerModuleManager(param1:SingletonEnforcer)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : DesignerModuleManager
      {
         if(instance == null)
         {
            instance = new DesignerModuleManager(new SingletonEnforcer());
         }
         return instance;
      }
      
      override protected function get moduleName() : String
      {
         return "DesignerModule";
      }
      
      private function getDesignerModule(param1:Function) : void
      {
         var moduleComplete:Function;
         var callback:Function = param1;
         var module:IFlashModule = getModule();
         if(module == null)
         {
            moduleComplete = function():void
            {
               initModule();
               callback(IDesignerModule(getModule()));
            };
            loadModule(moduleComplete);
         }
         else
         {
            callback(IDesignerModule(module));
         }
      }
      
      private function initModule() : void
      {
         (getModule() as IDesignerModule).setActorModel(ActorModel.getInstance());
         (getModule() as IDesignerModule).setClipArtProvider(new ClipArtAMFService());
      }
      
      public function openDesignerBrowser() : void
      {
         var moduleLoaded:Function = null;
         moduleLoaded = function(param1:IDesignerModule):void
         {
            param1.openDesignerBrowser();
         };
         this.getDesignerModule(moduleLoaded);
      }
      
      public function showDesignCreator() : void
      {
         var moduleLoaded:Function = null;
         moduleLoaded = function(param1:IDesignerModule):void
         {
            param1.createDesign();
         };
         this.getDesignerModule(moduleLoaded);
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
