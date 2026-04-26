package com.moviestarplanet.utils.loader
{
   import com.moviestarplanet.globalsharedutils.SnapshotUrl;
   import com.moviestarplanet.loader.ILoaderUrl;
   
   public class ObfuscatedSnapshotUrl extends SnapshotUrl implements ILoaderUrl
   {
      
      private var _isThumbnail:Boolean;
      
      private var _obfuscator:String;
      
      public function ObfuscatedSnapshotUrl(param1:*, param2:int, param3:String, param4:String, param5:Boolean, param6:Date = null)
      {
         this._obfuscator = param4;
         this._isThumbnail = param5;
         super(param1,param2,param3,param6);
      }
      
      override protected function postFix(param1:int) : String
      {
         if(this._isThumbnail)
         {
            return "_" + this._obfuscator + "-s" + super.postFix(param1);
         }
         return "_" + this._obfuscator + super.postFix(param1);
      }
   }
}

