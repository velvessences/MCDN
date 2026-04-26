package com.moviestarplanet.services.spendingservice.valueObjects
{
   import com.moviestarplanet.moviestar.ClothingCategories;
   import com.moviestarplanet.utils.MSP_SWFLoader;
   import com.moviestarplanet.utils.loader.ContentUrl;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   
   public class SpecialsGreetingItemInfo
   {
      
      public var SpecialsGreetingItemId:int;
      
      public var GreetingTypeId:int;
      
      public var EntityType:String;
      
      public var EntityId:int;
      
      public var Filename:String;
      
      private var _ClothesCategoryId:int;
      
      public function SpecialsGreetingItemInfo(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            this.SpecialsGreetingItemId = param1.SpecialsGreetingItemId as int;
            this.GreetingTypeId = param1.GreetingTypeId as int;
            this.EntityType = param1.EntityType as String;
            this.EntityId = param1.EntityId;
            this.Filename = param1.Filename;
            this.ClothesCategoryId = param1.ClothesCategoryId;
         }
      }
      
      public static function getLoaderForItem(param1:Object) : MSP_SWFLoader
      {
         var _loc2_:SpecialsGreetingItemInfo = new SpecialsGreetingItemInfo(param1);
         if(_loc2_.EntityType != "CLOTHES")
         {
            return null;
         }
         var _loc3_:MSP_SWFLoader = new MSP_SWFLoader(false);
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,loaderForItemFail,false,0,true);
         _loc3_.autoLoad = false;
         _loc3_.addEventListener(Event.COMPLETE,loaderForItemComplete,false,0,true);
         _loc3_.source = _loc2_.getContentUrl();
         return _loc3_;
      }
      
      private static function loaderForItemFail(param1:Event) : void
      {
         var _loc2_:MSP_SWFLoader = param1.target as MSP_SWFLoader;
         _loc2_.removeEventListener(Event.COMPLETE,loaderForItemComplete);
         _loc2_.dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private static function loaderForItemComplete(param1:Event) : void
      {
         var _loc2_:MSP_SWFLoader = param1.target as MSP_SWFLoader;
         _loc2_.removeEventListener(Event.COMPLETE,loaderForItemComplete);
         (_loc2_.content as MovieClip).gotoAndStop(2);
      }
      
      public function get ClothesCategoryId() : int
      {
         return this._ClothesCategoryId;
      }
      
      public function set ClothesCategoryId(param1:int) : void
      {
         if(param1 == 0)
         {
            param1 = -1;
         }
         this._ClothesCategoryId = param1;
      }
      
      public function getContentUrl() : ContentUrl
      {
         return new ContentUrl(new ClothingCategories().GetCategorySubPath(this.ClothesCategoryId) + this.Filename,ContentUrl.CLOTH);
      }
   }
}

