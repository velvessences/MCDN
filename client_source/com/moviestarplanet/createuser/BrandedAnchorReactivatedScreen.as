package com.moviestarplanet.createuser
{
   import com.moviestarplanet.SpecialCharacters.SpCharGraphicsManager;
   import com.moviestarplanet.anchorCharacters.AnchorCharacters;
   import com.moviestarplanet.utils.ui.FlashInstanceUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class BrandedAnchorReactivatedScreen extends BrandedAnchorGiftScreen
   {
      
      private static var BRANDED_SNAPSHOT_READY:String = "BRANDED_SNAPSHOT_READY";
      
      private var closeCallback:Function;
      
      private var brandedSnapshot:DisplayObject;
      
      public function BrandedAnchorReactivatedScreen(param1:int, param2:Array, param3:Function)
      {
         super(param1,param2);
         this.closeCallback = param3;
         eventController.listenForEvent(eventdispatcher,BRANDED_SNAPSHOT_READY);
      }
      
      override public function show() : void
      {
         super.show();
         SpCharGraphicsManager.loadSponsoredCharacterGraphic(actorId,SpCharGraphicsManager.ACTIVITY_BAR_WEB,this.onSnapshotLoaded);
      }
      
      private function onSnapshotLoaded(param1:DisplayObject) : void
      {
         this.brandedSnapshot = param1;
         eventdispatcher.dispatchEvent(new Event(BRANDED_SNAPSHOT_READY));
      }
      
      override protected function onAllReady() : void
      {
         super.onAllReady();
         FlashInstanceUtils.addItemToInstance(this.brandedSnapshot,avatarPlaceHolder,true,true,false);
      }
      
      override protected function close() : void
      {
         super.close();
         this.closeCallback();
         this.closeCallback = null;
      }
      
      override protected function get headlineText() : String
      {
         var _loc1_:String = AnchorCharacters.getSpecialCharacterInfo(actorId).ReactivationMessage;
         return _loc1_ == null ? "" : _loc1_;
      }
   }
}

