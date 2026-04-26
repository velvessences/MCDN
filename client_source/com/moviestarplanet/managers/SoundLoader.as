package com.moviestarplanet.managers
{
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.assetManager.UnionRep;
   import com.moviestarplanet.assetManager.loaders.AssetLoader;
   import flash.media.Sound;
   
   internal class SoundLoader extends AssetLoader
   {
      
      private namespace AssetManagerNS = "AssetManager";
      
      private var soundUrl:String;
      
      public function SoundLoader(param1:UnionRep, param2:String, param3:IAssetUrl, param4:Function = null, param5:Function = null, param6:Boolean = true)
      {
         this.soundUrl = param2;
         returnByteArray = true;
         super(param1,param3,param4,param5,param6);
      }
      
      public static function create(param1:String, param2:IAssetUrl, param3:Function = null, param4:Function = null, param5:Boolean = true) : SoundLoader
      {
         return new SoundLoader(UnionRep.instance,param1,param2,param3,param4,param5);
      }
      
      public function getSound() : Sound
      {
         var _loc1_:Sound = new Sound();
         _loc1_.loadCompressedDataFromByteArray(payload,payload.length);
         return _loc1_;
      }
      
      public function getSoundUrl() : String
      {
         return this.soundUrl;
      }
   }
}

