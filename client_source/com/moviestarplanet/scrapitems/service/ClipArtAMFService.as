package com.moviestarplanet.scrapitems.service
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   import com.moviestarplanet.scrapitems.IClipArtProvider;
   
   public class ClipArtAMFService implements IClipArtProvider
   {
      
      private static var cache:Object = {};
      
      protected var amfCaller:AmfCaller;
      
      public function ClipArtAMFService()
      {
         super();
         this.amfCaller = new AmfCaller("MovieStarPlanet.WebService.ScrapBlog.AMFClipArtService");
      }
      
      public function getClipArt(param1:Function, param2:int = 0, param3:Boolean = true) : void
      {
         var webMethodDone:Function;
         var cacheKey:String = null;
         var doneCallback:Function = param1;
         var clipArtCategoryId:int = param2;
         var filterDiamonds:Boolean = param3;
         var cacheExtra:String = filterDiamonds ? "_filtered" : "_all";
         cacheKey = "CLIPART_" + clipArtCategoryId.toString() + cacheExtra;
         if(cache[cacheKey] != null)
         {
            doneCallback(SerializeUtils.clone(cache[cacheKey]));
         }
         else
         {
            webMethodDone = function(param1:Object):void
            {
               cache[cacheKey] = param1 as Array;
               var _loc2_:Object = SerializeUtils.clone(param1);
               doneCallback(_loc2_);
            };
            this.amfCaller.callFunction("GetClipArtNew",[clipArtCategoryId,filterDiamonds],true,webMethodDone,this.fail);
         }
      }
      
      private function fail(param1:* = null) : void
      {
         trace("ERROR: ScrapAMFService server call failed.");
      }
   }
}

