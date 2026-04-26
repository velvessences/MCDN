package com.moviestarplanet.windowpopup.popup
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.display.IWindowScaler;
   import com.moviestarplanet.display.IWindowScalerScalable;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.utils.displayobject.DisplayObjectUtil;
   import com.moviestarplanet.utils.flash.MSP_FlashLoader;
   import com.moviestarplanet.utils.loader.AssetUrl;
   import com.moviestarplanet.utils.loader.IMSP_Loader;
   import com.moviestarplanet.utils.loader.MSP_LoaderManager;
   import com.moviestarplanet.utils.loader.RawUrl;
   import com.moviestarplanet.utils.translation.TranslationUtilities;
   import com.moviestarplanet.window.base.AbstractWindow;
   import com.moviestarplanet.window.base.IPlatformWindowOpener;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class BaseSwfPopup extends AbstractWindow implements IWindowScalerScalable
   {
      
      [Inject]
      public var windowOpener:IPlatformWindowOpener;
      
      [Inject]
      public var windowScaler:IWindowScaler;
      
      protected var content:DisplayObject;
      
      private var bounds:Rectangle;
      
      public function BaseSwfPopup(param1:String)
      {
         var _loc2_:IMSP_Loader = null;
         super();
         InjectionManager.manager().injectMe(this);
         MessageCommunicator.send(new MsgEvent(MSPEvent.LOADING_SHOW));
         _loc2_ = new MSP_FlashLoader(true);
         _loc2_.LoadCallBack = this.loadDone;
         _loc2_.LoadUrl(new RawUrl(AssetUrl.serverCdnPrefix + param1),MSP_LoaderManager.PRIORITY_UI);
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler,false,0,true);
      }
      
      protected function hideLoading() : void
      {
         MessageCommunicator.send(new MsgEvent(MSPEvent.LOADING_HIDE));
      }
      
      override public function getWindowRectangle() : Rectangle
      {
         return new Rectangle(this.xPos,this.yPos,this.contentWidth,this.contentHeight);
      }
      
      protected function loadDone(param1:MSP_FlashLoader) : void
      {
         this.content = param1.content;
         TranslationUtilities.translateDisplayObject(param1.content,true);
         addChild(param1);
         scrollRect = new Rectangle(0,0,this.contentWidth,this.contentHeight);
         this.hideLoading();
         this.show();
      }
      
      protected function show() : void
      {
         this.windowOpener.openWindow(this);
         if(this.windowScaler != null)
         {
            this.windowScaler.scale(this,10,false,200);
         }
      }
      
      protected function close() : void
      {
         this.windowOpener.closeWindow(this);
      }
      
      protected function get xPos() : int
      {
         var _loc1_:int = 235;
         var _loc2_:int = 980;
         return _loc1_ + _loc2_ / 2 - this.contentWidth / 2;
      }
      
      protected function get yPos() : int
      {
         var _loc1_:int = 80;
         var _loc2_:int = 500;
         return _loc1_ + _loc2_ / 2 - this.contentHeight / 2;
      }
      
      protected function get contentWidth() : int
      {
         if(this.bounds == null)
         {
            this.bounds = DisplayObjectUtil.getVisibleBounds(this.content);
         }
         return this.bounds.width;
      }
      
      protected function get contentHeight() : int
      {
         if(this.bounds == null)
         {
            this.bounds = DisplayObjectUtil.getVisibleBounds(this.content);
         }
         return this.bounds.height;
      }
      
      private function removedFromStageHandler(param1:Event) : void
      {
         var thisInstance:BaseSwfPopup = null;
         var event:Event = param1;
         var destroyIfRemoved:Function = function(param1:TimerEvent):void
         {
            if(thisInstance.stage == null)
            {
               destroy();
            }
         };
         thisInstance = this;
         var timer:Timer = new Timer(1,1);
         timer.addEventListener(TimerEvent.TIMER,destroyIfRemoved);
         timer.start();
      }
      
      protected function destroy() : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
      }
   }
}

