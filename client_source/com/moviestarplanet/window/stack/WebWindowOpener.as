package com.moviestarplanet.window.stack
{
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.window.base.AbstractWindow;
   import com.moviestarplanet.window.base.IPlatformWindowOpener;
   import com.moviestarplanet.window.base.WindowLayers;
   import com.moviestarplanet.window.event.WindowEvent;
   import com.moviestarplanet.window.utils.IWindowStackObserver;
   import com.moviestarplanet.window.utils.PopupUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class WebWindowOpener implements IPlatformWindowOpener
   {
      
      private static var singleton:WebWindowOpener;
      
      public function WebWindowOpener()
      {
         super();
      }
      
      public static function instance() : IPlatformWindowOpener
      {
         if(singleton == null)
         {
            singleton = new WebWindowOpener();
         }
         return singleton;
      }
      
      public function ResizeWindows() : void
      {
         throw new Error("WebWindowOpener.ResizeWindows not implemented");
      }
      
      public function openWindow(param1:Object, param2:int = 0, param3:Object = null) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:DisplayObject = param1 as DisplayObject;
         if(param3 != null && param3.x != null && param3.y != null)
         {
            _loc5_ = int(parseInt(param3.x));
            _loc6_ = int(parseInt(param3.y));
         }
         else
         {
            _loc5_ = this.getX(_loc4_);
            _loc6_ = this.getY(_loc4_);
         }
         if(param2 == 0)
         {
            param2 = this.getZ(_loc4_);
         }
         if(param1 is WindowStackableInterface)
         {
            WindowStack.showViewStackable(param1 as WindowStackableInterface,_loc5_,_loc6_,param2);
         }
         else
         {
            if(!(param1 is Sprite))
            {
               throw new ArgumentError("WebWindowOpener cannot open " + param1);
            }
            WindowStack.showSpriteAsViewStackable(param1 as Sprite,_loc5_,_loc6_,param2);
         }
         MessageCommunicator.sendMessage(WindowEvent.WINDOW_OPENED,param1);
      }
      
      private function getX(param1:DisplayObject) : int
      {
         if(param1 is AbstractWindow)
         {
            return (param1 as AbstractWindow).getWindowRectangle().x;
         }
         if(param1.x > 0 || param1.y > 0)
         {
            return param1.x;
         }
         return PopupUtils.windowCanvasRect.x + (PopupUtils.windowCanvasRect.width - param1.width) / 2;
      }
      
      private function getY(param1:DisplayObject) : int
      {
         if(param1 is AbstractWindow)
         {
            return (param1 as AbstractWindow).getWindowRectangle().y;
         }
         if(param1.x > 0 || param1.y > 0)
         {
            return param1.y;
         }
         return PopupUtils.windowCanvasRect.y + (PopupUtils.windowCanvasRect.height - param1.height) / 2;
      }
      
      private function getZ(param1:DisplayObject) : int
      {
         if(param1 is AbstractWindow)
         {
            return (param1 as AbstractWindow).getZIndex();
         }
         return WindowLayers.NOTICE;
      }
      
      public function closeWindow(param1:Object) : void
      {
         if(param1 is WindowStackableInterface)
         {
            WindowStack.removeViewStackable(param1 as WindowStackableInterface);
         }
         else
         {
            if(!(param1 is Sprite))
            {
               throw new ArgumentError("WebWindowOpener cannot close " + param1);
            }
            WindowStack.removeSpriteViewStackable(param1 as Sprite);
         }
      }
      
      public function destroy() : void
      {
         singleton = null;
      }
      
      public function closeAllWindows() : void
      {
         WindowStack.closeAllWindows();
      }
      
      public function getStacks() : Vector.<Object>
      {
         return WindowStack.windowStack.getStacks();
      }
      
      public function startObservingWindowStack(param1:IWindowStackObserver) : void
      {
      }
      
      public function stopObservingWindowStack(param1:IWindowStackObserver) : void
      {
      }
   }
}

