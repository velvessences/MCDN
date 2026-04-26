package com.moviestarplanet.clientcensor
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.constants.ConstantsPlatform;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.model.IActorModel;
   import com.moviestarplanet.userbehavior.utils.chatfilter.userbehaviorcontrol.PasswordCheck;
   import com.moviestarplanet.utils.translation.LocaleHelper;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class BlackListUtil
   {
      
      public static var GetRelativeBlackListPathFunction:Function;
      
      public static var actorModel:IActorModel;
      
      public static var languageMapLocaleChainMobile:String;
      
      public static var mobileHelper:IMobileHeper;
      
      private static var instance:BlackListUtil;
      
      private const characterEscapes:Array = ["$","."];
      
      private var unwantedWordsRegex:Array;
      
      private var unwantedNumbersRegex:Array;
      
      private var _unwantedWordsLiteVector:Vector.<String>;
      
      private var _badWordLocale:String;
      
      private var unwantedWordsRawGLOBAL:Array;
      
      private var unwantedWordsRawNumbersEN_US:Array;
      
      private var unwantedWordsRawEN_US:Array;
      
      private var unwantedWordsRawDA_DK:Array;
      
      private var unwantedWordsRawSV_SE:Array;
      
      private var unwantedWordsRawNB_NO:Array;
      
      private var unwantedWordsRawFI_FI:Array;
      
      private var unwantedWordsRawNL_NL:Array;
      
      private var unwantedWordsRawDE_DE:Array;
      
      private var unwantedWordsRawPL_PL:Array;
      
      private var unwantedWordsRawFR_FR:Array;
      
      private var unwantedWordsRawTR_TR:Array;
      
      private var unwantedMatchWholeWords:Array;
      
      private var usernamesBlackWords:Array;
      
      private var emailRegExp:RegExp;
      
      private var passwordTextRegExpr:RegExp;
      
      private var passwordTextDkRegExpr:RegExp;
      
      private var passwordTextSeRegExpr:RegExp;
      
      private var passwordTextNoRegExpr:RegExp;
      
      private var passwordTextFiRegExpr:RegExp;
      
      private var passwordTextDeRegExpr:RegExp;
      
      private var passwordTextNlRegExpr:RegExp;
      
      private var passwordTextFrRegExpr:RegExp;
      
      private var passwordTextTrRegExpr:RegExp;
      
      private var isInitialized:Boolean;
      
      private const blackListPostFix:String = ".blacklist.txt";
      
      private const globalBlackListFilename:String = "Global" + this.blackListPostFix;
      
      private const WORD_FILE_INDEX:int = 0;
      
      private const MATCH_WHOLE_WORD_FILE_INDEX:int = 1;
      
      private const YOUTUBE_FILE_INDEX:int = 2;
      
      private const USERNAME_FILE_INDEX:int = 3;
      
      private const ALERT_FILE_INDEX:int = 4;
      
      private const BLACKLIST_FILE_INDEX:int = 5;
      
      private const EXACT_FILE_INDEX:int = 6;
      
      private const WORD_UNWANTED_RAW_INDEX:int = 0;
      
      private const MATCH_WHOLE_WORD_UNWANTED_RAW_INDEX:int = 1;
      
      private const ALERT_UNWANTED_RAW_INDEX:int = 2;
      
      private const BLACKLIST_UNWANTED_RAW_INDEX:int = 3;
      
      private const REGEX_REGEXARRAY_INDEX:int = 0;
      
      private const ALERT_REGEXARRAY_INDEX:int = 1;
      
      private const BLACKLIST_REGEXARRAY_INDEX:int = 2;
      
      private const FRAGMENT_FILTERING_VALUE:int = 0;
      
      private const EXACT_FILTERING_VALUE:int = 1;
      
      private const TOTAL_EXACT_FILTERING_VALUE:int = 2;
      
      public const nonCharacterClass:String = "[^A-Za-z0-9åäæąáàâçćðþęèéêëğîïíłńøóöôœšśşßúüùûýÿźżžÅÄÆĄÁÀÂÇĆÐÞĘÈÉÊËĞÎÏÍŁŃØÓÖÔŒŠŚŞßÚÜÙÛÝŸŹŻŽ]";
      
      private const characterEquivalents_A:Array = new Array("a","á","Á","à","À","â","Â","4","@","/-\\","/\\","^","∂","Ă","∆");
      
      private const characterEquivalents_B:Array = new Array("b","8","|3","6","13","ß","]3");
      
      private const characterEquivalents_C:Array = new Array("c","(","<","¢","{","©","ς","Č");
      
      private const characterEquivalents_D:Array = new Array("d","|)","[)","∂","])","I>","|>","0","ð","Ð","4","Ď");
      
      private const characterEquivalents_E:Array = new Array("e","é","É","è","È","ë","Ë","ê","Ê","3","£","&","€","[-","ə","∑","Ĕ","є");
      
      private const characterEquivalents_F:Array = new Array("f","|=","]=","}","(=","Ŧ","ph","ƒ");
      
      private const characterEquivalents_G:Array = new Array("g","6","9","&","(_+","C-","ﻮ","Ğ","б","ģ");
      
      private const characterEquivalents_H:Array = new Array("h","|-|","#","]-[","[-]",")-(","(-)",":-:","}{","}-{","ђ","Ĥ");
      
      private const characterEquivalents_I:Array = new Array("i","í","Í","ì","Ì","ï","Î","î","Ï","!","1","|","¡","ι","Ĩ");
      
      private const characterEquivalents_J:Array = new Array("j","_|","_/","]","¿","</","_)","Ĵ");
      
      private const characterEquivalents_K:Array = new Array("k","X","|<","|X","|{","к","К","ќ","Ķ");
      
      private const characterEquivalents_L:Array = new Array("l","1","7","|_","£","|","|_","lJ","¬","Ĺ","ℓ");
      
      private const characterEquivalents_M:Array = new Array("m","44","/\\/\\","|\\/|","|v|","IYI","IVI","[V]","^^","nn","//\\\\//\\\\","(V)","(\\/)","/|\\","/|/|",".\\\\","/^^\\","/V\\","|^^|","м");
      
      private const characterEquivalents_N:Array = new Array("n","|\\|","/\\/","//\\\\//","~","И","[\\]","<\\>","{\\}","//","₪","]\\[","Ń","η");
      
      private const characterEquivalents_O:Array = new Array("o","ó","Ó","ò","Ò","ô","Ô","0","()","Ω","*","°","[]","¤","◊","Ő","σ","ø","Ø");
      
      private const characterEquivalents_P:Array = new Array("p","|o","|º","|>","|\"","?","9","[]D","|7","q","þ","¶","|D","ρ","ק");
      
      private const characterEquivalents_Q:Array = new Array("q","0_","0","(,)","<|","¶","9","σ","ợ");
      
      private const characterEquivalents_R:Array = new Array("r","|2","2","/2","I2","|^","|~","lz","®","|2","[z","|`","l2","Я",".-","Ŕ","г");
      
      private const characterEquivalents_S:Array = new Array("s","5","$","z","§","Ś");
      
      private const characterEquivalents_T:Array = new Array("t","7","+","-|-","1","][\'","†","Ť");
      
      private const characterEquivalents_U:Array = new Array("u","|_|","(_)","µ","[_]","\\_/","\\_\\","/_/","Ú","υ");
      
      private const characterEquivalents_V:Array = new Array("v","\\/","√","ν");
      
      private const characterEquivalents_W:Array = new Array("w","\\/\\/","vv","//","\\\\\'","\\^/","(n)","\\X/","\\|/","\\_|_/","\\//\\\\//","\\_:_/","]I[","UU","Ш","ω","ώ","Ŵ");
      
      private const characterEquivalents_X:Array = new Array("x","><","Ж","}{",")(","Ж","ץ","χ");
      
      private const characterEquivalents_Y:Array = new Array("y","j","`/","`(","-/","/","Ψ","φ","λ","Ч","¥","ÿ","ч","Ŷ","א");
      
      private const characterEquivalents_Z:Array = new Array("z","2","≥","~/_","%","7_","Ź");
      
      private const characterEquivalents_U00E6:Array = new Array("æ","Æ");
      
      private const characterEquivalents_U00E2:Array = new Array("â","Â");
      
      private const characterEquivalents_U00F8:Array = new Array("ø","Ø");
      
      private const characterEquivalents_U00E5:Array = new Array("å","Å");
      
      private const characterEquivalents_U00E4:Array = new Array("ä","Ä");
      
      private const characterEquivalents_U00F6:Array = new Array("ö","Ö");
      
      private const characterEquivalents_U0161:Array = new Array("š","Š");
      
      private const characterEquivalents_U017E:Array = new Array("ž","Ž");
      
      private const characterEquivalents_U0105:Array = new Array("ą","Ą");
      
      private const characterEquivalents_U0107:Array = new Array("ć","Ć");
      
      private const characterEquivalents_U0119:Array = new Array("ę","Ę");
      
      private const characterEquivalents_U0142:Array = new Array("ł","Ł");
      
      private const characterEquivalents_U0144:Array = new Array("ń","Ń");
      
      private const characterEquivalents_U00F3:Array = new Array("ó","Ó");
      
      private const characterEquivalents_U015B:Array = new Array("ś","Ś");
      
      private const characterEquivalents_U017A:Array = new Array("ź","Ź");
      
      private const characterEquivalents_U017C:Array = new Array("ż","Ż");
      
      private const characterEquivalents_U00FC:Array = new Array("ü","Ü");
      
      private const characterEquivalents_U011F:Array = new Array("ğ","Ğ");
      
      private const characterEquivalents_U00E7:Array = new Array("ç","Ç");
      
      private const characterEquivalents_U015F:Array = new Array("ş","Ş");
      
      private const characterEquivalents_U00E1:Array = new Array("á","Á");
      
      private const characterEquivalents_U00F0:Array = new Array("ð","Ð");
      
      private const characterEquivalents_U00E9:Array = new Array("é","É");
      
      private const characterEquivalents_U00ED:Array = new Array("í","Í");
      
      private const characterEquivalents_U00FA:Array = new Array("ú","Ú");
      
      private const characterEquivalents_U00FD:Array = new Array("ý","Ý");
      
      private const characterEquivalents_U00FE:Array = new Array("þ","Þ");
      
      private const characterEquivalents_U00E0:Array = new Array("à","À");
      
      private const characterEquivalents_U00E8:Array = new Array("è","È");
      
      private const characterEquivalents_U00F9:Array = new Array("ù","Ù");
      
      private const characterEquivalents_U00EB:Array = new Array("ë","Ë");
      
      private const characterEquivalents_U00EF:Array = new Array("ï","Ï");
      
      private const characterEquivalents_U00FF:Array = new Array("ÿ","Ÿ");
      
      private const characterEquivalents_U00F1:Array = new Array("ñ","Ñ");
      
      private const characterEquivalents_U00EA:Array = new Array("ê","Ê");
      
      private const characterEquivalents_U00EE:Array = new Array("î","Î");
      
      private const characterEquivalents_U00F4:Array = new Array("ô","Ô");
      
      private const characterEquivalents_U0153:Array = new Array("œ","Œ");
      
      private const characterEquivalents_U00FB:Array = new Array("û","Û");
      
      private const characterEquivalents_U00DF:Array = new Array("ß","ß");
      
      private const alphabet_en_US:Array = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z");
      
      private const alphabet_nb_NO:Array = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","æ","ø","å");
      
      private const alphabet_sv_SE:Array = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","å","ä","ö");
      
      private const alphabet_da_DK_plus_Dagbjortish:Array = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","æ","ø","å","á","ð","é","í","ó","ú","ý","þ");
      
      private const alphabet_de_DE:Array = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","ä","ö","ü","ß");
      
      private const alphabet_nl_NL:Array = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z");
      
      private const alphabet_fi_FI:Array = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","š","ž","å","ä","ö");
      
      private const alphabet_pl_PL:Array = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","ą","ć","ę","ł","ń","ó","ś","ź","ż");
      
      private const alphabet_fr_FR:Array = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","à","â","ä","è","é","ê","ë","î","ï","ô","œ","ù","û","ü","ÿ","ç");
      
      private const alphabet_tr_TR:Array = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","ç","ğ","ö","ş","ü");
      
      private var charactersEquivalents:Dictionary;
      
      private var loadedAlphabetLocale:String = "";
      
      private var passwordRegExpr:RegExp;
      
      public function BlackListUtil(param1:SingletonBlocker)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Use getInstance().");
         }
         this.unwantedWordsRawGLOBAL = new Array();
         this.unwantedWordsRawNumbersEN_US = new Array();
         this.unwantedWordsRawEN_US = new Array();
         this.unwantedWordsRawDA_DK = new Array();
         this.unwantedWordsRawSV_SE = new Array();
         this.unwantedWordsRawNB_NO = new Array();
         this.unwantedWordsRawFI_FI = new Array();
         this.unwantedWordsRawNL_NL = new Array();
         this.unwantedWordsRawDE_DE = new Array();
         this.unwantedWordsRawPL_PL = new Array();
         this.unwantedWordsRawFR_FR = new Array();
         this.unwantedWordsRawTR_TR = new Array();
         this.unwantedMatchWholeWords = new Array();
         this.usernamesBlackWords = new Array();
         this.emailRegExp = /([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)/g;
         this.passwordTextRegExpr = /password/gi;
         this.passwordTextDkRegExpr = /kode/gi;
         this.passwordTextSeRegExpr = /lösenord/gi;
         this.passwordTextNoRegExpr = /passord/gi;
         this.passwordTextFiRegExpr = /salasana/gi;
         this.passwordTextDeRegExpr = /passwort/gi;
         this.passwordTextNlRegExpr = /wachtwoord/gi;
         this.passwordTextFrRegExpr = /mot de passe/gi;
         this.passwordTextTrRegExpr = /şifre/gi;
      }
      
      public static function getInstance() : BlackListUtil
      {
         if(instance == null)
         {
            instance = new BlackListUtil(new SingletonBlocker());
         }
         return instance;
      }
      
      private function loadBlackListFile(param1:String, param2:Function) : void
      {
         var filename:String = null;
         var csv:CSV = null;
         var completeHandler:Function = null;
         var failHandler:Function = null;
         var countryCode:String = param1;
         var callBack:Function = param2;
         completeHandler = function(param1:Event):void
         {
            addWordsFromFile(csv,countryCode.toLowerCase());
            if(mobileHelper != null)
            {
               mobileHelper.saveLocalCSV(countryCode,csv);
            }
            loadGlobalBlackListFile(callBack);
         };
         failHandler = function(param1:Event):void
         {
            trace("failed:" + countryCode);
            trace(filename + " (black list) file does not exist.");
            loadGlobalBlackListFile(callBack);
         };
         filename = countryCode + "/" + countryCode + this.blackListPostFix;
         var _url:String = GetRelativeBlackListPathFunction(filename);
         csv = new CSV();
         csv.recordsetDelimiter = BlackListConstants.RECORDSED_DELIMITER;
         csv.embededHeader = BlackListConstants.EMBEDED_HEADER;
         csv.fieldSeperator = BlackListConstants.FIELD_SEPERATOR;
         csv.fieldEnclosureToken = BlackListConstants.FIELD_ENCLOSURE_TOKEN;
         csv.addEventListener(Event.COMPLETE,completeHandler);
         csv.addEventListener(IOErrorEvent.IO_ERROR,failHandler);
         csv.load(new URLRequest(_url));
      }
      
      private function loadGlobalBlackListFile(param1:Function) : void
      {
         var filename:String = null;
         var csv:CSV = null;
         var completeHandler:Function = null;
         var failHandler:Function = null;
         var callBack:Function = param1;
         completeHandler = function(param1:Event):void
         {
            addWordsFromFile(csv,"global",callBack);
            if(mobileHelper != null)
            {
               mobileHelper.saveGlobalCSV(csv);
            }
         };
         failHandler = function(param1:Event):void
         {
            trace("failed:global");
            trace(filename + " (black list) file does not exist.");
            if(callBack != null)
            {
               callBack();
            }
         };
         filename = "Global/" + this.globalBlackListFilename;
         var _url:String = GetRelativeBlackListPathFunction(filename);
         csv = new CSV();
         csv.recordsetDelimiter = BlackListConstants.RECORDSED_DELIMITER;
         csv.embededHeader = BlackListConstants.EMBEDED_HEADER;
         csv.fieldSeperator = BlackListConstants.FIELD_SEPERATOR;
         csv.fieldEnclosureToken = BlackListConstants.FIELD_ENCLOSURE_TOKEN;
         csv.addEventListener(Event.COMPLETE,completeHandler);
         csv.addEventListener(IOErrorEvent.IO_ERROR,failHandler);
         csv.load(new URLRequest(_url));
      }
      
      private function addWord(param1:Array, param2:String, param3:int, param4:Boolean, param5:Boolean, param6:int) : void
      {
         if(param1.length <= param6 || param1[param6][0] != param2)
         {
            param1.push([param2,param3,param4,param5]);
         }
      }
      
      private function addWordsFromFile(param1:CSV, param2:String, param3:Function = null) : void
      {
         var _loc6_:int = 0;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:String = null;
         var _loc10_:RegExp = null;
         var _loc4_:Array = null;
         param2 = param2.toLocaleLowerCase();
         switch(param2)
         {
            case "global":
               _loc4_ = this.unwantedWordsRawGLOBAL;
               break;
            case "de_de":
               _loc4_ = this.unwantedWordsRawDE_DE;
               break;
            case "en_us":
               _loc4_ = this.unwantedWordsRawEN_US;
               break;
            case "nl_nl":
               _loc4_ = this.unwantedWordsRawNL_NL;
               break;
            case "pl_pl":
               _loc4_ = this.unwantedWordsRawPL_PL;
               break;
            case "fr_fr":
               _loc4_ = this.unwantedWordsRawFR_FR;
               break;
            case "tr_tr":
               _loc4_ = this.unwantedWordsRawTR_TR;
               break;
            case "sv_se":
               _loc4_ = this.unwantedWordsRawSV_SE;
               break;
            case "da_dk":
               _loc4_ = this.unwantedWordsRawDA_DK;
               break;
            case "nb_no":
               _loc4_ = this.unwantedWordsRawNB_NO;
               break;
            case "fi_fi":
               _loc4_ = this.unwantedWordsRawFI_FI;
         }
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:int = 0;
         while(_loc5_ < param1.data.length)
         {
            _loc6_ = param1.data[_loc5_][this.MATCH_WHOLE_WORD_FILE_INDEX].toString() == "1" ? this.EXACT_FILTERING_VALUE : this.FRAGMENT_FILTERING_VALUE;
            if(param1.data[_loc5_].length > this.EXACT_FILE_INDEX)
            {
               _loc8_ = param1.data[_loc5_][this.EXACT_FILE_INDEX].toString() == "1";
               if(_loc8_)
               {
                  _loc6_ = this.TOTAL_EXACT_FILTERING_VALUE;
               }
            }
            _loc7_ = true;
            if(param1.data[_loc5_].length > this.BLACKLIST_FILE_INDEX)
            {
               _loc7_ = param1.data[_loc5_][this.BLACKLIST_FILE_INDEX].toString() == "1";
            }
            this.addWord(_loc4_,param1.data[_loc5_][this.WORD_FILE_INDEX].toString(),_loc6_,param1.data[_loc5_][this.ALERT_FILE_INDEX].toString() == "1",_loc7_,_loc5_);
            if(param1.data[_loc5_][this.USERNAME_FILE_INDEX].toString() == "1")
            {
               _loc9_ = this.generateBlacklistRegexString(param1.data[_loc5_][this.WORD_FILE_INDEX],_loc6_);
               _loc10_ = this.generateFilteringRegExp(_loc9_,_loc6_);
               if(_loc10_ != null)
               {
                  this.usernamesBlackWords.push(_loc10_);
               }
            }
            _loc5_++;
         }
         if(param3 != null)
         {
            param3();
         }
      }
      
      public function prepareUnwantedWordsRegex(param1:Function = null) : void
      {
         var loadFromServer:Function;
         var onCSVReady:Function;
         var onCSVLoadFail:Function;
         var loadInstantBlockingDone:Function = null;
         var loadDone:Function = null;
         var onFinish:Function = param1;
         if(this.unwantedWordsRegex == null || this._badWordLocale != this.localeChain)
         {
            loadFromServer = function():void
            {
               InstantBlocking.loadInstantBlockingFile(loadInstantBlockingDone);
            };
            loadInstantBlockingDone = function():void
            {
               loadBlackListFile(_badWordLocale.toLowerCase(),loadDone);
               if(mobileHelper != null)
               {
                  mobileHelper.saveInstantBlocking(InstantBlocking.instantBlockingData);
               }
            };
            loadDone = function():void
            {
               if(unwantedWordsRegex.length > 0)
               {
                  unwantedWordsRegex.length = 0;
               }
               if(unwantedMatchWholeWords.length > 0)
               {
                  unwantedMatchWholeWords.length = 0;
               }
               addLocaleUnwantedWords(unwantedWordsRawGLOBAL);
               switch(_badWordLocale.toLowerCase())
               {
                  case "de_de":
                     addLocaleUnwantedWords(unwantedWordsRawDE_DE);
                     break;
                  case "en_us":
                     addLocaleUnwantedWords(unwantedWordsRawEN_US);
                     break;
                  case "nl_nl":
                     addLocaleUnwantedWords(unwantedWordsRawNL_NL);
                     break;
                  case "pl_pl":
                     addLocaleUnwantedWords(unwantedWordsRawPL_PL);
                     break;
                  case "fr_fr":
                     addLocaleUnwantedWords(unwantedWordsRawFR_FR);
                     break;
                  case "sv_se":
                     addLocaleUnwantedWords(unwantedWordsRawSV_SE);
                     break;
                  case "da_dk":
                     addLocaleUnwantedWords(unwantedWordsRawDA_DK);
                     break;
                  case "nb_no":
                     addLocaleUnwantedWords(unwantedWordsRawNB_NO);
                     break;
                  case "fi_fi":
                     addLocaleUnwantedWords(unwantedWordsRawFI_FI);
                     break;
                  case "tr_tr":
                     addLocaleUnwantedWords(unwantedWordsRawTR_TR);
               }
               if(onFinish != null)
               {
                  onFinish();
               }
            };
            this._badWordLocale = this.localeChain;
            if(this.unwantedWordsRegex)
            {
               if(this.unwantedWordsRegex.length > 0)
               {
                  this.unwantedWordsRegex.length = 0;
               }
            }
            else
            {
               this.unwantedWordsRegex = new Array();
            }
            if(this.unwantedNumbersRegex)
            {
               if(this.unwantedNumbersRegex.length > 0)
               {
                  this.unwantedNumbersRegex.length = 0;
               }
            }
            else
            {
               this.unwantedNumbersRegex = new Array();
            }
            if(this.usernamesBlackWords)
            {
               if(this.usernamesBlackWords.length > 0)
               {
                  this.usernamesBlackWords.length = 0;
               }
            }
            else
            {
               this.usernamesBlackWords = new Array();
            }
            if(this._unwantedWordsLiteVector)
            {
               if(this._unwantedWordsLiteVector.length > 0)
               {
                  this._unwantedWordsLiteVector.length = 0;
               }
            }
            else
            {
               this._unwantedWordsLiteVector = new Vector.<String>();
            }
            if(mobileHelper != null)
            {
               onCSVReady = function():void
               {
                  if(mobileHelper.localCSV == null || mobileHelper.globalCSV == null || mobileHelper.instantBlockingData == null)
                  {
                     loadFromServer();
                  }
                  else
                  {
                     addWordsFromFile(mobileHelper.globalCSV,"global");
                     addWordsFromFile(mobileHelper.localCSV,_badWordLocale);
                     InstantBlocking.setupInstantBlockingData(mobileHelper.instantBlockingData);
                     loadDone();
                  }
               };
               onCSVLoadFail = function():void
               {
                  loadFromServer();
               };
               mobileHelper.initalizeBlacklistCSVFromCache(this._badWordLocale,onCSVReady,onCSVLoadFail);
               return;
            }
            loadFromServer();
         }
         else if(onFinish != null)
         {
            onFinish();
         }
      }
      
      public function createUnwantedWordRegExprString(param1:String, param2:Boolean = true, param3:Boolean = true) : String
      {
         var _loc4_:String = null;
         var _loc5_:String = "";
         var _loc6_:int = 0;
         while(_loc6_ < param1.length)
         {
            if(param1.charAt(_loc6_) != "\\")
            {
               _loc4_ = param1.charAt(_loc6_);
               if(this.characterEscapes.indexOf(_loc4_) >= 0)
               {
                  _loc4_ = "\\" + _loc4_;
               }
               _loc5_ += param3 ? this.getCharacterReplacingGroupRegex(_loc4_) + "+" : _loc4_;
               if(param2 && _loc6_ < param1.length - 1)
               {
                  _loc5_ += "[^A-Za-z0-9æøåäöšžąćęłńóśźżüßğçşáðéíóúýþöàèùëïüÿñÆØÅÄÖŠŽĄĆĘŁŃÓŚŹŻÜßĞÇŞ]{0,5}?";
               }
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      private function generateFragmentFilteringRegExp(param1:String) : RegExp
      {
         return new RegExp(param1,"gi");
      }
      
      private function generateExactFilteringRegExp(param1:String) : RegExp
      {
         return new RegExp("(?:" + this.nonCharacterClass + "|^)" + param1 + "(?:" + this.nonCharacterClass + "|$)","gi");
      }
      
      private function generateTotalExactFilteringRegExp(param1:String) : RegExp
      {
         return new RegExp("(?:" + this.nonCharacterClass + "|^)" + param1 + "(?:" + this.nonCharacterClass + "|$)","gi");
      }
      
      private function generateFilteringRegExp(param1:String, param2:int) : RegExp
      {
         switch(param2)
         {
            case this.FRAGMENT_FILTERING_VALUE:
               return this.generateFragmentFilteringRegExp(param1);
            case this.EXACT_FILTERING_VALUE:
               return this.generateExactFilteringRegExp(param1);
            case this.TOTAL_EXACT_FILTERING_VALUE:
               return this.generateTotalExactFilteringRegExp(param1);
            default:
               return null;
         }
      }
      
      private function generateBlacklistRegexString(param1:String, param2:int) : String
      {
         switch(param2)
         {
            case this.FRAGMENT_FILTERING_VALUE:
               return this.createUnwantedWordRegExprString(param1);
            case this.EXACT_FILTERING_VALUE:
               return this.createUnwantedWordRegExprString(param1);
            case this.TOTAL_EXACT_FILTERING_VALUE:
               return this.createUnwantedWordRegExprString(param1,false,false);
            default:
               return null;
         }
      }
      
      private function addLocaleUnwantedWords(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:RegExp = null;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         while(_loc7_ < param1.length)
         {
            _loc5_ = true;
            _loc6_ = true;
            this._unwantedWordsLiteVector.push(param1[_loc7_][this.WORD_UNWANTED_RAW_INDEX]);
            _loc2_ = int(param1[_loc7_][this.MATCH_WHOLE_WORD_UNWANTED_RAW_INDEX] as int);
            _loc3_ = this.generateBlacklistRegexString(param1[_loc7_][this.WORD_UNWANTED_RAW_INDEX],_loc2_);
            _loc4_ = this.generateFilteringRegExp(_loc3_,_loc2_);
            if(param1[_loc7_].length > this.ALERT_UNWANTED_RAW_INDEX)
            {
               _loc5_ = Boolean(param1[_loc7_][this.ALERT_UNWANTED_RAW_INDEX] as Boolean);
            }
            if(param1[_loc7_].length > this.BLACKLIST_UNWANTED_RAW_INDEX)
            {
               _loc6_ = Boolean(param1[_loc7_][this.BLACKLIST_UNWANTED_RAW_INDEX] as Boolean);
            }
            this.unwantedWordsRegex.push([_loc4_,_loc5_,_loc6_]);
            if(_loc6_)
            {
               this.unwantedMatchWholeWords.push(new RegExp("(?:" + this.nonCharacterClass + "|^)" + _loc3_ + "(?:" + this.nonCharacterClass + "|$)","gi"));
            }
            _loc7_++;
         }
      }
      
      private function getCharacterEquivalentsArrayByLetter(param1:String) : Array
      {
         switch(param1)
         {
            case "a":
               return this.characterEquivalents_A;
            case "b":
               return this.characterEquivalents_B;
            case "c":
               return this.characterEquivalents_C;
            case "d":
               return this.characterEquivalents_D;
            case "e":
               return this.characterEquivalents_E;
            case "f":
               return this.characterEquivalents_F;
            case "g":
               return this.characterEquivalents_G;
            case "h":
               return this.characterEquivalents_H;
            case "i":
               return this.characterEquivalents_I;
            case "j":
               return this.characterEquivalents_J;
            case "k":
               return this.characterEquivalents_K;
            case "l":
               return this.characterEquivalents_L;
            case "m":
               return this.characterEquivalents_M;
            case "n":
               return this.characterEquivalents_N;
            case "o":
               return this.characterEquivalents_O;
            case "p":
               return this.characterEquivalents_P;
            case "q":
               return this.characterEquivalents_Q;
            case "r":
               return this.characterEquivalents_R;
            case "s":
               return this.characterEquivalents_S;
            case "t":
               return this.characterEquivalents_T;
            case "u":
               return this.characterEquivalents_U;
            case "v":
               return this.characterEquivalents_V;
            case "w":
               return this.characterEquivalents_W;
            case "x":
               return this.characterEquivalents_X;
            case "y":
               return this.characterEquivalents_Y;
            case "z":
               return this.characterEquivalents_Z;
            case "å":
               return this.characterEquivalents_U00E5;
            case "æ":
               return this.characterEquivalents_U00E6;
            case "ä":
               return this.characterEquivalents_U00E4;
            case "ą":
               return this.characterEquivalents_U0105;
            case "â":
               return this.characterEquivalents_U00E2;
            case "á":
               return this.characterEquivalents_U00E1;
            case "à":
               return this.characterEquivalents_U00E0;
            case "ć":
               return this.characterEquivalents_U0107;
            case "ç":
               return this.characterEquivalents_U00E7;
            case "þ":
               return this.characterEquivalents_U00FE;
            case "ð":
               return this.characterEquivalents_U00F0;
            case "é":
               return this.characterEquivalents_U00E9;
            case "ę":
               return this.characterEquivalents_U0119;
            case "è":
               return this.characterEquivalents_U00E8;
            case "ê":
               return this.characterEquivalents_U00EA;
            case "ë":
               return this.characterEquivalents_U00EB;
            case "ï":
               return this.characterEquivalents_U00EF;
            case "î":
               return this.characterEquivalents_U00EE;
            case "í":
               return this.characterEquivalents_U00ED;
            case "ğ":
               return this.characterEquivalents_U011F;
            case "ł":
               return this.characterEquivalents_U0142;
            case "ñ":
               return this.characterEquivalents_U00F1;
            case "ń":
               return this.characterEquivalents_U0144;
            case "ó":
               return this.characterEquivalents_U00F3;
            case "ø":
               return this.characterEquivalents_U00F8;
            case "ö":
               return this.characterEquivalents_U00F6;
            case "ô":
               return this.characterEquivalents_U00F4;
            case "œ":
               return this.characterEquivalents_U0153;
            case "ş":
               return this.characterEquivalents_U015F;
            case "ś":
               return this.characterEquivalents_U015B;
            case "š":
               return this.characterEquivalents_U0161;
            case "ù":
               return this.characterEquivalents_U00F9;
            case "ú":
               return this.characterEquivalents_U00FA;
            case "ü":
               return this.characterEquivalents_U00FC;
            case "û":
               return this.characterEquivalents_U00FB;
            case "ÿ":
               return this.characterEquivalents_U00FF;
            case "ý":
               return this.characterEquivalents_U00FD;
            case "ž":
               return this.characterEquivalents_U017E;
            case "ź":
               return this.characterEquivalents_U017A;
            case "ż":
               return this.characterEquivalents_U017C;
            case "ß":
               return this.characterEquivalents_U00DF;
            default:
               return null;
         }
      }
      
      private function escapeRegexMetacharacters(param1:String) : String
      {
         var _loc3_:String = null;
         var _loc2_:String = "";
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1.charAt(_loc4_);
            if(_loc3_ == "^" || _loc3_ == "$" || _loc3_ == "." || _loc3_ == "*" || _loc3_ == "\\" || _loc3_ == "+" || _loc3_ == "?" || _loc3_ == "|" || _loc3_ == "-" || _loc3_ == "(" || _loc3_ == ")" || _loc3_ == "[" || _loc3_ == "]" || _loc3_ == "{" || _loc3_ == "}")
            {
               _loc2_ += "\\";
            }
            if(_loc3_ == "\\")
            {
               _loc2_ += "\\";
            }
            else
            {
               _loc2_ += _loc3_;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function GetCharactersEquivalentsDictionary() : Dictionary
      {
         var _loc2_:String = null;
         var _loc4_:Array = null;
         var _loc6_:int = 0;
         if(this.loadedAlphabetLocale != this.localeChain)
         {
            this.charactersEquivalents = null;
         }
         if(this.charactersEquivalents != null)
         {
            return this.charactersEquivalents;
         }
         this.charactersEquivalents = new Dictionary();
         var _loc1_:Array = this.GetUserLocaleAlphabet();
         var _loc3_:Array = new Array();
         var _loc5_:int = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc5_];
            _loc3_.length = 0;
            _loc4_ = this.getCharacterEquivalentsArrayByLetter(_loc2_);
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length)
            {
               _loc3_.push(this.escapeRegexMetacharacters(_loc4_[_loc6_]));
               _loc6_++;
            }
            this.charactersEquivalents[_loc2_] = "(" + _loc3_.join("|") + ")";
            _loc5_++;
         }
         return this.charactersEquivalents;
      }
      
      public function getCharacterReplacingGroupRegex(param1:String) : String
      {
         if(this.GetCharactersEquivalentsDictionary()[param1] != null)
         {
            return this.GetCharactersEquivalentsDictionary()[param1];
         }
         return param1;
      }
      
      private function GetUserLocaleAlphabet() : Array
      {
         var _loc1_:String = this.localeChain;
         this.loadedAlphabetLocale = _loc1_;
         switch(_loc1_)
         {
            case "en_US":
               return this.alphabet_en_US;
            case "nb_NO":
               return this.alphabet_nb_NO;
            case "sv_SE":
               return this.alphabet_sv_SE;
            case "da_DK":
               return this.alphabet_da_DK_plus_Dagbjortish;
            case "de_DE":
               return this.alphabet_de_DE;
            case "nl_NL":
               return this.alphabet_nl_NL;
            case "fi_FI":
               return this.alphabet_fi_FI;
            case "pl_PL":
               return this.alphabet_pl_PL;
            case "fr_FR":
               return this.alphabet_fr_FR;
            case "tr_TR":
               return this.alphabet_tr_TR;
            default:
               return this.alphabet_en_US;
         }
      }
      
      private function IgnoreMatchWholeWord(param1:String) : Boolean
      {
         var _loc2_:String = param1.substr(1,1);
         if(_loc2_ == "$")
         {
            return true;
         }
         _loc2_ = param1.substr(4,1);
         if(_loc2_ == "$")
         {
            return true;
         }
         _loc2_ = param1.substr(param1.length - 1,1);
         if(_loc2_ == "$")
         {
            return true;
         }
         _loc2_ = param1.substr(param1.length - 2,1);
         if(_loc2_ == "$")
         {
            return true;
         }
         _loc2_ = param1.substr(0,1);
         if(_loc2_ == "@")
         {
            return true;
         }
         _loc2_ = param1.substr(param1.length - 1,1);
         if(_loc2_ == "@")
         {
            return true;
         }
         return false;
      }
      
      public function getVovelAccentRegex(param1:String) : String
      {
         switch(param1)
         {
            case "a":
               return "(a|á|à|â)";
            case "e":
               return "(e|é|è|ë|ê)";
            case "i":
               return "(i|í|ì|ï|î)";
            case "o":
               return "(o|ó|ò|ô)";
            case "u":
               return "(u|ú|ù|û)";
            case "y":
               return "(y|ý|ÿ)";
            case "s":
               return "(s)";
            default:
               return param1;
         }
      }
      
      public function getBlacklistMatches(param1:String) : Array
      {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         if(actorModel.isModerator)
         {
            return [];
         }
         this.prepareUnwantedWordsRegex();
         var _loc2_:Array = new Array();
         var _loc5_:int = 0;
         while(_loc5_ < this.unwantedMatchWholeWords.length)
         {
            _loc3_ = param1.replace("$","S").match(this.unwantedMatchWholeWords[_loc5_] as RegExp);
            if(_loc3_ != null && _loc3_.length > 0)
            {
               _loc6_ = true;
               _loc7_ = 0;
               while(_loc7_ < _loc3_.length)
               {
                  _loc4_ = _loc3_[_loc7_] as String;
                  if(_loc4_ != null)
                  {
                     if(!_loc4_.match(/^[\d\s]*$/))
                     {
                        _loc6_ = false;
                     }
                  }
                  _loc7_++;
               }
               if(!_loc6_)
               {
                  _loc2_ = _loc2_.concat(_loc3_);
               }
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function filterTextForUnwantedWords(param1:String, param2:Boolean = true) : BlackWordAlert
      {
         var _loc3_:RegExp = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc10_:int = 0;
         if(actorModel.isModerator)
         {
            return new BlackWordAlert(param1);
         }
         param1 = param1.replace(this.emailRegExp,"***email***");
         var _loc7_:int = 0;
         this.prepareUnwantedWordsRegex();
         var _loc8_:String = param1;
         var _loc9_:int = 0;
         while(_loc9_ < this.unwantedWordsRegex.length)
         {
            if(this.unwantedWordsRegex[_loc9_][this.ALERT_REGEXARRAY_INDEX])
            {
               _loc3_ = this.unwantedWordsRegex[_loc9_][this.REGEX_REGEXARRAY_INDEX] as RegExp;
               _loc4_ = param1.match(_loc3_);
               if(_loc4_ != null && _loc4_.length > 0)
               {
                  _loc7_ += _loc4_.length;
               }
            }
            if(this.unwantedWordsRegex[_loc9_][this.BLACKLIST_REGEXARRAY_INDEX])
            {
               param1 = param1.replace("$","S");
               _loc5_ = param1.match(this.unwantedWordsRegex[_loc9_][this.REGEX_REGEXARRAY_INDEX] as RegExp);
               if(_loc5_ != null && _loc5_.length > 0)
               {
                  _loc10_ = 0;
                  while(_loc10_ < _loc5_.length)
                  {
                     _loc6_ = _loc5_[_loc10_];
                     if(!(_loc6_ != null && Boolean(_loc6_.match(/^[\d\s]*$/))))
                     {
                        if(_loc6_ != null)
                        {
                           _loc6_ = _loc6_.replace(/^\s+|\s+$/gs,"");
                        }
                        param1 = this.replaceAll(param1,_loc6_,"***");
                     }
                     _loc10_++;
                  }
               }
            }
            _loc9_++;
         }
         if(param2)
         {
            _loc10_ = 0;
            while(_loc10_ < this.unwantedNumbersRegex.length)
            {
               param1 = param1.replace(this.unwantedNumbersRegex[_loc10_] as RegExp,"***");
               _loc10_++;
            }
         }
         if(param1.indexOf("***") != -1)
         {
            return new BlackWordAlert(param1,_loc7_);
         }
         return new BlackWordAlert(_loc8_,_loc7_);
      }
      
      public function filterTextForUnwantedWordsLite(param1:String, param2:Boolean = true) : BlackWordAlert
      {
         var _loc9_:int = 0;
         if(actorModel.isModerator)
         {
            return new BlackWordAlert(param1);
         }
         if(param1 == null)
         {
            return new BlackWordAlert("");
         }
         param1 = param1.replace(this.emailRegExp,"***email***");
         var _loc3_:int = 0;
         this.prepareUnwantedWordsRegex();
         var _loc4_:String = param1;
         var _loc5_:Array = param1.split(" ");
         var _loc6_:Vector.<String> = new Vector.<String>();
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc6_[_loc7_] = _loc5_[_loc7_].toLowerCase();
            _loc7_++;
         }
         var _loc8_:int = 0;
         while(_loc8_ < this._unwantedWordsLiteVector.length)
         {
            _loc9_ = 0;
            while(_loc9_ < _loc5_.length)
            {
               if(_loc6_[_loc9_] == this._unwantedWordsLiteVector[_loc8_])
               {
                  _loc3_++;
                  _loc5_[_loc9_] = "***";
               }
               _loc9_++;
            }
            _loc8_++;
         }
         param1 = _loc5_.join(" ");
         if(param1.indexOf("***") != -1)
         {
            return new BlackWordAlert(param1,_loc3_);
         }
         return new BlackWordAlert(_loc4_,_loc3_);
      }
      
      private function replaceAll(param1:String, param2:String, param3:String) : String
      {
         if(param1 == null)
         {
            return param1;
         }
         return param1.split(param2).join(param3);
      }
      
      public function countAlertWords(param1:String) : Array
      {
         var _loc3_:RegExp = null;
         var _loc4_:Array = null;
         var _loc5_:AlertWordCounter = null;
         this.prepareUnwantedWordsRegex();
         var _loc2_:Array = new Array();
         var _loc6_:int = 0;
         while(_loc6_ < this.unwantedWordsRegex.length)
         {
            if(this.unwantedWordsRegex[_loc6_][this.ALERT_REGEXARRAY_INDEX])
            {
               _loc3_ = this.unwantedWordsRegex[_loc6_][this.REGEX_REGEXARRAY_INDEX] as RegExp;
               _loc4_ = param1.match(_loc3_);
               if(_loc4_ != null && _loc4_.length > 0)
               {
                  _loc5_ = new AlertWordCounter();
                  _loc5_.Word = _loc4_[0];
                  _loc5_.Counter = _loc4_.length;
                  _loc2_.push(_loc5_);
               }
            }
            _loc6_++;
         }
         return _loc2_;
      }
      
      public function IsUsernameBlackWord(param1:String) : Boolean
      {
         var _loc2_:RegExp = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.usernamesBlackWords.length)
         {
            _loc2_ = this.usernamesBlackWords[_loc3_] as RegExp;
            if(_loc2_ != null)
            {
               _loc2_.lastIndex = 0;
               if(_loc2_.test(param1))
               {
                  return true;
               }
            }
            _loc3_++;
         }
         return false;
      }
      
      public function containsPassword(param1:String) : int
      {
         if(!actorModel.isLoggedIn || actorModel.isModerator)
         {
            return 0;
         }
         var _loc2_:Boolean = PasswordCheck.containsUserPassword(param1,actorModel.actorPassword);
         if(_loc2_)
         {
            MessageCommunicator.send(new MsgEvent(MSPEvent.SHOW_USER_ALERT_AND_SAFETY_SCREEN,{
               "text":LocaleHelper.getInstance().getString("DO_NOT_SHARE2"),
               "title":LocaleHelper.getInstance().getString("DO_NOT_SHARE")
            }));
         }
         var _loc3_:Boolean = PasswordCheck.containsWordPassword(param1);
         if(_loc3_)
         {
            MessageCommunicator.send(new MsgEvent(MSPEvent.SHOW_USER_ALERT_AND_SAFETY_SCREEN,{
               "text":LocaleHelper.getInstance().getString("WARNING_PASSWORD"),
               "title":LocaleHelper.getInstance().getString("WARNING")
            }));
         }
         if(_loc2_)
         {
            return 1;
         }
         if(_loc3_)
         {
            return 2;
         }
         return 0;
      }
      
      public function parseLocation(param1:String) : int
      {
         if(param1.length == 0)
         {
            return -1;
         }
         var _loc2_:Array = param1.match(/\d{3,}/);
         if(_loc2_ != null && _loc2_.length == 1)
         {
            return parseInt(_loc2_[0]);
         }
         return -1;
      }
      
      private function getDateString() : String
      {
         var _loc1_:Date = new Date();
         return _loc1_.fullYearUTC.toString() + "_" + _loc1_.monthUTC.toString() + "_" + _loc1_.dateUTC.toString();
      }
      
      private function get localeChain() : String
      {
         if(ConstantsPlatform.isWeb)
         {
            return Config.GetLanguage;
         }
         return languageMapLocaleChainMobile;
      }
   }
}

class SingletonBlocker
{
   
   public function SingletonBlocker()
   {
      super();
   }
}
