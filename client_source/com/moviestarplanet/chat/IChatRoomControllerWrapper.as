package com.moviestarplanet.chat
{
   public interface IChatRoomControllerWrapper
   {
      
      function get chatRoomId() : String;
      
      function set chatRoomId(param1:String) : void;
      
      function displayMyRoom(param1:int = 0) : void;
      
      function displayMyRoomWithItems(param1:int = 0) : void;
      
      function get isPlayingChatroomGame() : Boolean;
      
      function set isPlayingChatroomGame(param1:Boolean) : void;
      
      function set walkEnabled(param1:Boolean) : void;
      
      function enterChatRoom(param1:String) : void;
      
      function get currentRoomActorId() : Number;
      
      function set currentRoomActorId(param1:Number) : void;
      
      function get currentRoomName() : String;
      
      function set currentRoomName(param1:String) : void;
      
      function get currentRoomSection() : int;
      
      function set currentRoomSection(param1:int) : void;
      
      function get currentRoomCloseHandler() : Function;
      
      function set currentRoomCloseHandler(param1:Function) : void;
   }
}

