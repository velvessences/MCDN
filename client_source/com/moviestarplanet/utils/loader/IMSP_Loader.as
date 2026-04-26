package com.moviestarplanet.utils.loader
{
   import com.moviestarplanet.loader.ILoaderUrl;
   import flash.display.DisplayObject;
   import flash.display.LoaderInfo;
   import flash.events.IEventDispatcher;
   import flash.system.LoaderContext;
   
   public interface IMSP_Loader extends IEventDispatcher
   {
      
      function get sourceUrl() : String;
      
      function set sourceUrl(param1:String) : void;
      
      function get LoadCallBack() : Function;
      
      function set LoadCallBack(param1:Function) : void;
      
      function get LoadFailCallBack() : Function;
      
      function set LoadFailCallBack(param1:Function) : void;
      
      function get isDeletable() : Boolean;
      
      function set isDeletable(param1:Boolean) : void;
      
      function doLoad() : void;
      
      function LoadUrl(param1:ILoaderUrl, param2:int = 2, param3:Boolean = true) : void;
      
      function get loadedContents() : *;
      
      function get content() : DisplayObject;
      
      function get contentLoaderInfo() : LoaderInfo;
      
      function dispose() : void;
      
      function set loaderContext(param1:LoaderContext) : void;
      
      function get loaderContext() : LoaderContext;
      
      function set buttonMode(param1:Boolean) : void;
      
      function get buttonMode() : Boolean;
   }
}

