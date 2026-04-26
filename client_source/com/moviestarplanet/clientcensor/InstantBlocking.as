package com.moviestarplanet.clientcensor
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.utils.getQualifiedClassName;
   
   public class InstantBlocking
   {
      
      public static var GetRelativeBlackListPathFunction:Function;
      
      private static var _instantBlockingData:String;
      
      private static const instantBlockingFilename:String = "instantBlocking.txt";
      
      private static const instantBlockingSeparator:String = "\r\n";
      
      private static const MIN_LENGTH_EXACT_BLOCKING:int = 10;
      
      private static var instantBlockingList:Array = [];
      
      public function InstantBlocking()
      {
         super();
         throw new Error("Do not instantiate " + getQualifiedClassName(this));
      }
      
      public static function loadInstantBlockingFile(param1:Function) : void
      {
         var request:URLRequest;
         var _url:String = null;
         var instantLoader:URLLoader = null;
         var onComplete:Function = null;
         var onError:Function = null;
         var callBack:Function = param1;
         onComplete = function(param1:Event):void
         {
            var event:Event = param1;
            instantLoader.removeEventListener(Event.COMPLETE,onComplete);
            instantLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);
            instantLoader.removeEventListener(IOErrorEvent.IO_ERROR,onError);
            try
            {
               setupInstantBlockingData(event.target.data);
            }
            catch(e:TypeError)
            {
               trace("#THROWING ERROR# onComplete catch statement: " + e);
            }
            if(callBack != null)
            {
               callBack();
            }
         };
         onError = function(param1:Event):void
         {
            trace("loading instant Blocking failed: " + _url);
            trace("loading instant Blocking failed: " + _url);
            callBack();
         };
         var filename:String = "Global/" + instantBlockingFilename;
         _url = GetRelativeBlackListPathFunction(filename);
         instantLoader = new URLLoader();
         instantLoader.addEventListener(Event.COMPLETE,onComplete);
         instantLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);
         instantLoader.addEventListener(IOErrorEvent.IO_ERROR,onError);
         request = new URLRequest(_url);
         request.method = URLRequestMethod.GET;
         instantLoader.load(request);
      }
      
      public static function setupInstantBlockingData(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         _instantBlockingData = param1;
         if(param1 != null)
         {
            _loc2_ = param1.split(instantBlockingSeparator);
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc4_ = _loc2_[_loc3_].toString().toLowerCase();
               createBlockingRegex(_loc4_);
               _loc3_++;
            }
         }
      }
      
      private static function createBlockingRegex(param1:String) : void
      {
         var _loc2_:String = null;
         if(param1.length != 0)
         {
            _loc2_ = "";
            if(param1.length <= MIN_LENGTH_EXACT_BLOCKING)
            {
               _loc2_ = createRegex(param1);
            }
            else
            {
               _loc2_ = createRegex(param1,true);
            }
            if(_loc2_.length != 0)
            {
               instantBlockingList.push(_loc2_);
            }
         }
      }
      
      private static function createRegex(param1:String, param2:Boolean = false) : String
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(param1.length != 0)
         {
            param1 = param1.replace(/^http(s)?:\/\//,"");
            _loc3_ = "";
            if(param2)
            {
               _loc3_ += "[^A-Za-z0-9æøåäöšžąćęłńóśźżüßğçşáðéíóúýþöàèùëïüÿñÆØÅÄÖŠŽĄĆĘŁŃÓŚŹŻÜßĞÇŞ]{0,5}?";
            }
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               _loc3_ += formatCharacters(param1.charAt(_loc4_));
               if(param2)
               {
                  _loc3_ += "[^A-Za-z0-9æøåäöšžąćęłńóśźżüßğçşáðéíóúýþöàèùëïüÿñÆØÅÄÖŠŽĄĆĘŁŃÓŚŹŻÜßĞÇŞ]{0,5}?";
               }
               _loc4_++;
            }
            return _loc3_;
         }
         return "";
      }
      
      private static function formatCharacters(param1:String) : String
      {
         switch(param1)
         {
            case ".":
               return "\\.";
            case "?":
               return "\\?";
            default:
               return param1;
         }
      }
      
      public static function IsTextBlocked(param1:String) : Boolean
      {
         var _loc3_:RegExp = null;
         param1 = param1.toLowerCase();
         var _loc2_:int = 0;
         while(_loc2_ < instantBlockingList.length)
         {
            _loc3_ = new RegExp(instantBlockingList[_loc2_].toString());
            if(_loc3_.exec(param1))
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public static function get instantBlockingData() : String
      {
         return _instantBlockingData;
      }
   }
}

