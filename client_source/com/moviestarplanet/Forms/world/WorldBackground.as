package com.moviestarplanet.Forms.world
{
   import com.moviestarplanet.Forms.world.elements.WorldArea;
   import com.moviestarplanet.msg.EventController;
   import com.moviestarplanet.utils.MSP_SWFLoader;
   import com.moviestarplanet.utils.displayobject.FlattenUtilities;
   import com.moviestarplanet.utils.loader.RawUrl;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import mx.core.FlexGlobals;
   import mx.core.UIComponent;
   import mx.events.ResizeEvent;
   
   public class WorldBackground extends UIComponent
   {
      
      private var loader:MSP_SWFLoader;
      
      private var mHolder:UIComponent;
      
      public function WorldBackground()
      {
         super();
         this.loader = new MSP_SWFLoader(false);
         this.loader.autoLoad = false;
         var _loc1_:EventController = new EventController();
         if(stage == null)
         {
            _loc1_.listenForEvent(this,Event.ADDED_TO_STAGE);
         }
         _loc1_.listenForEvent(this.loader,Event.COMPLETE);
         _loc1_.notifyMe(this.alldone);
         this.mHolder = new UIComponent();
         addChild(this.mHolder);
      }
      
      private function alldone() : void
      {
         this.draw();
         FlexGlobals.topLevelApplication.addEventListener(ResizeEvent.RESIZE,this.resize,false,0,true);
      }
      
      private function resize(param1:Event) : void
      {
         this.draw();
      }
      
      private function draw() : void
      {
         var _loc1_:Number = stage.stageWidth / 1240;
         var _loc2_:Number = stage.stageHeight / 720;
         var _loc3_:Number = Number(Math.min(_loc1_,_loc2_));
         var _loc4_:Sprite = this.loader.content as Sprite;
         _loc4_.scrollRect = new Rectangle(0,0,stage.stageWidth / _loc3_,stage.stageHeight / _loc3_);
         FlattenUtilities.flattenSprite(_loc4_,_loc3_,true,false,false);
         if(this.mHolder.numChildren)
         {
            while(this.mHolder.numChildren)
            {
               this.mHolder.removeChildAt(0);
            }
         }
         this.mHolder.addChild(_loc4_);
      }
      
      public function load() : void
      {
         this.loader.LoadUrl(new RawUrl(WorldArea.BACKGROUND_SWF_PATH));
      }
   }
}

