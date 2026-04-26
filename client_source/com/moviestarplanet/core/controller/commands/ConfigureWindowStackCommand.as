package com.moviestarplanet.core.controller.commands
{
   import com.greensock.TweenMax;
   import com.moviestarplanet.Components.CloseButton;
   import com.moviestarplanet.Windows.WindowScalerWeb;
   import com.moviestarplanet.analytics.timer.IWindowString;
   import com.moviestarplanet.analytics.timer.WindowStringWeb;
   import com.moviestarplanet.display.IWindowScaler;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.window.base.IPlatformWindowOpener;
   import com.moviestarplanet.window.stack.WebWindowOpener;
   import com.moviestarplanet.window.stack.WindowStack;
   import com.moviestarplanet.window.utils.PopupUtils;
   
   public class ConfigureWindowStackCommand
   {
      
      public function ConfigureWindowStackCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         WindowStack.container = Main.Instance.mainCanvas;
         WindowStack.defaultCloseButtonClass = CloseButton;
         WindowStack.tweenerClass = TweenMax;
         PopupUtils.rootContainer = Main.Instance.mainCanvas;
         PopupUtils.windowCanvasRect = ApplicationReference.getApplicationSize();
         InjectionManager.mapper().map(IPlatformWindowOpener).toValue(WebWindowOpener.instance());
         InjectionManager.mapper().map(IWindowScaler).toSingleton(WindowScalerWeb);
         InjectionManager.mapper().map(IWindowString).toSingleton(WindowStringWeb);
      }
   }
}

