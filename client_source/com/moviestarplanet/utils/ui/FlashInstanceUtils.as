package com.moviestarplanet.utils.ui
{
   import com.moviestarplanet.controls.utils.Buttonizer;
   import com.moviestarplanet.loader.ILoaderUrl;
   import com.moviestarplanet.utils.displayobject.DisplayObjectUtil;
   import com.moviestarplanet.utils.flash.MSP_FlashLoader;
   import com.moviestarplanet.utils.loader.IMSP_Loader;
   import com.moviestarplanet.utils.loader.MSP_LoaderManager;
   import com.moviestarplanet.utils.loaderfacade.LoaderFacade;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public class FlashInstanceUtils
   {
      
      public function FlashInstanceUtils()
      {
         super();
      }
      
      public static function loadFlashInstance(param1:ApplicationDomain, param2:ILoaderUrl, param3:Function, param4:Boolean = true) : void
      {
         var loader:IMSP_Loader = null;
         var done:Function = null;
         var applicationDomain:ApplicationDomain = param1;
         var url:ILoaderUrl = param2;
         var loadDone:Function = param3;
         var doContentManage:Boolean = param4;
         done = function(param1:Event):void
         {
            loadDone(loader);
         };
         loader = LoaderFacade.createLoader(doContentManage);
         loader.addEventListener(Event.COMPLETE,done);
         loader.loaderContext = new LoaderContext(false,applicationDomain);
         loader.LoadUrl(url,MSP_LoaderManager.PRIORITY_UI);
      }
      
      public static function loadFlashInstanceNew(param1:ILoaderUrl, param2:Function, param3:Boolean = true) : void
      {
         var _loc4_:MSP_FlashLoader = new MSP_FlashLoader(param3);
         _loc4_.LoadCallBack = param2;
         _loc4_.LoadUrl(param1,MSP_LoaderManager.PRIORITY_UI);
      }
      
      public static function loadContentForInstance(param1:ILoaderUrl, param2:DisplayObjectContainer, param3:Function = null, param4:ILoaderUrl = null, param5:Boolean = true, param6:Boolean = true, param7:Boolean = false, param8:int = -1, param9:Function = null, param10:Boolean = true, param11:Boolean = false, param12:Boolean = false) : IMSP_Loader
      {
         var loader:IMSP_Loader = null;
         var loadComplete:Function = null;
         var loadFailed:Function = null;
         var contentUrl:ILoaderUrl = param1;
         var instance:DisplayObjectContainer = param2;
         var clickListener:Function = param3;
         var altContentUrl:ILoaderUrl = param4;
         var useGlow:Boolean = param5;
         var resize:Boolean = param6;
         var keepAspectRatio:Boolean = param7;
         var atIndex:int = param8;
         var loadResponse:Function = param9;
         var allowCodeImport:Boolean = param10;
         var center:Boolean = param11;
         var cleanPlaceholder:Boolean = param12;
         loadComplete = function(param1:Event):void
         {
            if(loadResponse != null)
            {
               loadResponse(true);
            }
            if(clickListener != null && instance != null)
            {
               Buttonizer.buttonize(instance,clickListener,useGlow);
            }
            if(clickListener != null)
            {
               loader.content.addEventListener(MouseEvent.CLICK,clickListener);
            }
            loader.buttonMode = true;
            addItemToInstance(loader.content,instance,resize,keepAspectRatio,center,cleanPlaceholder,atIndex);
         };
         loadFailed = function(param1:Event):void
         {
            if(loadResponse != null)
            {
               loadResponse(false);
            }
            if(altContentUrl != null)
            {
               loadContentForInstance(altContentUrl,instance,clickListener);
            }
         };
         loader = LoaderFacade.createLoader(true,allowCodeImport);
         loader.addEventListener(Event.COMPLETE,loadComplete);
         loader.addEventListener(IOErrorEvent.IO_ERROR,loadFailed);
         loader.LoadUrl(contentUrl);
         return loader;
      }
      
      public static function removeContentFromInstance(param1:IMSP_Loader, param2:DisplayObjectContainer) : void
      {
         if(param1 != null && param1.content != null)
         {
            removeItemFromInstance(param1.content,param2);
         }
      }
      
      public static function removeItemFromInstance(param1:DisplayObject, param2:DisplayObjectContainer) : void
      {
         if(param1 != null && param2 != null && Boolean(param2.contains(param1)))
         {
            param2.removeChild(param1);
         }
      }
      
      public static function addContentToInstance(param1:IMSP_Loader, param2:DisplayObjectContainer, param3:Boolean = true, param4:Boolean = false, param5:int = -1) : void
      {
         if(param1 != null && param1.content != null)
         {
            addItemToInstance(param1.content,param2,param3,param4,false,false,param5);
         }
      }
      
      public static function addItemToInstance(param1:DisplayObject, param2:DisplayObjectContainer, param3:Boolean = true, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false, param7:int = -1) : void
      {
         if(param3 == true)
         {
            param1.width = param2.width;
            param1.height = param2.height;
         }
         if(param4 == true)
         {
            correctAspectRatio(param1);
         }
         if(param5)
         {
            centerItem(param1,param2);
         }
         if(!param6)
         {
            if(param7 >= 0)
            {
               param2.addChildAt(param1,param7);
            }
            else
            {
               param2.addChild(param1);
            }
         }
         else
         {
            param2.removeChildren();
            param2.addChildAt(param1,0);
         }
      }
      
      public static function addIconToInstance(param1:Class, param2:DisplayObjectContainer, param3:Boolean = true, param4:Boolean = false, param5:Boolean = false) : void
      {
         var _loc6_:Sprite = new param1() as Sprite;
         _loc6_.width = param2.width;
         _loc6_.height = param2.height;
         if(param3 == true)
         {
            correctAspectRatio(_loc6_);
         }
         if(_loc6_ is MovieClip)
         {
            (_loc6_ as MovieClip).stop();
         }
         if(param4)
         {
            centerItem(_loc6_,param2);
         }
         if(!param5)
         {
            param2.addChild(_loc6_);
         }
         else
         {
            param2.removeChildren();
            param2.addChildAt(_loc6_,0);
         }
      }
      
      public static function addIconToInstanceNoDimensions(param1:Class, param2:DisplayObjectContainer, param3:Boolean = true) : void
      {
         var _loc4_:Sprite = new param1() as Sprite;
         var _loc5_:* = int(param2.numChildren - 1);
         while(_loc5_ >= 0)
         {
            param2.removeChildAt(_loc5_);
            _loc5_--;
         }
         param2.addChild(_loc4_);
         if(param3 == true)
         {
            correctAspectRatio(_loc4_);
         }
         _loc4_.graphics.beginFill(16711680,0);
         _loc4_.graphics.drawRect(0,0,_loc4_.width,_loc4_.height);
         _loc4_.graphics.endFill();
      }
      
      public static function addAtPlaceholder(param1:DisplayObject, param2:DisplayObject, param3:DisplayObjectContainer, param4:Boolean = false, param5:Boolean = false) : void
      {
         param2.visible = false;
         param1.x = param2.x;
         param1.y = param2.y;
         if(param5)
         {
            param1.width = param2.width;
            param1.height = param2.height;
         }
         if(param4 && Boolean(param3.contains(param2)))
         {
            param3.addChildAt(param1,param3.getChildIndex(param2));
         }
         else
         {
            param3.addChild(param1);
         }
      }
      
      public static function addItemWithMaskToInstance(param1:DisplayObject, param2:DisplayObjectContainer) : void
      {
         var _loc3_:Rectangle = DisplayObjectUtil.getVisibleBounds(param1);
         var _loc4_:Number = Number(Math.min(param2.width / _loc3_.width,param2.height / _loc3_.height));
         param1.scaleX = param1.scaleY = _loc4_;
         param1.x = -_loc3_.x * _loc4_ + (param2.width - _loc3_.width * _loc4_) / 2;
         param1.y = -_loc3_.y * _loc4_ + (param2.height - _loc3_.height * _loc4_) / 2;
         param2.removeChildren();
         param2.addChildAt(param1,0);
      }
      
      public static function correctAspectRatio(param1:DisplayObject) : void
      {
         if(param1.scaleX > param1.scaleY)
         {
            param1.scaleX = param1.scaleY;
         }
         else
         {
            param1.scaleY = param1.scaleX;
         }
      }
      
      public static function centerItem(param1:DisplayObject, param2:DisplayObject) : void
      {
         param1.x = (param2.width - param1.width) / 2;
         param1.y = (param2.height - param1.height) / 2;
      }
   }
}

