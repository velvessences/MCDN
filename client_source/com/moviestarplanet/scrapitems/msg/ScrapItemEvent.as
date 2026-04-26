package com.moviestarplanet.scrapitems.msg
{
   import flash.events.Event;
   
   public class ScrapItemEvent extends Event
   {
      
      public static const ITEM_COMPLETE:String = "ITEM_COMPLETE";
      
      public static const ITEM_FAILED:String = "ITEM_FAILED";
      
      public static const RENDERER_COMPLETE:String = "RENDERER_COMPLETE";
      
      public static const RENDERER_IO_ERROR:String = "RENDERER_IO_ERROR";
      
      public function ScrapItemEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

