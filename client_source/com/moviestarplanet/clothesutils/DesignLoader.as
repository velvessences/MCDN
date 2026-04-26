package com.moviestarplanet.clothesutils
{
   import com.moviestarplanet.body.IDesign;
   import com.moviestarplanet.scrapitems.ScrapItem;
   import com.moviestarplanet.scrapitems.ScrapItemClipArt;
   import com.moviestarplanet.scrapitems.msg.ScrapItemEvent;
   import com.moviestarplanet.scrapitems.pattern.PatternLoader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class DesignLoader
   {
      
      private var loadCallback:Function;
      
      private var mc:MovieClip;
      
      private var itemsLeftToLoad:int = 0;
      
      private var eventBus:IEventDispatcher;
      
      private var toBeDisposed:Array = [];
      
      public function DesignLoader(param1:IEventDispatcher)
      {
         super();
         this.eventBus = param1;
      }
      
      public function loadDesignToCloth(param1:MovieClip, param2:IDesign, param3:Function = null) : void
      {
         var dataObj:Object = null;
         var stickers:Object = null;
         var i:int = 0;
         var part:MovieClip = null;
         var partName:String = null;
         var item:Object = null;
         var scItem:ScrapItem = null;
         var pattern:PatternLoader = null;
         var t:Timer = null;
         var done:Function = null;
         var mc:MovieClip = param1;
         var design:IDesign = param2;
         var callback:Function = param3;
         if(design != null)
         {
            this.loadCallback = callback;
            this.mc = mc;
            dataObj = design.DataObject;
            stickers = dataObj.stickers;
            if(stickers == null)
            {
               stickers = dataObj;
            }
            while(i < mc.numChildren)
            {
               part = mc.getChildAt(i) as MovieClip;
               if(part != null)
               {
                  partName = part.name.toUpperCase();
                  if(stickers[partName])
                  {
                     for each(item in stickers[partName].itemData)
                     {
                        scItem = new ScrapItemClipArt();
                        this.toBeDisposed.push(scItem);
                        this.listenForLoad(scItem);
                        scItem.dataObject = item;
                        if(part.Stickers)
                        {
                           part.Stickers.scrollRect = part.Stickers.getBounds(part.Stickers);
                           part.Stickers.addChild(scItem);
                        }
                     }
                  }
               }
               i++;
            }
            if(dataObj.pattern)
            {
               pattern = new PatternLoader(mc);
               this.toBeDisposed.push(pattern);
               if(pattern.hasPatternParts())
               {
                  this.listenForLoad(pattern);
                  pattern.dataObject = dataObj.pattern;
               }
            }
            if(this.itemsLeftToLoad == 0)
            {
               done = function():void
               {
                  t.removeEventListener(TimerEvent.TIMER,done);
                  onDesignLoaded();
               };
               t = new Timer(1,1);
               t.addEventListener(TimerEvent.TIMER,done);
               t.start();
            }
         }
         else
         {
            this.onDesignLoaded();
         }
      }
      
      private function listenForLoad(param1:IEventDispatcher) : void
      {
         ++this.itemsLeftToLoad;
         param1.addEventListener(ScrapItemEvent.ITEM_COMPLETE,this.onItemComplete);
         param1.addEventListener(ScrapItemEvent.ITEM_FAILED,this.onItemFailed);
      }
      
      private function onItemFailed(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(ScrapItemEvent.ITEM_COMPLETE,this.onItemComplete);
         (param1.target as IEventDispatcher).removeEventListener(ScrapItemEvent.ITEM_FAILED,this.onItemFailed);
         --this.itemsLeftToLoad;
         if(this.itemsLeftToLoad <= 0)
         {
            this.onDesignLoadFailed();
         }
      }
      
      private function onItemComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(ScrapItemEvent.ITEM_COMPLETE,this.onItemComplete);
         (param1.target as IEventDispatcher).removeEventListener(ScrapItemEvent.ITEM_FAILED,this.onItemFailed);
         --this.itemsLeftToLoad;
         if(this.itemsLeftToLoad <= 0)
         {
            this.onDesignLoaded();
         }
      }
      
      private function onDesignLoadFailed() : void
      {
         this.eventBus.dispatchEvent(new ClothesEvent(ClothesEvent.CLOTHES_FAILED));
         this.nullifyVars();
      }
      
      private function onDesignLoaded() : void
      {
         this.eventBus.dispatchEvent(new ClothesEvent(ClothesEvent.CLOTHES_COMPLETE));
         if(this.loadCallback != null)
         {
            this.loadCallback(this.mc);
         }
         this.nullifyVars();
      }
      
      private function nullifyVars() : void
      {
         this.loadCallback = null;
         this.mc = null;
         this.eventBus = null;
      }
      
      public function dispose() : void
      {
         this.nullifyVars();
         while(this.toBeDisposed.length > 0)
         {
            this.toBeDisposed.pop().destroy();
         }
      }
   }
}

