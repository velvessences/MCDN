package com.moviestarplanet.safety
{
   import com.moviestarplanet.utils.displayobject.DisplayObjectUtilities;
   import com.moviestarplanet.utils.loader.RawUrl;
   import com.moviestarplanet.utils.swfmapping.SWFPropertyBinder;
   import com.moviestarplanet.utils.ui.FlashInstanceUtils;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   import mx.controls.SWFLoader;
   
   public class SafetyHandler
   {
      
      private static var instance:SafetyHandler;
      
      private var safetyBinder:SWFPropertyBinder;
      
      private var container:DisplayObjectContainer;
      
      private var safetyScreen:SWFLoader;
      
      private var isOpen:Boolean = false;
      
      private var _version:String;
      
      public function SafetyHandler()
      {
         super();
         this.container = Main.Instance.mainCanvas.overlayContainer;
      }
      
      public static function getInstance() : SafetyHandler
      {
         if(instance == null)
         {
            instance = new SafetyHandler();
         }
         return instance;
      }
      
      public function addCornerAd(param1:String) : void
      {
         this._version = param1;
         FlashInstanceUtils.loadFlashInstance(ApplicationDomain.currentDomain,new RawUrl("swf/safety/SafetyCornerAd.swf"),this.loadDone);
      }
      
      private function loadDone(param1:SWFLoader) : void
      {
         var _loc2_:Object = param1.content;
         Main.Instance.mainCanvas.applicationViewStack.mainView.moviestarContainer.addChild(param1);
         param1.x = 1020;
         param1.y = 335;
         DisplayObjectUtilities.buttonize(param1,this.onClicked,true);
      }
      
      private function onClicked(param1:MouseEvent) : void
      {
         SafetyPopUp.show(this._version);
      }
   }
}

