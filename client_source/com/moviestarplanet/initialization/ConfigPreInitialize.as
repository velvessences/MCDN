package com.moviestarplanet.initialization
{
   import com.moviestarplanet.Components.ClickItems.MainAppClickItemFactoryImpl;
   import com.moviestarplanet.actorsession.ActorSessionObserver;
   import com.moviestarplanet.admin.controller.commands.AdminMessageCommand;
   import com.moviestarplanet.alert.SetupAlertListenersCommand;
   import com.moviestarplanet.clickitems.ClickItemFactory;
   import com.moviestarplanet.configurations.ApplicationConfig;
   import com.moviestarplanet.configurations.ApplicationConfigAccessor;
   import com.moviestarplanet.configurations.config_access_internal;
   import com.moviestarplanet.core.controller.commands.ConfigureDateUtilsCommand;
   import com.moviestarplanet.core.controller.commands.FontManagerCommand;
   import com.moviestarplanet.core.controller.commands.RegisterClassCommand;
   import com.moviestarplanet.core.controller.commands.SetupAmfCommand;
   import com.moviestarplanet.core.controller.commands.SetupWebCoreFunctionalityCommand;
   import com.moviestarplanet.core.controller.commands.SetupYouTubePlayerCommand;
   import com.moviestarplanet.core.controller.commands.startupcommands.HandleUnauthorizedWebServiceCallsCommand;
   import com.moviestarplanet.core.controller.commands.startupcommands.SetupLogoutHandlerCommand;
   import com.moviestarplanet.core.controller.commands.startupcommands.SetupNudgeServiceCommand;
   import com.moviestarplanet.core.controller.commands.startupcommands.SetupRoomConnectinCommand;
   import com.moviestarplanet.core.controller.commands.startupcommands.StartConnectionManagerCommand;
   import com.moviestarplanet.usersession.ActorSessionNotifier;
   import com.moviestarplanet.utils.FontManager;
   import flash.system.Security;
   
   public class ConfigPreInitialize
   {
      
      public function ConfigPreInitialize()
      {
         super();
      }
      
      public static function execute() : void
      {
         new SetupRoomConnectinCommand().execute();
         new SetupWebCoreFunctionalityCommand().execute();
         new RegisterClassCommand().execute();
         new ConfigureDateUtilsCommand().execute();
         new AdminMessageCommand().execute();
         new FontManagerCommand().execute();
         new SetupAmfCommand().execute();
         new SetupYouTubePlayerCommand().execute();
         ApplicationConfigAccessor.config_access_internal::setCurrentContext(ApplicationConfig.CONTEXT_FRONTPAGE);
         ActorSessionNotifier.getInstance().subscribe(ActorSessionObserver.getInstance());
         Security.allowInsecureDomain("*");
         Security.allowDomain("*");
         ClickItemFactory.factoryImpl = new MainAppClickItemFactoryImpl();
         new StartConnectionManagerCommand().execute();
         FontManager.initializeFonts();
         new SetupAlertListenersCommand().execute();
         new HandleUnauthorizedWebServiceCallsCommand().execute();
         new SetupLogoutHandlerCommand().execute();
         new SetupNudgeServiceCommand().execute();
      }
   }
}

