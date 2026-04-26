package com.moviestarplanet.core.controller.commands.startupcommands
{
   import com.moviestarplanet.configurations.AppSettings;
   import com.moviestarplanet.utils.UserIdleMonitor;
   import com.moviestarplanet.utils.translation.LocaleHelper;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   import flash.external.ExternalInterface;
   import robotlegs.bender.extensions.commandCenter.api.ICommand;
   
   public class CheckInactivityLogoutCommand implements ICommand
   {
      
      public function CheckInactivityLogoutCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         var _loc1_:String = ExternalInterface.call("window.location.href.toString");
         var _loc2_:Number = parseInt(AppSettings.getInstance().getSetting(AppSettings.CLIENT_IDLE_TIMEOUT)) / 60;
         _loc2_ = Math.round(_loc2_ * 100) / 100;
         if(_loc1_.indexOf(UserIdleMonitor.IDLE_LOGOUT_PARAM) != -1)
         {
            Prompt.show(LocaleHelper.getInstance().getString("MSP_INACTIVE_POPUP_TEXT",[_loc2_]),LocaleHelper.getInstance().getString("MSP_INACTIVE_POPUP_HEADLINE"));
         }
      }
   }
}

