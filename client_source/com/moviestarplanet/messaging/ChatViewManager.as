package com.moviestarplanet.messaging
{
   import com.moviestarplanet.chat.LiveChatHandler;
   import com.moviestarplanet.chatCommunicator.chatHelpers.chatpermission.ChatPermissionManager;
   import com.moviestarplanet.friends.FriendsManager;
   import com.moviestarplanet.games.EmbeddedGames.EmbeddedGamesModuleManager;
   import com.moviestarplanet.messaging.module.moduleparts.chatwindow.view.ChatViewEvent;
   import com.moviestarplanet.messaging.module.moduleparts.chatwindow.view.IChatView;
   import com.moviestarplanet.model.friends.IFriend;
   import com.moviestarplanet.msgservice.MsgService;
   import com.moviestarplanet.msgservice.utils.ConversationIdCache;
   import com.moviestarplanet.utils.DateUtils;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.window.utils.PopupUtils;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import mx.core.Container;
   
   public class ChatViewManager extends EventDispatcher
   {
      
      private static var _instance:ChatViewManager;
      
      private var _chatformInstanceDic:Dictionary = new Dictionary(true);
      
      public function ChatViewManager(param1:Class)
      {
         super();
         if(param1 != SingletonBlocker)
         {
            throw new Error("ChatViewManager is a singleton class, use ChatViewManager.getInstance instead!");
         }
      }
      
      public static function getInstance() : ChatViewManager
      {
         if(_instance == null)
         {
            _instance = new ChatViewManager(SingletonBlocker);
         }
         return _instance;
      }
      
      public function getChatView(param1:String) : IChatView
      {
         return this._chatformInstanceDic[param1];
      }
      
      private function setChatView(param1:String, param2:IChatView) : void
      {
         this._chatformInstanceDic[param1] = param2;
      }
      
      public function deleteEntry(param1:String) : void
      {
         delete this._chatformInstanceDic[param1];
      }
      
      public function closeChatView(param1:String) : void
      {
         var _loc2_:IChatView = null;
         if(this._chatformInstanceDic[param1] != null)
         {
            _loc2_ = this._chatformInstanceDic[param1];
            _loc2_.close();
         }
      }
      
      public function showChatForm(param1:Number, param2:Number, param3:String = null, param4:int = 0) : void
      {
         var isFriendVip:Boolean = false;
         var done:Function = null;
         var friend:IFriend = null;
         var x:Number = param1;
         var y:Number = param2;
         var conversationId:String = param3;
         var friendId:int = param4;
         done = function(param1:String):void
         {
            doShowChatForm(x,y,param1,isFriendVip,friendId);
         };
         if(friendId > 0)
         {
            friend = FriendsManager.getInstance().getFriend(friendId);
            if(friend != null)
            {
               isFriendVip = friend.isVip;
            }
         }
         if(conversationId == null)
         {
            ConversationIdCache.getInstance().getOrCreateConversationIdForActorId(friendId,done);
         }
         else if(LiveChatHandler.hasLeft(conversationId) == false)
         {
            this.doShowChatForm(x,y,conversationId,isFriendVip,friendId);
         }
      }
      
      private function doShowChatForm(param1:Number, param2:Number, param3:String, param4:Boolean, param5:int) : void
      {
         var chatwindowgotten:Function = null;
         var x:Number = param1;
         var y:Number = param2;
         var conversationId:String = param3;
         var isFriendVip:Boolean = param4;
         var friendId:int = param5;
         chatwindowgotten = function(param1:IChatView, param2:Boolean = false):void
         {
            if(param1 != null)
            {
               if(getChatView(conversationId) == null || getChatView(conversationId).isDisplayed == false)
               {
                  if(!param2)
                  {
                     setChatView(conversationId,param1);
                  }
                  MsgService.getInstance().markRead(conversationId,null);
                  ChatViewManager.getInstance().dispatchEvent(new ChatViewEvent(ChatViewEvent.MESSAGE_READ,{"conversationId":conversationId}));
                  PopupUtils.showPopupChatbox(param1 as Container,x,y);
                  if(param1.y <= 0)
                  {
                     (param1 as Container).y = 300;
                  }
               }
            }
         };
         if(!ChatPermissionManager.instance.isPermitted)
         {
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("CHAT_NOT_ALLOWED_DESC",[DateUtils.msToHrsMinsSecsString(ChatPermissionManager.instance.getSecondsRemaining() * 1000)]));
            return;
         }
         if(x > 1000)
         {
            x = 1000;
         }
         if(EmbeddedGamesModuleManager.getInstance().isPlaying)
         {
            x = 0;
         }
         if(this.getChatView(conversationId))
         {
            chatwindowgotten(this.getChatView(conversationId),true);
         }
         else
         {
            MessagingManager.createChatView(conversationId,friendId,isFriendVip,chatwindowgotten);
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
