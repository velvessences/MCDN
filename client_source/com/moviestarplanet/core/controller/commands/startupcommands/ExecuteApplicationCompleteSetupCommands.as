package com.moviestarplanet.core.controller.commands.startupcommands
{
   import com.moviestarplanet.analytics.timer.AnalyticsTimer;
   import com.moviestarplanet.clientcensor.NannyBase;
   import com.moviestarplanet.configurations.ApplicationConfig;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.constants.ConstantsPlatform;
   import com.moviestarplanet.core.controller.commands.ActorUpdateCommand;
   import com.moviestarplanet.core.controller.commands.AssignActorSchoolInformationCommand;
   import com.moviestarplanet.core.controller.commands.ChatCommand;
   import com.moviestarplanet.core.controller.commands.ConfigureActorSettingsCommand;
   import com.moviestarplanet.core.controller.commands.ConfigureAwardsCommand;
   import com.moviestarplanet.core.controller.commands.ConfigureModulesCommand;
   import com.moviestarplanet.core.controller.commands.ConfigureServerPathsCommand;
   import com.moviestarplanet.core.controller.commands.ConfigureServicesCommand;
   import com.moviestarplanet.core.controller.commands.ConfigureSiteConfigsCommand;
   import com.moviestarplanet.core.controller.commands.ConfigureVisualsCommand;
   import com.moviestarplanet.core.controller.commands.ConfigureWindowStackCommand;
   import com.moviestarplanet.core.controller.commands.CountryCommand;
   import com.moviestarplanet.core.controller.commands.GetLatestErrorCommand;
   import com.moviestarplanet.core.controller.commands.HandleMovieStarCommand;
   import com.moviestarplanet.core.controller.commands.HandleSponsoredReactivationCommand;
   import com.moviestarplanet.core.controller.commands.MapFlexInjectionsCommand;
   import com.moviestarplanet.core.controller.commands.MapNewTagHelperCommand;
   import com.moviestarplanet.core.controller.commands.ParseUrlParamsCommand;
   import com.moviestarplanet.core.controller.commands.SetupAppSettingsCommand;
   import com.moviestarplanet.core.controller.commands.SetupEmoticonsCommand;
   import com.moviestarplanet.core.controller.commands.SetupLoadingCommand;
   import com.moviestarplanet.core.controller.commands.SetupNavigationListenersCommand;
   import com.moviestarplanet.core.controller.commands.SetupSessionCommand;
   import com.moviestarplanet.core.controller.commands.SetupVersionCommand;
   import com.moviestarplanet.core.controller.commands.ShopOffersCommand;
   import com.moviestarplanet.core.controller.commands.SnapshotServiceSettings;
   import com.moviestarplanet.core.controller.commands.UserBehaviorServiceSettings;
   import com.moviestarplanet.core.controller.listeners.ArtbookOperator;
   import com.moviestarplanet.core.controller.listeners.ContentOperator;
   import com.moviestarplanet.core.controller.listeners.PhotoUploadOperator;
   import com.moviestarplanet.core.controller.listeners.ShoppingOperator;
   import com.moviestarplanet.core.controller.listeners.TamperTechnologyOperator;
   import com.moviestarplanet.core.controller.listeners.UtilsOperator;
   import com.moviestarplanet.core.controller.listeners.VIPStoreOperator;
   import com.moviestarplanet.logging.UncaughtErrorHandler;
   import com.moviestarplanet.mainview.SetFocusOnApplicationCommand;
   import com.moviestarplanet.managers.SoundManager;
   import com.moviestarplanet.moviestar.controller.InitializeMovieStarServiceCommand;
   import com.moviestarplanet.platform.ApplicationId;
   import com.moviestarplanet.statusbar.ActorStatus.ActorStateHandler;
   import com.moviestarplanet.utils.chatfilter.nanny.WebNanny;
   import com.moviestarplanet.utils.tooltips.MSP_ToolTipManager;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.utils.ui.MovieStarOperator;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import mx.managers.SystemManager;
   import mx.managers.ToolTipManager;
   
   public class ExecuteApplicationCompleteSetupCommands
   {
      
      private var sitemapsLoaded:Function;
      
      public function ExecuteApplicationCompleteSetupCommands()
      {
         super();
      }
      
      public function execute(param1:Function) : void
      {
         this.sitemapsLoaded = param1;
         new SetStageReferenceCommand().execute();
         new HandleBrowserUnloadCommand().execute();
         new SetFocusOnApplicationCommand().execute();
         new SetupStyleManagerCommand().execute();
         SystemManager(Main.Instance.systemManager).rawChildren.getChildAt(0).visible = false;
         new MapFlexInjectionsCommand().execute();
         new GetLatestErrorCommand().execute();
         new SetupLoadingCommand().execute();
         new SetupVersionCommand().execute();
         new SetupSessionCommand().execute();
         new HandleMovieStarCommand().execute();
         new ShopOffersCommand().execute();
         new InitializeMovieStarServiceCommand().execute();
         new ActorUpdateCommand().execute();
         new ConfigureAwardsCommand().execute();
         new SetupNavigationListenersCommand().execute();
         new SetupEmoticonsCommand().execute();
         new AssignActorSchoolInformationCommand().execute(null);
         new MapNewTagHelperCommand().execute();
         new HandleSponsoredReactivationCommand().execute();
         ApplicationConfig.applicationType = ApplicationId.APPLICATION_WEB;
         new SetupServiceUrlUtilCommand().execute();
         new UncaughtErrorHandler();
         MovieStarOperator.wireup();
         ShoppingOperator.wireup();
         VIPStoreOperator.wireup();
         ContentOperator.wireup();
         UtilsOperator.wireup();
         ArtbookOperator.wireup();
         PhotoUploadOperator.wireup();
         TamperTechnologyOperator.wireup();
         NannyBase.instance = WebNanny.getInstance();
         MSP_ToolTipManager.initialize(Main.Instance);
         new CountryCommand().execute();
         new ConfigureSiteConfigsCommand().execute();
         new ConfigureServerPathsCommand().execute();
         new UserBehaviorServiceSettings().execute();
         new SnapshotServiceSettings().execute();
         new ConfigureServicesCommand().execute();
         new ConfigureVisualsCommand().execute();
         new ConfigureModulesCommand().execute();
         new ConfigureWindowStackCommand().execute();
         new SetupAppSettingsCommand().execute();
         AnalyticsTimer.getInstance();
         ConstantsPlatform.setupConstantsWeb();
         new ChatCommand().execute();
         ToolTipManager.showDelay = 0;
         SoundManager.Instance();
         new InitEcoSystemVariablesCommand().execute();
         new ContextMenuSetup(Main.Instance);
         new MoviestarInfoUpdatedHandler().setup();
         ActorStateHandler.instantiate(Main.Instance.mainCanvas);
         MSPLocaleManagerWeb.changeLanguage(Config.GetLanguage,this.completeLocaleResourceHandler2);
      }
      
      private function completeLocaleResourceHandler2() : void
      {
         Config.loadSiteMaps(Config.cdnLocalBasePath,this.sitemapsLoaded);
         new ConfigureActorSettingsCommand().execute();
         new ParseUrlParamsCommand().execute();
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.ctrlKey == true && param1.keyCode == Keyboard.D)
         {
            new DevDebugCommands().execute();
         }
      }
   }
}

