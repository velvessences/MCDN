package com.moviestarplanet.globalsharedutils.storage
{
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.net.registerClassAlias;
   
   public class ObjectCache
   {
      
      private static var _instance:ObjectCache;
      
      internal static var enableFileIO:Boolean = true;
      
      public static const LANGUAGE_MAPS_KEY:String = "LanguageMaps";
      
      public static const ANCHOR_CHARACTER_LIST_KEY:String = "AnchorCharacterList";
      
      public static const BONSTER_TEMPLATES_KEY:String = "BonsterTemplates";
      
      public static const CLICK_ITEMS_KEY:String = "ClickItems";
      
      public static const LEVEL_THRESHOLD_KEY:String = "LevelThresholds";
      
      public static const PARSED_TRANSLATION_KEY:String = "ParsedTranslation";
      
      public static const INFO_SITES_KEY:String = "InfoSites";
      
      public static const EMOTICONS_KEY:String = "Emoticons";
      
      private const FILE_NAME:String = "./mspobjectcache/cached_object_data.dat";
      
      private const INVALIDATION_TIME:int = 2592000;
      
      private var _data:ObjectCacheData;
      
      private var _dirtyFlags:Object;
      
      private var hashesToSet:Vector.<String>;
      
      private var objectsToSet:Vector.<String>;
      
      public function ObjectCache(param1:SingletonBlocker)
      {
         super();
         this.hashesToSet = new <String>[ANCHOR_CHARACTER_LIST_KEY,BONSTER_TEMPLATES_KEY,CLICK_ITEMS_KEY,LEVEL_THRESHOLD_KEY,PARSED_TRANSLATION_KEY,EMOTICONS_KEY];
         this.objectsToSet = new Vector.<String>();
         if(param1 == null)
         {
            throw new Error("ObjectCache is a Singleton, use getInstance() instead");
         }
         registerClassAlias("com.moviestarplanet.globalsharedutils.storage.ObjectCacheData",ObjectCacheData);
         this._dirtyFlags = new Object();
         if(enableFileIO)
         {
            this.read();
         }
         if(this._data == null)
         {
            this._data = new ObjectCacheData();
            this._data.hashValues = new Object();
            this._data.objects = new Object();
         }
      }
      
      public static function getInstance() : ObjectCache
      {
         if(_instance == null)
         {
            _instance = new ObjectCache(new SingletonBlocker());
         }
         return _instance;
      }
      
      public function setHashValue(param1:String, param2:String) : void
      {
         if(this._data.objects[param1] == null || this._data.hashValues[param1] == null || this._data.hashValues[param1] != param2)
         {
            this._data.hashValues[param1] = param2;
            this._dirtyFlags[param1] = true;
         }
         this.hashSettled(param1);
      }
      
      public function getObject(param1:String) : Object
      {
         return this._data.objects[param1];
      }
      
      public function clearObject(param1:String) : void
      {
         delete this._data.objects[param1];
      }
      
      public function setObject(param1:String, param2:Object) : void
      {
         this._data.objects[param1] = param2;
         this._dirtyFlags[param1] = false;
         if(enableFileIO)
         {
            this.write();
         }
         this.objectSettled(param1);
      }
      
      public function shouldUpdate(param1:String) : Boolean
      {
         var _loc2_:Boolean = Boolean(this._dirtyFlags[param1] as Boolean);
         if(_loc2_)
         {
            this.objectsToSet.push(param1);
         }
         return _loc2_;
      }
      
      private function write() : void
      {
         var file:File = null;
         var fileStream:FileStream = null;
         try
         {
            file = File.applicationStorageDirectory.resolvePath(this.FILE_NAME);
            fileStream = new FileStream();
            fileStream.open(file,FileMode.WRITE);
            this._data.timestamp = new Date().getTime();
            fileStream.writeObject(this._data);
            fileStream.close();
         }
         catch(e:Error)
         {
            trace("Error at flash.filesystem::FileStream/writeObject(). Likely to be out of space");
         }
      }
      
      private function read() : void
      {
         var fileStream:FileStream = null;
         var obj:ObjectCacheData = null;
         var currentTime:Number = NaN;
         var cachedTime:Number = NaN;
         var timeDifference:int = 0;
         var key:* = undefined;
         var file:File = File.applicationStorageDirectory.resolvePath(this.FILE_NAME);
         if(file.exists)
         {
            fileStream = new FileStream();
            fileStream.open(file,FileMode.READ);
            try
            {
               obj = fileStream.readObject() as ObjectCacheData;
            }
            catch(e:Error)
            {
               trace("Error at flash.filesystem::FileStream/readObject(). Likely to be an error while saving data");
            }
            fileStream.close();
            if(obj != null)
            {
               currentTime = Number(new Date().getTime());
               cachedTime = Number(obj.timestamp as Number);
               timeDifference = int(int((currentTime - cachedTime) / 1000));
               if(timeDifference < this.INVALIDATION_TIME)
               {
                  this._data = obj as ObjectCacheData;
               }
            }
         }
         if(this._data != null)
         {
            for each(key in this.hashesToSet)
            {
               if(this._data.objects[key] == null)
               {
                  this._dirtyFlags[key] = true;
               }
            }
         }
      }
      
      private function hashSettled(param1:String) : void
      {
         var _loc2_:int = int(this.hashesToSet.indexOf(param1));
         if(_loc2_ == -1)
         {
            return;
         }
         this.hashesToSet.splice(_loc2_,1);
         if(this.hashesToSet.length <= 0 && this.objectsToSet.length <= 0)
         {
            this.cleanUnusedObjects();
         }
      }
      
      private function objectSettled(param1:String) : void
      {
         var _loc2_:int = int(this.objectsToSet.indexOf(param1));
         if(_loc2_ == -1)
         {
            return;
         }
         this.objectsToSet.splice(_loc2_,1);
         if(this.hashesToSet.length <= 0 && this.objectsToSet.length <= 0)
         {
            this.cleanUnusedObjects();
         }
      }
      
      private function cleanUnusedObjects() : void
      {
         this.clearObject(PARSED_TRANSLATION_KEY);
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
