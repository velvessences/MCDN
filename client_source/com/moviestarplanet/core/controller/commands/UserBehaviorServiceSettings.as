package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.amf.ServiceUrlUtil;
   import com.moviestarplanet.clientcensor.BlackListUtil;
   import com.moviestarplanet.clientcensor.Censor;
   import com.moviestarplanet.clientcensor.CensorWeb;
   import com.moviestarplanet.clientcensor.InstantBlocking;
   import com.moviestarplanet.clientcensor.MSPUserBehaviorMessageFormatter;
   import com.moviestarplanet.clientcensor.NannyBase;
   import com.moviestarplanet.combat.CombatHelper;
   import com.moviestarplanet.configurations.AppSettings;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.model.ActorModel;
   import com.moviestarplanet.services.userservice.UserAmfServiceWeb;
   import com.moviestarplanet.services.wrappers.AdminService;
   import com.moviestarplanet.services.wrappers.SessionService;
   import com.moviestarplanet.userbehavior.IUserBehaviorMessageFormatter;
   import com.moviestarplanet.userbehavior.services.UserBehaviorAmfService;
   import com.moviestarplanet.userbehavior.services.UserBehaviorServiceProvider;
   import com.moviestarplanet.userbehavior.utils.chatfilter.userbehaviorcontrol.FilterlistHandlingBase;
   import com.moviestarplanet.userbehavior.utils.chatfilter.userbehaviorcontrol.UserBehaviorControl;
   import com.moviestarplanet.usersession.service.UserSessionAMFService;
   
   public class UserBehaviorServiceSettings
   {
      
      public function UserBehaviorServiceSettings()
      {
         super();
      }
      
      public function execute() : void
      {
         var country:String;
         var useUserBehaviorServiceAppSettingCallback:Function = null;
         var useUserNameFilteringAppSettingCallback:Function = null;
         var userBehaviorServiceHostNameAppSettingCallback:Function = null;
         var userBehaviorServiceFilterSymbolCallback:Function = null;
         useUserBehaviorServiceAppSettingCallback = function(param1:String):void
         {
            if(param1 == "true")
            {
               SessionService.GetAppSetting("UserBehaviorServiceHostName",userBehaviorServiceHostNameAppSettingCallback);
            }
         };
         useUserNameFilteringAppSettingCallback = function(param1:String):void
         {
            UserBehaviorControl.getInstance().useUserBehaviorServiceNameFiltering = param1 == "true";
         };
         userBehaviorServiceHostNameAppSettingCallback = function(param1:String):void
         {
            ServiceUrlUtil.setUserBehaviorServiceHostName(param1);
         };
         userBehaviorServiceFilterSymbolCallback = function(param1:String):void
         {
            FilterlistHandlingBase.setFilterSymbolFromCharCode(int(param1));
         };
         InjectionManager.mapper().map(IUserBehaviorMessageFormatter).toType(MSPUserBehaviorMessageFormatter);
         FilterlistHandlingBase.userBehaviourServiceProvider = UserBehaviorServiceProvider.getInstance();
         NannyBase.actorModel = ActorModel.getInstance();
         NannyBase.UpdateBehaviourStatusFunction = UserSessionAMFService.instance.UpdateBehaviourStatus;
         NannyBase.LockOutUserFunction = AdminService.LockOutUser;
         InstantBlocking.GetRelativeBlackListPathFunction = Config.GetRelativeBlackListPath;
         UserBehaviorControl.localCensor = new CensorWeb();
         BlackListUtil.GetRelativeBlackListPathFunction = Config.GetRelativeBlackListPath;
         Censor.LogInputFunction = UserAmfServiceWeb.logInput;
         Censor.LogInputGroupChatFunction = UserAmfServiceWeb.logInputGroupChat;
         BlackListUtil.actorModel = ActorModel.getInstance();
         Censor.actorModel = ActorModel.getInstance();
         Censor.SaveAlertWordsCountFunction = UserAmfServiceWeb.SaveAlertWordsCount;
         country = Config.GetCountry;
         if(Config.isCustomBranch())
         {
            country = Config.getBaseBranch();
         }
         else if((country == "test" || country == "dev") && Config.GetBrand == "MyStarPlanet")
         {
            country += "mystarplanet";
         }
         UserBehaviorAmfService.setCountry(country);
         MessageCommunicator.subscribe(UserBehaviorControl.USER_BEHAVIOR_FAILURE,CombatHelper.getInstance().logUserBehaviorFailure);
         SessionService.GetAppSetting("UseUserBehaviorService",useUserBehaviorServiceAppSettingCallback);
         SessionService.GetAppSetting("UseUserNameFiltering",useUserNameFilteringAppSettingCallback);
         SessionService.GetAppSetting(AppSettings.USER_BEHAVIOUR_FILTER_SYMBOL,userBehaviorServiceFilterSymbolCallback);
      }
   }
}

