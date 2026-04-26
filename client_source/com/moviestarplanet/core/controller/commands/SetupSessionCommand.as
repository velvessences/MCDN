package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.chatpermission.ChatPermissionManager;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.level.configuration.ILevelConfiguration;
   import com.moviestarplanet.level.configuration.LevelConfiguration;
   import com.moviestarplanet.service.ISessionAmfService;
   import com.moviestarplanet.session.service.SessionAmfServiceForWeb;
   
   public class SetupSessionCommand
   {
      
      public function SetupSessionCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         ChatPermissionManager.instance.sessionService = new SessionAmfServiceForWeb();
         InjectionManager.mapper().map(ISessionAmfService).toSingleton(SessionAmfServiceForWeb);
         InjectionManager.mapper().map(ILevelConfiguration).toSingleton(LevelConfiguration);
      }
   }
}

