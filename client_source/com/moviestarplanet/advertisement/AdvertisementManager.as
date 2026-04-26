package com.moviestarplanet.advertisement
{
   import com.moviestarplanet.advertisement.initializer.AdvertisementInitializer;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class AdvertisementManager extends EventDispatcher
   {
      
      private static var instance:AdvertisementManager;
      
      public static const VENDOR_ALL:int = 0;
      
      public static const VENDOR_GOVIRAL:int = 1;
      
      public static const VENDOR_SUPERSONICADS:int = 2;
      
      public static const VENDOR_ADTECH:int = 3;
      
      public static const TYPE_BANNER:int = 1;
      
      public static const TYPE_VIDEO:int = 2;
      
      public static const TYPE_VIDEO_INCENTIVE:int = 3;
      
      public static const TYPE_ARCADE:int = 4;
      
      public static const TYPE_MOVIE:int = 5;
      
      public static const TYPE_YOUTUBE:int = 6;
      
      public static const TYPE_WHEEL_REROLL:int = 7;
      
      public static const TYPE_VIDEO_INCENTIVE_MOBILE:int = 8;
      
      public static const INITIALIZED:String = "INITIALIZED";
      
      private var _adCountryMap:Vector.<AdvertisementArgs> = new Vector.<AdvertisementArgs>();
      
      private var advertsSeenToday:int;
      
      private var areAdsInitialized:Boolean;
      
      private var adInitializer:AdvertisementInitializer;
      
      private var _hasAdTechIncentive:Boolean = false;
      
      private var _actorId:int;
      
      private var _incentive:IncentiveBase;
      
      private var _banner:BannerBase;
      
      private var _videoPlayer:VideoPlayer = new VideoPlayer();
      
      private var _hasWheelIncentive:Boolean = false;
      
      public function AdvertisementManager()
      {
         super();
         this.areAdsInitialized = false;
         this.adInitializer = new AdvertisementInitializer(this.onAdinitialized);
      }
      
      public static function getInstance() : AdvertisementManager
      {
         if(instance == null)
         {
            instance = new AdvertisementManager();
         }
         return instance;
      }
      
      private function onAdinitialized() : void
      {
         if(this.adInitializer.hasBanner)
         {
            this._banner = new BannerAdTech();
         }
         if(this.adInitializer.hasIncentivized)
         {
            this._hasAdTechIncentive = true;
            this._incentive = new IncentiveAdTechAds(this.actorId);
            DisplayDebugInfo.getInstance().addParam("AdTechIncentive: true");
         }
         if(this.adInitializer.hasWheelIncentive)
         {
            this._hasWheelIncentive = true;
         }
         this.areAdsInitialized = true;
         dispatchEvent(new Event(INITIALIZED));
      }
      
      public function isInitialized() : Boolean
      {
         return this.areAdsInitialized;
      }
      
      public function setAdImpressions(param1:int) : void
      {
         this.advertsSeenToday = param1;
         AdTechAnalytics.setAdsSeenToday(this.advertsSeenToday);
         this.adInitializer.setImpressions(this.advertsSeenToday);
      }
      
      public function watchIncentivized() : void
      {
         AdvertisementAMFService.watchAdvertisement();
         ++this.advertsSeenToday;
         AdTechAnalytics.setAdsSeenToday(this.advertsSeenToday);
      }
      
      public function get adsSeen() : int
      {
         return this.advertsSeenToday;
      }
      
      public function get hasAdTechIncentive() : Boolean
      {
         return this._hasAdTechIncentive;
      }
      
      public function canSeeAdTechIncentive() : Boolean
      {
         return this.hasAdTechIncentive && this.advertsSeenToday < this.adInitializer.maxIncentiveAdsPerDay;
      }
      
      public function get hasWheelIncentive() : Boolean
      {
         return this._hasWheelIncentive;
      }
      
      public function canSeeWheelIncentive() : Boolean
      {
         return this.hasWheelIncentive && this.advertsSeenToday < this.adInitializer.maxWheelAdsPerDay;
      }
      
      public function get videoPlayer() : VideoPlayer
      {
         return this._videoPlayer;
      }
      
      public function get adCountryMap() : Vector.<AdvertisementArgs>
      {
         return this._adCountryMap;
      }
      
      public function getNextVideoAt(param1:int) : AdvertisementVideoObject
      {
         if(this.videoPlayer == null)
         {
            return null;
         }
         return this.videoPlayer.getNextVideoAt(param1);
      }
      
      public function getNumVideos() : int
      {
         if(this.videoPlayer == null)
         {
            return 0;
         }
         return this.videoPlayer.getNumVideos();
      }
      
      public function randomizePositions(param1:int) : void
      {
         if(this.videoPlayer == null)
         {
            return;
         }
         this.videoPlayer.randomizePositions(param1);
      }
      
      public function get actorId() : int
      {
         return this._actorId;
      }
      
      public function init(param1:String, param2:Vector.<AdvertisementArgs>, param3:Boolean, param4:int = 0) : void
      {
         this._actorId = param4;
         this._adCountryMap = param2;
         this.videoPlayer.init(param2,param3);
         DisplayDebugInfo.getInstance().addParam("advertisement init, num: " + param2.length);
         this.adInitializer.setAdCountryMap(param2,param3);
      }
      
      public function get incentive() : IncentiveBase
      {
         return this._incentive;
      }
      
      public function get banner() : BannerBase
      {
         return this._banner;
      }
      
      public function showBanner() : void
      {
         if(this._banner != null)
         {
            this._banner.show();
         }
      }
      
      public function hideBanners() : void
      {
         if(this._banner != null)
         {
            this._banner.hide();
         }
      }
      
      public function destroy() : void
      {
         if(this.adInitializer != null)
         {
            this.adInitializer.destroy();
            this.adInitializer = null;
         }
         if(this._incentive != null)
         {
            this._incentive.destroy();
            this._incentive = null;
         }
         if(this._banner != null)
         {
            this._banner.setData(null);
            this._banner = null;
         }
         if(this._videoPlayer != null)
         {
            this._videoPlayer.destroy();
            this._videoPlayer = null;
         }
         instance = null;
      }
   }
}

