package com.moviestarplanet.Components.Friends
{
   import com.moviestarplanet.window.stack.WindowStackableInterface;
   import com.moviestarplanet.window.utils.PopupUtils;
   import flash.events.Event;
   import mx.containers.Canvas;
   import mx.core.UIComponent;
   
   public class FriendshipContainer extends Canvas implements WindowStackableInterface
   {
      
      private static var previousFC:FriendshipContainer;
      
      private var bestFriendSelector:BestFriendSelector;
      
      public function FriendshipContainer()
      {
         super();
         this.bestFriendSelector = new BestFriendSelector(this);
         var _loc1_:UIComponent = new UIComponent();
         _loc1_.addChild(this.bestFriendSelector);
         addChild(_loc1_);
      }
      
      public static function showBestFriendSelectorPopUp(param1:int, param2:int, param3:Function = null) : void
      {
         var _loc4_:FriendshipContainer = new FriendshipContainer();
         _loc4_.bestFriendSelector.actorId = param1;
         _loc4_.bestFriendSelector.newBestFriendId = param2;
         _loc4_.bestFriendSelector.acceptCallback = param3;
         previousFC = _loc4_;
         PopupUtils.showPopupXY(_loc4_,235,80);
      }
      
      public static function closeGlobal() : void
      {
         if(previousFC == null)
         {
            return;
         }
         PopupUtils.removePopup(previousFC);
      }
      
      private function onCloseClick(param1:Event) : void
      {
         this.close();
      }
      
      public function close() : void
      {
         PopupUtils.removePopup(this);
      }
   }
}

