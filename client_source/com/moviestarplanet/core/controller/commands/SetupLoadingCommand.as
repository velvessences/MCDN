package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.window.loading.LoadingBar;
   
   public class SetupLoadingCommand
   {
      
      private static var loadingBar:LoadingBar;
      
      public function SetupLoadingCommand()
      {
         super();
      }
      
      private static function loadingShow(param1:MsgEvent) : void
      {
         if(loadingBar == null)
         {
            loadingBar = new LoadingBar();
         }
         loadingBar.show();
      }
      
      private static function loadingHide(param1:MsgEvent) : void
      {
         if(loadingBar != null)
         {
            loadingBar.hide();
         }
      }
      
      public function execute() : void
      {
         MessageCommunicator.subscribe(MSPEvent.LOADING_SHOW,loadingShow);
         MessageCommunicator.subscribe(MSPEvent.LOADING_HIDE,loadingHide);
      }
   }
}

