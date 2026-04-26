package com.moviestarplanet.configurations
{
   import com.moviestarplanet.configurations.service.AMFAppSettingsService;
   import com.moviestarplanet.configurations.service.AMFAppSettingsServiceMobile;
   import com.moviestarplanet.constants.ConstantsPlatform;
   import com.moviestarplanet.session.valueobjects.AppSetting;
   import com.moviestarplanet.session.valueobjects.ApplicationSetting;
   import flash.utils.Dictionary;
   
   public class AppSettings
   {
      
      private static var _instance:AppSettings;
      
      public static const ACTIVE_VIP_SALE:String = "vipsale";
      
      public static const ALLOWED_NON_FRIEND_COMMUNICATION:String = "AllowedNonFriendCommunication";
      
      public static const APP_SETTINGS_VERSION:String = "appsettingsversion";
      
      public static const BITMAP_SHARING_ENABLED:String = "BitmapSharingEnabled";
      
      public static const BLOB_HOSTNAME:String = "BlobServiceHostName";
      
      public static const BONSTER_SWITCH:String = "BonsterShopSwitch";
      
      public static const BOONIEPLANET_EXTERNAL_LINK:String = "BooniePlanetURL";
      
      public static const CHAT_FMS_SERVER:String = "chatFMSServer";
      
      public static const CHRISTMAS_START_DATE:String = "ChristmasStartDate";
      
      public static const CLIENT_EXCEPTION_REPORT_COOLDOWN:String = "clientExceptionReportCooldown";
      
      public static const CLIENT_IDLE_TIMEOUT:String = "clientidletimeout";
      
      public static const COM_FMS_SERVER:String = "CommFMSServer";
      
      public static const COM_PUBLIC_ACTIVITY_FMS_LOAD_BALANCER:String = "ComPublicActivityFMSLoadBalancer";
      
      public static const CURRENT_SEASON:String = "CurrentSeason";
      
      public static const DETAILED_PURCHASE_LOGGING:String = "detailedPurchaseLogging";
      
      public static const DISCONTINUED_APP:String = "DiscontinuedApp";
      
      public static const ECO_SYSTEM_URL:String = "EcoSystemUrl";
      
      public static const ENABLE_CLIENT_EXCEPTION:String = "enableClientExceptionLogging";
      
      public static const ENABLE_SPECIAL_OFFERS:String = "EnableSpecialOffers";
      
      public static const EXTERNAL_APP_LEVEL_REQUIRED:String = "ExternalAppLinksLevelRequired";
      
      public static const FAME_OVERHAUL_SWITCH:String = "FameOverhaulSwitch";
      
      public static const GCM_SENDER_ID:String = "PushNotificationGcmSender";
      
      public static const GIFT_CERTIFICATE_ENABLED:String = "giftcertificateenabled";
      
      public static const IMAGE_UPLOAD:String = "ImageUpload";
      
      public static const IMAGE_UPLOAD_AGE_RESTRICTION:String = "ImageUploadAgeRestriction";
      
      public static const IMAGE_UPLOAD_DAILY_LIMIT:String = "ImageUploadDailyLimit";
      
      public static const IMAGE_UPLOAD_DAILY_LIMIT_VIP:String = "ImageUploadDailyLimitVIP";
      
      public static const IMAGE_UPLOAD_REQUIRED_LEVEL:String = "ImageUploadLevelRequired";
      
      public static const MAT_COLLECT_DISABLED:String = "MATCollectDisabled";
      
      public static const MAX_CONCURRENT_LOADS:String = "MaxConcurrentLoads";
      
      public static const MESSAGE_SERVER_URL:String = "MessageServerUrl";
      
      public static const MESSAGE_SERVICE_ELB:String = "MessageServiceELB";
      
      public static const MIN_SEARCH_LENGTH:String = "TextSearchMinLength";
      
      public static const MOBILE_VERSION_AMAZON:String = "mobileversion_amazonstore";
      
      public static const MOBILE_VERSION_GOOGLE:String = "mobileversion_googleplay";
      
      public static const MOBILE_VERSION_IOS:String = "mobileversion_appstore";
      
      public static const MOB_DYNAMIC_INFO_MESSAGE:String = "MobDynamicInfoMessage";
      
      public static const MY_SCHOOL_FIRST_NAME_ENABLED:String = "MySchoolFirstNameEnabled";
      
      public static const NEWS_FEED_AD_FIRST_INDEX:String = "NewsFeedAdFirstIndex";
      
      public static const NEWS_FEED_AD_INTERVAL:String = "NewsFeedAdInterval";
      
      public static const PHOTO_UPLOAD_ON_WEB:String = "PhotoUploadOnWeb";
      
      public static const PORTRAIT_MODE:String = "portraitmode";
      
      public static const PUBLIC_ACTIVITY_AMS_SERVER:String = "PublicActivityAMSServer";
      
      public static const PUSH_NOTIFICATION:String = "PushNotification";
      
      public static const RELEASE_VERSION:String = "ReleaseVersion";
      
      public static const ROBOBLASTPLANET_EXTERNAL_LINK:String = "RoboBlastPlanetURL";
      
      public static const SCHOOL_FRIENDS_ENABLED_SWITCH:String = "SchoolFriendsSwitchEnabled";
      
      public static const SEASONAL_SALE:String = "SeasonalSale";
      
      public static const SEND_MESSAGES_TO_CASSANDRA_DATABASE:String = "SendMessagesToCassandraDatabase";
      
      public static const SERVER_TYPE:String = "ServerType";
      
      public static const SHOW_ERRORS_TO_ALL_MOB_USERS:String = "ShowErrorsToAllMobUsers";
      
      public static const SHOW_OFFER_COUNTDOWN:String = "showoffercountdown";
      
      public static const SNAPSHOT_SERVER_URL:String = "SnapshotServerUrl";
      
      public static const SNAPSHOT_SERVICE_HOST_NAME:String = "SnapshotServiceHostName";
      
      public static const SPECIAL_INPUT_TEXT_CHARS:String = "specialinputtextchars";
      
      public static const SUPER_VIP_DISABLED:String = "SuperVIPDisabled";
      
      public static const SWRVE_ENABLED:String = "SwrveEnabled";
      
      public static const USE_JSONC:String = "usejsonc";
      
      public static const USER_BEHAVIOR_SERVICE:String = "UseUserBehaviorService";
      
      public static const USER_BEHAVIOR_SERVICE_HOST_NAME:String = "UserBehaviorServiceHostName";
      
      public static const USER_NAME_FILTERING:String = "UseUserNameFiltering";
      
      public static const USE_OLD_MESSAGES_LIST:String = "UseOldMessagesList";
      
      public static const XMPP_CONFERENCE_SERVER_URL:String = "XmppConferenceServerUrl";
      
      public static const XMPP_SERVER:String = "XmppServerUrl";
      
      public static const XMPP_STATUS:String = "XMPPFeatureState";
      
      public static const XMPP_USE_LOCALHOST:String = "XmppUseLocalhost";
      
      public static const YOUTUBE_API_KEY:String = "youtubeapikey";
      
      public static const YOUTUBE_ENABLED_ANDROID:String = "YoutubeAndroid";
      
      public static const YOUTUBE_ENABLED_IOS:String = "YoutubeIos";
      
      public static const YOUTUBE_ENABLED_KINDLE:String = "YoutubeKindle";
      
      public static const GOSSIP_FEED_ON:String = "GossipFeedOn";
      
      public static const HELP_CENTER_LINK:String = "HelpCenterLink";
      
      public static const SAFETY_HELPLINE_LINK:String = "SafetyHelplineLink";
      
      public static const SAFETY_RULES_LINK:String = "SafetyRulesLink";
      
      public static const GIT_BASE_BRANCH:String = "GitBaseBranch";
      
      public static const DEVICE_FINGERPRINT_COLLECTION_ENABLED:String = "DeviceFingerprintCollectionEnabled";
      
      public static const MODERATION_CHECK_UPDATE_TIMER_SECONDS:String = "ModerationCheckUpdateTimerSeconds";
      
      public static const USER_BEHAVIOUR_FILTER_SYMBOL:String = "UserBehaviourFilterSymbol";
      
      public static const ACTOR_DETAILS_CHECK_UPDATE_TIMER_SECONDS:String = "ActorDetailsCheckUpdateTimerSeconds";
      
      public static const MANGROVE_SWITCH:String = "MangroveAnalyticsSwitch";
      
      public static const MANGROVE_COLLECTOR_URL:String = "MangroveAnalyticsCollectorURL";
      
      public static const MANGROVE_BUFFER_SIZE:String = "MangroveAnalyticsBufferSize";
      
      public static const MANGROVE_DISABLED_EVENTS:String = "MangroveAnalyticsDisabledEvents";
      
      public static const MANGROVE_DISABLE_BASE64:String = "MangroveAnalyticsDisableBase64";
      
      public static const MANGROVE_FEATURE_USAGE_MIN_T:String = "MangroveAnalyticsFeatureUsageMinTime";
      
      public static const LOG_MISSING_ASSETS:String = "LogMissingAssets";
      
      private var _values:Dictionary;
      
      private var _isInitialized:Boolean;
      
      public const sharedByAllKeys:Array = [SUPER_VIP_DISABLED,IMAGE_UPLOAD,IMAGE_UPLOAD_REQUIRED_LEVEL,IMAGE_UPLOAD_AGE_RESTRICTION,MIN_SEARCH_LENGTH,SEASONAL_SALE,XMPP_USE_LOCALHOST,RELEASE_VERSION,BOONIEPLANET_EXTERNAL_LINK,ROBOBLASTPLANET_EXTERNAL_LINK,EXTERNAL_APP_LEVEL_REQUIRED,MESSAGE_SERVICE_ELB,SEND_MESSAGES_TO_CASSANDRA_DATABASE,XMPP_CONFERENCE_SERVER_URL,USE_OLD_MESSAGES_LIST,USE_JSONC,SCHOOL_FRIENDS_ENABLED_SWITCH,MY_SCHOOL_FIRST_NAME_ENABLED,ECO_SYSTEM_URL,XMPP_SERVER,XMPP_STATUS,SPECIAL_INPUT_TEXT_CHARS,ALLOWED_NON_FRIEND_COMMUNICATION,SHOW_OFFER_COUNTDOWN,YOUTUBE_API_KEY,MESSAGE_SERVER_URL,ACTIVE_VIP_SALE,DEVICE_FINGERPRINT_COLLECTION_ENABLED,MANGROVE_SWITCH,MANGROVE_COLLECTOR_URL,MANGROVE_BUFFER_SIZE,MANGROVE_DISABLED_EVENTS,MANGROVE_DISABLE_BASE64,MANGROVE_FEATURE_USAGE_MIN_T,DEVICE_FINGERPRINT_COLLECTION_ENABLED,HELP_CENTER_LINK,SAFETY_HELPLINE_LINK,SAFETY_RULES_LINK,MODERATION_CHECK_UPDATE_TIMER_SECONDS,LOG_MISSING_ASSETS,USER_BEHAVIOUR_FILTER_SYMBOL,ACTOR_DETAILS_CHECK_UPDATE_TIMER_SECONDS
      ,SNAPSHOT_SERVER_URL];
      
      public const mobileKeys:Array = [SERVER_TYPE,MAX_CONCURRENT_LOADS,SNAPSHOT_SERVICE_HOST_NAME,SWRVE_ENABLED,USER_BEHAVIOR_SERVICE,USER_BEHAVIOR_SERVICE_HOST_NAME,CHAT_FMS_SERVER,BLOB_HOSTNAME,FAME_OVERHAUL_SWITCH,CURRENT_SEASON,BONSTER_SWITCH,MAT_COLLECT_DISABLED,USER_NAME_FILTERING,IMAGE_UPLOAD_DAILY_LIMIT,IMAGE_UPLOAD_DAILY_LIMIT_VIP,COM_FMS_SERVER,DISCONTINUED_APP,MOB_DYNAMIC_INFO_MESSAGE,PUBLIC_ACTIVITY_AMS_SERVER,COM_PUBLIC_ACTIVITY_FMS_LOAD_BALANCER,NEWS_FEED_AD_INTERVAL,NEWS_FEED_AD_FIRST_INDEX,BITMAP_SHARING_ENABLED,CHRISTMAS_START_DATE,SHOW_ERRORS_TO_ALL_MOB_USERS,PUSH_NOTIFICATION,DETAILED_PURCHASE_LOGGING,PORTRAIT_MODE,CLIENT_EXCEPTION_REPORT_COOLDOWN,APP_SETTINGS_VERSION,GOSSIP_FEED_ON];
      
      public const androidKeys:Array = [YOUTUBE_ENABLED_ANDROID,GCM_SENDER_ID];
      
      public const iosKeys:Array = [YOUTUBE_ENABLED_IOS];
      
      public const kindleKeys:Array = [YOUTUBE_ENABLED_KINDLE];
      
      public const webKeys:Array = [ENABLE_CLIENT_EXCEPTION,GIFT_CERTIFICATE_ENABLED,ENABLE_SPECIAL_OFFERS,PHOTO_UPLOAD_ON_WEB,MOBILE_VERSION_AMAZON,MOBILE_VERSION_GOOGLE,MOBILE_VERSION_IOS,YOUTUBE_ENABLED_KINDLE,YOUTUBE_ENABLED_IOS,YOUTUBE_ENABLED_ANDROID,CLIENT_IDLE_TIMEOUT];
      
      public function AppSettings(param1:AppSettingsSingletonBlocker)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : AppSettings
      {
         if(_instance == null)
         {
            _instance = new AppSettings(new AppSettingsSingletonBlocker());
         }
         return _instance;
      }
      
      public function initialize(param1:Function, param2:Function, param3:Boolean = true) : void
      {
         var keys:Array;
         var onSettingsRetrieved:Function = null;
         var done:Function = param1;
         var onFail:Function = param2;
         var ismobile:Boolean = param3;
         onSettingsRetrieved = function(param1:Array):void
         {
            var _loc2_:Object = null;
            _isInitialized = true;
            var _loc3_:int = 0;
            while(_loc3_ < param1.length)
            {
               if(ismobile)
               {
                  _loc2_ = param1[_loc3_] as ApplicationSetting;
               }
               else
               {
                  _loc2_ = param1[_loc3_] as AppSetting;
               }
               _values[_loc2_.name] = _loc2_.value;
               _loc3_++;
            }
            if(done != null)
            {
               done();
            }
         };
         this._isInitialized = false;
         this._values = new Dictionary();
         keys = this.sharedByAllKeys;
         if(ismobile)
         {
            keys = keys.concat(this.mobileKeys);
            if(ConstantsPlatform.isAndroid)
            {
               keys = keys.concat(this.androidKeys);
            }
            else if(ConstantsPlatform.isKindle)
            {
               keys = keys.concat(this.kindleKeys);
            }
            else if(ConstantsPlatform.isIOS)
            {
               keys = keys.concat(this.iosKeys);
            }
            AMFAppSettingsServiceMobile.getAppSettings(keys,onSettingsRetrieved,onFail);
         }
         else
         {
            keys = keys.concat(this.webKeys);
            AMFAppSettingsService.getAppSettings(keys,onSettingsRetrieved,onFail);
         }
      }
      
      public function getSetting(param1:String) : String
      {
         return this._values[param1];
      }
      
      public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public function set isInitialized(param1:Boolean) : void
      {
         this._isInitialized = param1;
      }
      
      public function get values() : Dictionary
      {
         return this._values;
      }
      
      public function isPortraitOn() : Boolean
      {
         var _loc1_:String = AppSettings.getInstance().getSetting(AppSettings.PORTRAIT_MODE);
         var _loc2_:Boolean = false;
         if(_loc1_ != null && _loc1_.length > 2)
         {
            if(ConstantsPlatform.isIOS && _loc1_.charAt(0) == "1")
            {
               _loc2_ = true;
            }
            else if(ConstantsPlatform.isGoogle && _loc1_.charAt(1) == "1")
            {
               _loc2_ = true;
            }
            else if(ConstantsPlatform.isKindle && _loc1_.charAt(2) == "1")
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
   }
}

class AppSettingsSingletonBlocker
{
   
   public function AppSettingsSingletonBlocker()
   {
      super();
   }
}
