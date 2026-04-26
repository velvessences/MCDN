package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.Components.ShowMovieFromUrl;
   import com.moviestarplanet.admin.module.AdminModuleManager;
   import com.moviestarplanet.analytics.AnalyticsReceiveCurrencyCommand;
   import com.moviestarplanet.analytics.constants.AnalyticsConstants;
   import com.moviestarplanet.analytics.constants.AnalyticsStarcoinsAmount;
   import com.moviestarplanet.artbook.ArtBookModuleManager;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.core.model.actor.reload.ActorReload;
   import com.moviestarplanet.createuser.NewUserState;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.msg.MSPDataEvent;
   import com.moviestarplanet.parentalconsent.ParentalConsentHandler;
   import com.moviestarplanet.payment.Module.PaymentManager;
   import com.moviestarplanet.popup.OldPopupHandler;
   import com.moviestarplanet.services.wrappers.UserService;
   import com.moviestarplanet.usersession.service.UserSessionAMFService;
   import com.moviestarplanet.usersession.valueobjects.ActorPersonalInfo;
   import com.moviestarplanet.utils.GetHtmlParametersCommand;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   import com.moviestarplanet.windowpopup.popup.PromptEvent;
   import flash.external.ExternalInterface;
   import mx.controls.Alert;
   import mx.utils.Base64Decoder;
   import mx.utils.Base64Encoder;
   import mx.utils.URLUtil;
   
   public class ParseUrlParamsCommand
   {
      
      public function ParseUrlParamsCommand()
      {
         super();
      }
      
      private static function movieFromURLClosed(param1:MSPDataEvent) : void
      {
         MessageCommunicator.unscribe(MSPDataEvent.MOVIE_FROM_URL_CLOSED,movieFromURLClosed);
         Main.Instance.mainCanvas.applicationViewStack.allowMainPopupClosingOnCreationComplete = true;
      }
      
      public function execute() : void
      {
         var done2:Function;
         var changeDone:Function;
         var done:Function;
         var done1:Function;
         var done3:Function;
         var doneParentSettings:Function;
         var urlParamsString:String = null;
         var movieGuid:String = null;
         var actorName:String = null;
         var actorIdStr:String = null;
         var actorId:int = 0;
         var decoder:Base64Decoder = null;
         var queryparamsString:String = null;
         var queryparams:Object = null;
         var actorIdValidated:int = 0;
         var queryparams2:String = null;
         var encoder:Base64Encoder = null;
         var displayText:String = null;
         var browserUrl:String = ExternalInterface.call("eval","document.location.href");
         var htmlParams:Object = new GetHtmlParametersCommand().execute(browserUrl);
         var paramIndex:int = int(browserUrl.indexOf("?"));
         if(paramIndex > -1)
         {
            paramIndex++;
            if(paramIndex < browserUrl.length)
            {
               if(browserUrl.substr(paramIndex,10) == "debug=true")
               {
                  return;
               }
               urlParamsString = browserUrl.substr(paramIndex);
               if(htmlParams["sm"] != null)
               {
                  movieGuid = htmlParams["sm"];
                  this.ShowMovieFromUrlMethod(movieGuid);
                  return;
               }
               if(htmlParams["nonews"] != null)
               {
                  actorName = htmlParams["un"];
                  actorIdStr = htmlParams["ui"];
                  actorId = int(parseInt(actorIdStr));
                  if(actorId != 0)
                  {
                     done2 = function():void
                     {
                        Prompt.show(MSPLocaleManagerWeb.getInstance().getString("NEWS_STOP_MESSAGE"),MSPLocaleManagerWeb.getInstance().getString("NO_MORE_NEWS"));
                     };
                     UserSessionAMFService.instance.SetEmailSettings(actorId,actorName,1,done2);
                     return;
                  }
               }
               else
               {
                  if(htmlParams["utm_source"] != null)
                  {
                     return;
                  }
                  if(htmlParams["moderator"] != null)
                  {
                     return;
                  }
               }
               if(urlParamsString.length > 0)
               {
                  try
                  {
                     decoder = new Base64Decoder();
                     decoder.decode(urlParamsString);
                     queryparamsString = String(decoder.toByteArray());
                     queryparams = URLUtil.stringToObject(queryparamsString);
                     if(queryparams.emailValidation != null && queryparams.uid != null)
                     {
                        actorIdValidated = int(parseInt(queryparams.uid));
                        if(queryparams.mail != null)
                        {
                           changeDone = function(param1:int):void
                           {
                              if(param1 == 0)
                              {
                                 Prompt.show(MSPLocaleManagerWeb.getInstance().getString("CHANGE_EMAIL_SUCCESS"),MSPLocaleManagerWeb.getInstance().getString("CHANGE_EMAIL"));
                              }
                              else if(param1 == 1)
                              {
                                 Prompt.show(MSPLocaleManagerWeb.getInstance().getString("INVALID_USERNAME_PASSWORD"),MSPLocaleManagerWeb.getInstance().getString("CHANGE_EMAIL"));
                              }
                              else
                              {
                                 Prompt.show(MSPLocaleManagerWeb.getInstance().getString("CHANGE_EMAIL_ERROR"),MSPLocaleManagerWeb.getInstance().getString("CHANGE_EMAIL"));
                              }
                           };
                           UserSessionAMFService.instance.EmailChanged(actorIdValidated,queryparams.mail,queryparams.un,queryparams.ps,queryparams.newes,changeDone);
                        }
                        else
                        {
                           done = function(param1:Boolean):void
                           {
                              if(param1)
                              {
                                 AnalyticsReceiveCurrencyCommand.execute(AnalyticsConstants.EARN_SC_SINGLE_EMAIL_VALIDATED,AnalyticsStarcoinsAmount.EMAIL_VALIDATED);
                                 Prompt.show(MSPLocaleManagerWeb.getInstance().getString("CONGRATS_RECIEVED_STARCOINS"),MSPLocaleManagerWeb.getInstance().getString("RECIEVED_STARCOINS"));
                              }
                              else
                              {
                                 Prompt.show(MSPLocaleManagerWeb.getInstance().getString("ONLY_STARCOINS_ONCE"),MSPLocaleManagerWeb.getInstance().getString("STARCOINS_ALREADY"));
                              }
                           };
                           UserSessionAMFService.instance.EmailValidated(actorIdValidated,done);
                        }
                     }
                     else if(queryparams.hash != null && queryparams.deleteUserRequest != null && queryparams.uname != null && queryparams.upw != null && queryparams.uid != null)
                     {
                        if(SerializeUtils.checkHash("woieoijf" + queryparams.uid + queryparams.uname + queryparams.upw,queryparams.hash))
                        {
                           done1 = function(param1:int):void
                           {
                              if(param1 == 0)
                              {
                                 Prompt.show(MSPLocaleManagerWeb.getInstance().getString("USER_DELETED"),MSPLocaleManagerWeb.getInstance().getString("DELETE_USER"),4);
                                 MessageCommunicator.send(new MsgEvent(MSPEvent.DO_LOGOUT_ALL_SESSIONS,queryparams.uid));
                              }
                              else
                              {
                                 Prompt.show(MSPLocaleManagerWeb.getInstance().getString("INVALID_USERNAME_PASSWORD"),MSPLocaleManagerWeb.getInstance().getString("DELETE_USER"),4);
                              }
                           };
                           UserSessionAMFService.instance.DeleteUser(queryparams.uname,queryparams.upw,parseInt(queryparams.uid),done1);
                        }
                        else
                        {
                           Alert.show("URL params error.","Error");
                        }
                     }
                     else if(queryparams.hash != null && queryparams.confirmChangeMail != null && queryparams.uname != null && queryparams.upw != null && queryparams.uid != null && queryparams.oldmail != null && queryparams.newmail != null && queryparams.newes != null)
                     {
                        queryparams2 = "uid=" + queryparams.uid + ";emailValidation=true;mail=" + queryparams.newmail + ";newes=" + queryparams.newes + ";un=" + queryparams.uname + ";ps=" + queryparams.upw;
                        encoder = new Base64Encoder();
                        encoder.insertNewLines = false;
                        encoder.encode(queryparams2);
                        if(SerializeUtils.checkHash("woieoijf" + queryparams.uid + queryparams.uname + queryparams.upw + queryparams.oldmail + queryparams.newmail + queryparams.newes,queryparams.hash))
                        {
                           done3 = function():void
                           {
                              if(ActorSession.loggedInActor != null)
                              {
                                 ActorReload.getInstance().requestReload();
                              }
                              Prompt.show(MSPLocaleManagerWeb.getInstance().getString("EMAIL_SENT_TO",[queryparams.newmail]),MSPLocaleManagerWeb.getInstance().getString("EMAIL_SEND"),4);
                           };
                           UserSessionAMFService.instance.SendNewEmailValidation(queryparams.newmail,queryparams.uid,queryparams.uname,encoder.toString(),queryparams.newes,true,done3);
                        }
                        else
                        {
                           Alert.show("URL params error.","Error");
                        }
                     }
                     else if(queryparams.hash != null && queryparams.parentSettings != null && queryparams.uid != null)
                     {
                        if(SerializeUtils.checkHash("woieoijf" + queryparams.uid,queryparams.hash))
                        {
                           doneParentSettings = function(param1:ActorPersonalInfo):void
                           {
                              if(param1 != null)
                              {
                                 AdminModuleManager.getInstance().showParentalAdministration(param1);
                              }
                           };
                           UserService.GetActorPersonalInfo(parseInt(queryparams.uid),doneParentSettings);
                        }
                        else
                        {
                           Alert.show("URL params error.","Error");
                        }
                     }
                     else if(queryparams.viewContentType != null && queryparams.viewContentId != null)
                     {
                        switch(queryparams.viewContentType)
                        {
                           case 7:
                              ArtBookModuleManager.getInstance().openArtBookViewerExternal(queryparams.viewContentId);
                              break;
                           default:
                              Alert.show("contentType not impl");
                        }
                     }
                     else if(queryparams.sm != null)
                     {
                        this.ShowMovieFromUrlMethod(queryparams.sm);
                     }
                     else if(queryparams.un != null)
                     {
                        NewUserState.invitedByActorID = queryparams.uid;
                        NewUserState.invitedByUserName = queryparams.un;
                        this.ShowWelcomeMessage(queryparams.un);
                     }
                     else if(queryparams.subscriptionId != null)
                     {
                        PaymentManager.getInstance().showDisableRecurringPaymentLoginPopup(queryparams.subscriptionId,150,80);
                     }
                     else if(queryparams.grantParentalConsent != null && queryparams.actorid != null && queryparams.parentalConfirmCode != null)
                     {
                        ParentalConsentHandler.OpenConfirmParentalConsentPopup(queryparams.actorid,queryparams.parentalConfirmCode);
                     }
                     else if(queryparams.caruText != null && queryparams.actionType != null && queryparams.actionResult != null)
                     {
                        displayText = null;
                        switch(queryparams.actionType)
                        {
                           case "EmailOptOut":
                              switch(queryparams.actionResult)
                              {
                                 case "UrlMalformedError":
                                    displayText = "CARU_ERROR_IN_PROCESS";
                                    break;
                                 case "RemovedSuccessFully":
                                    displayText = "CARU_DELETE_CHILDS_EMAIL";
                                    break;
                                 case "AlreadyRemoved":
                                    displayText = "CARU_ALREADY_DELETED_CHILDS_EMAIL";
                              }
                              break;
                           case "ParentalConsentRevoke":
                              switch(queryparams.actionResult)
                              {
                                 case "UrlMalformedError":
                                    displayText = "CARU_ERROR_IN_PROCESS";
                                    break;
                                 case "AlreadyRevoked":
                                    displayText = "CARU_NO_CONSENT_FOUND";
                                    break;
                                 case "RevokedSuccesFully":
                                    displayText = "CARU_REVOKED_PARENTAL_CONSENT";
                              }
                              break;
                           case "ParentalConsentConfirmation":
                              switch(queryparams.actionResult)
                              {
                                 case "UrlMalformedError":
                                    displayText = "CARU_ERROR_IN_PROCESS";
                                    break;
                                 case "ConfirmedSuccessfully":
                                    displayText = "CARU_CONFIRMED_PARENTAL_CONSENT";
                              }
                        }
                        if(displayText != null)
                        {
                           Alert.show(MSPLocaleManagerWeb.getInstance().getString(displayText));
                        }
                     }
                  }
                  catch(error:Error)
                  {
                     Alert.show("Url params ignored","Invalid URL params - " + error.message);
                  }
               }
            }
         }
      }
      
      private function ShowMovieFromUrlMethod(param1:String) : void
      {
         var _loc2_:ShowMovieFromUrl = new ShowMovieFromUrl();
         _loc2_.init(param1);
         _loc2_.scaleX = 1.45;
         _loc2_.scaleY = 1.45;
         Main.Instance.mainCanvas.applicationViewStack.allowMainPopupClosingOnCreationComplete = false;
         MessageCommunicator.subscribe(MSPDataEvent.MOVIE_FROM_URL_CLOSED,movieFromURLClosed);
         OldPopupHandler.getInstance().showMainPopup(_loc2_,0,0);
      }
      
      private function ShowWelcomeMessage(param1:String) : void
      {
         var closeHandler:Function = null;
         var invitedByUserName:String = param1;
         closeHandler = function(param1:PromptEvent):void
         {
            if(param1.detail == Prompt.YES)
            {
               Main.Instance.mainCanvas.applicationViewStack.showRegisterNewUser();
            }
         };
         var title:String = MSPLocaleManagerWeb.getInstance().getString("WELCOME");
         var msg:String = MSPLocaleManagerWeb.getInstance().getString("YOU_WERE_INVITED");
         if(invitedByUserName != null && invitedByUserName.length > 0)
         {
            msg = MSPLocaleManagerWeb.getInstance().getString("YOU_WERE_INVITED_BY",[invitedByUserName]);
         }
         Prompt.show(msg,title,Prompt.YES | Prompt.NO,null,closeHandler);
      }
   }
}

