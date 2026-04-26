package com.moviestarplanet.Module
{
   import avmplus.getQualifiedClassName;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.session.service.SessionAmfServiceForWeb;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.SecurityDomain;
   
   public class AbstractFlashModuleManager
   {
      
      public static var applicationRoot:DisplayObjectContainer;
      
      public static var serverCdnPrefix:String;
      
      private var _isModuleLoaded:Boolean = false;
      
      private var module:IFlashModule;
      
      private var callbackQueue:Array;
      
      private var isLoading:Boolean = false;
      
      private var loadErrorCount:int;
      
      private var loader:Loader;
      
      public function AbstractFlashModuleManager()
      {
         super();
         if(getQualifiedClassName(this).indexOf("AbstractFlashModuleManager") >= 0)
         {
            throw new Error("AbstractFlashModuleManager is an abstract class and cannot be instantiated.");
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
      
      public function loadModule(param1:Function = null) : void
      {
         var versionDone:Function;
         var loadComplete:Function = null;
         var loadError:Function = null;
         var callback:Function = param1;
         loadComplete = function(param1:Event):void
         {
            loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadComplete);
            loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadError);
            var _loc2_:* = loader.content;
            if(_loc2_ is IFlashModule == false)
            {
               throw new Error("Module " + getQualifiedClassName(_loc2_) + " is not of type IFlashModule");
            }
            parseInjection(_loc2_);
            module = IFlashModule(_loc2_);
            _isModuleLoaded = true;
            isLoading = false;
            MessageCommunicator.send(new MsgEvent(MSPEvent.LOADING_HIDE));
            moduleLoaded();
         };
         loadError = function(param1:Event):void
         {
            if(loadErrorCount < 1)
            {
               ++loadErrorCount;
               loadModule(moduleLoaded);
            }
            if(Config.IsRunningInDevelopment)
            {
               throw new Error("External module missing for " + moduleName);
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
               loader = new Loader();
               var _loc3_:LoaderContext = new LoaderContext(true,ApplicationDomain.currentDomain,SecurityDomain.currentDomain);
               loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
               loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadError);
               loader.load(new URLRequest(_loc2_),_loc3_);
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
         if(param1 is ILocaleManagerInject)
         {
            (param1 as ILocaleManagerInject).localeManager = MSPLocaleManagerWeb.getInstance();
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
      
      protected function getModule() : IFlashModule
      {
         return this.module;
      }
   }
}

