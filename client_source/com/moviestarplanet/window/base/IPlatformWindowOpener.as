package com.moviestarplanet.window.base
{
   import com.moviestarplanet.window.utils.IWindowStackObserver;
   
   public interface IPlatformWindowOpener
   {
      
      function ResizeWindows() : void;
      
      function openWindow(param1:Object, param2:int = 0, param3:Object = null) : void;
      
      function closeWindow(param1:Object) : void;
      
      function destroy() : void;
      
      function closeAllWindows() : void;
      
      function startObservingWindowStack(param1:IWindowStackObserver) : void;
      
      function stopObservingWindowStack(param1:IWindowStackObserver) : void;
      
      function getStacks() : Vector.<Object>;
   }
}

