package com.moviestarplanet.services.service
{
   import com.adobe.fiber.core.model_internal;
   import com.adobe.fiber.services.wrapper.WebServiceWrapper;
   import com.adobe.serializers.utility.TypeUtility;
   import com.moviestarplanet.admin.valueobjects.ChatLog;
   import com.moviestarplanet.admin.valueobjects.PagedBadWordActorList;
   import com.moviestarplanet.admin.valueobjects.PagedChatLogList;
   import com.moviestarplanet.admin.valueobjects.PagedReportList;
   import com.moviestarplanet.admin.valueobjects.Report;
   import com.moviestarplanet.amf.ServiceUrlUtil;
   import com.moviestarplanet.amf.valueobjects.TicketHeader;
   import com.moviestarplanet.forum.valueobjects.PagedTopicList;
   import com.moviestarplanet.forum.valueobjects.Topic;
   import com.moviestarplanet.friendship.valueobjects.PagedActorBrowseItemList;
   import com.moviestarplanet.movie.valueobjects.Movie;
   import com.moviestarplanet.news.valueobjects.News;
   import com.moviestarplanet.news.valueobjects.PagedNewsList;
   import com.moviestarplanet.usersession.valueobjects.ActorDetailSecure;
   import com.moviestarplanet.usersession.valueobjects.ActorDetails;
   import com.moviestarplanet.usersession.valueobjects.ActorDetailsVersion;
   import com.moviestarplanet.usersession.valueobjects.ActorPersonalInfo;
   import com.moviestarplanet.valueObjects.ActorName;
   import com.moviestarplanet.valueObjects.CountrySiteStatus;
   import com.moviestarplanet.valueObjects.LoginHistoryItem;
   import com.moviestarplanet.valueObjects.LoginStatus;
   import com.moviestarplanet.valueObjects.LoginStatus2;
   import com.moviestarplanet.valueObjects.NewsUpdate;
   import com.moviestarplanet.valueObjects.PagedGuestBookEntryList;
   import com.moviestarplanet.valueObjects.PagedLocaleResourceList;
   import com.moviestarplanet.valueObjects.PagedUserList;
   import com.moviestarplanet.valueObjects.ServiceResult;
   import com.moviestarplanet.valueObjects.ServiceResultDataOfString;
   import com.moviestarplanet.valueObjects.ServiceResultDataOfUpdateQuestResult;
   import com.moviestarplanet.valueObjects.Testdateresult;
   import com.moviestarplanet.valueObjects.Wallpaper;
   import mx.collections.ArrayCollection;
   import mx.rpc.AbstractOperation;
   import mx.rpc.AsyncToken;
   import mx.rpc.soap.mxml.Operation;
   import mx.rpc.soap.mxml.WebService;
   
   internal class _Super_Service extends WebServiceWrapper
   {
      
      public function _Super_Service()
      {
         var _loc2_:Operation = null;
         super();
         _serviceControl = new WebService();
         var _loc1_:Object = new Object();
         _loc2_ = new Operation(null,"UnblockActor");
         _loc2_.resultType = int;
         _loc1_["UnblockActor"] = _loc2_;
         _loc2_ = new Operation(null,"SaveAllLocaleFilesForMobile");
         _loc1_["SaveAllLocaleFilesForMobile"] = _loc2_;
         _loc2_ = new Operation(null,"ipstrings");
         _loc2_.resultElementType = String;
         _loc1_["ipstrings"] = _loc2_;
         _loc2_ = new Operation(null,"SetPostAsDeleted");
         _loc1_["SetPostAsDeleted"] = _loc2_;
         _loc2_ = new Operation(null,"deleteTopic");
         _loc2_.resultType = int;
         _loc1_["deleteTopic"] = _loc2_;
         _loc2_ = new Operation(null,"LogoutTicket");
         _loc1_["LogoutTicket"] = _loc2_;
         _loc2_ = new Operation(null,"GetActorIdFromName");
         _loc2_.resultType = int;
         _loc1_["GetActorIdFromName"] = _loc2_;
         _loc2_ = new Operation(null,"DeleteUser2");
         _loc2_.resultType = int;
         _loc1_["DeleteUser2"] = _loc2_;
         _loc2_ = new Operation(null,"FindUserForFriendBrowser");
         _loc2_.resultType = PagedActorBrowseItemList;
         _loc1_["FindUserForFriendBrowser"] = _loc2_;
         _loc2_ = new Operation(null,"IP2CountryRefresh");
         _loc2_.resultType = Boolean;
         _loc1_["IP2CountryRefresh"] = _loc2_;
         _loc2_ = new Operation(null,"LikeAdd");
         _loc2_.resultType = Boolean;
         _loc1_["LikeAdd"] = _loc2_;
         _loc2_ = new Operation(null,"dailyStarcoinsReceive");
         _loc1_["dailyStarcoinsReceive"] = _loc2_;
         _loc2_ = new Operation(null,"UnlockUser");
         _loc2_.resultType = int;
         _loc1_["UnlockUser"] = _loc2_;
         _loc2_ = new Operation(null,"deleteTwitterText");
         _loc2_.resultType = int;
         _loc1_["deleteTwitterText"] = _loc2_;
         _loc2_ = new Operation(null,"NewForcedEntityName");
         _loc2_.resultType = ServiceResult;
         _loc1_["NewForcedEntityName"] = _loc2_;
         _loc2_ = new Operation(null,"deleteMovieViaProfile");
         _loc2_.resultType = int;
         _loc1_["deleteMovieViaProfile"] = _loc2_;
         _loc2_ = new Operation(null,"ImportLocaleResources");
         _loc2_.resultElementType = String;
         _loc1_["ImportLocaleResources"] = _loc2_;
         _loc2_ = new Operation(null,"IsAdminSite");
         _loc2_.resultType = Boolean;
         _loc1_["IsAdminSite"] = _loc2_;
         _loc2_ = new Operation(null,"Login");
         _loc2_.resultType = LoginStatus;
         _loc1_["Login"] = _loc2_;
         _loc2_ = new Operation(null,"ChangeCurrentQuestActive");
         _loc1_["ChangeCurrentQuestActive"] = _loc2_;
         _loc2_ = new Operation(null,"GetActorMovieCount");
         _loc2_.resultType = int;
         _loc1_["GetActorMovieCount"] = _loc2_;
         _loc2_ = new Operation(null,"ActiveLocales");
         _loc2_.resultElementType = String;
         _loc1_["ActiveLocales"] = _loc2_;
         _loc2_ = new Operation(null,"GetModeratorList");
         _loc2_.resultType = PagedUserList;
         _loc1_["GetModeratorList"] = _loc2_;
         _loc2_ = new Operation(null,"LoadActorDetailsSecure");
         _loc2_.resultType = ActorDetailSecure;
         _loc1_["LoadActorDetailsSecure"] = _loc2_;
         _loc2_ = new Operation(null,"RenameUser");
         _loc2_.resultType = int;
         _loc1_["RenameUser"] = _loc2_;
         _loc2_ = new Operation(null,"SaveActorLocale");
         _loc1_["SaveActorLocale"] = _loc2_;
         _loc2_ = new Operation(null,"LoadGuestBook");
         _loc2_.resultType = PagedGuestBookEntryList;
         _loc1_["LoadGuestBook"] = _loc2_;
         _loc2_ = new Operation(null,"DeleteBioText");
         _loc2_.resultType = int;
         _loc1_["DeleteBioText"] = _loc2_;
         _loc2_ = new Operation(null,"MailChimpResyncList");
         _loc2_.resultType = Boolean;
         _loc1_["MailChimpResyncList"] = _loc2_;
         _loc2_ = new Operation(null,"GetMovieByGuid");
         _loc2_.resultType = Movie;
         _loc1_["GetMovieByGuid"] = _loc2_;
         _loc2_ = new Operation(null,"GiveAutoWarning");
         _loc2_.resultType = int;
         _loc1_["GiveAutoWarning"] = _loc2_;
         _loc2_ = new Operation(null,"SaveActorPersonalInfo");
         _loc2_.resultType = ActorPersonalInfo;
         _loc1_["SaveActorPersonalInfo"] = _loc2_;
         _loc2_ = new Operation(null,"awardActorVIP");
         _loc1_["awardActorVIP"] = _loc2_;
         _loc2_ = new Operation(null,"UpdateRateMovie");
         _loc1_["UpdateRateMovie"] = _loc2_;
         _loc2_ = new Operation(null,"SetEmailSettings");
         _loc1_["SetEmailSettings"] = _loc2_;
         _loc2_ = new Operation(null,"getLoginHistory");
         _loc2_.resultElementType = LoginHistoryItem;
         _loc1_["getLoginHistory"] = _loc2_;
         _loc2_ = new Operation(null,"LoadActorDetails2");
         _loc2_.resultType = ActorDetails;
         _loc1_["LoadActorDetails2"] = _loc2_;
         _loc2_ = new Operation(null,"testdate");
         _loc2_.resultType = Testdateresult;
         _loc1_["testdate"] = _loc2_;
         _loc2_ = new Operation(null,"GetMovieById");
         _loc2_.resultType = Movie;
         _loc1_["GetMovieById"] = _loc2_;
         _loc2_ = new Operation(null,"saveNews");
         _loc2_.resultType = int;
         _loc1_["saveNews"] = _loc2_;
         _loc2_ = new Operation(null,"RateMovie");
         _loc1_["RateMovie"] = _loc2_;
         _loc2_ = new Operation(null,"CreateTopicNew");
         _loc2_.resultType = int;
         _loc1_["CreateTopicNew"] = _loc2_;
         _loc2_ = new Operation(null,"BlockName");
         _loc2_.resultType = int;
         _loc1_["BlockName"] = _loc2_;
         _loc2_ = new Operation(null,"SendNewEmailValidation");
         _loc1_["SendNewEmailValidation"] = _loc2_;
         _loc2_ = new Operation(null,"SaveChatAllowed");
         _loc2_.resultType = Boolean;
         _loc1_["SaveChatAllowed"] = _loc2_;
         _loc2_ = new Operation(null,"GetAppSetting");
         _loc2_.resultType = String;
         _loc1_["GetAppSetting"] = _loc2_;
         _loc2_ = new Operation(null,"exposeTickeHeader");
         _loc2_.resultType = TicketHeader;
         _loc1_["exposeTickeHeader"] = _loc2_;
         _loc2_ = new Operation(null,"UndeleteUser");
         _loc2_.resultType = ActorDetailSecure;
         _loc1_["UndeleteUser"] = _loc2_;
         _loc2_ = new Operation(null,"UpdateBehaviourStatusNew");
         _loc2_.resultType = int;
         _loc1_["UpdateBehaviourStatusNew"] = _loc2_;
         _loc2_ = new Operation(null,"SaveLocaleResourceFiles");
         _loc2_.resultElementType = String;
         _loc1_["SaveLocaleResourceFiles"] = _loc2_;
         _loc2_ = new Operation(null,"DeleteUser");
         _loc2_.resultType = int;
         _loc1_["DeleteUser"] = _loc2_;
         _loc2_ = new Operation(null,"DeleteMovie");
         _loc1_["DeleteMovie"] = _loc2_;
         _loc2_ = new Operation(null,"awardActorMoneySecure");
         _loc1_["awardActorMoneySecure"] = _loc2_;
         _loc2_ = new Operation(null,"GetWallpapers");
         _loc2_.resultElementType = Wallpaper;
         _loc1_["GetWallpapers"] = _loc2_;
         _loc2_ = new Operation(null,"SendRetentionMail");
         _loc1_["SendRetentionMail"] = _loc2_;
         _loc2_ = new Operation(null,"BlockedActors");
         _loc2_.resultElementType = ActorName;
         _loc1_["BlockedActors"] = _loc2_;
         _loc2_ = new Operation(null,"SendMovieAsMail");
         _loc1_["SendMovieAsMail"] = _loc2_;
         _loc2_ = new Operation(null,"ChangePasswordNew");
         _loc1_["ChangePasswordNew"] = _loc2_;
         _loc2_ = new Operation(null,"GetBadWordActorList");
         _loc2_.resultType = PagedBadWordActorList;
         _loc1_["GetBadWordActorList"] = _loc2_;
         _loc2_ = new Operation(null,"EmailChanged");
         _loc2_.resultType = int;
         _loc1_["EmailChanged"] = _loc2_;
         _loc2_ = new Operation(null,"unmarkIpAsPublic");
         _loc2_.resultType = int;
         _loc1_["unmarkIpAsPublic"] = _loc2_;
         _loc2_ = new Operation(null,"DeletePost");
         _loc2_.resultType = int;
         _loc1_["DeletePost"] = _loc2_;
         _loc2_ = new Operation(null,"GetChatLogListLocked");
         _loc2_.resultElementType = ChatLog;
         _loc1_["GetChatLogListLocked"] = _loc2_;
         _loc2_ = new Operation(null,"GetTopics");
         _loc2_.resultType = PagedTopicList;
         _loc1_["GetTopics"] = _loc2_;
         _loc2_ = new Operation(null,"SaveLocaleResources");
         _loc1_["SaveLocaleResources"] = _loc2_;
         _loc2_ = new Operation(null,"GetNewsById");
         _loc2_.resultType = News;
         _loc1_["GetNewsById"] = _loc2_;
         _loc2_ = new Operation(null,"Login2");
         _loc2_.resultType = LoginStatus2;
         _loc1_["Login2"] = _loc2_;
         _loc2_ = new Operation(null,"IsDevSite");
         _loc2_.resultType = Boolean;
         _loc1_["IsDevSite"] = _loc2_;
         _loc2_ = new Operation(null,"GetAutoSavedMovie");
         _loc2_.resultType = String;
         _loc1_["GetAutoSavedMovie"] = _loc2_;
         _loc2_ = new Operation(null,"BlockActor");
         _loc2_.resultType = int;
         _loc1_["BlockActor"] = _loc2_;
         _loc2_ = new Operation(null,"BuyBeautyClinicItemsNew");
         _loc2_.resultType = ServiceResultDataOfString;
         _loc1_["BuyBeautyClinicItemsNew"] = _loc2_;
         _loc2_ = new Operation(null,"LockOutUser");
         _loc2_.resultType = int;
         _loc1_["LockOutUser"] = _loc2_;
         _loc2_ = new Operation(null,"ClearCache");
         _loc1_["ClearCache"] = _loc2_;
         _loc2_ = new Operation(null,"EmailValidatedCancel");
         _loc1_["EmailValidatedCancel"] = _loc2_;
         _loc2_ = new Operation(null,"fileExists");
         _loc2_.resultType = Boolean;
         _loc1_["fileExists"] = _loc2_;
         _loc2_ = new Operation(null,"GetReportList");
         _loc2_.resultType = PagedReportList;
         _loc1_["GetReportList"] = _loc2_;
         _loc2_ = new Operation(null,"ForceEntityNameChange");
         _loc2_.resultType = ServiceResult;
         _loc1_["ForceEntityNameChange"] = _loc2_;
         _loc2_ = new Operation(null,"GetActorNameFromId");
         _loc2_.resultType = String;
         _loc1_["GetActorNameFromId"] = _loc2_;
         _loc2_ = new Operation(null,"LoadActorDetailsVersion");
         _loc2_.resultType = ActorDetailsVersion;
         _loc1_["LoadActorDetailsVersion"] = _loc2_;
         _loc2_ = new Operation(null,"GiveAutograph");
         _loc1_["GiveAutograph"] = _loc2_;
         _loc2_ = new Operation(null,"moderatorUpdateTopic");
         _loc1_["moderatorUpdateTopic"] = _loc2_;
         _loc2_ = new Operation(null,"SendEmailValidation");
         _loc1_["SendEmailValidation"] = _loc2_;
         _loc2_ = new Operation(null,"ClearNewMarkings");
         _loc1_["ClearNewMarkings"] = _loc2_;
         _loc2_ = new Operation(null,"BadWordCountAdd");
         _loc1_["BadWordCountAdd"] = _loc2_;
         _loc2_ = new Operation(null,"GetChatLogList");
         _loc2_.resultType = PagedChatLogList;
         _loc1_["GetChatLogList"] = _loc2_;
         _loc2_ = new Operation(null,"GetActorLocale");
         _loc2_.resultType = String;
         _loc1_["GetActorLocale"] = _loc2_;
         _loc2_ = new Operation(null,"SendInvitation");
         _loc1_["SendInvitation"] = _loc2_;
         _loc2_ = new Operation(null,"SetTopicAsDeleted");
         _loc1_["SetTopicAsDeleted"] = _loc2_;
         _loc2_ = new Operation(null,"SaveMyRoom");
         _loc1_["SaveMyRoom"] = _loc2_;
         _loc2_ = new Operation(null,"GetNews");
         _loc2_.resultType = PagedNewsList;
         _loc1_["GetNews"] = _loc2_;
         _loc2_ = new Operation(null,"ipasint");
         _loc2_.resultType = int;
         _loc1_["ipasint"] = _loc2_;
         _loc2_ = new Operation(null,"GetCountrySiteStatus");
         _loc2_.resultType = CountrySiteStatus;
         _loc1_["GetCountrySiteStatus"] = _loc2_;
         _loc2_ = new Operation(null,"GetAutoSavedMovieId");
         _loc2_.resultType = int;
         _loc1_["GetAutoSavedMovieId"] = _loc2_;
         _loc2_ = new Operation(null,"LoadActorDetails");
         _loc2_.resultType = ActorDetails;
         _loc1_["LoadActorDetails"] = _loc2_;
         _loc2_ = new Operation(null,"PublishMovie");
         _loc1_["PublishMovie"] = _loc2_;
         _loc2_ = new Operation(null,"UpdateQuest");
         _loc2_.resultType = ServiceResultDataOfUpdateQuestResult;
         _loc1_["UpdateQuest"] = _loc2_;
         _loc2_ = new Operation(null,"UnblockName");
         _loc2_.resultType = int;
         _loc1_["UnblockName"] = _loc2_;
         _loc2_ = new Operation(null,"UpdateRetention");
         _loc2_.resultType = String;
         _loc1_["UpdateRetention"] = _loc2_;
         _loc2_ = new Operation(null,"MovieWatched");
         _loc2_.resultType = int;
         _loc1_["MovieWatched"] = _loc2_;
         _loc2_ = new Operation(null,"EntityCommentDelete");
         _loc1_["EntityCommentDelete"] = _loc2_;
         _loc2_ = new Operation(null,"markIpAsPublic");
         _loc2_.resultType = int;
         _loc1_["markIpAsPublic"] = _loc2_;
         _loc2_ = new Operation(null,"EmailValidated");
         _loc2_.resultType = Boolean;
         _loc1_["EmailValidated"] = _loc2_;
         _loc2_ = new Operation(null,"BadWordCountClear");
         _loc1_["BadWordCountClear"] = _loc2_;
         _loc2_ = new Operation(null,"IsModerator");
         _loc2_.resultType = Boolean;
         _loc1_["IsModerator"] = _loc2_;
         _loc2_ = new Operation(null,"GetLocaleResources");
         _loc2_.resultType = PagedLocaleResourceList;
         _loc1_["GetLocaleResources"] = _loc2_;
         _loc2_ = new Operation(null,"GetActorPersonalInfo");
         _loc2_.resultType = ActorPersonalInfo;
         _loc1_["GetActorPersonalInfo"] = _loc2_;
         _loc2_ = new Operation(null,"UpdateActorPersonalInfo");
         _loc1_["UpdateActorPersonalInfo"] = _loc2_;
         _loc2_ = new Operation(null,"MovieCompetitionPublish");
         _loc2_.resultType = Boolean;
         _loc1_["MovieCompetitionPublish"] = _loc2_;
         _loc2_ = new Operation(null,"Pay");
         _loc2_.resultType = ActorDetails;
         _loc1_["Pay"] = _loc2_;
         _loc2_ = new Operation(null,"getNowAsString");
         _loc2_.resultType = String;
         _loc1_["getNowAsString"] = _loc2_;
         _loc2_ = new Operation(null,"ReportActor");
         _loc1_["ReportActor"] = _loc2_;
         _serviceControl.operations = _loc1_;
         try
         {
            _serviceControl.convertResultHandler = TypeUtility.convertResultHandler;
         }
         catch(e:Error)
         {
         }
         this.preInitializeService();
         model_internal::initialize();
      }
      
      protected function preInitializeService() : void
      {
         _serviceControl.service = "WebService";
         _serviceControl.port = "WebServiceSoap";
         wsdl = ServiceUrlUtil.getServiceUrlBase() + "WebService/Service.asmx?wsdl";
         model_internal::loadWSDLIfNecessary();
      }
      
      public function UnblockActor(param1:int, param2:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("UnblockActor");
         return _loc3_.send(param1,param2);
      }
      
      public function ReportHandled(param1:int, param2:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("ReportHandled");
         return _loc3_.send(param1,param2);
      }
      
      public function SaveAllLocaleFilesForMobile() : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc1_:AbstractOperation = _serviceControl.getOperation("SaveAllLocaleFilesForMobile");
         return _loc1_.send();
      }
      
      public function GetHighscoreAnimations(param1:int, param2:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("GetHighscoreAnimations");
         return _loc3_.send(param1,param2);
      }
      
      public function GetHighscoreBackgrounds(param1:int, param2:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("GetHighscoreBackgrounds");
         return _loc3_.send(param1,param2);
      }
      
      public function saveSpamReport(param1:String, param2:int, param3:String, param4:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc5_:AbstractOperation = _serviceControl.getOperation("saveSpamReport");
         return _loc5_.send(param1,param2,param3,param4);
      }
      
      public function GetMovieCompetition(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("GetMovieCompetition");
         return _loc2_.send(param1);
      }
      
      public function ipstrings(param1:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("ipstrings");
         return _loc2_.send(param1);
      }
      
      public function SetPostAsDeleted(param1:int, param2:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("SetPostAsDeleted");
         return _loc3_.send(param1,param2);
      }
      
      public function deleteTopic(param1:int, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("deleteTopic");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function GetHighscoreMovieLastMonth(param1:int, param2:Boolean, param3:String, param4:int, param5:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc6_:AbstractOperation = _serviceControl.getOperation("GetHighscoreMovieLastMonth");
         return _loc6_.send(param1,param2,param3,param4,param5);
      }
      
      public function GetActorIdFromName(param1:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("GetActorIdFromName");
         return _loc2_.send(param1);
      }
      
      public function DeleteUser2(param1:int, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("DeleteUser2");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function GetMarketingStepGift(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("GetMarketingStepGift");
         return _loc2_.send(param1);
      }
      
      public function FindUserForFriendBrowser(param1:int, param2:Boolean, param3:String, param4:int, param5:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc6_:AbstractOperation = _serviceControl.getOperation("FindUserForFriendBrowser");
         return _loc6_.send(param1,param2,param3,param4,param5);
      }
      
      public function IP2CountryRefresh(param1:String, param2:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("IP2CountryRefresh");
         return _loc3_.send(param1,param2);
      }
      
      public function LikeAdd(param1:String, param2:int, param3:int, param4:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc5_:AbstractOperation = _serviceControl.getOperation("LikeAdd");
         return _loc5_.send(param1,param2,param3,param4);
      }
      
      public function dailyStarcoinsReceive(param1:int, param2:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("dailyStarcoinsReceive");
         return _loc3_.send(param1,param2);
      }
      
      public function UnlockUser(param1:int, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("UnlockUser");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function deleteTwitterText(param1:int, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("deleteTwitterText");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function GetHighscoreWeek(param1:int, param2:Boolean, param3:String, param4:int, param5:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc6_:AbstractOperation = _serviceControl.getOperation("GetHighscoreWeek");
         return _loc6_.send(param1,param2,param3,param4,param5);
      }
      
      public function NewForcedEntityName(param1:int, param2:int, param3:int, param4:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc5_:AbstractOperation = _serviceControl.getOperation("NewForcedEntityName");
         return _loc5_.send(param1,param2,param3,param4);
      }
      
      public function GetWarningLog(param1:int, param2:int, param3:String, param4:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc5_:AbstractOperation = _serviceControl.getOperation("GetWarningLog");
         return _loc5_.send(param1,param2,param3,param4);
      }
      
      public function deleteMovieViaProfile(param1:int, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("deleteMovieViaProfile");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function ImportLocaleResources(param1:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("ImportLocaleResources");
         return _loc2_.send(param1);
      }
      
      public function IsAdminSite(param1:String, param2:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("IsAdminSite");
         return _loc3_.send(param1,param2);
      }
      
      public function Login(param1:String, param2:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("Login");
         return _loc3_.send(param1,param2);
      }
      
      public function GetHighscoreMusic(param1:int, param2:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("GetHighscoreMusic");
         return _loc3_.send(param1,param2);
      }
      
      public function GetIPLoginType(param1:int, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("GetIPLoginType");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function getHighscoreScrapBlogs(param1:int, param2:Boolean, param3:Boolean, param4:String, param5:int, param6:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc7_:AbstractOperation = _serviceControl.getOperation("getHighscoreScrapBlogs");
         return _loc7_.send(param1,param2,param3,param4,param5,param6);
      }
      
      public function ChangeCurrentQuestActive(param1:int, param2:Boolean) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("ChangeCurrentQuestActive");
         return _loc3_.send(param1,param2);
      }
      
      public function unblockIP(param1:int, param2:int, param3:String, param4:String, param5:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc6_:AbstractOperation = _serviceControl.getOperation("unblockIP");
         return _loc6_.send(param1,param2,param3,param4,param5);
      }
      
      public function GetActorMovieCount(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("GetActorMovieCount");
         return _loc2_.send(param1);
      }
      
      public function ActiveLocales() : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc1_:AbstractOperation = _serviceControl.getOperation("ActiveLocales");
         return _loc1_.send();
      }
      
      public function BlockedAndBlockingActors(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("BlockedAndBlockingActors");
         return _loc2_.send(param1);
      }
      
      public function GetModeratorList(param1:int, param2:int, param3:String, param4:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc5_:AbstractOperation = _serviceControl.getOperation("GetModeratorList");
         return _loc5_.send(param1,param2,param3,param4);
      }
      
      public function LoadActorDetailsSecure(param1:int, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("LoadActorDetailsSecure");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function RenameUser(param1:int, param2:String, param3:String, param4:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc5_:AbstractOperation = _serviceControl.getOperation("RenameUser");
         return _loc5_.send(param1,param2,param3,param4);
      }
      
      public function GetChatLogListByReportTime(param1:int, param2:int, param3:int, param4:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc5_:AbstractOperation = _serviceControl.getOperation("GetChatLogListByReportTime");
         return _loc5_.send(param1,param2,param3,param4);
      }
      
      public function SaveActorLocale(param1:int, param2:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("SaveActorLocale");
         return _loc3_.send(param1,param2);
      }
      
      public function GetHighscoreClothes(param1:int, param2:int, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("GetHighscoreClothes");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function AwardStartupReward(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("AwardStartupReward");
         return _loc2_.send(param1);
      }
      
      public function LoadGuestBook(param1:int, param2:int, param3:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("LoadGuestBook");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function DeleteBioText(param1:int, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("DeleteBioText");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function MailChimpResyncList(param1:String, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("MailChimpResyncList");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function GetMovieByGuid(param1:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("GetMovieByGuid");
         return _loc2_.send(param1);
      }
      
      public function GiveAutoWarning(param1:int, param2:String, param3:int, param4:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc5_:AbstractOperation = _serviceControl.getOperation("GiveAutoWarning");
         return _loc5_.send(param1,param2,param3,param4);
      }
      
      public function SaveActorPersonalInfo(param1:int, param2:int, param3:int, param4:int, param5:String, param6:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc7_:AbstractOperation = _serviceControl.getOperation("SaveActorPersonalInfo");
         return _loc7_.send(param1,param2,param3,param4,param5,param6);
      }
      
      public function awardActorVIP(param1:int, param2:int, param3:String, param4:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc5_:AbstractOperation = _serviceControl.getOperation("awardActorVIP");
         return _loc5_.send(param1,param2,param3,param4);
      }
      
      public function SetEmailSettings(param1:int, param2:String, param3:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("SetEmailSettings");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function getLoginHistory(param1:int, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("getLoginHistory");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function LoadActorDetails2(param1:int, param2:Boolean, param3:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("LoadActorDetails2");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function testdate() : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc1_:AbstractOperation = _serviceControl.getOperation("testdate");
         return _loc1_.send();
      }
      
      public function GetMovieById(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("GetMovieById");
         return _loc2_.send(param1);
      }
      
      public function saveNews(param1:NewsUpdate) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("saveNews");
         return _loc2_.send(param1);
      }
      
      public function CreateTopicNew(param1:int, param2:int, param3:String, param4:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc5_:AbstractOperation = _serviceControl.getOperation("CreateTopicNew");
         return _loc5_.send(param1,param2,param3,param4);
      }
      
      public function BlockName(param1:String, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("BlockName");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function SendNewEmailValidation(param1:String, param2:int, param3:String, param4:String, param5:int, param6:Boolean) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc7_:AbstractOperation = _serviceControl.getOperation("SendNewEmailValidation");
         return _loc7_.send(param1,param2,param3,param4,param5,param6);
      }
      
      public function SaveChatAllowed(param1:int, param2:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("SaveChatAllowed");
         return _loc3_.send(param1,param2);
      }
      
      public function GetMovieRatings(param1:int, param2:int, param3:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("GetMovieRatings");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function GetBlockedNames(param1:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("GetBlockedNames");
         return _loc2_.send(param1);
      }
      
      public function GetAppSetting(param1:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("GetAppSetting");
         return _loc2_.send(param1);
      }
      
      public function exposeTickeHeader(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("exposeTickeHeader");
         return _loc2_.send(param1);
      }
      
      public function UndeleteUser(param1:int, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("UndeleteUser");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function GetHighscore(param1:int, param2:Boolean, param3:String, param4:int, param5:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc6_:AbstractOperation = _serviceControl.getOperation("GetHighscore");
         return _loc6_.send(param1,param2,param3,param4,param5);
      }
      
      public function UpdateBehaviourStatusNew(param1:int, param2:int, param3:String, param4:Number, param5:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc6_:AbstractOperation = _serviceControl.getOperation("UpdateBehaviourStatusNew");
         return _loc6_.send(param1,param2,param3,param4,param5);
      }
      
      public function SaveLocaleResourceFiles(param1:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("SaveLocaleResourceFiles");
         return _loc2_.send(param1);
      }
      
      public function DeleteUser(param1:String, param2:String, param3:Boolean) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("DeleteUser");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function DeleteMovie(param1:int, param2:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("DeleteMovie");
         return _loc3_.send(param1,param2);
      }
      
      public function awardActorMoneySecure(param1:int, param2:int, param3:String, param4:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc5_:AbstractOperation = _serviceControl.getOperation("awardActorMoneySecure");
         return _loc5_.send(param1,param2,param3,param4);
      }
      
      public function UpdateGift(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("UpdateGift");
         return _loc2_.send(param1);
      }
      
      public function GetModeratorWarningCount(param1:int, param2:int, param3:int, param4:String, param5:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc6_:AbstractOperation = _serviceControl.getOperation("GetModeratorWarningCount");
         return _loc6_.send(param1,param2,param3,param4,param5);
      }
      
      public function GetTotalModeratorActivitiesDone(param1:int, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("GetTotalModeratorActivitiesDone");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function GetWallpapers(param1:int, param2:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("GetWallpapers");
         return _loc3_.send(param1,param2);
      }
      
      public function GetBlockedIP(param1:int, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("GetBlockedIP");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function GetWarnedIPListNew(param1:int, param2:int, param3:int, param4:String, param5:String, param6:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc7_:AbstractOperation = _serviceControl.getOperation("GetWarnedIPListNew");
         return _loc7_.send(param1,param2,param3,param4,param5,param6);
      }
      
      public function SendRetentionMail(param1:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("SendRetentionMail");
         return _loc2_.send(param1);
      }
      
      public function BlockedActors(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("BlockedActors");
         return _loc2_.send(param1);
      }
      
      public function GetIPUsers(param1:int, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("GetIPUsers");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function SendMovieAsMail(param1:int, param2:String, param3:String, param4:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc5_:AbstractOperation = _serviceControl.getOperation("SendMovieAsMail");
         return _loc5_.send(param1,param2,param3,param4);
      }
      
      public function ChangePasswordNew(param1:int, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("ChangePasswordNew");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function GetMovieListForActorNew(param1:int, param2:int, param3:int, param4:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc5_:AbstractOperation = _serviceControl.getOperation("GetMovieListForActorNew");
         return _loc5_.send(param1,param2,param3,param4);
      }
      
      public function GetBadWordActorList(param1:int, param2:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("GetBadWordActorList");
         return _loc3_.send(param1,param2);
      }
      
      public function EmailChanged(param1:int, param2:String, param3:String, param4:String, param5:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc6_:AbstractOperation = _serviceControl.getOperation("EmailChanged");
         return _loc6_.send(param1,param2,param3,param4,param5);
      }
      
      public function unmarkIpAsPublic(param1:int, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("unmarkIpAsPublic");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function DeletePost(param1:int, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("DeletePost");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function GetChatLogListLocked(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("GetChatLogListLocked");
         return _loc2_.send(param1);
      }
      
      public function GetIPWarnings(param1:int, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("GetIPWarnings");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function GetTopics(param1:int, param2:int, param3:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("GetTopics");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function SaveLocaleResources(param1:ArrayCollection) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("SaveLocaleResources");
         return _loc2_.send(param1);
      }
      
      public function GetNewsById(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("GetNewsById");
         return _loc2_.send(param1);
      }
      
      public function SendContentEmail(param1:String, param2:String, param3:int, param4:int, param5:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc6_:AbstractOperation = _serviceControl.getOperation("SendContentEmail");
         return _loc6_.send(param1,param2,param3,param4,param5);
      }
      
      public function Login2(param1:String, param2:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("Login2");
         return _loc3_.send(param1,param2);
      }
      
      public function IsDevSite(param1:String, param2:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("IsDevSite");
         return _loc3_.send(param1,param2);
      }
      
      public function GetAutoSavedMovie(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("GetAutoSavedMovie");
         return _loc2_.send(param1);
      }
      
      public function BlockActor(param1:int, param2:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("BlockActor");
         return _loc3_.send(param1,param2);
      }
      
      public function BuyBeautyClinicItemsNew(param1:int, param2:int, param3:int, param4:int, param5:String, param6:String, param7:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc8_:AbstractOperation = _serviceControl.getOperation("BuyBeautyClinicItemsNew");
         return _loc8_.send(param1,param2,param3,param4,param5,param6,param7);
      }
      
      public function LockOutUser(param1:int, param2:int, param3:String, param4:Number, param5:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc6_:AbstractOperation = _serviceControl.getOperation("LockOutUser");
         return _loc6_.send(param1,param2,param3,param4,param5);
      }
      
      public function ClearCache(param1:String, param2:String, param3:Boolean) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("ClearCache");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function EmailValidatedCancel(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("EmailValidatedCancel");
         return _loc2_.send(param1);
      }
      
      public function GetHighscoreMovie(param1:int, param2:Boolean, param3:String, param4:int, param5:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc6_:AbstractOperation = _serviceControl.getOperation("GetHighscoreMovie");
         return _loc6_.send(param1,param2,param3,param4,param5);
      }
      
      public function fileExists(param1:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("fileExists");
         return _loc2_.send(param1);
      }
      
      public function GetReportList(param1:Boolean, param2:int, param3:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("GetReportList");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function ForceEntityNameChange(param1:int, param2:int, param3:int, param4:String, param5:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc6_:AbstractOperation = _serviceControl.getOperation("ForceEntityNameChange");
         return _loc6_.send(param1,param2,param3,param4,param5);
      }
      
      public function GetActorNameFromId(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("GetActorNameFromId");
         return _loc2_.send(param1);
      }
      
      public function LoadActorDetailsVersion(param1:int, param2:Boolean) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("LoadActorDetailsVersion");
         return _loc3_.send(param1,param2);
      }
      
      public function GiveAutograph(param1:int, param2:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("GiveAutograph");
         return _loc3_.send(param1,param2);
      }
      
      public function GetReportOverview() : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc1_:AbstractOperation = _serviceControl.getOperation("GetReportOverview");
         return _loc1_.send();
      }
      
      public function moderatorUpdateTopic(param1:Topic) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("moderatorUpdateTopic");
         return _loc2_.send(param1);
      }
      
      public function SendEmailValidation(param1:String, param2:int, param3:String, param4:String, param5:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc6_:AbstractOperation = _serviceControl.getOperation("SendEmailValidation");
         return _loc6_.send(param1,param2,param3,param4,param5);
      }
      
      public function woGetMovieRatings(param1:String, param2:int, param3:int, param4:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc5_:AbstractOperation = _serviceControl.getOperation("woGetMovieRatings");
         return _loc5_.send(param1,param2,param3,param4);
      }
      
      public function ClearNewMarkings(param1:String, param2:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("ClearNewMarkings");
         return _loc3_.send(param1,param2);
      }
      
      public function GetHighscoreClickItem(param1:int, param2:Boolean, param3:Boolean, param4:String, param5:int, param6:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc7_:AbstractOperation = _serviceControl.getOperation("GetHighscoreClickItem");
         return _loc7_.send(param1,param2,param3,param4,param5,param6);
      }
      
      public function BadWordCountAdd(param1:int, param2:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("BadWordCountAdd");
         return _loc3_.send(param1,param2);
      }
      
      public function GetChatLogList(param1:int, param2:int, param3:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("GetChatLogList");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function GetActorLocale(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("GetActorLocale");
         return _loc2_.send(param1);
      }
      
      public function GetHighscoreLook(param1:int, param2:Boolean, param3:String, param4:int, param5:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc6_:AbstractOperation = _serviceControl.getOperation("GetHighscoreLook");
         return _loc6_.send(param1,param2,param3,param4,param5);
      }
      
      public function SendInvitation(param1:String, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("SendInvitation");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function SetTopicAsDeleted(param1:int, param2:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("SetTopicAsDeleted");
         return _loc3_.send(param1,param2);
      }
      
      public function SaveMyRoom(param1:int, param2:String, param3:String, param4:ArrayCollection) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc5_:AbstractOperation = _serviceControl.getOperation("SaveMyRoom");
         return _loc5_.send(param1,param2,param3,param4);
      }
      
      public function GetNews(param1:int, param2:int, param3:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("GetNews");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function ipasint(param1:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("ipasint");
         return _loc2_.send(param1);
      }
      
      public function GetCountrySiteStatus(param1:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("GetCountrySiteStatus");
         return _loc2_.send(param1);
      }
      
      public function GetAutoSavedMovieId(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("GetAutoSavedMovieId");
         return _loc2_.send(param1);
      }
      
      public function LoadActorDetails(param1:int, param2:Boolean) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("LoadActorDetails");
         return _loc3_.send(param1,param2);
      }
      
      public function PublishMovie(param1:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("PublishMovie");
         return _loc2_.send(param1);
      }
      
      public function UpdateQuest(param1:int, param2:String, param3:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("UpdateQuest");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function GetEntityComments(param1:String, param2:int, param3:int, param4:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc5_:AbstractOperation = _serviceControl.getOperation("GetEntityComments");
         return _loc5_.send(param1,param2,param3,param4);
      }
      
      public function UnblockName(param1:String, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("UnblockName");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function UpdateRetention(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("UpdateRetention");
         return _loc2_.send(param1);
      }
      
      public function MovieWatched(param1:int, param2:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("MovieWatched");
         return _loc3_.send(param1,param2);
      }
      
      public function GetBlockedInfo(param1:int, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("GetBlockedInfo");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function GetMovieCompetitionList(param1:String, param2:int, param3:int, param4:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc5_:AbstractOperation = _serviceControl.getOperation("GetMovieCompetitionList");
         return _loc5_.send(param1,param2,param3,param4);
      }
      
      public function EntityCommentDelete(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("EntityCommentDelete");
         return _loc2_.send(param1);
      }
      
      public function GetModeratorWarnings(param1:int, param2:String, param3:int, param4:int, param5:String, param6:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc7_:AbstractOperation = _serviceControl.getOperation("GetModeratorWarnings");
         return _loc7_.send(param1,param2,param3,param4,param5,param6);
      }
      
      public function isIPBlockedNew(param1:int, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("isIPBlockedNew");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function blockIP(param1:int, param2:int, param3:String, param4:String, param5:int, param6:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc7_:AbstractOperation = _serviceControl.getOperation("blockIP");
         return _loc7_.send(param1,param2,param3,param4,param5,param6);
      }
      
      public function markIpAsPublic(param1:int, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("markIpAsPublic");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function GetCurrentQuest(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("GetCurrentQuest");
         return _loc2_.send(param1);
      }
      
      public function GetSubmittedScrapBlog(param1:int, param2:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("GetSubmittedScrapBlog");
         return _loc3_.send(param1,param2);
      }
      
      public function EmailValidated(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("EmailValidated");
         return _loc2_.send(param1);
      }
      
      public function BadWordCountClear(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("BadWordCountClear");
         return _loc2_.send(param1);
      }
      
      public function IsModerator(param1:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("IsModerator");
         return _loc2_.send(param1);
      }
      
      public function GetLocaleResources(param1:String, param2:String, param3:String, param4:int, param5:int) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc6_:AbstractOperation = _serviceControl.getOperation("GetLocaleResources");
         return _loc6_.send(param1,param2,param3,param4,param5);
      }
      
      public function GetActorPersonalInfo(param1:int, param2:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("GetActorPersonalInfo");
         return _loc3_.send(param1,param2);
      }
      
      public function UpdateActorPersonalInfo(param1:ActorPersonalInfo, param2:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc3_:AbstractOperation = _serviceControl.getOperation("UpdateActorPersonalInfo");
         return _loc3_.send(param1,param2);
      }
      
      public function MovieCompetitionPublish(param1:int, param2:String, param3:String) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc4_:AbstractOperation = _serviceControl.getOperation("MovieCompetitionPublish");
         return _loc4_.send(param1,param2,param3);
      }
      
      public function getNowAsString() : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc1_:AbstractOperation = _serviceControl.getOperation("getNowAsString");
         return _loc1_.send();
      }
      
      public function ReportActor(param1:Report) : AsyncToken
      {
         model_internal::loadWSDLIfNecessary();
         var _loc2_:AbstractOperation = _serviceControl.getOperation("ReportActor");
         return _loc2_.send(param1);
      }
   }
}

