package com.moviestarplanet.chat
{
   import com.moviestarplanet.Forms.ChatRoom;
   import com.moviestarplanet.competition.valueobjects.MovieCompetition;
   
   public class ChatRoomControllerWrapper implements IChatRoomControllerWrapper
   {
      
      private static var instance:IChatRoomControllerWrapper;
      
      public function ChatRoomControllerWrapper()
      {
         super();
      }
      
      public static function getInstance() : IChatRoomControllerWrapper
      {
         if(instance == null)
         {
            instance = new ChatRoomControllerWrapper();
         }
         return instance;
      }
      
      public function get chatRoomView() : ChatRoom
      {
         return ChatRoomController.chatRoomView;
      }
      
      public function set chatRoomView(param1:ChatRoom) : void
      {
         ChatRoomController.chatRoomView = param1;
      }
      
      public function showPublicProfile(param1:int, param2:String, param3:int = 0, param4:Function = null, param5:MovieCompetition = null) : void
      {
         ChatRoomController.showPublicProfile(param1,param2,param3,param4,param5);
      }
      
      public function get chatRoomId() : String
      {
         return ChatRoomController.chatRoomId;
      }
      
      public function set chatRoomId(param1:String) : void
      {
         ChatRoomController.chatRoomId = param1;
      }
      
      public function displayMyRoom(param1:int = 0) : void
      {
         ChatRoomController.displayMyRoom(param1);
      }
      
      public function displayMyRoomWithItems(param1:int = 0) : void
      {
         ChatRoomController.displayMyRoomWithItems(param1);
      }
      
      public function get isPlayingChatroomGame() : Boolean
      {
         return ChatRoomController.isPlayingChatroomGame;
      }
      
      public function set isPlayingChatroomGame(param1:Boolean) : void
      {
         ChatRoomController.isPlayingChatroomGame = param1;
      }
      
      public function set walkEnabled(param1:Boolean) : void
      {
         ChatRoomController.chatRoomView.disableWalk = !param1;
      }
      
      public function enterChatRoom(param1:String) : void
      {
         return ChatRoomController.enterChatRoom(param1);
      }
      
      public function get currentRoomActorId() : Number
      {
         return ChatRoomController.currentRoomActorId;
      }
      
      public function set currentRoomActorId(param1:Number) : void
      {
         ChatRoomController.currentRoomActorId = param1;
      }
      
      public function get currentRoomName() : String
      {
         return ChatRoomController.currentRoomName;
      }
      
      public function set currentRoomName(param1:String) : void
      {
         ChatRoomController.currentRoomName = param1;
      }
      
      public function get currentRoomSection() : int
      {
         return ChatRoomController.currentRoomSection;
      }
      
      public function set currentRoomSection(param1:int) : void
      {
         ChatRoomController.currentRoomSection = param1;
      }
      
      public function get currentRoomCompetition() : MovieCompetition
      {
         return ChatRoomController.currentRoomCompetition;
      }
      
      public function set currentRoomCompetition(param1:MovieCompetition) : void
      {
         ChatRoomController.currentRoomCompetition = param1;
      }
      
      public function get currentRoomCloseHandler() : Function
      {
         return ChatRoomController.currentRoomCloseHandler;
      }
      
      public function set currentRoomCloseHandler(param1:Function) : void
      {
         ChatRoomController.currentRoomCloseHandler = param1;
      }
   }
}

