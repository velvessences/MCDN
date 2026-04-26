package com.moviestarplanet.parentalconsent
{
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.parentalconsent.popup.ConfirmParentalConsentPopup;
   import com.moviestarplanet.parentalconsent.popup.EnterParentalCodePopup;
   import com.moviestarplanet.parentalconsent.popup.ParentalConsentPopup;
   import com.moviestarplanet.services.wrappers.parentalconsentwebservice.ParentalConsentWebService;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.window.stack.WindowStack;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   
   public class ParentalConsentHandler
   {
      
      public static const ACTION_MOBILE_PAYMENT:int = 1;
      
      public function ParentalConsentHandler()
      {
         super();
      }
      
      public static function ParentalConsentRequiredAction(param1:int, param2:Function) : void
      {
         var done:Function = null;
         var actionCode:int = param1;
         var callBackAllowedAction:Function = param2;
         done = function(param1:Boolean, param2:Boolean):void
         {
            var parentalCodeConfirmed:Function = null;
            var userApproved:Boolean = param1;
            var requireParentalCode:Boolean = param2;
            parentalCodeConfirmed = function(param1:Boolean):void
            {
               callBackAllowedAction(param1);
            };
            if(!userApproved)
            {
               ParentalConsentHandler.GetParentalConsent();
            }
            else if(requireParentalCode)
            {
               ParentalConsentHandler.EnterParentalCode(actionCode,parentalCodeConfirmed);
            }
            else
            {
               parentalCodeConfirmed(true);
            }
         };
         if(!Config.IsServerRestricted())
         {
            callBackAllowedAction(true);
         }
         else
         {
            GetParentalConsentRequirements(done,actionCode);
         }
      }
      
      private static function GetParentalConsentRequirements(param1:Function, param2:int) : void
      {
         var done:Function = null;
         var callBack:Function = param1;
         var actionCode:int = param2;
         done = function(param1:String):void
         {
            var _loc2_:Boolean = actionRequiresParentalCode(actionCode);
            var _loc3_:Boolean = true;
            switch(param1.toLowerCase())
            {
               case "regular":
                  _loc2_ = false;
                  break;
               case "approved":
                  break;
               case "unapproved":
               default:
                  _loc3_ = false;
            }
            callBack(_loc3_,_loc2_);
         };
         ParentalConsentWebService.GetUserType(ActorSession.loggedInActor.ActorId,done);
      }
      
      private static function actionRequiresParentalCode(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         switch(param1)
         {
            case ACTION_MOBILE_PAYMENT:
               _loc2_ = true;
               break;
            default:
               _loc2_ = false;
         }
         return _loc2_;
      }
      
      public static function GetParentalConsent() : void
      {
         WindowStack.showViewStackable(new ParentalConsentPopup(),400,110,WindowStack.Z_BROWSER);
      }
      
      public static function OpenConfirmParentalConsentPopup(param1:int, param2:String) : void
      {
         var done:Function = null;
         var actorId:int = param1;
         var parentalConsentConfirmCode:String = param2;
         done = function(param1:Boolean):void
         {
            if(param1)
            {
               WindowStack.showViewStackable(new ConfirmParentalConsentPopup(actorId,parentalConsentConfirmCode),330,80,WindowStack.Z_BROWSER);
            }
            else
            {
               Prompt.show(MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_CONFIRM_MATCH_ERROR"));
            }
         };
         ParentalConsentWebService.MatchActorIdToParentalConsentConfirmCode(actorId,parentalConsentConfirmCode,done);
      }
      
      public static function EnterParentalCode(param1:int, param2:Function) : void
      {
         WindowStack.showViewStackable(new EnterParentalCodePopup(param1,param2),420,140,WindowStack.Z_BROWSER);
      }
   }
}

