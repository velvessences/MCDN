package com.moviestarplanet.clothesutils
{
   import com.moviestarplanet.body.IAttachable;
   import com.moviestarplanet.body.IDesignable;
   import com.moviestarplanet.body.ILoadable;
   import com.moviestarplanet.utils.ColorMap;
   import com.moviestarplanet.utils.loader.ContentUrl;
   import com.moviestarplanet.utils.loaderfacade.LoaderFacade;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class ClothesUtils
   {
      
      public function ClothesUtils()
      {
         super();
      }
      
      public static function prepareClothesForWearing(param1:IAttachable, param2:uint, param3:Function, param4:Boolean = true, param5:Number = 1) : void
      {
         var eventBus:IEventDispatcher = null;
         var cloth:ILoadable = null;
         var LoadDone:Function = null;
         var rel:IAttachable = param1;
         var skinColor:uint = param2;
         var callback:Function = param3;
         var flatten:Boolean = param4;
         var scale:Number = param5;
         LoadDone = function(param1:*):void
         {
            var _loc2_:MovieClip = param1.content as MovieClip;
            if(_loc2_ != null)
            {
               if(cloth.ColorScheme)
               {
                  ColorMap.CreateColorMapFromString(_loc2_,cloth.ColorScheme);
               }
               ColorMap.SetColorsOnMovieClip(_loc2_,skinColor,rel.Color);
               if((rel as IDesignable).hasDesign())
               {
                  if(flatten)
                  {
                     prepareFlatten(eventBus,_loc2_,scale);
                  }
                  new DesignLoader(eventBus).loadDesignToCloth(_loc2_,(rel as IDesignable).GetDesign(),callback);
               }
               else
               {
                  callback(_loc2_);
               }
            }
         };
         eventBus = new EventDispatcher();
         if(!rel.isWearable)
         {
            callback(null);
         }
         cloth = rel.Loadable;
         LoaderFacade.requestLoad(new ContentUrl(cloth.path,ContentUrl.CLOTH,cloth.LastUpdated),LoadDone,2,false,false);
      }
      
      private static function prepareFlatten(param1:IEventDispatcher, param2:MovieClip, param3:Number) : void
      {
         new ClothesFlattener(param1,param2,param3).flattenOnComplete();
      }
   }
}

