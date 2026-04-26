package com.moviestarplanet.clientcensor
{
   import com.adobe.linguistics.spelling.HunspellDictionary;
   import com.adobe.linguistics.spelling.SpellChecker;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.emoticon.utility.EmoticonUtility;
   import com.moviestarplanet.userbehavior.IRedifyableTextInputComponent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   
   public class WhiteListBase
   {
      
      public static var instance:WhiteListBase;
      
      private static var sp:SpellChecker;
      
      protected static var hunspeller:HunspellDictionary;
      
      private static var wordsList:Vector.<String>;
      
      protected static var _initalizing:Boolean = false;
      
      private var currentCulture:String;
      
      private const EXTRA_CHARS_REGEX:RegExp = /[\-]/g;
      
      protected var lastRedifiedField:DisplayObject;
      
      public function WhiteListBase(param1:Function)
      {
         super();
         hunspeller = new HunspellDictionary();
         this.currentCulture = Config.GetLanguage;
         wordsList = new Vector.<String>();
         if(param1 != null)
         {
            param1();
         }
      }
      
      protected static function hasLoadedFilter() : Boolean
      {
         return sp != null;
      }
      
      public static function addWordToWhiteList(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1 = param1.toLowerCase();
         if(hasLoadedFilter())
         {
            hunspeller.squigglyDictionary.addWord(param1);
         }
         else
         {
            wordsList.push(param1);
         }
      }
      
      protected function initialize() : void
      {
         if(!_initalizing)
         {
            _initalizing = true;
            this.initializeWithLanguage(this.currentCulture);
         }
      }
      
      public function initializeWithLanguage(param1:String) : void
      {
         var _loc2_:String = "dictionaries/" + param1 + "/" + param1 + ".aff.txt";
         var _loc3_:String = "dictionaries/" + param1 + "/" + param1 + ".dict.txt?ver=05032012";
         hunspeller.load(_loc2_,_loc3_);
         hunspeller.addEventListener(Event.COMPLETE,this.handleLoadComplete);
         hunspeller.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         _initalizing = false;
         hunspeller.removeEventListener(Event.COMPLETE,this.handleLoadComplete);
         hunspeller.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         throw new Error("the Whitelist Coudnt Be loaded. " + param1.text);
      }
      
      public function reloadWhitelist(param1:String) : void
      {
         if(instance != null)
         {
            this.initializeWithLanguage(param1);
         }
      }
      
      protected function handleLoadComplete(param1:Event) : void
      {
         hunspeller.removeEventListener(Event.COMPLETE,this.handleLoadComplete);
         hunspeller.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         sp = new SpellChecker(hunspeller);
         this.addExtraWords();
      }
      
      private function addExtraWords() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = int(wordsList.length);
         while(_loc1_ < _loc2_)
         {
            hunspeller.squigglyDictionary.addWord(wordsList[_loc1_]);
            _loc1_++;
         }
         wordsList.length = 0;
         this.setupUserSpecificWordList();
      }
      
      private function checkAndInitialize() : Boolean
      {
         if(!hasLoadedFilter())
         {
            this.initialize();
            return true;
         }
         return false;
      }
      
      public function redifyBadWords(param1:IRedifyableTextInputComponent, param2:Boolean = true) : Boolean
      {
         var onBadWord:Function = null;
         var inputCtrl:IRedifyableTextInputComponent = param1;
         var checkAge:Boolean = param2;
         onBadWord = function(param1:int, param2:int):void
         {
            inputCtrl.doRedify([[param1,param1 + param2]]);
            hasBadWord = true;
         };
         var hasBadWord:Boolean = false;
         if(inputCtrl == null)
         {
            return false;
         }
         if(this.checkAndInitialize())
         {
            return true;
         }
         inputCtrl.removeRedified();
         this.patternCheckForBadWords(inputCtrl.text,onBadWord);
         return hasBadWord;
      }
      
      public function resetLastFailedField() : void
      {
         var _loc1_:String = null;
         if(this.lastRedifiedField is IRedifyableTextInputComponent)
         {
            _loc1_ = this.lastRedifiedField["text"] as String;
            this.defaultColor(_loc1_,this.lastRedifiedField);
            this.redifyBadWords(this.lastRedifiedField as IRedifyableTextInputComponent);
         }
      }
      
      protected function defaultColor(param1:String, param2:DisplayObject) : void
      {
      }
      
      internal function filterText(param1:String) : String
      {
         var onBadWord:Function = null;
         var inputText:String = param1;
         onBadWord = function(param1:int, param2:int):void
         {
            var _loc3_:String = "";
            var _loc4_:int = 0;
            while(_loc4_ < param2)
            {
               _loc3_ += "*";
               _loc4_++;
            }
            inputText = inputText.substr(0,param1) + _loc3_ + inputText.substr(param1 + param2,inputText.length);
         };
         if(!hasLoadedFilter())
         {
            this.initialize();
            return inputText;
         }
         this.patternCheckForBadWords(inputText,onBadWord);
         return inputText;
      }
      
      protected function setupUserSpecificWordList() : void
      {
      }
      
      private function isWhitelistedSymbol(param1:String) : Boolean
      {
         switch(param1)
         {
            case "!":
               return true;
            case "#":
               return true;
            case "�":
               return true;
            case "%":
               return true;
            case "&":
               return true;
            case "/":
               return true;
            case "(":
               return true;
            case ")":
               return true;
            case "=":
               return true;
            case "?":
               return true;
            case "<":
               return true;
            case ">":
               return true;
            case "@":
               return true;
            case "�":
               return true;
            case "$":
               return true;
            case "�":
               return true;
            case "{":
               return true;
            case "[":
               return true;
            case "]":
               return true;
            case "}":
               return true;
            case "�":
               return true;
            default:
               return false;
         }
      }
      
      public function patternCheckForBadWords(param1:String, param2:Function) : Boolean
      {
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:RegExp = null;
         var _loc11_:int = 0;
         if(this.checkAndInitialize())
         {
            return true;
         }
         var _loc3_:RegExp = /[^\s]+/;
         var _loc4_:String = param1;
         var _loc5_:int = 0;
         while(true)
         {
            _loc5_ += _loc4_.search(_loc3_);
            _loc6_ = _loc4_.match(_loc3_);
            if(_loc6_ == null)
            {
               break;
            }
            _loc7_ = _loc6_[0] as String;
            _loc10_ = EmoticonUtility.instance.allEmoticonsExpression();
            _loc7_ = _loc7_.replace(_loc10_,"");
            _loc8_ = _loc7_.match(/\d/) != null;
            _loc7_ = _loc7_.replace(/[!\.,\?;:%]{1}$/,"");
            _loc7_ = _loc7_.replace(this.EXTRA_CHARS_REGEX,"");
            _loc9_ = sp.checkWord(_loc7_.toLowerCase());
            if(_loc7_ != "" && !this.isWhitelistedSymbol(_loc7_) && (_loc8_ || !_loc9_))
            {
               _loc11_ = int((_loc6_[0] as String).length);
               if(param2 == null)
               {
                  return false;
               }
               param2(_loc5_,_loc11_);
            }
            _loc5_ += _loc6_[0].length;
            _loc4_ = param1.substr(_loc5_);
         }
         return true;
      }
   }
}

