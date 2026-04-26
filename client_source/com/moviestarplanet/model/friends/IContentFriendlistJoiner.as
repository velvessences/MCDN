package com.moviestarplanet.model.friends
{
   public interface IContentFriendlistJoiner
   {
      
      function joinObject(param1:Object) : void;
      
      function joinArray(param1:Array) : void;
      
      function joinVector(param1:Vector.<Object>) : void;
      
      function onFriendAdded(param1:IFriend) : void;
      
      function initialize(param1:IFriendList) : void;
   }
}

