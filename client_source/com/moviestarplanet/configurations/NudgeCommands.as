package com.moviestarplanet.configurations
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.session.nudge.NudgeDispatcher;
   
   public class NudgeCommands
   {
      
      public static const COMMAND_COMBAT:String = "Combat";
      
      public static const COMMAND_RELOAD_ACTOR_DETAILS:String = "ActorDetails";
      
      public function NudgeCommands()
      {
         super();
      }
      
      public function setupSharedCommands() : void
      {
         NudgeDispatcher.getInstance().addCommand(NudgeCommands.COMMAND_COMBAT,this.commandCombat);
         NudgeDispatcher.getInstance().addCommand(NudgeCommands.COMMAND_RELOAD_ACTOR_DETAILS,this.commandReload);
      }
      
      public function commandCombat() : void
      {
         MessageCommunicator.send(new MsgEvent(MSPEvent.NUDGE_EVENT_UPDATE_COMBAT));
      }
      
      public function commandReload() : void
      {
         MessageCommunicator.send(new MsgEvent(MSPEvent.NUDGE_EVENT_UPDATE_RELOAD_ACTOR));
      }
   }
}

