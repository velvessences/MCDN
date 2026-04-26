package com.moviestarplanet.emoticon
{
   import com.moviestarplanet.emoticon.utility.EmoticonUtility;
   import com.moviestarplanet.emoticon.valueobjects.Emoticon;
   import com.moviestarplanet.emoticon.valueobjects.EmoticonPackage;
   import com.moviestarplanet.utils.loader.AssetUrl;
   import com.moviestarplanet.utils.loader.IMSP_Loader;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class EmoticonLoader implements IEmoticonClassLoader
   {
      
      private var callbackQueueOfLoadingPackages:Dictionary;
      
      private var emoticonSwfPath:String;
      
      private var emoticonSprites:Dictionary;
      
      public function EmoticonLoader(param1:String)
      {
         super();
         this.emoticonSwfPath = param1;
         this.callbackQueueOfLoadingPackages = new Dictionary();
         this.emoticonSprites = new Dictionary();
      }
      
      public function loadEmoticon(param1:String, param2:Function) : void
      {
         var swfLoaded:Function = null;
         var emoticonPackage:EmoticonPackage = null;
         var loader:IMSP_Loader = null;
         var symbolName:String = param1;
         var loadCompleteCallback:Function = param2;
         swfLoaded = function(param1:IMSP_Loader):void
         {
            var _loc2_:Sprite = null;
            var _loc4_:Function = null;
            saveLoadedEmoticons(emoticonPackage,param1);
            param1.dispose();
            var _loc3_:Array = callbackQueueOfLoadingPackages[emoticonPackage.emoticonPackageId];
            var _loc5_:int = 0;
            while(_loc5_ < _loc3_.length)
            {
               _loc4_ = _loc3_[_loc5_].callback;
               _loc2_ = emoticonSprites[_loc3_[_loc5_].symbolName] as Sprite;
               _loc4_(cloneEmoticonSprite(_loc2_));
               _loc5_++;
            }
            callbackQueueOfLoadingPackages[emoticonPackage.emoticonPackageId] = null;
            delete callbackQueueOfLoadingPackages[emoticonPackage.emoticonPackageId];
         };
         if(this.emoticonSprites[symbolName] != null)
         {
            loadCompleteCallback(this.cloneEmoticonSprite(this.emoticonSprites[symbolName]));
         }
         else
         {
            emoticonPackage = EmoticonUtility.instance.getEmoticonPackageFromSymbolName(symbolName);
            if(this.callbackQueueOfLoadingPackages[emoticonPackage.emoticonPackageId] == null)
            {
               this.callbackQueueOfLoadingPackages[emoticonPackage.emoticonPackageId] = new Array();
               this.addCallbackToQueue(emoticonPackage,symbolName,loadCompleteCallback);
               loader = this.getNewLoader();
               loader.LoadCallBack = swfLoaded;
               loader.LoadUrl(new AssetUrl(this.emoticonSwfPath + "/" + emoticonPackage.swfFileName,AssetUrl.SWF));
            }
            else
            {
               this.addCallbackToQueue(emoticonPackage,symbolName,loadCompleteCallback);
            }
         }
      }
      
      private function addCallbackToQueue(param1:EmoticonPackage, param2:String, param3:Function) : void
      {
         (this.callbackQueueOfLoadingPackages[param1.emoticonPackageId] as Array).push({
            "callback":param3,
            "symbolName":param2
         });
      }
      
      private function saveLoadedEmoticons(param1:EmoticonPackage, param2:IMSP_Loader) : void
      {
         var _loc3_:Emoticon = null;
         var _loc4_:int = 0;
         while(_loc4_ < param1.emoticons.length)
         {
            _loc3_ = param1.emoticons[_loc4_] as Emoticon;
            this.emoticonSprites[_loc3_.Symbol] = (param2.loadedContents as Sprite).getChildByName(_loc3_.Symbol) as Sprite;
            _loc4_++;
         }
      }
      
      protected function getNewLoader() : IMSP_Loader
      {
         throw new Error("Override in subclass with platform specific loader.");
      }
      
      protected function cloneEmoticonSprite(param1:Sprite) : Sprite
      {
         throw new Error("Override in subclass with platform specific method of cloning emoticon.");
      }
   }
}

