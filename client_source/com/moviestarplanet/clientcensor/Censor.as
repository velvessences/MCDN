package com.moviestarplanet.clientcensor
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.configurations.AppSettings;
   import com.moviestarplanet.constants.ConstantsPlatform;
   import com.moviestarplanet.emoticon.utility.NativeEmoticonSupport;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.globalsharedutils.messaging.MessageStyleUtility;
   import com.moviestarplanet.model.IActorModel;
   import com.moviestarplanet.userbehavior.IRedifyableTextInputComponent;
   import com.moviestarplanet.userbehavior.utils.chatfilter.userbehaviorcontrol.WhitelistHandling;
   import com.moviestarplanet.utils.StringUtilities;
   import com.moviestarplanet.utils.translation.LocaleHelper;
   import flash.utils.getQualifiedClassName;
   
   public class Censor
   {
      
      public static var actorModel:IActorModel;
      
      public static var SaveAlertWordsCountFunction:Function;
      
      public static var LogInputFunction:Function;
      
      public static var LogInputGroupChatFunction:Function;
      
      private static var restriction:String;
      
      public static var moderatorList:Array = [];
      
      public function Censor()
      {
         super();
         throw new Error("Do not instantiate " + getQualifiedClassName(this));
      }
      
      private static function containsPhoneNumbers(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return true;
         }
         var _loc2_:Array = param1.match(/(\d[\-\.\s]?){8,}/g);
         if(_loc2_ != null && _loc2_.length > 0)
         {
            MessageCommunicator.send(new MsgEvent(MSPEvent.SHOW_USER_ALERT,{
               "text":LocaleHelper.getInstance().getString("DO_NOT_SHARE_LINKS"),
               "title":LocaleHelper.getInstance().getString("ATTENTION")
            }));
            return true;
         }
         return false;
      }
      
      public static function isInputStringSafeLocal(param1:String, param2:Boolean = true, param3:Boolean = true) : Boolean
      {
         var _loc4_:Array = BlackListUtil.getInstance().countAlertWords(param1);
         if(_loc4_.length > 0)
         {
            SaveAlertWordsCountFunction(actorModel.actorId,_loc4_);
         }
         if(param3 && NannyBase.instance.isMuted())
         {
            return false;
         }
         var _loc5_:Boolean = BlackListUtil.getInstance().containsPassword(param1) == 0;
         var _loc6_:Boolean = actorModel.isModerator || !containsPhoneNumbers(param1);
         var _loc7_:Boolean = !isLink(param1);
         var _loc8_:Boolean = true;
         if(whitelistEnabled)
         {
            _loc8_ = WhiteListBase.instance.patternCheckForBadWords(param1,null);
         }
         return _loc6_ && _loc7_ && _loc8_ && _loc5_;
      }
      
      public static function isInputStringBlackListSafe(param1:String) : Boolean
      {
         return BlackListUtil.getInstance().filterTextForUnwantedWords(param1,false).NewText == param1;
      }
      
      public static function censorText(param1:String, param2:int = 0) : String
      {
         var _loc3_:String = null;
         if(param1 == null)
         {
            return "";
         }
         if(actorModel.isModerator)
         {
            return param1;
         }
         if(param2 > 0 && moderatorList.indexOf(param2) >= 0)
         {
            return param1;
         }
         if(MessageStyleUtility.containsFontCode(param1))
         {
            _loc3_ = MessageStyleUtility.extractEntireCode(param1);
            param1 = MessageStyleUtility.removeFontCode(param1);
         }
         param1 = BlackListUtil.getInstance().filterTextForUnwantedWordsLite(param1,true).NewText;
         if(_loc3_)
         {
            param1 += _loc3_;
         }
         return param1;
      }
      
      public static function censorTextLite(param1:String) : String
      {
         var _loc2_:String = null;
         if(actorModel.isModerator)
         {
            return param1;
         }
         if(MessageStyleUtility.containsFontCode(param1))
         {
            _loc2_ = MessageStyleUtility.extractEntireCode(param1);
            param1 = MessageStyleUtility.removeFontCode(param1);
         }
         if(!whitelistEnabled)
         {
            param1 = BlackListUtil.getInstance().filterTextForUnwantedWordsLite(param1,true).NewText;
         }
         if(_loc2_)
         {
            param1 += _loc2_;
         }
         return param1;
      }
      
      public static function redifyBadWords(param1:IRedifyableTextInputComponent) : void
      {
         if(whitelistEnabled)
         {
            WhitelistHandling.getInstance().redifyBadWords(param1);
         }
      }
      
      public static function logInput(param1:String, param2:int, param3:String = "", param4:int = -1, param5:Function = null) : void
      {
         if(!StringUtilities.isEmpty(param1))
         {
            param1 = MessageStyleUtility.removeFontCode(param1);
            LogInputFunction(param2,actorModel.actorId,BlackListUtil.getInstance().parseLocation(param3),param4,param1,param5);
         }
      }
      
      public static function logInputGroupChat(param1:String, param2:int, param3:String, param4:int = -1, param5:Function = null) : void
      {
         if(!StringUtilities.isEmpty(param1))
         {
            param1 = MessageStyleUtility.removeFontCode(param1);
            LogInputGroupChatFunction(param2,actorModel.actorId,param3,param4,param1,param5);
         }
      }
      
      public static function get whitelistEnabled() : Boolean
      {
         if(actorModel.isModerator)
         {
            return false;
         }
         if(!actorModel.isAgeRestrictions)
         {
            return false;
         }
         return true;
      }
      
      protected static function isLink(param1:String) : Boolean
      {
         var _loc3_:RegExp = null;
         if(actorModel.isModerator)
         {
            return false;
         }
         var _loc2_:Boolean = InstantBlocking.IsTextBlocked(param1);
         if(_loc2_)
         {
            MessageCommunicator.send(new MsgEvent(MSPEvent.SHOW_USER_ALERT,{
               "text":LocaleHelper.getInstance().getString("DO_NOT_SHARE_LINKS_EMAILS"),
               "title":LocaleHelper.getInstance().getString("DO_NOT_SHARE_LINKS_EMAILS_HEADER")
            }));
         }
         else
         {
            _loc3_ = /(www\.?[a-zA-Z0-9]+)|(http(s)*)/gi;
            _loc2_ = Boolean(_loc3_.test(param1));
            if(_loc2_)
            {
               MessageCommunicator.send(new MsgEvent(MSPEvent.SHOW_USER_ALERT,{
                  "text":LocaleHelper.getInstance().getString("DO_NOT_SHARE_LINKS"),
                  "title":LocaleHelper.getInstance().getString("ATTENTION")
               }));
            }
         }
         return _loc2_;
      }
      
      public static function getAllowedInputChars() : String
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(restriction == null)
         {
            _loc1_ = "";
            _loc2_ = null;
            if(!AppSettings.getInstance().isInitialized)
            {
               throw new Error("You cannot initialize the Censor before having the AppSettings ready");
            }
            _loc2_ = AppSettings.getInstance().getSetting(AppSettings.SPECIAL_INPUT_TEXT_CHARS) as String;
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.split(",");
               _loc4_ = int(_loc3_.length);
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  _loc1_ += String.fromCharCode(_loc3_[_loc5_]);
                  _loc5_++;
               }
               if(_loc1_ == null || _loc1_ == "")
               {
                  _loc1_ = " ❤♥";
               }
            }
            if(ConstantsPlatform.isIOS)
            {
               _loc1_ += NativeEmoticonSupport.getInstance().getEmoticonCharcodesAsString();
            }
            restriction = String.fromCharCode(33) + "-" + String.fromCharCode(767) + _loc1_;
         }
         return restriction;
      }
      
      public static function set mobileHelper(param1:IMobileHeper) : void
      {
         BlackListUtil.mobileHelper = param1;
      }
   }
}

