package com.moviestarplanet.Forms.world
{
   import com.moviestarplanet.Forms.world.elements.WorldArea;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.quest.gifthunt.GiftHuntManager;
   import flash.geom.Rectangle;
   import mx.core.Container;
   import mx.core.ScrollPolicy;
   
   public class MapHolder extends Container
   {
      
      private var mapCache:Object = new Object();
      
      public function MapHolder()
      {
         super();
         scrollRect = new Rectangle(0,0,980,500);
         this.horizontalScrollPolicy = ScrollPolicy.OFF;
         this.verticalScrollPolicy = ScrollPolicy.OFF;
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
      }
      
      public function show(param1:WorldArea) : void
      {
         GiftHuntManager.getInstance().clearSubscribedQueues();
         if(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
         if(param1 == null)
         {
            param1 = WorldArea.OVERVIEW;
         }
         var _loc2_:Boolean = false;
         var _loc3_:LocalMap = this.mapCache[param1.swfVarName];
         if(_loc3_ == null)
         {
            if(param1 == WorldArea.SHOPPING)
            {
               _loc3_ = new ShoppingMap(param1);
            }
            else if(param1 == WorldArea.PETS)
            {
               _loc3_ = new PetMap(param1);
            }
            else if(param1 == WorldArea.OVERVIEW)
            {
               _loc3_ = new OverviewMap(param1);
            }
            else if(param1 == WorldArea.GAMES)
            {
               _loc3_ = new MiniGamesMap(param1);
            }
            else
            {
               _loc3_ = new LocalMap(param1);
            }
            this.mapCache[param1.swfVarName] = _loc3_;
         }
         else
         {
            _loc2_ = true;
         }
         _loc3_.width = this.width;
         _loc3_.height = this.height;
         this.addChild(_loc3_);
         if(_loc2_)
         {
            MessageCommunicator.send(new MsgEvent(MSPEvent.MAP_LOAD_FROM_CACHE,_loc3_));
            _loc3_.addGiftsToArea();
         }
      }
      
      public function highlightButtons() : void
      {
         var _loc1_:LocalMap = this.getChildAt(0) as LocalMap;
         _loc1_.flashButtons();
      }
      
      public function getLocalMap() : LocalMap
      {
         return this.getChildAt(0) as LocalMap;
      }
   }
}

