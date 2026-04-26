package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.core.model.actor.reload.ActorReload;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.msg.events.ActorUpdateEvent;
   
   public class ActorUpdateCommand
   {
      
      public function ActorUpdateCommand()
      {
         super();
      }
      
      public static function updateActor(param1:MsgEvent) : void
      {
         ActorReload.getInstance().requestReload();
      }
      
      public function execute() : void
      {
         MessageCommunicator.subscribe(ActorUpdateEvent.UPDATE,updateActor);
      }
   }
}

