package com.moviestarplanet.pictures
{
   import com.moviestarplanet.Module.AbstractFlashModuleManager;
   import com.moviestarplanet.Module.IFlashModule;
   import com.moviestarplanet.flash.components.comments.CommentsComponent;
   import com.moviestarplanet.utils.EntityTypeType;
   
   public class PicturesModuleManager extends AbstractFlashModuleManager
   {
      
      private static var instance:PicturesModuleManager;
      
      public function PicturesModuleManager(param1:SingletonEnforcer)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : PicturesModuleManager
      {
         if(instance == null)
         {
            instance = new PicturesModuleManager(new SingletonEnforcer());
         }
         return instance;
      }
      
      override protected function get moduleName() : String
      {
         return "PictureUploadModule";
      }
      
      private function getPictureUploadModule(param1:Function) : void
      {
         var moduleComplete:Function;
         var callback:Function = param1;
         var module:IFlashModule = getModule();
         if(module == null)
         {
            moduleComplete = function():void
            {
               (getModule() as IPictureUploadModule).setCommentsComponent(CommentsComponent.getInstance(EntityTypeType.IMAGE_UPLOAD));
               callback(IPictureUploadModule(getModule()));
            };
            loadModule(moduleComplete);
         }
         else
         {
            callback(IPictureUploadModule(module));
         }
      }
      
      public function openPictureUpload(param1:int = -1) : void
      {
         var moduleLoaded:Function = null;
         var photoNotificationId:int = param1;
         moduleLoaded = function(param1:IPictureUploadModule):void
         {
            param1.openPictureUpload(photoNotificationId);
         };
         this.getPictureUploadModule(moduleLoaded);
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
