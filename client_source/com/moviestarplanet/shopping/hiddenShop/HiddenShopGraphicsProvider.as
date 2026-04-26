package com.moviestarplanet.shopping.hiddenShop
{
   import com.moviestarplanet.flash.graphics.GraphicsProviderEvent;
   import com.moviestarplanet.shopping.hiddenShop.rendering.FlashHiddenShop;
   import com.moviestarplanet.shopping.hiddenShop.rendering.Selection;
   import com.moviestarplanet.utils.flash.MSP_FlashLoader;
   import com.moviestarplanet.utils.loader.MSP_LoaderManager;
   import com.moviestarplanet.utils.loader.RawUrl;
   import flash.display.DisplayObject;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.net.registerClassAlias;
   
   public class HiddenShopGraphicsProvider extends EventDispatcher
   {
      
      private var _ready:Boolean;
      
      private var loaderinfo:LoaderInfo;
      
      public function HiddenShopGraphicsProvider()
      {
         super();
      }
      
      protected function get url() : String
      {
         return "swf/tools/HiddenShop.swf";
      }
      
      private function loadComplete(param1:MSP_FlashLoader) : void
      {
         this.loaderinfo = param1.content.loaderInfo;
         this.registerClasses();
         dispatchEvent(new GraphicsProviderEvent(GraphicsProviderEvent.GRAPHICS_LOADED,this));
         this._ready = true;
      }
      
      private function registerClasses() : void
      {
         registerClassAlias("com.moviestarplanet.shopping.hiddenShop.rendering.FlashHiddenShop",FlashHiddenShop);
         registerClassAlias("com.moviestarplanet.shopping.hiddenShop.rendering.Selection",Selection);
      }
      
      public function load() : void
      {
         MSP_FlashLoader.RequestLoad(new RawUrl(this.url),this.loadComplete,MSP_LoaderManager.PRIORITY_UI,true,true);
      }
      
      public function provideSymbol(param1:String) : DisplayObject
      {
         var _loc2_:Class = this.loaderinfo.applicationDomain.getDefinition(param1) as Class;
         var _loc3_:DisplayObject = new _loc2_() as DisplayObject;
         if(_loc3_ is MovieClip)
         {
            (_loc3_ as MovieClip).stop();
         }
         return _loc3_;
      }
      
      public function get mainScreen() : FlashHiddenShop
      {
         return FlashHiddenShop(this.provideSymbol("com.moviestarplanet.shopping.hiddenShop.rendering.FlashHiddenShop"));
      }
      
      public function get selection() : Selection
      {
         return Selection(this.provideSymbol("com.moviestarplanet.shopping.hiddenShop.rendering.Selection"));
      }
   }
}

