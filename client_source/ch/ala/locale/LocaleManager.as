package ch.ala.locale
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class LocaleManager
   {
      
      private static var _instance:LocaleManager;
      
      private var _localeChain:Array;
      
      private var _requiredBundlesReady:Boolean;
      
      private var bundles:Dictionary;
      
      private var loadingQueue:Array;
      
      private var timeoutID:uint;
      
      private var verbose:Boolean = false;
      
      private const LOAD_MAX_RETRIES:int = 3;
      
      public var keepNewLine:Boolean = false;
      
      public function LocaleManager()
      {
         super();
         _localeChain = [];
         _requiredBundlesReady = true;
         bundles = new Dictionary();
         loadingQueue = [];
      }
      
      public static function getInstance() : LocaleManager
      {
         if(_instance == null)
         {
            _instance = new LocaleManager();
         }
         return _instance;
      }
      
      public function addRequiredBundles(param1:Array, param2:Function = null) : void
      {
         var successForAll:Boolean;
         var bundles:Array = param1;
         var onRequiredComplete:Function = param2;
         var onComplete:* = function(param1:String, param2:String, param3:Boolean):void
         {
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            if(onRequiredComplete is Function)
            {
               if(!param3)
               {
                  successForAll = false;
               }
               _loc4_ = uint(loadingQueue.length);
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  if(loadingQueue[_loc5_].onComplete === onComplete)
                  {
                     return;
                  }
                  _loc5_++;
               }
               if(successForAll)
               {
                  _requiredBundlesReady = true;
               }
               onRequiredComplete(successForAll);
            }
         };
         _requiredBundlesReady = false;
         var i:int = bundles.length - 1;
         while(i >= 0)
         {
            loadingQueue.unshift({
               "locale":bundles[i].locale,
               "bundleName":bundles[i].bundleName,
               "onComplete":onComplete
            });
            i = i - 1;
         }
         successForAll = true;
         if(loadingQueue.length == bundles.length)
         {
            loadBundle();
         }
      }
      
      public function addBundle(param1:String, param2:String, param3:String, param4:Function = null) : void
      {
         loadingQueue.push({
            "url":param1,
            "locale":param2,
            "bundleName":param3,
            "onComplete":param4
         });
         if(loadingQueue.length == 1)
         {
            loadBundle();
         }
      }
      
      private function unqueueFirst(param1:Boolean) : void
      {
         var _loc2_:Object = loadingQueue.shift();
         if(_loc2_.onComplete is Function)
         {
            _loc2_.onComplete(_loc2_.locale,_loc2_.bundleName,param1);
         }
         timeoutID = setTimeout(loadBundle,1);
      }
      
      private function loadBundle() : void
      {
         var identifier:Object;
         var loader:URLLoader;
         var tries:int;
         var onComplete:* = function(param1:Event):void
         {
            var _loc2_:URLLoader = param1.target as URLLoader;
            _loc2_.removeEventListener("complete",onComplete);
            _loc2_.removeEventListener("ioError",onIOError);
            var _loc3_:Boolean = false;
            try
            {
               parseBundle(identifier.locale,identifier.bundleName,_loc2_.data);
               _loc3_ = true;
            }
            catch(e:Error)
            {
               log("Could not read/parse FileStream. Error: " + e.toString());
            }
            finally
            {
               unqueueFirst(_loc3_);
            }
         };
         var onIOError:* = function(param1:IOErrorEvent):void
         {
            var _loc2_:URLLoader = null;
            var _loc3_:URLLoader = null;
            var _loc4_:Boolean = false;
            if(tries < 3)
            {
               tries = tries + 1;
               trace("IOError at LocaleManager, will try for the #" + tries + " time (max. " + 3 + " attempts)");
               _loc2_ = param1.target as URLLoader;
               _loc2_.load(new URLRequest(identifier.url));
            }
            else
            {
               trace("IOError at LocaleManager");
               _loc3_ = param1.target as URLLoader;
               _loc3_.removeEventListener("complete",onComplete);
               _loc3_.removeEventListener("ioError",onIOError);
               _loc4_ = false;
               unqueueFirst(_loc4_);
            }
         };
         if(timeoutID)
         {
            clearTimeout(timeoutID);
         }
         if(loadingQueue.length < 1)
         {
            return;
         }
         identifier = loadingQueue[0];
         if(identifier.locale in bundles && identifier.bundle in bundles[identifier.locale])
         {
            log("loadBundle: Bundle " + identifier.locale + "/" + identifier.bundle + " is already available.");
            unqueueFirst(true);
            return;
         }
         loader = new URLLoader();
         loader.dataFormat = "text";
         loader.addEventListener("complete",onComplete);
         loader.addEventListener("ioError",onIOError);
         tries = 1;
         loader.load(new URLRequest(identifier.url));
      }
      
      public function getBundleData(param1:String, param2:String) : Dictionary
      {
         return bundles[param1][param2];
      }
      
      private function parseBundle(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:String = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc10_:String = null;
         var _loc6_:int = 0;
         if(!(param1 in bundles))
         {
            bundles[param1] = new Dictionary();
         }
         bundles[param1][param2] = new Dictionary();
         var _loc9_:Array = param3.split("\n");
         var _loc5_:uint = uint(_loc9_.length);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = _loc9_[_loc6_];
            _loc7_ = int(_loc4_.indexOf("="));
            if(_loc7_ != -1)
            {
               _loc8_ = _loc4_.substring(0,_loc7_);
               _loc10_ = _loc4_.substring(_loc7_ + 1);
               §§push(bundles[param1][param2]);
               var _loc11_:String;
               §§push((_loc11_ = _loc8_).replace(new RegExp("^\\s+|\\s+$","g"),""));
               var _loc12_:String = _loc10_;
               var _loc13_:* = this.keepNewLine ? _loc12_.replace(new RegExp("\\\\n|\\\\r","g"),"\n") : _loc12_;
               §§pop()[§§pop()] = _loc13_.replace(new RegExp("^\\s+|\\s+$","g"),"");
            }
            _loc6_++;
         }
      }
      
      public function loadFromParsedBundle(param1:ParsedLocaleBundle) : void
      {
         if(bundles[param1.localeChain] == null)
         {
            bundles[param1.localeChain] = new Dictionary();
         }
         bundles[param1.localeChain][param1.bundleName] = param1.parsedData;
      }
      
      final private function trim(param1:String) : String
      {
         return param1.replace(/^\s+|\s+$/g,"");
      }
      
      final private function newLine(param1:String) : String
      {
         return keepNewLine ? param1.replace(/\\n|\\r/g,"\n") : param1;
      }
      
      private function getRawString(param1:String, param2:String) : String
      {
         var _loc4_:* = 0;
         var _loc3_:uint = uint(_localeChain.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_localeChain[_loc4_] in bundles && param1 in bundles[_localeChain[_loc4_]] && param2 in bundles[_localeChain[_loc4_]][param1])
            {
               return bundles[_localeChain[_loc4_]][param1][param2];
            }
            _loc4_++;
         }
         log("getString(" + param1 + ", " + param2 + "): No matching resource found.");
         return "";
      }
      
      public function getString(param1:String, param2:String, param3:Array = null) : String
      {
         var _loc5_:RegExp = null;
         var _loc6_:int = 0;
         var _loc4_:String = getRawString(param1,param2);
         if(param3 != null)
         {
            _loc6_ = 0;
            while(_loc6_ < param3.length)
            {
               _loc5_ = new RegExp("\\{" + _loc6_ + "\\}","g");
               _loc4_ = _loc4_.replace(_loc5_,param3[_loc6_]);
               _loc6_++;
            }
         }
         return _loc4_;
      }
      
      public function missingCheat(param1:String, param2:String) : String
      {
         return param2;
      }
      
      public function get localeChain() : Array
      {
         return _localeChain;
      }
      
      public function set localeChain(param1:Array) : void
      {
         _localeChain = param1;
      }
      
      public function get requiredBundlesReady() : Boolean
      {
         return _requiredBundlesReady;
      }
      
      public function isSpecificBundleReady(param1:Object) : Boolean
      {
         return param1.locale in bundles && param1.bundle in bundles[param1.locale];
      }
      
      private function log(param1:String) : void
      {
         if(verbose)
         {
            trace("[LocaleManager] " + param1);
         }
      }
   }
}

