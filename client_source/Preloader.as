package
{
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.configurations.environment.DebugEnvironmentInitializerWeb;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.utils.ui.FlashInstanceUtils;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import mx.events.FlexEvent;
   import mx.preloaders.DownloadProgressBar;
   
   public class Preloader extends DownloadProgressBar
   {
      
      public var PreloaderGraphic:Class = Preloader_PreloaderGraphic;
      
      public var LogoGraphic:Class = Preloader_LogoGraphic;
      
      private var _preloaderGraphic:MovieClip;
      
      private var _logoGraphic:MovieClip;
      
      public function Preloader()
      {
         super();
         this._preloaderGraphic = new this.PreloaderGraphic();
         this._logoGraphic = new this.LogoGraphic();
      }
      
      override public function set preloader(param1:Sprite) : void
      {
         var _loc3_:String = null;
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:DisplayObject = null;
         addChild(this._preloaderGraphic);
         this._preloaderGraphic.gotoAndStop(0);
         var _loc2_:Object = LoaderInfo(this.root.loaderInfo).parameters;
         if(_loc2_ != null && Boolean(_loc2_.hasOwnProperty("brandName")) && _loc2_["brandName"] != null)
         {
            _loc3_ = _loc2_["brandName"];
         }
         else
         {
            _loc3_ = "MovieStarPlanet";
         }
         if(this._preloaderGraphic != null && Boolean(this._preloaderGraphic.hasOwnProperty("MSPlogo")))
         {
            _loc4_ = this._preloaderGraphic.MSPlogo as DisplayObjectContainer;
            _loc5_ = _loc4_.getChildAt(0) as DisplayObject;
            this._logoGraphic.gotoAndStop(_loc3_);
            FlashInstanceUtils.addAtPlaceholder(this._logoGraphic,_loc5_,_loc4_);
         }
         param1.addEventListener(ProgressEvent.PROGRESS,this.onSWFDownloadProgress);
         param1.addEventListener(Event.COMPLETE,this.onSWFDownloadComplete);
         param1.addEventListener(FlexEvent.INIT_PROGRESS,this.onFlexInitProgress);
         param1.addEventListener(FlexEvent.INIT_COMPLETE,this.onFlexInitComplete);
         this.centerPreloader();
      }
      
      private function centerPreloader() : void
      {
         x = stageWidth / 2 - this._preloaderGraphic.width / 2;
         y = stageHeight / 2 - this._preloaderGraphic.height / 2;
      }
      
      private function onSWFDownloadProgress(param1:ProgressEvent) : void
      {
         var _loc2_:Object = LoaderInfo(this.root.loaderInfo).parameters;
         var _loc3_:Number = Number(param1.bytesTotal);
         var _loc4_:Number = Number(param1.bytesLoaded);
         var _loc5_:Number = Number(Math.round(_loc4_ / _loc3_ * 19));
         var _loc6_:int = int(Math.floor(_loc5_ * 5));
         this._preloaderGraphic.gotoAndStop(_loc5_);
         this._preloaderGraphic.amount_txt.text = String(_loc6_) + "%";
      }
      
      private function onSWFDownloadComplete(param1:Event) : void
      {
         this._preloaderGraphic.gotoAndStop(100);
         this._preloaderGraphic.amount_txt.text = "100%";
      }
      
      private function onFlexInitProgress(param1:FlexEvent) : void
      {
         this._preloaderGraphic.gotoAndStop(100);
         this._preloaderGraphic.amount_txt.text = "100%";
      }
      
      private function onFlexInitComplete(param1:FlexEvent) : void
      {
         this._preloaderGraphic.gotoAndStop(100);
         this.initEnvironment();
      }
      
      private function initEnvironment() : void
      {
         var _loc1_:DebugEnvironmentInitializerWeb = null;
         if(Config.IsRunningLocally)
         {
            _loc1_ = new DebugEnvironmentInitializerWeb();
            _loc1_.initEnvironment(this.loadLocales);
         }
         else
         {
            this.initEnvironmentAndLoadLocales();
         }
      }
      
      private function initEnvironmentAndLoadLocales() : void
      {
         var _loc1_:Object = LoaderInfo(this.root.loaderInfo).parameters;
         var _loc2_:String = _loc1_["cdnBasePath"];
         var _loc3_:String = _loc1_["cdnLocalBasePath"];
         var _loc4_:String = _loc1_["newWsPath"];
         var _loc5_:String = _loc1_["baseHost"];
         var _loc6_:String = _loc1_["baseBranch"];
         var _loc7_:String = _loc1_["translationsVersion"];
         Config.setBaseBranch(_loc6_);
         Config.setBaseHost(_loc5_);
         Config.initializeCdnPathsWeb(_loc2_,_loc3_,_loc4_);
         this.loadLocales(Config.cdnLocalBasePath,_loc7_);
      }
      
      private function loadLocales(param1:*, param2:*) : void
      {
         MSPLocaleManagerWeb.initializeLocaleManager(param1,Config.GetLanguage,param2,this.localeReady);
      }
      
      private function localeReady() : void
      {
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}

