package com.moviestarplanet.scrapblog.flash
{
   import com.moviestarplanet.Module.AbstractModuleManager;
   import flash.display.DisplayObject;
   import mx.core.UIComponent;
   
   public class ScrapBlogModuleManager extends AbstractModuleManager
   {
      
      private static var instance:ScrapBlogModuleManager;
      
      public function ScrapBlogModuleManager()
      {
         super();
      }
      
      public static function getInstance() : ScrapBlogModuleManager
      {
         if(null == instance)
         {
            instance = new ScrapBlogModuleManager();
         }
         return instance;
      }
      
      override protected function get moduleName() : String
      {
         return "ScrapBlogModuleFlash";
      }
      
      override protected function getLoadingThemeColor() : uint
      {
         return 11184810;
      }
      
      private function moduleWhenReady(param1:Function) : void
      {
         if(getModule() == null)
         {
            loadModule(param1);
         }
         else
         {
            param1();
         }
      }
      
      private function get scrapBlogModuleI() : ScrapBlogModule
      {
         return getModule() as ScrapBlogModule;
      }
      
      public function showScrapBlog(param1:Number) : void
      {
         var ready:Function = null;
         var scrapBlogId:Number = param1;
         ready = function():void
         {
            scrapBlogModuleI.viewScrapBlog(scrapBlogId,-2);
         };
         this.moduleWhenReady(ready);
      }
      
      public function getContent(param1:Number, param2:Function, param3:Boolean = false, param4:Number = 0, param5:Number = 0) : void
      {
         var ready:Function = null;
         var scrapBlogId:Number = param1;
         var callback:Function = param2;
         var hideWhileLoading:Boolean = param3;
         var requestedWidth:Number = param4;
         var requestedHeight:Number = param5;
         ready = function():void
         {
            scrapBlogModuleI.getContent(scrapBlogId,hideWhileLoading,callback,requestedWidth,requestedHeight);
         };
         this.moduleWhenReady(ready);
      }
      
      public function getContentForFlex(param1:Number, param2:Function, param3:Boolean = false, param4:Number = 0, param5:Number = 0) : void
      {
         var ready:Function = null;
         var done:Function = null;
         var scrapBlogId:Number = param1;
         var callback:Function = param2;
         var hideWhileLoading:Boolean = param3;
         var requestedWidth:Number = param4;
         var requestedHeight:Number = param5;
         ready = function():void
         {
            scrapBlogModuleI.getContent(scrapBlogId,hideWhileLoading,done,requestedWidth,requestedHeight);
         };
         done = function(param1:DisplayObject):void
         {
            var _loc2_:UIComponent = new UIComponent();
            _loc2_.addChild(param1);
            callback(_loc2_);
         };
         this.moduleWhenReady(ready);
      }
      
      public function editScrapBlog(param1:int) : void
      {
         var ready:Function = null;
         var scrapBlogId:int = param1;
         ready = function():void
         {
            scrapBlogModuleI.editScrapBlog(scrapBlogId);
         };
         this.moduleWhenReady(ready);
      }
      
      public function createScrapBlog(param1:int) : void
      {
         var ready:Function = null;
         var type:int = param1;
         ready = function():void
         {
            scrapBlogModuleI.createScrapBlog(type);
         };
         this.moduleWhenReady(ready);
      }
      
      public function showArtBookOverView() : void
      {
         var ready:Function = null;
         ready = function():void
         {
            scrapBlogModuleI.showArtBookOverview();
         };
         this.moduleWhenReady(ready);
      }
   }
}

