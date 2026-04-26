package com.moviestarplanet.friends
{
   import com.moviestarplanet.anchorCharacters.AnchorActivityManager;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.friendship.service.FriendshipServiceWeb;
   import com.moviestarplanet.friendship.valueobjects.FriendData;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.model.FriendList;
   import com.moviestarplanet.model.friends.IFriend;
   import com.moviestarplanet.model.friends.IFriendList;
   import com.moviestarplanet.model.friends.INewFriendListener;
   import com.moviestarplanet.model.friends.IRemoveFriendListener;
   import com.moviestarplanet.service.PushNotificationsAMFServiceWeb;
   import com.moviestarplanet.utils.DateUtils;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class FriendsManager extends EventDispatcher implements INewFriendListener, IRemoveFriendListener
   {
      
      private static var _instance:FriendsManager;
      
      public static const ACTORCONNECTEDCHANGED:String = "ACTORCONNECTEDCHANGED";
      
      [Inject]
      public var friendList:IFriendList;
      
      [Inject]
      public var webEventDispatcher:IEventDispatcher;
      
      private var initializeFriendInstancesStarted:Boolean = false;
      
      private const TIME_CONSTANT:Number = 31536000000;
      
      private var allFriendsSorted:Vector.<IFriend> = null;
      
      public function FriendsManager(param1:Class)
      {
         super();
         if(param1 != SingletonBlocker)
         {
            throw new Error("FriendsManager is a singleton class, use FriendsManager.getInstance instead!");
         }
         InjectionManager.manager().injectMe(this);
         this.friendList.listenForNewFriends(this);
         this.friendList.listenForRemovedFriends(this);
      }
      
      public static function getInstance() : FriendsManager
      {
         if(_instance == null)
         {
            _instance = new FriendsManager(SingletonBlocker);
         }
         return _instance;
      }
      
      public function onNewFriendLoaded(param1:IFriend) : void
      {
         this.allFriendsSorted = null;
      }
      
      public function onFriendRemoved(param1:IFriend) : void
      {
         this.allFriendsSorted = null;
      }
      
      public function getFriend(param1:int) : IFriend
      {
         return this.friendList.getFriendById(param1);
      }
      
      public function getNumFriends() : int
      {
         if(this.friendList == null)
         {
            return 0;
         }
         return this.friendList.size;
      }
      
      public function get numFriendsOnline() : int
      {
         if(this.friendList == null)
         {
            return 0;
         }
         return this.friendList.onlineFriends.length;
      }
      
      public function getOnlineFriends() : Vector.<IFriend>
      {
         return this.friendList.onlineFriends;
      }
      
      public function getOfflineFriends() : Vector.<IFriend>
      {
         return this.friendList.offlineFriends;
      }
      
      public function getAllFriendsSorted() : Vector.<IFriend>
      {
         if(this.initialized)
         {
            if(this.allFriendsSorted == null)
            {
               this.allFriendsSorted = this.friendList.friendList;
               this.allFriendsSorted.sort(this.friendNameSorter);
            }
            return this.allFriendsSorted;
         }
         return new Vector.<IFriend>();
      }
      
      private function friendNameSorter(param1:IFriend, param2:IFriend) : Number
      {
         if(param1.name.toLowerCase() > param2.name.toLowerCase())
         {
            return 1;
         }
         return -1;
      }
      
      public function getAllFriends() : Vector.<IFriend>
      {
         if(this.initialized)
         {
            return this.friendList.friendList;
         }
         return new Vector.<IFriend>();
      }
      
      public function addListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(this.friendList != null)
         {
            this.webEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
         }
      }
      
      public function removeListener(param1:String, param2:Function) : void
      {
         if(this.friendList != null)
         {
            this.webEventDispatcher.removeEventListener(param1,param2);
         }
      }
      
      public function get initialized() : Boolean
      {
         return this.friendList != null;
      }
      
      public function InitializeFriendInstances(param1:int, param2:Function = null) : void
      {
         var friendDataArray:Array = null;
         var getFriendListDone:Function = null;
         var onAnchorAdded:Function = null;
         var userId:int = param1;
         var initializeComplete:Function = param2;
         getFriendListDone = function(param1:Array):void
         {
            friendDataArray = param1;
            if(AnchorActivityManager.isAnchorAdded)
            {
               onAnchorAdded();
            }
            else
            {
               AnchorActivityManager.tellMeWhenAnchorAdded(onAnchorAdded,-1);
            }
         };
         onAnchorAdded = function():void
         {
            friendDataArray.push(getAnchorObject());
            friendList.serverNow = DateUtils.serverNow;
            friendList.parseList(friendDataArray);
            if(initializeComplete != null)
            {
               initializeComplete();
            }
            MessageCommunicator.sendMessage(FriendList.FRIEND_LIST_LOADED,null);
         };
         if(this.initializeFriendInstancesStarted)
         {
            return;
         }
         this.initializeFriendInstancesStarted = true;
         new FriendshipServiceWeb().GetFriendListWithNameAndScore(userId,getFriendListDone);
      }
      
      private function getAnchorObject() : FriendData
      {
         var _loc1_:FriendData = new FriendData();
         _loc1_.actorId = AnchorActivityManager.activeAnchorId;
         _loc1_.name = AnchorActivityManager.activeAnchorName;
         _loc1_.lastInteractionDate = new Date(2000,1);
         _loc1_.membershipTimeoutDate = new Date(2099,1);
         _loc1_.recentlyLoggedIn = true;
         _loc1_.status = 2;
         _loc1_.vipTier = 3;
         return _loc1_;
      }
      
      public function removeFriend(param1:int) : void
      {
         this.friendList.removeFriend(param1);
      }
      
      public function isFriend(param1:int) : Boolean
      {
         var _loc2_:IFriend = this.friendList.getFriendById(param1);
         return _loc2_ != null && _loc2_.level > -1;
      }
      
      public function hasFriend(param1:int) : Boolean
      {
         return this.friendList.getFriendById(param1) != null;
      }
      
      public function isFriendOnline(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:IFriend = this.friendList.getFriendById(param1);
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.online;
         }
         return _loc2_;
      }
      
      public function addFriend(param1:int, param2:int, param3:String, param4:Boolean, param5:int, param6:Boolean) : void
      {
         this.friendList.createAndAddFriend(param2,param3,param5,param6);
      }
      
      public function sendPushSpecialFriendPushNotificationTo(param1:int, param2:Boolean) : void
      {
         var _loc3_:PushNotificationsAMFServiceWeb = null;
         if(this.isFriendOnline(param1) == false)
         {
            _loc3_ = new PushNotificationsAMFServiceWeb();
            if(param2)
            {
               _loc3_.SendBoyfriendRequest(param1);
            }
            else
            {
               _loc3_.SendBestFriendRequest(param1);
            }
         }
      }
   }
}

class SingletonBlocker
{
   
   public function SingletonBlocker()
   {
      super();
   }
}
