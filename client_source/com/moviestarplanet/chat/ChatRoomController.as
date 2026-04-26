package com.moviestarplanet.chat
{
   import com.moviestarplanet.Components.EditMyRoom;
   import com.moviestarplanet.Components.popup.ErrorPopup;
   import com.moviestarplanet.Forms.ChatRoom;
   import com.moviestarplanet.Forms.minigame.queue.RoomRequester;
   import com.moviestarplanet.anchorCharacters.AnchorCharacters;
   import com.moviestarplanet.chat.video.videochatroom.VideoChatRoom;
   import com.moviestarplanet.competition.valueobjects.MovieCompetition;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.flash.components.popups.viponly.VIPOnlyPopUp;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.msg.AreaEvent;
   import com.moviestarplanet.pets.MyClickItem;
   import com.moviestarplanet.popup.OldPopupHandler;
   import com.moviestarplanet.utils.Utils;
   import com.moviestarplanet.utils.chat.ChatLogic;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.window.stack.WindowStack;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   import mx.collections.ArrayCollection;
   
   public class ChatRoomController
   {
      
      public static var currentRoomPublic:String;
      
      public static var currentRoomName:String;
      
      public static var currentRoomCompetition:MovieCompetition;
      
      public static var currentRoomCloseHandler:Function;
      
      public static var chatRoomView:ChatRoom;
      
      public static var currentRoomActorId:Number = 0;
      
      public static var currentRoomSection:int = 0;
      
      public static var isPlayingChatroomGame:Boolean = false;
      
      public function ChatRoomController()
      {
         super();
      }
      
      public static function showPublicProfile(param1:int, param2:String, param3:int = 0, param4:Function = null, param5:MovieCompetition = null) : void
      {
         var afterJoined:Function = null;
         var anchorName:String = null;
         var actorId:int = param1;
         var userName:String = param2;
         var roomSection:int = param3;
         var closeHandler:Function = param4;
         var competition:MovieCompetition = param5;
         afterJoined = function():void
         {
            if(closeHandler == null)
            {
               OldPopupHandler.getInstance().closeMainPopup();
            }
            if(chatRoomView == null || Utils.getClass(chatRoomView) != ChatRoom)
            {
               chatRoomView = new ChatRoom();
            }
            if(Main.Instance.mainCanvas.applicationViewStack.mainView.moviestarContainer.myMovieStar.clickItem != null)
            {
               chatRoomView.myClickItemString = (Main.Instance.mainCanvas.applicationViewStack.mainView.moviestarContainer.myMovieStar.clickItem as IChatRoomPet).chatRoomPetId;
            }
            else
            {
               chatRoomView.myClickItemString = "";
            }
            if(closeHandler == null)
            {
               WindowStack.showSpriteAsViewStackable(chatRoomView,235,80,WindowStack.Z_ROOM);
            }
            else
            {
               WindowStack.showSpriteAsViewStackable(chatRoomView,235,80,WindowStack.Z_INFO);
            }
            chatRoomView.Enter();
            if(ActorSession.getActorId() == actorId)
            {
               MessageCommunicator.send(new AreaEvent(AreaEvent.MY_ROOM));
            }
         };
         currentRoomPublic = "";
         currentRoomActorId = actorId;
         currentRoomName = userName;
         currentRoomSection = roomSection;
         currentRoomCloseHandler = closeHandler;
         currentRoomCompetition = competition;
         var blockingActors:ArrayCollection = ActorSession.blockingActors;
         if(false == ActorSession.isModerator() && true == blockingActors.contains(actorId))
         {
            new ErrorPopup(MSPLocaleManagerWeb.getInstance().getString("BLOCKED_OTHER_HEADLINE"),MSPLocaleManagerWeb.getInstance().getString("BLOCKED_OTHER_TEXT")).show();
         }
         else if(AnchorCharacters.isSpecialCharacter(currentRoomActorId))
         {
            anchorName = AnchorCharacters.getChatRoomInstanceName(currentRoomActorId);
            RoomRequester.requestRoom(anchorName,function(param1:String):void
            {
               afterJoined();
            });
         }
         else
         {
            RoomRequester.joinRoom(afterJoined,currentRoomActorId + "_room",Config.GetLanguage + "_profile");
         }
      }
      
      public static function get chatRoomId() : String
      {
         return chatRoomView.roomId;
      }
      
      public static function set chatRoomId(param1:String) : void
      {
         chatRoomView.roomId = param1;
      }
      
      public static function displayMyRoom(param1:int = 0) : void
      {
         WindowStack.clearViewStack();
         OldPopupHandler.getInstance().closeMainPopup();
         currentRoomSection = param1;
         WindowStack.showSpriteAsViewStackable(EditMyRoom.instance,235,80,WindowStack.Z_CONTENT);
      }
      
      public static function displayMyRoomWithItems(param1:int = 0) : void
      {
         displayMyRoom(param1);
         if(EditMyRoom.instance.itemsCanvas != null)
         {
            EditMyRoom.instance.itemsCanvas.visible = true;
         }
      }
      
      public static function set walkEnabled(param1:Boolean) : void
      {
         chatRoomView.disableWalk = !param1;
      }
      
      public static function enterChatRoom(param1:String) : void
      {
         var continueEnterChat:Function = null;
         var chatRoom:String = param1;
         continueEnterChat = function():void
         {
            OldPopupHandler.getInstance().closeMainPopup();
            currentRoomPublic = chatRoom;
            currentRoomName = chatRoom;
            currentRoomActorId = 0;
            switch(ChatRoomType.getChatType(chatRoom))
            {
               case ChatRoomType.VIDEO_CHATROOM:
                  if(chatRoomView == null || Utils.getClass(chatRoomView) != VideoChatRoom)
                  {
                     chatRoomView = new VideoChatRoom();
                  }
                  break;
               default:
                  if(chatRoomView == null || Utils.getClass(chatRoomView) != ChatRoom)
                  {
                     chatRoomView = new ChatRoom();
                  }
            }
            if(MyClickItem.string != null && MyClickItem.string != "")
            {
               chatRoomView.myClickItemString = MyClickItem.string;
            }
            else if(Main.Instance.mainCanvas.applicationViewStack.mainView.moviestarContainer.myMovieStar.clickItem != null)
            {
               chatRoomView.myClickItemString = (Main.Instance.mainCanvas.applicationViewStack.mainView.moviestarContainer.myMovieStar.clickItem as IChatRoomPet).chatRoomPetId;
            }
            else
            {
               chatRoomView.myClickItemString = "";
            }
            MyClickItem.string = "";
            WindowStack.showSpriteAsViewStackable(chatRoomView,235,80,WindowStack.Z_ROOM);
            chatRoomView.Enter();
         };
         if(!hasRequiredLevel(chatRoom))
         {
            return;
         }
         if(!hasRequiredVip(chatRoom))
         {
            return;
         }
         ThemeChatRoomControllerWeb.hasRequiredItem(chatRoom,continueEnterChat);
      }
      
      private static function hasRequiredLevel(param1:String) : Boolean
      {
         var _loc2_:Number = ChatLogic.GetRequiredLevelForChatRoom(param1);
         if(ActorSession.loggedInActor.Level < _loc2_)
         {
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("CHATROOM_LEVEL",[_loc2_,ActorSession.loggedInActor.Level]),MSPLocaleManagerWeb.getInstance().getString("HIGHER_LEVEL_REQ"));
            return false;
         }
         return true;
      }
      
      private static function hasRequiredVip(param1:String) : Boolean
      {
         var _loc2_:Boolean = ChatLogic.GetVipRequiredForChatRoom(param1);
         if(_loc2_ && !ActorSession.isVip)
         {
            VIPOnlyPopUp.Show(MSPLocaleManagerWeb.getInstance().getString("CHATROOM_VIP"));
            return false;
         }
         return true;
      }
   }
}

