package com.moviestarplanet.Module
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.session.service.SessionAmfServiceForWeb;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   import flash.system.SecurityDomain;
   import flash.utils.getQualifiedClassName;
   import mx.events.ModuleEvent;
   import mx.modules.IModuleInfo;
   import mx.modules.ModuleManager;
   
   public class AbstractModuleManager implements ModuleManagerInterface
   {
      
      public static var applicationRoot:DisplayObjectContainer;
      
      public static var serverCdnPrefix:String;
      
      private var _isModuleLoaded:Boolean = false;
      
      private var module:ModuleInterface;
      
      private var callbackQueue:Array;
      
      private var isLoading:Boolean = false;
      
      private var loadErrorCount:int;
      
      private var moduleInfo:IModuleInfo;
      
      public function AbstractModuleManager()
      {
         super();
         if(getQualifiedClassName(this).indexOf("AbstractModuleManager") >= 0)
         {
            throw new Error("AbstractModuleManager is an abstract class and cannot be instantiated.");
         }
         this.loadErrorCount = 0;
         this.callbackQueue = new Array();
      }
      
      public function get isModuleLoaded() : Boolean
      {
         return this._isModuleLoaded;
      }
      
      protected function get moduleName() : String
      {
         throw new Error(getQualifiedClassName(this) + " has not overwritten moduleName method.");
      }
      
      protected function getLoadingThemeColor() : uint
      {
         throw new Error(getQualifiedClassName(this) + " has not overwritten getLoadingThemeColor method.");
      }
      
      public function loadModule(param1:Function = null) : void
      {
         var versionDone:Function;
         var loadComplete:Function = null;
         var loadError:Function = null;
         var callback:Function = param1;
         loadComplete = function(param1:Event):void
         {
            moduleInfo.removeEventListener(ModuleEvent.READY,loadComplete);
            moduleInfo.removeEventListener(ModuleEvent.ERROR,loadError);
            var _loc2_:* = moduleInfo.factory.create();
            if(_loc2_ is ModuleInterface == false)
            {
               throw new Error("Module " + getQualifiedClassName(_loc2_) + " is not of type ModuleInterface.");
            }
            parseInjection(_loc2_);
            module = ModuleInterface(_loc2_);
            MessageCommunicator.send(new MsgEvent(MSPEvent.LOADING_HIDE));
            moduleLoaded();
            _isModuleLoaded = true;
            isLoading = false;
         };
         loadError = function(param1:Event):void
         {
            if(loadErrorCount < 1)
            {
               ++loadErrorCount;
               loadModule(moduleLoaded);
               if(Config.IsRunningInDevelopment)
               {
                  throw new Error("Module missing : " + param1.target.url);
               }
            }
         };
         this.callbackQueue.push(callback);
         if(!this.isLoading)
         {
            versionDone = function(param1:String):void
            {
               var _loc2_:String = serverCdnPrefix + param1;
               if(Config.IsRunningLocally && Config.debugRemote())
               {
                  _loc2_ = _loc2_.slice(0,_loc2_.indexOf("?v="));
               }
               moduleInfo = ModuleManager.getModule(_loc2_);
               moduleInfo.addEventListener(ModuleEvent.READY,loadComplete);
               moduleInfo.addEventListener(ModuleEvent.ERROR,loadError);
               moduleInfo.load(ApplicationDomain.currentDomain,SecurityDomain.currentDomain);
            };
            this.isLoading = true;
            MessageCommunicator.send(new MsgEvent(MSPEvent.LOADING_SHOW));
            new SessionAmfServiceForWeb().getModuleVersion(this.moduleName,versionDone);
         }
      }
      
      private function parseInjection(param1:*) : void
      {
         if(param1 is ApplicationInjectInterface)
         {
            (param1 as ApplicationInjectInterface).applicationRoot = applicationRoot;
         }
         if(param1 is InjectInterface)
         {
            (param1 as InjectInterface).commitInjection();
         }
      }
      
      private function moduleLoaded() : void
      {
         while(this.callbackQueue.length > 0)
         {
            (this.callbackQueue.pop() as Function)();
         }
      }
      
      protected function getModule() : ModuleInterface
      {
         return this.module;
      }
   }
}

