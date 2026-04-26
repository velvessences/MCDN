package com.moviestarplanet.model.contentJoiner
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.model.Friend;
   import com.moviestarplanet.model.friends.IContentFriendlistJoiner;
   import com.moviestarplanet.model.friends.IFriend;
   import com.moviestarplanet.model.friends.IFriendList;
   
   public class ContentFriendlistJoiner implements IContentFriendlistJoiner
   {
      
      private var listMap:Object;
      
      private var friendObjectMe:IFriend;
      
      public function ContentFriendlistJoiner()
      {
         super();
         this.listMap = new Object();
         MessageCommunicator.subscribe(MSPEvent.SETUP_CFLJ,this.onActorLoggedIn);
      }
      
      public function initialize(param1:IFriendList) : void
      {
         var _loc4_:IFriend = null;
         this.listMap = new Object();
         var _loc2_:int = int(param1.friendList.length);
         var _loc3_:Vector.<IFriend> = param1.friendList;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = _loc3_[_loc5_];
            this.listMap[_loc4_.userId] = _loc4_;
            _loc5_++;
         }
         if(this.friendObjectMe != null)
         {
            this.onFriendAdded(this.friendObjectMe);
         }
      }
      
      private function onActorLoggedIn(param1:MsgEvent) : void
      {
         var _loc2_:Object = param1.data;
         this.addInfoFromActorDetails(_loc2_);
      }
      
      private function addInfoFromActorDetails(param1:Object) : void
      {
         this.friendObjectMe = new Friend(param1.actorId,param1.Name,param1.isVip,"",param1.Level,0,0,0,param1.vipTier,param1.getLoginModeratorStatusForCheckOnLogin);
         this.onFriendAdded(this.friendObjectMe);
      }
      
      public function onFriendAdded(param1:IFriend) : void
      {
         this.listMap[param1.userId] = param1;
      }
      
      public function joinObject(param1:Object) : void
      {
         var _loc2_:Object = null;
         for each(_loc2_ in param1)
         {
            this.handleDataObject(_loc2_);
         }
      }
      
      public function joinArray(param1:Array) : void
      {
         this.handleDataList(param1);
      }
      
      public function joinVector(param1:Vector.<Object>) : void
      {
         this.handleDataList(param1);
      }
      
      private function handleDataList(param1:Object) : void
      {
         var _loc3_:Object = null;
         var _loc2_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = param1[_loc4_];
            this.handleDataObject(_loc3_);
            _loc4_++;
         }
      }
      
      private function handleDataObject(param1:Object) : void
      {
         var _loc2_:int = int(param1.ActorId);
         var _loc3_:IFriend = this.listMap[_loc2_];
         var _loc4_:ContentActorInfo = ContentActorInfo.fromValues(_loc3_.name,_loc3_.isVip,_loc3_.vipTier,_loc3_.level);
         param1.ActorInfo = _loc4_;
      }
   }
}

