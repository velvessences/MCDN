package com.moviestarplanet.version
{
   import com.junkbyte.console.Cc;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   import com.moviestarplanet.windowpopup.popup.PromptEvent;
   import flash.display.DisplayObject;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class ValidateClientVersion
   {
      
      private static var previouslyAsked:Boolean = false;
      
      public function ValidateClientVersion()
      {
         super();
      }
      
      public static function isVersionValid(param1:DisplayObject, param2:String, param3:Boolean = false) : Boolean
      {
         var forceUpdateCallback:Function;
         var askUpdateCallback:Function;
         var reload:Function;
         var currentUrl:String = null;
         var filename:String = null;
         var isValid:Boolean = false;
         var forceUpdateHeadline:String = null;
         var forceUpdateBodyText:String = null;
         var stage:DisplayObject = param1;
         var serverVersion:String = param2;
         var forceUpdate:Boolean = param3;
         currentUrl = ExternalInterface.call("eval","document.location.href");
         if(serverVersion != null)
         {
            if(serverVersion.indexOf("versionError") == -1 && currentUrl.indexOf("version=") == -1 && !previouslyAsked)
            {
               forceUpdateCallback = function(param1:PromptEvent):void
               {
                  reload();
               };
               askUpdateCallback = function(param1:PromptEvent):void
               {
                  if(param1.detail == Prompt.YES)
                  {
                     reload();
                  }
               };
               reload = function():void
               {
                  if(currentUrl.indexOf("?") == -1)
                  {
                     currentUrl += "?";
                  }
                  else
                  {
                     currentUrl += "&";
                  }
                  currentUrl += "version=" + serverVersion;
                  var _loc1_:URLRequest = new URLRequest(currentUrl);
                  navigateToURL(_loc1_,"_self");
               };
               filename = stage.loaderInfo.url;
               filename = filename.split("/").pop();
               Cc.infoch("login","Version check: " + serverVersion + " == " + filename);
               trace("Version check: " + serverVersion + " == " + filename);
               isValid = serverVersion + ".swf" == filename;
               if(!isValid)
               {
                  previouslyAsked = true;
                  forceUpdateHeadline = MSPLocaleManagerWeb.getInstance().getString("PROMPT_FORCE_UPDATE_HEADLINE") || "";
                  forceUpdateBodyText = MSPLocaleManagerWeb.getInstance().getString("PROMPT_FORCE_UPDATE_BODY_TEXT") || "";
                  if(forceUpdate)
                  {
                     UpdateVersionPopup.show(forceUpdateBodyText,forceUpdateHeadline,forceUpdateCallback);
                  }
                  else
                  {
                     Prompt.show(MSPLocaleManagerWeb.getInstance().getString("PROMPT_ASK_UPDATE_BODY"),forceUpdateHeadline,Prompt.YES | Prompt.NO,null,askUpdateCallback);
                  }
               }
               return isValid;
            }
         }
         return true;
      }
   }
}

