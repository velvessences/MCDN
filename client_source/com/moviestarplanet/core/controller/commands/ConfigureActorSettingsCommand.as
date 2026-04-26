package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.actor.IActorDetails;
   import com.moviestarplanet.actorvalues.IActorValueManager;
   import com.moviestarplanet.chatCommunicator.chatHelpers.chatpermission.ChatPermissionManager;
   import com.moviestarplanet.core.model.proxy.LoggedInUserProxy;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.managers.TrusteActorDetailsObserver;
   import com.moviestarplanet.model.ActorModel;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.model.IActorModel;
   import com.moviestarplanet.model.friends.ILoggedInUser;
   import com.moviestarplanet.msg.MsgInject;
   import com.moviestarplanet.usersession.ActorSessionNotifier;
   import com.moviestarplanet.utils.actorvalues.ActorValueManager;
   
   public class ConfigureActorSettingsCommand
   {
      
      public function ConfigureActorSettingsCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         InjectionManager.mapper().map(IActorDetails).toValue(ActorSession.loggedInActor);
         InjectionManager.mapper().map(IActorModel).toValue(ActorModel.getInstance());
         InjectionManager.mapper().map(IActorValueManager).toValue(ActorValueManager.getInstance());
         InjectionManager.mapper().map(ILoggedInUser).toSingleton(LoggedInUserProxy);
         MsgInject.isModerator = ActorSession.isModerator();
         ChatPermissionManager.instance.isModerator = ActorSession.isModerator();
         (ActorSessionNotifier.getInstance() as ActorSessionNotifier).subscribe(new TrusteActorDetailsObserver());
      }
   }
}

