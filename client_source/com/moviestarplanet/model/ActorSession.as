package com.moviestarplanet.model
{
   import com.moviestarplanet.actorservice.mobileservice.ActorAmfService;
   import com.moviestarplanet.actorservice.valueObjects.ActorAddress;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.commonvalueobjects.actor.BlockedAndBlockingActorsResult;
   import com.moviestarplanet.commonvalueobjects.login.PostLoginData;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.constants.events.EventsConstants;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.friendship.valueobjects.ActorRelationship;
   import com.moviestarplanet.mangroveanalytics.configuration.MangroveConfig;
   import com.moviestarplanet.mangroveanalytics.valueobjects.moviestarplanet.MangroveActorDetails;
   import com.moviestarplanet.services.actorservice.ActorService;
   import com.moviestarplanet.usersession.ActorSessionNotifier;
   import com.moviestarplanet.usersession.valueobjects.ActorDetails;
   import com.moviestarplanet.usersession.valueobjects.ActorDetailsExtended;
   import com.moviestarplanet.usersession.valueobjects.ActorPersonalInfo;
   import com.moviestarplanet.utils.DateUtils;
   import com.moviestarplanet.utils.TamperTechnology;
   import mx.collections.ArrayCollection;
   
   public class ActorSession
   {
      
      private static var _actorAddress:ActorAddress;
      
      private static var loadBlockingListsFromBundleCallback:Function;
      
      private static var _loggedInActor:ActorDetails = null;
      
      private static var _age:Number = -1;
      
      private static var _isModHidden:Boolean = false;
      
      private static var _isMod:Boolean = false;
      
      private static var _isAdmin:Boolean = false;
      
      public static var enableTracing:Boolean = false;
      
      public static var actorPassword:String = "";
      
      public static var blockedActors:ArrayCollection = new ArrayCollection();
      
      public static var blockingActors:ArrayCollection = new ArrayCollection();
      
      public static var showFameConversionPage:Boolean = false;
      
      public function ActorSession()
      {
         super();
      }
      
      public static function ReloadBlockingLists(param1:Function = null) : void
      {
         var serverMethodCallback:Function = null;
         var callback:Function = param1;
         serverMethodCallback = function(param1:BlockedAndBlockingActorsResult):void
         {
            doneLoadingBlockingAndBlocked(param1,callback);
         };
         ActorService.LoadBlockedAndBlockingActors(ActorSession.loggedInActor.ActorId,serverMethodCallback);
      }
      
      private static function doneLoadingBlockingAndBlocked(param1:BlockedAndBlockingActorsResult, param2:Function, param3:Boolean = false) : void
      {
         ActorSession.blockedActors = param1.BlockedActors;
         ActorSession.blockingActors = param1.BlockingActors;
         if(param2 != null)
         {
            param2();
         }
         if(param3 == false)
         {
            MessageCommunicator.send(new MsgEvent(MSPEvent.BLOCK_LIST_REFRESHED));
         }
      }
      
      public static function LoadBlockingListsFromBundle(param1:Function = null) : void
      {
         loadBlockingListsFromBundleCallback = param1;
         MessageCommunicator.subscribe(EventsConstants.POST_LOGIN_BUNDLE_RECEIVED,onDataReceived);
      }
      
      private static function onDataReceived(param1:MsgEvent) : void
      {
         MessageCommunicator.unscribe(EventsConstants.POST_LOGIN_BUNDLE_RECEIVED,onDataReceived);
         var _loc2_:PostLoginData = param1.data as PostLoginData;
         doneLoadingBlockingAndBlocked(_loc2_.BlockedAndBlockingActors,loadBlockingListsFromBundleCallback,true);
         loadBlockingListsFromBundleCallback = null;
      }
      
      public static function getBothBlockedAndBlockers() : ArrayCollection
      {
         var _loc1_:ArrayCollection = new ArrayCollection();
         if(ActorSession.blockedActors != null)
         {
            _loc1_.addAll(ActorSession.blockedActors);
         }
         if(ActorSession.blockingActors != null)
         {
            _loc1_.addAll(ActorSession.blockingActors);
         }
         return _loc1_;
      }
      
      public static function get actorAddress() : ActorAddress
      {
         return _actorAddress;
      }
      
      public static function set actorAddress(param1:ActorAddress) : void
      {
         _actorAddress = param1;
      }
      
      public static function get loggedInActor() : ActorDetails
      {
         return _loggedInActor;
      }
      
      public static function updateActorDetails(param1:ActorDetails) : void
      {
         if(_loggedInActor != null)
         {
            _loggedInActor.updateWithNewActorDetails(param1);
         }
         else
         {
            _loggedInActor = param1;
         }
         TamperTechnology.createHashedActorId(_loggedInActor.ActorId);
         MangroveConfig.setupUserDetails(getActorDetailsMangrove());
         (ActorSessionNotifier.getInstance() as ActorSessionNotifier).notify(param1);
      }
      
      public static function getActorId() : int
      {
         if(loggedInActor == null)
         {
            return -1;
         }
         return loggedInActor.ActorId as int;
      }
      
      public static function get actorName() : String
      {
         if(loggedInActor == null)
         {
            return "";
         }
         return loggedInActor.Name;
      }
      
      public static function get isFemale() : Boolean
      {
         if(loggedInActor != null)
         {
            return loggedInActor.isFemale;
         }
         return false;
      }
      
      public static function setPermissions(param1:ActorDetails, param2:String) : void
      {
         if(loggedInActor == null || param2 != "eui3hfiu3oa")
         {
            return;
         }
         _isModHidden = param1.getLoginModeratorStatusForCheckOnLogin() == 3;
         _isMod = param1.getLoginModeratorStatusForCheckOnLogin() > 0;
         _isAdmin = param1.getLoginModeratorStatusForCheckOnLogin() == 1 || param1.getLoginModeratorStatusForCheckOnLogin() == 3;
      }
      
      public static function isModeratorHidden() : Boolean
      {
         return _isModHidden;
      }
      
      public static function isModerator() : Boolean
      {
         return _isMod;
      }
      
      public static function isAdmin() : Boolean
      {
         return _isAdmin;
      }
      
      public static function get isAgeRestrictions() : Boolean
      {
         if(Config.IsServerRestricted() == true && age < 13)
         {
            return true;
         }
         return false;
      }
      
      public static function get age() : Number
      {
         if(Boolean(_age < 0 && loggedInActor != null) && Boolean(loggedInActor.ActorPersonalInfo) && Boolean(loggedInActor.ActorPersonalInfo.BirthDate))
         {
            _age = DateUtils.getYearsSince(loggedInActor.ActorPersonalInfo.BirthDate);
         }
         return _age;
      }
      
      public static function reloadActorDetails(param1:Function, param2:Function) : void
      {
      }
      
      public static function reloadActorDetailsExtended(param1:Function, param2:Function) : void
      {
         var reloadComplete:Function = null;
         var onComplete:Function = param1;
         var onFail:Function = param2;
         reloadComplete = function(param1:ActorDetailsExtended):void
         {
            ActorSession.updateActorDetails(param1.Details);
            onComplete();
         };
         ActorAmfService.LoadActorDetailsExtended(ActorSession.loggedInActor.ActorId,reloadComplete,onFail);
      }
      
      public static function reloadModeratorInformation(param1:Function, param2:Function) : void
      {
         if(ActorSession.loggedInActor)
         {
            ActorAmfService.loadModeratorInformation(ActorSession.loggedInActor.ActorId,param1,param2);
         }
      }
      
      public static function nullifyLoggedInActor() : void
      {
         _loggedInActor = null;
         _age = -1;
         _isModHidden = false;
         _isMod = false;
         _isAdmin = false;
      }
      
      public static function isRestrictedServerUserUnder13NoParentsEmail(param1:ActorPersonalInfo) : Boolean
      {
         if(Config.getCurrentSiteConfig().isRestricted())
         {
            if(param1 == null || param1.birthDate == null || DateUtils.getYearsSince(param1.birthDate) < 13 && !param1.parentEmail)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function isBlockedOrBlocking(param1:int) : Boolean
      {
         return ActorSession.blockedActors.contains(param1) || ActorSession.blockingActors.contains(param1);
      }
      
      public static function isBlocked(param1:int) : Boolean
      {
         return ActorSession.blockedActors.contains(param1);
      }
      
      public static function isBlocking(param1:int) : Boolean
      {
         return ActorSession.blockingActors.contains(param1);
      }
      
      public static function get isVip() : Boolean
      {
         if(ActorSession.loggedInActor == null)
         {
            return false;
         }
         return ActorSession.loggedInActor.isVip;
      }
      
      public static function getActorDetailsMangrove() : MangroveActorDetails
      {
         var _loc2_:int = 0;
         var _loc4_:ActorRelationship = null;
         var _loc1_:MangroveActorDetails = new MangroveActorDetails();
         _loc1_.UserId = _loggedInActor.ActorId.toString();
         _loc1_.Created = _loggedInActor.created;
         _loc1_.Diamonds = _loggedInActor.Diamonds;
         _loc1_.Fame = _loggedInActor.Fame;
         _loc1_.Fortune = _loggedInActor.Fortune;
         _loc1_.FriendCount = _loggedInActor.FriendCount;
         _loc1_.FriendCountVIP = _loggedInActor.FriendCountVIP;
         _loc1_.IsFemale = _loggedInActor.isFemale;
         _loc1_.IsVip = _loggedInActor.isVip;
         _loc1_.LastLogin = _loggedInActor.LastLogin;
         _loc1_.Level = _loggedInActor.Level;
         _loc1_.MembershipPurchasedDate = _loggedInActor.MembershipPurchasedDate;
         _loc1_.MembershipTimeoutDate = _loggedInActor.MembershipTimeoutDate;
         _loc1_.Money = _loggedInActor.Money;
         _loc1_.TotalVipDays = _loggedInActor.TotalVipDays;
         _loc1_.TimeNow = DateUtils.nowUTC.time;
         _loc1_.Country = Config.getCurrentSiteConfig().country;
         var _loc3_:int = _loggedInActor.ActorRelationships.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loggedInActor.ActorRelationships[_loc2_];
            if(ActorDetails.IsRelationshipBestFriend(_loc4_))
            {
               ++_loc1_.BestFriendsCount;
            }
            else if(ActorDetails.IsRelationshipBoyFriend(_loc4_))
            {
               ++_loc1_.BoyFriendsCount;
            }
            _loc2_++;
         }
         if(_loc1_.Country == "com")
         {
            _loc1_.Country = "us";
         }
         return _loc1_;
      }
   }
}

