package com.moviestarplanet.combat
{
   import com.moviestarplanet.combat.enums.CombatEvent;
   import com.moviestarplanet.combat.penalties.CombatPenalty;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.msg.ActionEvent;
   import com.moviestarplanet.usersession.service.UserSessionAMFService;
   import com.moviestarplanet.utils.chatfilter.nanny.WebNanny;
   
   public class CombatProfileUpdaterWeb extends CombatProfileUpdater
   {
      
      private static var instance:CombatProfileUpdaterWeb = getInstance();
      
      public function CombatProfileUpdaterWeb()
      {
         super();
         MessageCommunicator.subscribe(ActionEvent.OPEN_ARCADE_GAME,this.onArcadeGameOpened);
         MessageCommunicator.subscribe(ActionEvent.CLOSE_ARCADE_GAME,this.onArcadeGameClosed);
      }
      
      public static function getInstance() : CombatProfileUpdaterWeb
      {
         if(instance == null)
         {
            instance = new CombatProfileUpdaterWeb();
         }
         instance.initialize();
         return instance;
      }
      
      private function onArcadeGameClosed(param1:MsgEvent = null) : void
      {
         blockerAllowed = true;
         if(currentPrompt != null)
         {
            currentPrompt.setBlockerVisibility(blockerAllowed);
         }
      }
      
      private function onArcadeGameOpened(param1:MsgEvent = null) : void
      {
         blockerAllowed = false;
         if(currentPrompt != null)
         {
            currentPrompt.setBlockerVisibility(blockerAllowed);
         }
      }
      
      override protected function getLockPenalty() : CombatPenalty
      {
         return new LockPenaltyWeb(this);
      }
      
      override protected function onPenaltyDataRequest(param1:CombatEvent) : void
      {
         var _loc2_:CombatRequestPenaltyInfoData = param1.data as CombatRequestPenaltyInfoData;
         ActorSession.reloadModeratorInformation(_loc2_.onDataRecievedSuccess,_loc2_.onDataRecievedFailure);
      }
      
      override protected function penaltyExecuted() : void
      {
         UserSessionAMFService.instance.UpdateBehaviourStatus(ActorSession.loggedInActor.ActorId,0,"",-1,-1,null);
         WebNanny.getInstance().executePendingActionIfAny(null);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         MessageCommunicator.unscribe(ActionEvent.OPEN_ARCADE_GAME,this.onArcadeGameOpened);
         MessageCommunicator.unscribe(ActionEvent.CLOSE_ARCADE_GAME,this.onArcadeGameClosed);
      }
   }
}

