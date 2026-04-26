package com.moviestarplanet.core.controller.commands.startupcommands
{
   import com.moviestarplanet.Forms.minigame.queue.RoomRequester;
   
   public class SetupRoomConnectinCommand
   {
      
      public function SetupRoomConnectinCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         RoomRequester.roomCon;
      }
   }
}

