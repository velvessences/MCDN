package com.moviestarplanet.model
{
   import com.moviestarplanet.anchorCharacters.AnchorCharacters;
   import com.moviestarplanet.events.ComChannelEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.model.friends.ConstantsFriendshipStatus;
   import com.moviestarplanet.model.friends.ConstantsFriendshipType;
   import com.moviestarplanet.model.friends.IContentFriendlistJoiner;
   import com.moviestarplanet.model.friends.IFriend;
   import com.moviestarplanet.model.friends.IFriendConnectionStatusChangeListener;
   import com.moviestarplanet.model.friends.IFriendList;
   import com.moviestarplanet.model.friends.IFriendListSyncedListener;
   import com.moviestarplanet.model.friends.INewFriendListener;
   import com.moviestarplanet.model.friends.IParsableFriend;
   import com.moviestarplanet.model.friends.IRemoveFriendListener;
   import com.moviestarplanet.model.friends.VipTierConstants;
   import com.moviestarplanet.model.notification.Notification;
   import com.moviestarplanet.notification.INotificationChannel;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class FriendList implements IFriendList
   {
      
      public static const FRIEND_ADDED:String = "FRIEND_ADDED.FriendList";
      
      public static const FRIEND_REMOVED:String = "FRIEND_REMOVED.FriendList";
      
      public static const FRIEND_LIST_UPDATED:String = "FRIEND_LIST_UPDATED.FriendList";
      
      public static const FRIEND_LIST_LOADED:String = "FRIEND_LIST_LOADED";
      
      public static const ALL_FRIEND_SYNCS_FINISHED:String = "allFriendSyncsFinished";
      
      private static const FRIEND_RANKING_TIME_CONSTANT:Number = 365 * 24 * 60 * 60 * 1000;
      
      [Inject]
      public var eventDispatcher:IEventDispatcher;
      
      [Inject]
      public var notificationChannel:INotificationChannel;
      
      [Inject]
      public var contentJoiner:IContentFriendlistJoiner;
      
      protected var friendClass:Class = Friend;
      
      private var _allFriends:Dictionary;
      
      private var _pendingLoad:Dictionary;
      
      private var _friendsToCheck:Array;
      
      private var _timer:Timer = new Timer(50);
      
      private var _newFriendListeners:Vector.<INewFriendListener>;
      
      private var _removeFriendListeners:Vector.<IRemoveFriendListener>;
      
      private var _friendListLoadedListeners:Vector.<IFriendListSyncedListener>;
      
      private var _connectionStatusChangeListeners:Vector.<IFriendConnectionStatusChangeListener>;
      
      private var _isSynced:Boolean;
      
      private var _serverNow:Date;
      
      private var curFriendInitingId:Number = -1;
      
      public function FriendList()
      {
         super();
         this.initClassMembers();
      }
      
      public function parseFriendList(param1:Object) : void
      {
         var _loc2_:Friend = null;
         var _loc3_:Object = null;
         this._allFriends = new Dictionary();
         for each(_loc3_ in param1)
         {
            _loc2_ = new this.friendClass(_loc3_.user.UserId,_loc3_.user.Name,_loc3_.user.IsVip,_loc3_.user.SnapshotPath,1,ConstantsFriendshipType.CASUAL,ConstantsFriendshipStatus.IN_RELATIONSHIP,VipTierConstants.NON_VIP);
            _loc2_.assignHighscoreValues(_loc3_.user.money,_loc3_.user.fame,_loc3_.user.fortune,_loc3_.user.friendCount,_loc3_.user.roomLikes,_loc3_.user.membershipTimeoutDate,_loc3_.user.membershipTimeoutDate,_loc3_.user.isExtra,_loc3_.user.lastLogin);
            this._allFriends[_loc2_.actorId] = _loc2_;
            this._friendsToCheck.push(_loc2_);
         }
         this.checkFriendsOnlineStatusWhenReady();
         this.eventDispatcher.dispatchEvent(new MsgEvent(FRIEND_LIST_LOADED));
         this.contentJoiner.initialize(this);
      }
      
      public function parseInvitableFriends(param1:Object) : void
      {
      }
      
      public function parseList(param1:Array) : void
      {
         var _loc3_:IParsableFriend = null;
         var _loc4_:int = 0;
         var _loc5_:Friend = null;
         this._allFriends = new Dictionary();
         this.sortParsableFriends(param1);
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_];
            _loc4_ = (_loc2_ + 1) * 100 / param1.length;
            _loc5_ = new this.friendClass(_loc3_.userId,_loc3_.name,_loc3_.membershipTimeoutDate > new Date(),"",_loc3_.level,ConstantsFriendshipType.CASUAL,_loc3_.status,_loc4_,_loc3_.vipTier,_loc3_.moderator);
            _loc5_.assignHighscoreValues(_loc3_.money,_loc3_.fame,_loc3_.fortune,_loc3_.friendCount,_loc3_.roomLikes,_loc3_.membershipTimeoutDate,_loc3_.membershipPurchasedDate,_loc3_.isExtra,_loc3_.lastLogin);
            this._allFriends[_loc3_.userId] = _loc5_;
            this._friendsToCheck.push(_loc5_);
            _loc2_++;
         }
         this.checkFriendsOnlineStatusWhenReady();
         this.eventDispatcher.dispatchEvent(new MsgEvent(FRIEND_LIST_LOADED));
         this.contentJoiner.initialize(this);
      }
      
      private function checkFriendsOnlineStatusWhenReady() : void
      {
         if(this.notificationChannel.isChannelReady())
         {
            this.onComServSuccess(null);
         }
         else
         {
            this.eventDispatcher.addEventListener(ComChannelEvent.COMCONNECTION_SUCCESS,this.onComServSuccess);
            trace("FriendList checkFriendsOnlineStatusWhenReady waiting for channel");
         }
      }
      
      public function addFriendById(param1:int, param2:int, param3:int) : IFriend
      {
         var _loc4_:IFriend = null;
         if(this.getFriendById(param1) == null)
         {
            _loc4_ = new this.friendClass(param1,null,false,null,-1,param2,param3,Friend.RANK_MIDDLE,VipTierConstants.NON_VIP);
            this._pendingLoad[param1] = _loc4_;
            return null;
         }
         return this.getFriendById(param1);
      }
      
      public function createAndAddFriend(param1:int, param2:String, param3:int, param4:Boolean) : IFriend
      {
         var _loc5_:IFriend = null;
         if(this.getFriendById(param1) == null)
         {
            _loc5_ = this.createFriend(param1,param2,param3,param4,ConstantsFriendshipType.CASUAL,ConstantsFriendshipStatus.IN_RELATIONSHIP);
            this.addFriendToList(_loc5_);
         }
         return this.getFriendById(param1);
      }
      
      public function createFriend(param1:int, param2:String, param3:int, param4:Boolean, param5:int, param6:int) : IFriend
      {
         return new this.friendClass(param1,param2,param4,"",param3,param5,param6,Friend.RANK_MIDDLE,VipTierConstants.NON_VIP);
      }
      
      public function logFriendsInvited(param1:int) : void
      {
      }
      
      private function onComServSuccess(param1:ComChannelEvent) : void
      {
         if(this.notificationChannel.isChannelReady())
         {
            this.checkNextFriend();
            this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
            this._timer.start();
         }
         else
         {
            trace("FriendList onComServSuccess waiting for channel");
         }
      }
      
      public function parseFriendData(param1:Object) : void
      {
         var _loc3_:Friend = null;
         var _loc2_:int = int(param1.UserId);
         if(this._pendingLoad[_loc2_] != null)
         {
            _loc3_ = this._pendingLoad[_loc2_] as Friend;
            _loc3_.parseData(param1);
            this.addFriend(_loc3_);
            this._pendingLoad[_loc2_] = undefined;
         }
      }
      
      public function addFriendToList(param1:IFriend) : void
      {
         this.addFriend(param1);
      }
      
      private function addFriend(param1:IFriend) : void
      {
         if(this._allFriends)
         {
            this._allFriends[param1.userId] = param1;
         }
         this.notificationChannel.connectToFriend(param1.userId);
         this.broadcastNewFriend(param1);
         this.contentJoiner.onFriendAdded(param1);
      }
      
      private function broadcastNewFriend(param1:IFriend) : void
      {
         var _loc2_:INewFriendListener = null;
         for each(_loc2_ in this._newFriendListeners)
         {
            _loc2_.onNewFriendLoaded(param1);
         }
      }
      
      public function removeFriend(param1:Number) : void
      {
         var _loc3_:IRemoveFriendListener = null;
         var _loc2_:IFriend = this.getFriendById(param1);
         if(_loc2_ != null)
         {
            this.notificationChannel.disconnectFromFriend(param1);
            this._allFriends[param1] = null;
            (_loc2_ as Friend).destroy();
            delete this._allFriends[param1];
            this.eventDispatcher.dispatchEvent(new MsgEvent(FRIEND_REMOVED,param1));
            for each(_loc3_ in this._removeFriendListeners)
            {
               _loc3_.onFriendRemoved(_loc2_);
            }
         }
      }
      
      public function get size() : int
      {
         if(this._allFriends == null)
         {
            return 0;
         }
         return this.getLengthOfDictionary(this._allFriends);
      }
      
      public function relationshipCount(param1:int) : int
      {
         var _loc3_:IFriend = null;
         var _loc4_:Object = null;
         var _loc2_:int = 0;
         for(_loc4_ in this._allFriends)
         {
            _loc3_ = this._allFriends[_loc4_];
            if(_loc3_.status == param1)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      private function checkNextFriend() : Boolean
      {
         var _loc1_:Friend = null;
         if(this._friendsToCheck.length > 0 && this.notificationChannel.isChannelReady())
         {
            _loc1_ = this._friendsToCheck.pop();
            if(AnchorCharacters.isSpecialCharacter(_loc1_.actorId))
            {
               _loc1_.connectionStatus = "APPLICATION_WEB";
            }
            else
            {
               this.notificationChannel.connectToFriend(_loc1_.actorId);
            }
            this.curFriendInitingId = _loc1_.actorId;
            return true;
         }
         if(!this.notificationChannel.isChannelReady())
         {
            trace("FriendList checkNextFriend waiting for channel");
         }
         return false;
      }
      
      public function destroy() : void
      {
         var _loc1_:Friend = null;
         this.eventDispatcher.removeEventListener(ComChannelEvent.COMCONNECTION_SUCCESS,this.onComServSuccess);
         this._timer.stop();
         for each(_loc1_ in this._allFriends)
         {
            _loc1_.destroy();
         }
         this._allFriends = null;
         this.initClassMembers();
      }
      
      public function getFriendById(param1:Number) : IFriend
      {
         if(this._allFriends != null)
         {
            return this._allFriends[param1];
         }
         return null;
      }
      
      public function getFriendsByName(param1:String, param2:Boolean = false) : Array
      {
         var _loc4_:Friend = null;
         var _loc3_:Array = [];
         for each(_loc4_ in this._allFriends)
         {
            if(_loc4_.name.toLowerCase().indexOf(param1.toLowerCase()) != -1)
            {
               if(param2 || _loc4_.isFriends)
               {
                  _loc3_.push(_loc4_);
               }
            }
         }
         _loc3_.sortOn(["isPendingMyResponse","name"],[Array.DESCENDING | Array.CASEINSENSITIVE,Array.CASEINSENSITIVE]);
         return _loc3_;
      }
      
      private function onTimer(param1:Event) : void
      {
         var _loc2_:IFriendListSyncedListener = null;
         if(!this.checkNextFriend())
         {
            this._isSynced = true;
            MessageCommunicator.send(new MsgEvent(ALL_FRIEND_SYNCS_FINISHED));
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
            for each(_loc2_ in this._friendListLoadedListeners)
            {
               _loc2_.onNewFriendSynced(this.friendList);
            }
         }
      }
      
      public function getFriendsList(param1:Boolean = false) : Array
      {
         var _loc3_:Friend = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in this._allFriends)
         {
            if(!param1 || _loc3_.online)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function get onlineFriends() : Vector.<IFriend>
      {
         var _loc2_:Friend = null;
         var _loc1_:Vector.<IFriend> = new Vector.<IFriend>();
         for each(_loc2_ in this._allFriends)
         {
            if(_loc2_.online)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function get offlineFriends() : Vector.<IFriend>
      {
         var _loc2_:Friend = null;
         var _loc1_:Vector.<IFriend> = new Vector.<IFriend>();
         for each(_loc2_ in this._allFriends)
         {
            if(_loc2_.online == false)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function get friendList() : Vector.<IFriend>
      {
         var _loc2_:Friend = null;
         var _loc1_:Vector.<IFriend> = new Vector.<IFriend>();
         for each(_loc2_ in this._allFriends)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function sendToAllFriends(param1:Notification) : void
      {
         this.notificationChannel.sendNotificationToOnlineFriends(param1);
      }
      
      public function getFriendActorIds() : Vector.<uint>
      {
         var _loc2_:Friend = null;
         var _loc1_:Vector.<uint> = new Vector.<uint>(0);
         for each(_loc2_ in this._allFriends)
         {
            _loc1_.push(_loc2_.actorId);
         }
         return _loc1_;
      }
      
      public function getFriendStatus(param1:int) : int
      {
         var _loc2_:IFriend = this.getFriendById(param1);
         if(_loc2_)
         {
            return (_loc2_ as Friend).status;
         }
         return ConstantsFriendshipStatus.UNDEFINED;
      }
      
      public function get allFriends() : Dictionary
      {
         return this._allFriends;
      }
      
      public function listenForNewFriends(param1:INewFriendListener) : void
      {
         this._newFriendListeners.push(param1);
      }
      
      public function listenForStatusChange(param1:IFriendConnectionStatusChangeListener) : void
      {
         this._connectionStatusChangeListeners.push(param1);
      }
      
      public function stoplistenForStatusChange(param1:IFriendConnectionStatusChangeListener) : void
      {
         this._connectionStatusChangeListeners.splice(this._connectionStatusChangeListeners.indexOf(param1),1);
      }
      
      public function listenForRemovedFriends(param1:IRemoveFriendListener) : void
      {
         this._removeFriendListeners.push(param1);
      }
      
      public function stopListeningForRemovedFriends(param1:IRemoveFriendListener) : void
      {
         this._removeFriendListeners.splice(this._removeFriendListeners.indexOf(param1),1);
      }
      
      public function stopListeningForNewFriends(param1:INewFriendListener) : void
      {
         this._newFriendListeners.splice(this._newFriendListeners.indexOf(param1),1);
      }
      
      public function listenForListSynced(param1:IFriendListSyncedListener) : void
      {
         this._friendListLoadedListeners.push(param1);
      }
      
      public function stopListeningForListSynced(param1:IFriendListSyncedListener) : void
      {
         this._friendListLoadedListeners.splice(this._friendListLoadedListeners.indexOf(param1),1);
      }
      
      public function setOnlineStatus(param1:Number, param2:String) : void
      {
         var _loc4_:IFriendConnectionStatusChangeListener = null;
         var _loc3_:Friend = this.getFriendById(param1) as Friend;
         if(_loc3_)
         {
            _loc3_.connectionStatus = param2;
            for each(_loc4_ in this._connectionStatusChangeListeners)
            {
               _loc4_.onConnectionStatusChange(_loc3_);
            }
            this.eventDispatcher.dispatchEvent(new MsgEvent(FRIEND_LIST_UPDATED));
         }
      }
      
      public function get isSynced() : Boolean
      {
         return this._isSynced;
      }
      
      private function initClassMembers() : void
      {
         this._friendsToCheck = [];
         this._pendingLoad = new Dictionary();
         this._newFriendListeners = new Vector.<INewFriendListener>();
         this._friendListLoadedListeners = new Vector.<IFriendListSyncedListener>();
         this._removeFriendListeners = new Vector.<IRemoveFriendListener>();
         this._connectionStatusChangeListeners = new Vector.<IFriendConnectionStatusChangeListener>();
      }
      
      private function getLengthOfDictionary(param1:Dictionary) : int
      {
         var _loc3_:Object = null;
         var _loc2_:int = 0;
         for(_loc3_ in param1)
         {
            _loc2_++;
         }
         return _loc2_;
      }
      
      private function sortParsableFriends(param1:Array) : void
      {
         var _loc3_:IParsableFriend = null;
         var _loc4_:Number = NaN;
         var _loc2_:Date = this._serverNow;
         for each(_loc3_ in param1)
         {
            if(_loc3_.lastInteractionDate == null)
            {
               _loc3_.lastInteractionDate = new Date(2000,1);
            }
            _loc4_ = (FRIEND_RANKING_TIME_CONSTANT - (_loc2_.getTime() - _loc3_.lastInteractionDate.getTime())) / FRIEND_RANKING_TIME_CONSTANT;
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            _loc3_.score *= _loc4_;
         }
         param1.sortOn("score",Array.NUMERIC | Array.DESCENDING);
      }
      
      public function set serverNow(param1:Date) : void
      {
         this._serverNow = param1;
      }
   }
}

