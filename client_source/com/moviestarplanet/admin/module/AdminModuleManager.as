package com.moviestarplanet.admin.module
{
   import com.moviestarplanet.Module.AbstractModuleManager;
   import com.moviestarplanet.Module.ModuleInterface;
   import com.moviestarplanet.admin.valueobjects.ReportReader;
   import com.moviestarplanet.moviestar.valueObjects.Cloth;
   import com.moviestarplanet.moviestar.valueObjects.FacePart;
   import com.moviestarplanet.usersession.valueobjects.ActorPersonalInfo;
   
   public class AdminModuleManager extends AbstractModuleManager
   {
      
      private static var instance:AdminModuleManager;
      
      public function AdminModuleManager()
      {
         super();
      }
      
      public static function getInstance() : AdminModuleManager
      {
         if(instance == null)
         {
            instance = new AdminModuleManager();
         }
         return instance;
      }
      
      override protected function getLoadingThemeColor() : uint
      {
         return 0;
      }
      
      override protected function get moduleName() : String
      {
         return "AdminModule";
      }
      
      private function getAdminModule(param1:Function) : void
      {
         var moduleComplete:Function;
         var callback:Function = param1;
         var module:ModuleInterface = getModule();
         if(module == null)
         {
            moduleComplete = function():void
            {
               callback(IAdminModuleInfo(getModule()));
            };
            loadModule(moduleComplete);
         }
         else
         {
            callback(IAdminModuleInfo(module));
         }
      }
      
      public function openAdminWindow() : void
      {
         var moduleLoaded:Function = null;
         moduleLoaded = function(param1:IAdminModuleInfo):void
         {
            param1.openAdminWindow();
         };
         this.getAdminModule(moduleLoaded);
      }
      
      public function giveWarning(param1:int, param2:String, param3:Number, param4:Function = null) : void
      {
         var moduleLoaded:Function = null;
         var actorId:int = param1;
         var lockedText:String = param2;
         var chatLogId:Number = param3;
         var handle:Function = param4;
         moduleLoaded = function(param1:IAdminModuleInfo):void
         {
            param1.giveWarning(actorId,lockedText,chatLogId,handle);
         };
         this.getAdminModule(moduleLoaded);
      }
      
      public function giveAutoWarning(param1:int, param2:String, param3:int) : void
      {
         var moduleLoaded:Function = null;
         var actorId:int = param1;
         var lockedText:String = param2;
         var loc:int = param3;
         moduleLoaded = function(param1:IAdminModuleInfo):void
         {
            param1.giveAutoWarning(actorId,lockedText,loc);
         };
         this.getAdminModule(moduleLoaded);
      }
      
      public function lockUserOut(param1:int, param2:int, param3:String, param4:Number, param5:Function = null) : void
      {
         var moduleLoaded:Function = null;
         var actorId:int = param1;
         var numberOfDays:int = param2;
         var lockedText:String = param3;
         var chatLogId:Number = param4;
         var handle:Function = param5;
         moduleLoaded = function(param1:IAdminModuleInfo):void
         {
            param1.lockUserOut(actorId,numberOfDays,lockedText,chatLogId,handle);
         };
         this.getAdminModule(moduleLoaded);
      }
      
      public function OpenChatLog(param1:int, param2:ReportReader = null, param3:Number = 0, param4:Number = 0, param5:Function = null, param6:Function = null) : void
      {
         var moduleLoaded:Function = null;
         var actorId:int = param1;
         var reportReader:ReportReader = param2;
         var reportId:Number = param3;
         var categoryId:Number = param4;
         var handleCallback:Function = param5;
         var setFocusCallback:Function = param6;
         moduleLoaded = function(param1:IAdminModuleInfo):void
         {
            param1.OpenChatLog(actorId,reportReader,reportId,categoryId,handleCallback,setFocusCallback);
         };
         this.getAdminModule(moduleLoaded);
      }
      
      public function lockActor(param1:Number) : void
      {
         var moduleLoaded:Function = null;
         var actorId:Number = param1;
         moduleLoaded = function(param1:IAdminModuleInfo):void
         {
            param1.lockActor(actorId);
         };
         this.getAdminModule(moduleLoaded);
      }
      
      public function unLockActor(param1:Number) : void
      {
         var moduleLoaded:Function = null;
         var actorId:Number = param1;
         moduleLoaded = function(param1:IAdminModuleInfo):void
         {
            param1.unLockActor(actorId);
         };
         this.getAdminModule(moduleLoaded);
      }
      
      public function disconnectActor(param1:Number) : void
      {
         var moduleLoaded:Function = null;
         var actorId:Number = param1;
         moduleLoaded = function(param1:IAdminModuleInfo):void
         {
            param1.disconnectActor(actorId);
         };
         this.getAdminModule(moduleLoaded);
      }
      
      public function showParentalAdministration(param1:ActorPersonalInfo) : void
      {
         var moduleLoaded:Function = null;
         var api:ActorPersonalInfo = param1;
         moduleLoaded = function(param1:IAdminModuleInfo):void
         {
            param1.showParentalAdministration(api);
         };
         this.getAdminModule(moduleLoaded);
      }
      
      public function editClothes(param1:Cloth = null, param2:Boolean = false) : void
      {
         var moduleLoaded:Function = null;
         var clothes:Cloth = param1;
         var itemMode:Boolean = param2;
         moduleLoaded = function(param1:IAdminModuleInfo):void
         {
            param1.editClothes(clothes,itemMode);
         };
         this.getAdminModule(moduleLoaded);
      }
      
      public function editFacepart(param1:FacePart = null) : void
      {
         var moduleLoaded:Function = null;
         var facePart:FacePart = param1;
         moduleLoaded = function(param1:IAdminModuleInfo):void
         {
            param1.editFaceparts(facePart);
         };
         this.getAdminModule(moduleLoaded);
      }
   }
}

