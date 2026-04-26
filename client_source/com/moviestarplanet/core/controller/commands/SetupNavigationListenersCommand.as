package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.Forms.world.elements.WorldArea;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   
   public class SetupNavigationListenersCommand
   {
      
      public function SetupNavigationListenersCommand()
      {
         super();
      }
      
      private static function navigateToWorldArea(param1:MsgEvent) : void
      {
         WorldArea.showWorldArea(WorldArea.OVERVIEW);
      }
      
      public function execute() : void
      {
         MessageCommunicator.subscribe(MSPEvent.NAVIGATE_WORLD_AREA,navigateToWorldArea);
      }
   }
}

