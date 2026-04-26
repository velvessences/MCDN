package com.moviestarplanet.model.friends
{
   public interface IFriendList
   {
      
      function logFriendsInvited(param1:int) : void;
      
      function parseFriendList(param1:Object) : void;
      
      function parseInvitableFriends(param1:Object) : void;
      
      function getFriendsList(param1:Boolean = false) : Array;
      
      function getFriendById(param1:Number) : IFriend;
      
      function listenForNewFriends(param1:INewFriendListener) : void;
      
      function createFriend(param1:int, param2:String, param3:int, param4:Boolean, param5:int, param6:int) : IFriend;
      
      function createAndAddFriend(param1:int, param2:String, param3:int, param4:Boolean) : IFriend;
      
      function addFriendById(param1:int, param2:int, param3:int) : IFriend;
      
      function removeFriend(param1:Number) : void;
      
      function parseFriendData(param1:Object) : void;
      
      function parseList(param1:Array) : void;
      
      function stopListeningForNewFriends(param1:INewFriendListener) : void;
      
      function listenForListSynced(param1:IFriendListSyncedListener) : void;
      
      function stopListeningForListSynced(param1:IFriendListSyncedListener) : void;
      
      function get isSynced() : Boolean;
      
      function get friendList() : Vector.<IFriend>;
      
      function get onlineFriends() : Vector.<IFriend>;
      
      function get offlineFriends() : Vector.<IFriend>;
      
      function getFriendsByName(param1:String, param2:Boolean = false) : Array;
      
      function get size() : int;
      
      function addFriendToList(param1:IFriend) : void;
      
      function listenForRemovedFriends(param1:IRemoveFriendListener) : void;
      
      function stopListeningForRemovedFriends(param1:IRemoveFriendListener) : void;
      
      function listenForStatusChange(param1:IFriendConnectionStatusChangeListener) : void;
      
      function stoplistenForStatusChange(param1:IFriendConnectionStatusChangeListener) : void;
      
      function destroy() : void;
      
      function set serverNow(param1:Date) : void;
      
      function setOnlineStatus(param1:Number, param2:String) : void;
      
      function relationshipCount(param1:int) : int;
   }
}

