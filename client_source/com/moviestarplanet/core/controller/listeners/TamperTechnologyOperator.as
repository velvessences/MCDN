package com.moviestarplanet.core.controller.listeners
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.utils.TamperTechnology;
   import com.moviestarplanet.window.event.WindowEvent;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   import flash.utils.setTimeout;
   
   public class TamperTechnologyOperator
   {
      
      public function TamperTechnologyOperator()
      {
         super();
      }
      
      public static function wireup() : void
      {
         MessageCommunicator.subscribe(WindowEvent.WINDOW_OPENING,checkIfUserIsCheating);
      }
      
      private static function checkIfUserIsCheating(param1:MsgEvent) : void
      {
         if(ActorSession.loggedInActor == null)
         {
            return;
         }
         if(TamperTechnology.hasActorIdBeenModified(ActorSession.loggedInActor.ActorId))
         {
            if(Config.IsRunningInDevelopment)
            {
               new Prompt("This prompt will not be shown LIVE... If you did not use Cheat Engine, then notify people!","OMG! You\'re using CHEAT ENGINE??");
               setTimeout(logOutUser,10000);
            }
            else
            {
               logOutUser();
            }
         }
      }
      
      private static function logOutUser() : void
      {
         MessageCommunicator.send(new MsgEvent(MSPEvent.DO_LOGOUT));
      }
   }
}

