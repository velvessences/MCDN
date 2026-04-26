package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.chat.ChatRoomControllerWrapper;
   import com.moviestarplanet.chat.IChatRoomControllerWrapper;
   import com.moviestarplanet.injection.InjectionManager;
   
   public class ChatCommand
   {
      
      public function ChatCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         InjectionManager.mapper().map(IChatRoomControllerWrapper).toValue(ChatRoomControllerWrapper.getInstance());
      }
   }
}

