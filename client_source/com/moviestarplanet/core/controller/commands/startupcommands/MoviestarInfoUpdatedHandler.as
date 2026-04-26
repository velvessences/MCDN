package com.moviestarplanet.core.controller.commands.startupcommands
{
   import com.moviestarplanet.Components.Friends.FriendshipManager;
   import com.moviestarplanet.actorutils.ActorValueType;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.earningutils.service.FameSwitch;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.model.notification.NotificationType;
   import com.moviestarplanet.utils.actorvalues.ActorValueManager;
   import flash.events.Event;
   
   public class MoviestarInfoUpdatedHandler
   {
      
      public static const UPDATE_MOVIESTAR_INFO:String = "UPDATE_MOVIESTAR_INFO";
      
      private static var oldLevel:Number = -1;
      
      public function MoviestarInfoUpdatedHandler()
      {
         super();
      }
      
      private static function updateMoviestarInfo(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(Boolean(Main.Instance.initialized) && Main.Instance.mainCanvas.applicationViewStack.mainView.topBar != null)
         {
            ActorValueManager.getInstance().setValue(ActorValueType.FAME,ActorSession.loggedInActor.Fame);
            ActorValueManager.getInstance().setValue(ActorValueType.DIAMONDS,ActorSession.loggedInActor.Diamonds);
            ActorValueManager.getInstance().setValue(ActorValueType.STARCOINS,ActorSession.loggedInActor.Money);
            MessageCommunicator.sendMessage(MSPEvent.ACHIEVEMENTS_CLEAR_CACHE,null);
            MessageCommunicator.sendMessage(MSPEvent.ACHIEVEMENTS_GET_CLAIMABLE_COUNT,null);
            if(actorHasLevelledUp())
            {
               FriendshipManager.getInstance().sendBasicEventToFriends(NotificationType.LEVEL.type);
               MessageCommunicator.send(new MsgEvent(MSPEvent.MY_LEVEL_WENT_UP,ActorSession.loggedInActor.Level));
               _loc2_ = FameSwitch.IsFameOverhaulSwitchOn ? 6 : 3;
               if(oldLevel == _loc2_ - 1 && ActorSession.loggedInActor.Level == _loc2_ && !isNaN(ActorSession.loggedInActor.InvitedByActorId) && ActorSession.loggedInActor.InvitedByActorId > 0)
               {
                  FriendshipManager.getInstance().SendInvitationBonusToFriend(ActorSession.loggedInActor.InvitedByActorId);
               }
            }
            oldLevel = ActorSession.loggedInActor.Level;
         }
      }
      
      private static function actorHasLevelledUp() : Boolean
      {
         return oldLevel != -1 && oldLevel != ActorSession.loggedInActor.Level;
      }
      
      public function setup() : void
      {
         MessageCommunicator.subscribe(UPDATE_MOVIESTAR_INFO,updateMoviestarInfo);
      }
   }
}

