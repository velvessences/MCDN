package com.moviestarplanet.window.base
{
   import com.moviestarplanet.display.IWindowScaler;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.window.utils.IWindowStackObserver;
   import flash.display.DisplayObject;
   
   public class WindowOpener
   {
      
      private static var singleton:WindowOpener;
      
      [Inject]
      public var platformWindowOpener:IPlatformWindowOpener;
      
      [Inject]
      public var windowScaler:IWindowScaler;
      
      public function WindowOpener()
      {
         super();
         if(singleton != null)
         {
            throw new Error("WindowOpener is a singleton.");
         }
         InjectionManager.manager().injectMe(this);
      }
      
      public static function openWindow(param1:Object, param2:int = 9, param3:Object = null) : void
      {
         if(param1 != null)
         {
            getInstance().platformWindowOpener.openWindow(param1,param2,param3);
         }
      }
      
      public static function closeWindow(param1:Object) : void
      {
         if(param1 != null)
         {
            getInstance().platformWindowOpener.closeWindow(param1);
         }
      }
      
      public static function getStacks() : Vector.<Object>
      {
         return getInstance().platformWindowOpener.getStacks();
      }
      
      public static function closeAllWindows() : void
      {
         getInstance().platformWindowOpener.closeAllWindows();
      }
      
      public static function openAndScale(param1:DisplayObject, param2:int = 9, param3:int = 10, param4:Boolean = false, param5:int = 90) : void
      {
         if(getInstance().windowScaler != null)
         {
            getInstance().windowScaler.scale(param1,param3,param4,param5);
         }
         if(param1 != null)
         {
            getInstance().platformWindowOpener.openWindow(param1,param2);
         }
      }
      
      public static function openModal(param1:DisplayObject) : void
      {
         var _loc2_:Object = new Object();
         _loc2_.doClickOutsideClose = false;
         if(param1 != null)
         {
            getInstance().platformWindowOpener.openWindow(param1,WindowLayers.NOTICE,_loc2_);
         }
      }
      
      public static function openAndScaleModal(param1:DisplayObject, param2:int = 10, param3:Boolean = false, param4:int = 90) : void
      {
         if(getInstance().windowScaler != null)
         {
            getInstance().windowScaler.scale(param1,param2,param3,param4);
         }
         openModal(param1);
      }
      
      public static function startObservingWindowStack(param1:IWindowStackObserver) : void
      {
         getInstance().platformWindowOpener.startObservingWindowStack(param1);
      }
      
      public static function stopObservingWindowStack(param1:IWindowStackObserver) : void
      {
         getInstance().platformWindowOpener.stopObservingWindowStack(param1);
      }
      
      private static function getInstance() : WindowOpener
      {
         if(singleton == null)
         {
            singleton = new WindowOpener();
         }
         return singleton;
      }
      
      public static function destroyInstance() : void
      {
         singleton = null;
      }
   }
}

