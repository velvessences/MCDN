package com.moviestarplanet.dragonbones.loading
{
   import com.moviestarplanet.dragonbones.DragonBonesWrapper;
   import com.moviestarplanet.dragonbones.display.IArmatureDisplayWrapper;
   import com.moviestarplanet.dragonbones.display.NativeArmatureDisplayWrapper;
   import dragonBones.Armature;
   import dragonBones.factorys.NativeFactory;
   import flash.display.DisplayObject;
   import flash.system.SecurityDomain;
   
   public class SwfArmatureLoader implements IArmatureLoader
   {
      
      public static var isMobile:Boolean = false;
      
      public static var cdnLocalBasePath:String = "";
      
      public static var securityDomain:SecurityDomain = SecurityDomain.currentDomain;
      
      protected var factory:NativeFactory;
      
      private var _baseUrl:String = "";
      
      private var _json:Boolean = true;
      
      private var _nonNestedItems:Vector.<SwfArmatureLoaderNonNested> = new Vector.<SwfArmatureLoaderNonNested>();
      
      public function SwfArmatureLoader()
      {
         super();
         if(!factory)
         {
            factory = new NativeFactory();
         }
      }
      
      public function setAlreadyLoadedData(param1:DragonBonesWrapper, param2:String, param3:Function) : void
      {
         param3(param2);
      }
      
      public function loadArmatureWithAssetManager(param1:Object, param2:String, param3:String, param4:Function, param5:Function, param6:Function, param7:Function, param8:Function) : void
      {
         var _loc9_:SwfArmatureLoaderNonNested = getNonNestedInstance(param1,param2,param3,param4,param5);
         _loc9_.baseUrl = baseUrl;
         _loc9_.json = _json;
         _loc9_.loadSkeleton = param6;
         _loc9_.loadTexture = param7;
         _loc9_.loadGraphics = param8;
         _loc9_.loadWithAssetManager = true;
         _loc9_.load();
         _nonNestedItems.push(_loc9_);
      }
      
      public function createDisplayWrapper() : IArmatureDisplayWrapper
      {
         return new NativeArmatureDisplayWrapper();
      }
      
      public function loadArmature(param1:Object, param2:String, param3:String, param4:Function, param5:Function) : void
      {
         var _loc6_:SwfArmatureLoaderNonNested = getNonNestedInstance(param1,param2,param3,param4,param5);
         _loc6_.baseUrl = baseUrl;
         _loc6_.json = _json;
         _loc6_.loadWithAssetManager = false;
         _loc6_.load();
         _nonNestedItems.push(_loc6_);
      }
      
      public function loadAnimationData(param1:DragonBonesWrapper, param2:String, param3:Function) : void
      {
         param3(param2);
      }
      
      public function hookupToArmatureFrameEvent(param1:Armature, param2:Function) : void
      {
         (param1.display as DisplayObject).addEventListener("enterFrame",param2);
      }
      
      public function unhookFromArmatureFrameEvent(param1:Armature, param2:Function) : void
      {
         (param1.display as DisplayObject).removeEventListener("enterFrame",param2);
      }
      
      protected function getNonNestedInstance(param1:Object, param2:String, param3:String, param4:Function, param5:Function) : SwfArmatureLoaderNonNested
      {
         return new SwfArmatureLoaderNonNested(param1,param2,param3,param4,param5);
      }
      
      protected function get baseUrl() : String
      {
         return _baseUrl;
      }
      
      protected function set baseUrl(param1:String) : void
      {
         _baseUrl = param1;
      }
      
      public function get json() : Boolean
      {
         return _json;
      }
      
      public function set json(param1:Boolean) : void
      {
         _json = param1;
      }
      
      public function destroy() : void
      {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         if(factory != null)
         {
            factory.dispose();
            factory = null;
         }
         if(_nonNestedItems != null)
         {
            _loc1_ = uint(_nonNestedItems.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _nonNestedItems[_loc2_].destroy();
               _loc2_++;
            }
            _nonNestedItems.length = 0;
            _nonNestedItems = null;
         }
      }
   }
}

