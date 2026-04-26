package com.moviestarplanet.dragonbones.loading
{
   import com.moviestarplanet.utils.assets.AssetCacheManager;
   import dragonBones.Armature;
   import dragonBones.factorys.NativeFactory;
   import dragonBones.objects.ObjectDataParser;
   import dragonBones.objects.SkeletonData;
   import dragonBones.objects.XMLDataParser;
   import dragonBones.textures.NativeTextureAtlas;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   public class SwfArmatureLoaderNonNested
   {
      
      public var json:Boolean = true;
      
      public var baseUrl:String = "";
      
      public var loadSkeleton:Function = null;
      
      public var loadTexture:Function = null;
      
      public var loadGraphics:Function = null;
      
      public var loadWithAssetManager:Boolean;
      
      protected var skeletonLoader:URLLoader = null;
      
      protected var textureXmlLoader:URLLoader = null;
      
      private var textureGraphicLoader:Loader = null;
      
      protected var armaturePathObj:Object = null;
      
      protected var skeletonId:String;
      
      protected var armatureName:String;
      
      protected var successCallback:Function;
      
      private var failCallback:Function;
      
      protected var skeletonData:SkeletonData;
      
      private var textureXml:Object;
      
      protected var skeletonUrlStr:String;
      
      protected var completeURL:String = "";
      
      protected var armaturePath:String = "";
      
      protected var factory:NativeFactory = new NativeFactory();
      
      protected var jsonTypeSkeleton:String;
      
      protected var jsonTypeTexture:String;
      
      public function SwfArmatureLoaderNonNested(param1:Object, param2:String, param3:String, param4:Function, param5:Function)
      {
         super();
         armaturePathObj = param1;
         skeletonId = param2;
         armatureName = param3;
         successCallback = param4;
         failCallback = param5;
         jsonTypeSkeleton = "/skeleton.json";
         jsonTypeTexture = "/texture.json";
      }
      
      public function load() : void
      {
         var _loc3_:ByteArray = null;
         var _loc1_:URLRequest = null;
         armaturePath = armaturePathObj.toString();
         if(skeletonId == null)
         {
            skeletonId = armaturePath;
         }
         var _loc2_:Armature = factory.buildArmature(armatureName,null,skeletonId,skeletonId);
         if(_loc2_ != null)
         {
            successCallback(_loc2_);
         }
         else
         {
            if(loadWithAssetManager)
            {
               completeURL = armaturePath as String;
            }
            else
            {
               completeURL = SwfArmatureLoader.cdnLocalBasePath + baseUrl + (armaturePath as String);
            }
            if(json)
            {
               skeletonUrlStr = completeURL + jsonTypeSkeleton;
            }
            else
            {
               skeletonUrlStr = completeURL + "/skeleton.xml";
            }
            if(StarlingBitmapArmatureLoader.skeletonCache[skeletonUrlStr] != null)
            {
               skeletonData = StarlingBitmapArmatureLoader.skeletonCache[skeletonUrlStr];
               skeletonLoaded(skeletonData);
            }
            else if(loadSkeleton != null && loadWithAssetManager)
            {
               loadSkeleton(skeletonUrlStr,json,skeletonLoaded,loadingFailed);
            }
            else if(AssetCacheManager.hasDataForPath(skeletonUrlStr))
            {
               _loc3_ = AssetCacheManager.getData(skeletonUrlStr);
               if(json)
               {
                  skeletonLoaded(getJsonObject(_loc3_));
               }
               else
               {
                  skeletonLoaded(XML(_loc3_));
               }
            }
            else
            {
               _loc1_ = new URLRequest(skeletonUrlStr);
               skeletonLoader = new URLLoader();
               skeletonLoader.dataFormat = "binary";
               skeletonLoader.addEventListener("complete",skeletonLoadedEvent);
               skeletonLoader.addEventListener("ioError",loadingFailedEvent);
               skeletonLoader.load(_loc1_);
            }
         }
      }
      
      private function skeletonLoaded(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc2_:URLRequest = null;
         if(json)
         {
            skeletonData = ObjectDataParser.parseSkeletonData(param1);
            if(param1.hasOwnProperty("dispose"))
            {
               param1.dispose();
               param1 = null;
            }
         }
         else
         {
            skeletonData = XMLDataParser.parseSkeletonData(param1 as XML);
         }
         if(json)
         {
            _loc3_ = completeURL + jsonTypeTexture;
         }
         else
         {
            _loc3_ = completeURL + "/texture.xml";
         }
         if(skeletonData != null && factory.getSkeletonData(skeletonId) == null)
         {
            factory.addSkeletonData(skeletonData,skeletonId);
            if(loadTexture != null && loadWithAssetManager)
            {
               loadTexture(_loc3_,json,textureXmlLoaded,loadingFailed);
            }
            else
            {
               _loc2_ = new URLRequest(_loc3_);
               textureXmlLoader = new URLLoader();
               textureXmlLoader.dataFormat = "binary";
               textureXmlLoader.addEventListener("complete",textureXmlLoadedEvent);
               textureXmlLoader.addEventListener("ioError",loadingFailedEvent);
               textureXmlLoader.load(_loc2_);
            }
         }
      }
      
      private function skeletonLoadedEvent(param1:Event = null) : void
      {
         AssetCacheManager.addData(skeletonUrlStr,skeletonLoader.data);
         removeLoaderListeners();
         if(skeletonLoader != null)
         {
            if(json)
            {
               skeletonLoaded(getJsonObject(skeletonLoader.data));
            }
            else
            {
               skeletonLoaded(XML(skeletonLoader.data));
            }
         }
      }
      
      protected function getJsonObject(param1:*) : Object
      {
         return JSON.parse(param1);
      }
      
      private function textureXmlLoadedEvent(param1:Object) : void
      {
         removeLoaderListeners();
         if(textureXmlLoader != null)
         {
            if(json)
            {
               textureXmlLoaded(getJsonObject(textureXmlLoader.data));
            }
            else
            {
               textureXmlLoaded(XML(textureXmlLoader.data));
            }
         }
      }
      
      protected function textureXmlLoaded(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:LoaderContext = null;
         textureXml = param1;
         textureXmlLoader = null;
         if(json)
         {
            _loc2_ = completeURL + "/texture.dbswf";
         }
         else
         {
            _loc2_ = completeURL + "/texture.swf";
         }
         if(loadGraphics != null && loadWithAssetManager)
         {
            loadGraphics(_loc2_,textureGraphicLoaded,loadingFailed);
         }
         else
         {
            textureGraphicLoader = new Loader();
            textureGraphicLoader.contentLoaderInfo.addEventListener("complete",textureGraphicLoadedEvent);
            textureGraphicLoader.contentLoaderInfo.addEventListener("ioError",loadingFailedEvent);
            if(SwfArmatureLoader.isMobile)
            {
               textureGraphicLoader.load(new URLRequest(_loc2_));
            }
            else
            {
               _loc3_ = new LoaderContext(true,null,SwfArmatureLoader.securityDomain);
               textureGraphicLoader.load(new URLRequest(_loc2_),_loc3_);
            }
         }
      }
      
      private function textureGraphicLoadedEvent(param1:Event) : void
      {
         removeLoaderListeners();
         var _loc2_:MovieClip = textureGraphicLoader.content as MovieClip;
         textureGraphicLoaded(_loc2_);
         _loc2_ = null;
         if(textureGraphicLoader != null)
         {
            textureGraphicLoader.unload();
            textureGraphicLoader = null;
         }
      }
      
      private function textureGraphicLoaded(param1:MovieClip) : void
      {
         var _loc4_:MovieClip = param1;
         while(_loc4_ != null && _loc4_.totalFrames < 3 && _loc4_.numChildren > 0)
         {
            _loc4_ = _loc4_.getChildAt(0) as MovieClip;
         }
         if(_loc4_ == null || _loc4_.totalFrames < 3)
         {
            trace("ERROR: unsupported texture: " + armatureName);
            _loc4_ = textureGraphicLoader.content as MovieClip;
         }
         var _loc3_:NativeTextureAtlas = new NativeTextureAtlas(_loc4_,textureXml);
         _loc4_ = null;
         factory.addTextureAtlas(_loc3_,skeletonId);
         if(armatureName == null)
         {
            armatureName = skeletonData.armatureNames[0];
         }
         var _loc2_:Armature = factory.buildArmature(armatureName,null,skeletonId,skeletonId);
         if(successCallback != null)
         {
            successCallback(_loc2_);
         }
         successCallback = null;
         failCallback = null;
      }
      
      private function cleanTextureXml() : void
      {
         if(textureXml && textureXml.hasOwnProperty("dispose"))
         {
            textureXml.dispose();
            textureXml = null;
         }
      }
      
      protected function loadingFailedEvent(param1:IOErrorEvent) : void
      {
         loadingFailed();
      }
      
      protected function loadingFailed() : void
      {
         if(failCallback != null)
         {
            failCallback();
         }
         destroy();
      }
      
      protected function removeLoaderListeners() : void
      {
         if(skeletonLoader != null)
         {
            skeletonLoader.removeEventListener("complete",skeletonLoadedEvent);
            skeletonLoader.removeEventListener("ioError",loadingFailedEvent);
         }
         if(textureXmlLoader != null)
         {
            textureXmlLoader.removeEventListener("complete",textureXmlLoadedEvent);
            textureXmlLoader.removeEventListener("ioError",loadingFailedEvent);
         }
         if(textureGraphicLoader != null)
         {
            textureGraphicLoader.contentLoaderInfo.removeEventListener("complete",textureGraphicLoadedEvent);
            textureGraphicLoader.contentLoaderInfo.removeEventListener("ioError",loadingFailedEvent);
         }
      }
      
      public function destroy() : void
      {
         removeLoaderListeners();
         skeletonLoader = null;
         textureXmlLoader = null;
         textureGraphicLoader = null;
         successCallback = null;
         failCallback = null;
         loadSkeleton = null;
         loadTexture = null;
         loadGraphics = null;
         cleanTextureXml();
         if(factory != null)
         {
            factory.dispose();
            factory = null;
         }
         armaturePathObj = null;
         if(skeletonData != null)
         {
            skeletonData.dispose();
            skeletonData = null;
         }
      }
   }
}

