package com.moviestarplanet.window.loading
{
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.locale.ILocaleManager;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import mx.core.FlexGlobals;
   
   public class LoadingBar extends LoadingProgressBarAS implements ILoadingOverlay
   {
      
      [Inject]
      public var localeManager:ILocaleManager;
      
      private var closeTimer:Timer = new Timer(10000,1);
      
      public function LoadingBar(param1:String = "")
      {
         InjectionManager.manager().injectMe(this);
         if(param1 == "")
         {
            param1 = this.loadingDefaultText;
         }
         this.label = param1;
         super();
      }
      
      private function get loadingDefaultText() : String
      {
         return this.localeManager.getString("LOADING");
      }
      
      public function show() : void
      {
         calculatePosition();
         visible = true;
         FlexGlobals.topLevelApplication.mainCanvas.addChild(this);
         this.closeTimer.addEventListener(TimerEvent.TIMER,this.loadingBarTimeOut);
         this.closeTimer.start();
      }
      
      public function hide() : void
      {
         this.closeTimer.stop();
         this.closeTimer.removeEventListener(TimerEvent.TIMER,this.loadingBarTimeOut);
         if(this.parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      private function loadingBarTimeOut(param1:TimerEvent) : void
      {
         this.hide();
      }
   }
}

