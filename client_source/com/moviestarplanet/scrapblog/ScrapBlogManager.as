package com.moviestarplanet.scrapblog
{
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.dailyCompetition.DailyCompetition;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.msg.ActionEvent;
   import com.moviestarplanet.popup.OldPopupHandler;
   import com.moviestarplanet.scrapblog.flash.ScrapBlogModuleManager;
   import com.moviestarplanet.services.wrappers.SessionService;
   import com.moviestarplanet.utils.Utils;
   import com.moviestarplanet.valueObjects.NewsUpdate;
   import com.moviestarplanet.window.loading.LoadingBar;
   import com.moviestarplanet.window.stack.WindowStack;
   import com.moviestarplanet.window.stack.WindowStackableInterface;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.system.ApplicationDomain;
   import flash.system.SecurityDomain;
   import flash.utils.Timer;
   import mx.core.UIComponent;
   import mx.events.ModuleEvent;
   import mx.modules.IModuleInfo;
   import mx.modules.ModuleManager;
   
   public class ScrapBlogManager
   {
      
      private static var instance:ScrapBlogManager;
      
      public static var useFlashScrapBlog:Boolean = false;
      
      private var _scrapBlogModule:Object;
      
      private var sbLoadingBar:LoadingBar;
      
      private var loadErrorCount:int = 0;
      
      private var _moduleInfo:IModuleInfo;
      
      public function ScrapBlogManager()
      {
         super();
      }
      
      public static function getInstance() : ScrapBlogManager
      {
         if(!instance)
         {
            instance = new ScrapBlogManager();
         }
         return instance;
      }
      
      public function showArtBookOverview() : void
      {
         ScrapBlogModuleManager.getInstance().showArtBookOverView();
      }
      
      public function createScrapBlog(param1:int = 0, param2:int = 0) : void
      {
         var ready:Function = null;
         var contentWidth:int = param1;
         var contentHeight:int = param2;
         ready = function():void
         {
            scrapBlogI.createScrapBlog(ScrapBlogTypes.ARTBOOK,contentWidth,contentHeight);
            show();
            MessageCommunicator.send(new ActionEvent(ActionEvent.CREATE_SCRAPBLOG));
         };
         if(useFlashScrapBlog)
         {
            ScrapBlogModuleManager.getInstance().createScrapBlog(ScrapBlogTypes.ARTBOOK);
            return;
         }
         this.scrapBlogWhenReady(ready);
      }
      
      public function submitScrapblogToCompetition(param1:Number) : void
      {
         var ready:Function = null;
         var competitionId:Number = param1;
         ready = function():void
         {
            scrapBlogI.showSubmissableList(competitionId);
         };
         this.scrapBlogWhenReady(ready);
      }
      
      public function closeViewScrapblog() : void
      {
         var ready:Function = null;
         ready = function():void
         {
            scrapBlogI.closeViewScrapBlog();
         };
         this.scrapBlogWhenReady(ready);
      }
      
      public function viewScrapBlogInParent(param1:Number, param2:Number = 1, param3:DisplayObjectContainer = null) : void
      {
         var ready:Function = null;
         var scrapBlogId:Number = param1;
         var scrapBlogType:Number = param2;
         var parent:DisplayObjectContainer = param3;
         ready = function():void
         {
            scrapBlogI.viewScrapBlog(scrapBlogId,scrapBlogType);
            showInParent(parent);
            DailyCompetition.hide();
         };
         if(useFlashScrapBlog)
         {
            ScrapBlogModuleManager.getInstance().showScrapBlog(scrapBlogId);
            return;
         }
         this.scrapBlogWhenReady(ready);
      }
      
      public function viewScrapBlog(param1:Number, param2:Number = 1) : void
      {
         var ready:Function = null;
         var scrapBlogId:Number = param1;
         var scrapBlogType:Number = param2;
         ready = function():void
         {
            scrapBlogI.viewScrapBlog(scrapBlogId,scrapBlogType);
            show();
         };
         if(useFlashScrapBlog)
         {
            ScrapBlogModuleManager.getInstance().showScrapBlog(scrapBlogId);
            return;
         }
         this.scrapBlogWhenReady(ready);
      }
      
      public function viewScrapBlogExternal(param1:Number, param2:Number = 1) : void
      {
         var popup:ScrapBlogExternalViewContainer = null;
         var timerCompleteHandler:Function = null;
         var ready:Function = null;
         var scrapBlogId:Number = param1;
         var scrapBlogType:Number = param2;
         timerCompleteHandler = function():void
         {
            OldPopupHandler.getInstance().showFakePopup(popup,0,0,true,false,Main.Instance.mainCanvas.applicationViewStack.FrontPageView);
            scrapBlogWhenReady(ready);
         };
         ready = function():void
         {
            popup.scrapBlog = scrapBlogI.viewScrapBlogExternal(scrapBlogId,scrapBlogType);
         };
         popup = new ScrapBlogExternalViewContainer();
         var timer:Timer = new Timer(500,1);
         timer.addEventListener(TimerEvent.TIMER_COMPLETE,timerCompleteHandler);
         timer.start();
      }
      
      public function createClubLogo(param1:Function) : void
      {
         var ready:Function = null;
         var saveCallback:Function = param1;
         ready = function():void
         {
            scrapBlogI.createClubLogo(saveCallback);
            show();
         };
         this.scrapBlogWhenReady(ready);
      }
      
      public function editClubLogo(param1:int, param2:Function) : void
      {
         var ready:Function = null;
         var scrapBlogId:int = param1;
         var saveCallback:Function = param2;
         ready = function():void
         {
            var iComplete:Function = null;
            iComplete = function():void
            {
               scrapBlogI.editClubLogo(scrapBlogId,saveCallback);
            };
            var component:UIComponent = UIComponent(_scrapBlogModule);
            Utils.waitForComponentCompletion(component,iComplete);
            WindowStack.showViewStackable(WindowStackableInterface(component),235,80,WindowStack.Z_CONTENT);
         };
         this.scrapBlogWhenReady(ready);
      }
      
      public function createClubBackground(param1:Function) : void
      {
         var ready:Function = null;
         var saveCallback:Function = param1;
         ready = function():void
         {
            scrapBlogI.createClubBackground(saveCallback);
            show();
         };
         this.scrapBlogWhenReady(ready);
      }
      
      public function editClubBackground(param1:int, param2:Function) : void
      {
         var ready:Function = null;
         var scrapBlogId:int = param1;
         var saveCallback:Function = param2;
         ready = function():void
         {
            var iComplete:Function = null;
            iComplete = function():void
            {
               scrapBlogI.editClubBackground(scrapBlogId,saveCallback);
            };
            var component:UIComponent = UIComponent(_scrapBlogModule);
            Utils.waitForComponentCompletion(component,iComplete);
            WindowStack.showViewStackable(WindowStackableInterface(component),235,80,WindowStack.Z_CONTENT);
         };
         this.scrapBlogWhenReady(ready);
      }
      
      public function getClubBackground(param1:int, param2:Function) : void
      {
         var ready:Function = null;
         var scrapBlogId:int = param1;
         var callback:Function = param2;
         ready = function():void
         {
            callback(scrapBlogI.getClubBackground(scrapBlogId));
         };
         this.scrapBlogWhenReady(ready,false);
      }
      
      public function createNews(param1:Function) : void
      {
         var ready:Function = null;
         var saveCallback:Function = param1;
         ready = function():void
         {
            scrapBlogI.createNews(saveCallback);
            show();
         };
         if(useFlashScrapBlog)
         {
            ScrapBlogModuleManager.getInstance().createScrapBlog(ScrapBlogTypes.NEWS);
            return;
         }
         this.scrapBlogWhenReady(ready);
      }
      
      public function getNews(param1:Number, param2:Function) : void
      {
         var flashNewsLoaded:Function = null;
         var ready:Function = null;
         var scrapBlogId:Number = param1;
         var callback:Function = param2;
         flashNewsLoaded = function(param1:DisplayObject):void
         {
            callback(wrapFlash(param1));
         };
         ready = function():void
         {
            callback(scrapBlogI.getNews(scrapBlogId));
         };
         if(useFlashScrapBlog)
         {
            ScrapBlogModuleManager.getInstance().getContent(scrapBlogId,flashNewsLoaded);
            return;
         }
         this.scrapBlogWhenReady(ready,false);
      }
      
      private function wrapFlash(param1:DisplayObject) : UIComponent
      {
         var _loc2_:UIComponent = null;
         _loc2_ = new UIComponent();
         _loc2_.addChild(param1);
         _loc2_.width = 500;
         _loc2_.height = 500;
         return _loc2_;
      }
      
      public function editNews(param1:Number, param2:NewsUpdate, param3:Function) : void
      {
         var ready:Function = null;
         var scrapBlogId:Number = param1;
         var newsUpdate:NewsUpdate = param2;
         var saveCallback:Function = param3;
         ready = function():void
         {
            scrapBlogI.editNews(scrapBlogId,newsUpdate,saveCallback);
            show();
         };
         this.scrapBlogWhenReady(ready);
      }
      
      public function show() : void
      {
         var _loc1_:UIComponent = UIComponent(this._scrapBlogModule);
         WindowStack.showViewStackable(WindowStackableInterface(_loc1_),235,80,WindowStack.Z_CONTENT);
      }
      
      public function showInParent(param1:DisplayObjectContainer) : void
      {
         var _loc2_:UIComponent = UIComponent(this._scrapBlogModule);
         WindowStack.showChildWindow(_loc2_,235,80,param1);
      }
      
      private function get scrapBlogI() : IScrapBlogView
      {
         return this._scrapBlogModule as IScrapBlogView;
      }
      
      private function scrapBlogWhenReady(param1:Function, param2:Boolean = true) : void
      {
         var versionDone:Function = null;
         var readyCallback:Function = param1;
         var showLoader:Boolean = param2;
         versionDone = function(param1:String):void
         {
            var doneLoad:Function;
            var loadError:Function;
            var modulePath:String = param1;
            if(scrapBlogI == null)
            {
               doneLoad = function(param1:Event):void
               {
                  if(showLoader)
                  {
                     sbLoadingBar.hide();
                  }
                  _scrapBlogModule = _moduleInfo.factory.create();
                  if(ActorSession.loggedInActor != null)
                  {
                     scrapBlogI.actorId = ActorSession.loggedInActor.ActorId;
                  }
                  readyCallback();
               };
               loadError = function(param1:Event):void
               {
                  if(loadErrorCount == 0)
                  {
                     ++loadErrorCount;
                     scrapBlogWhenReady(readyCallback);
                  }
               };
               if(showLoader)
               {
                  if(sbLoadingBar == null)
                  {
                     sbLoadingBar = new LoadingBar();
                  }
                  sbLoadingBar.show();
               }
               _moduleInfo = ModuleManager.getModule(Config.cdnLocalBasePath + modulePath);
               _moduleInfo.addEventListener(ModuleEvent.READY,doneLoad);
               _moduleInfo.addEventListener(ModuleEvent.ERROR,loadError);
               _moduleInfo.load(ApplicationDomain.currentDomain,SecurityDomain.currentDomain);
            }
            else
            {
               readyCallback();
            }
         };
         SessionService.getModuleVersion("ScrapBlogModule",versionDone);
      }
      
      public function createTemplate(param1:int, param2:Number, param3:Number) : void
      {
         var ready:Function = null;
         var type:int = param1;
         var width:Number = param2;
         var height:Number = param3;
         ready = function():void
         {
            scrapBlogI.createTemplate(type,width,height);
            show();
         };
         this.scrapBlogWhenReady(ready);
      }
      
      public function createFromTemplate(param1:Number, param2:Function) : void
      {
         var ready:Function = null;
         var scrapBlogType:Number = param1;
         var loadCallback:Function = param2;
         ready = function():void
         {
            loadCallback(scrapBlogI.createFromTemplate(scrapBlogType));
         };
         this.scrapBlogWhenReady(ready);
      }
      
      public function loadTemplate(param1:Number, param2:Number, param3:Function) : void
      {
         var ready:Function = null;
         var templateType:Number = param1;
         var actorId:Number = param2;
         var loadCallback:Function = param3;
         ready = function():void
         {
            loadCallback(scrapBlogI.loadTemplate(templateType,actorId));
         };
         this.scrapBlogWhenReady(ready);
      }
      
      public function loadBio(param1:Number, param2:Function) : void
      {
         var ready:Function = null;
         var scrapBlogId:Number = param1;
         var loadCallback:Function = param2;
         ready = function():void
         {
            loadCallback(scrapBlogI.loadBio(scrapBlogId));
         };
         this.scrapBlogWhenReady(ready);
      }
      
      public function getBioContainer(param1:Function) : void
      {
         var ready:Function = null;
         var callback:Function = param1;
         ready = function():void
         {
            callback(scrapBlogI.getBioContainer());
         };
         this.scrapBlogWhenReady(ready);
      }
   }
}

