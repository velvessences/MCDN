package com.moviestarplanet.utils
{
   import com.moviestarplanet.Forms.NewReport;
   import com.moviestarplanet.Forms.ValidateEmailOpener;
   import com.moviestarplanet.anchorCharacters.AnchorCharacters;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.flash.components.popups.HTMLPrompt;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.window.stack.WindowStack;
   import com.moviestarplanet.windowpopup.popup.PromptEvent;
   import mx.controls.Alert;
   
   public class ReportUtils
   {
      
      public static const REPORT_PROCEED:String = "ReportUtils.REPORT_PROCEED";
      
      public static const REPORT_CANCEL:String = "ReportUtils.REPORT_CANCEL";
      
      public function ReportUtils()
      {
         super();
      }
      
      public static function reportUser(param1:int, param2:String = null) : void
      {
         var questionString:String = null;
         var doDelete:Function = null;
         var safeString:String = null;
         var reportedActorId:int = param1;
         var userName:String = param2;
         doDelete = function(param1:PromptEvent):void
         {
            var _loc2_:NewReport = null;
            if(param1.detail == Alert.YES)
            {
               if(ActorSession.loggedInActor.EmailValidated == 2)
               {
                  _loc2_ = makeNewReport(reportedActorId,userName,false);
                  WindowStack.showViewStackable(_loc2_,400,170,WindowStack.Z_NOTICE);
               }
               else
               {
                  ValidateEmailOpener.getInstance().open(true);
               }
            }
         };
         if(userName == null)
         {
            questionString = "<b><font size=\"14\">" + MSPLocaleManagerWeb.getInstance().getString("YOU_ABOUT_REPORT_USER") + "</font></b>\n\n";
         }
         else
         {
            safeString = MSPLocaleManagerWeb.getInstance().getString("YOU_ABOUT_REPORT_NAME",[userName]).replace(/</g,"&lt;");
            safeString = safeString.replace(/>/g,"&gt;");
            questionString = "<b><font size=\"14\">" + safeString + "</font></b>\n\n";
         }
         questionString += MSPLocaleManagerWeb.getInstance().getString("NOT_ALLOWED_FALSE_REPORTS") + "\n" + MSPLocaleManagerWeb.getInstance().getString("IF_YOU_DO_WILL_GET_WARNING") + "\n\n" + MSPLocaleManagerWeb.getInstance().getString("REPORT_NOT_AUTOMATICALLY_WARN") + "\n\n" + "<b>" + MSPLocaleManagerWeb.getInstance().getString("ARE_YOU_SURE_CONTINUE") + "</b>";
         HTMLPrompt.show(questionString,MSPLocaleManagerWeb.getInstance().getString("REPORT_ABUSE"),Alert.YES | Alert.NO,null,doDelete,null,0);
      }
      
      public static function reportEntity(param1:int, param2:int, param3:int, param4:String = null) : void
      {
         var questionString:String = null;
         var doDelete:Function = null;
         var safeString:String = null;
         var reportedActorId:int = param1;
         var entityType:int = param2;
         var entityId:int = param3;
         var entityTitle:String = param4;
         doDelete = function(param1:PromptEvent):void
         {
            if(param1.detail == Alert.YES)
            {
               MessageCommunicator.sendMessage(REPORT_PROCEED,null);
               if(ActorSession.loggedInActor.EmailValidated == 2)
               {
                  WindowStack.showViewStackable(makeNewReport(reportedActorId,entityTitle,true,entityType,entityId),400,170,WindowStack.Z_NOTICE);
               }
               else
               {
                  ValidateEmailOpener.getInstance().open(true,null,null,true);
               }
            }
            else if(param1.detail == Alert.NO)
            {
               MessageCommunicator.sendMessage(REPORT_CANCEL,null);
            }
         };
         if(AnchorCharacters.isSpecialCharacter(reportedActorId))
         {
            return;
         }
         if(entityTitle == null)
         {
            questionString = "<b><font size=\"14\">" + MSPLocaleManagerWeb.getInstance().getString("YOU_ABOUT_REPORT_CONTENT") + "</font></b>\n\n";
         }
         else
         {
            safeString = MSPLocaleManagerWeb.getInstance().getString("YOU_ABOUT_REPORT_NAME",[entityTitle]).replace(/</g,"&lt;");
            safeString = safeString.replace(/>/g,"&gt;");
            questionString = "<b><font size=\"14\">" + safeString + "</font></b>\n\n";
         }
         questionString += MSPLocaleManagerWeb.getInstance().getString("NOT_ALLOWED_FALSE_REPORTS") + "\n" + MSPLocaleManagerWeb.getInstance().getString("IF_YOU_DO_WILL_GET_WARNING") + "\n\n" + MSPLocaleManagerWeb.getInstance().getString("REPORT_NOT_AUTOMATICALLY_WARN") + "\n\n" + "<b>" + MSPLocaleManagerWeb.getInstance().getString("ARE_YOU_SURE_CONTINUE") + "</b>";
         HTMLPrompt.show(questionString,MSPLocaleManagerWeb.getInstance().getString("REPORT_ABUSE"),Alert.YES | Alert.NO,null,doDelete,null,0);
      }
      
      private static function makeNewReport(param1:int, param2:String, param3:Boolean, param4:int = 0, param5:int = 0) : NewReport
      {
         var _loc6_:NewReport = new NewReport();
         _loc6_.reportedActorId = param1;
         _loc6_.entityId = param5;
         _loc6_.entityType = param4;
         _loc6_.nameOrTitle = param2;
         _loc6_.isEntity = param3;
         return _loc6_;
      }
   }
}

