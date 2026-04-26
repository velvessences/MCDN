package com.moviestarplanet.magazine
{
   import com.moviestarplanet.Components.Friends.FriendshipManager;
   import com.moviestarplanet.magazine.advertisement.MagazineCornerAdvertisement;
   import com.moviestarplanet.magazine.info.MagazineInfo;
   import com.moviestarplanet.magazine.redeem.request.MagazineRedeemView;
   import com.moviestarplanet.magazine.redeem.success.MagazineRedeemSuccess;
   import com.moviestarplanet.model.notification.NotificationType;
   import com.moviestarplanet.redeem.RedeemController;
   import com.moviestarplanet.redeem.RedeemModel;
   import com.moviestarplanet.redeem.RedeemModelInterface;
   import com.moviestarplanet.redeem.RedeemViewInterface;
   import com.moviestarplanet.window.stack.WindowStack;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import mx.core.FlexSprite;
   import mx.core.UIComponent;
   
   public class MagazineController
   {
      
      private static const VIEWPORT_RECT:Rectangle = new Rectangle(235,80,980,500);
      
      private static const LEVEL_UP_ANIMATION_SIZE:Number = 550;
      
      private static const LEVEL_UP_ANIMATION_VERTICAL_OFFSET:Number = -50;
      
      public function MagazineController()
      {
         super();
      }
      
      public static function openMagazineRedeem() : void
      {
         var internalSuccess:Function = null;
         var view:RedeemViewInterface = null;
         internalSuccess = function():void
         {
            RedeemController.closeRedeem(view);
            MagazineController.openMagazineCongratulations();
         };
         var success:Function = internalSuccess;
         var model:RedeemModelInterface = new RedeemModel(1,success);
         view = new MagazineRedeemView(model);
         var graphicsRectangle:Rectangle = new Rectangle(0,0,480,380);
         var x:Number = VIEWPORT_RECT.x + (VIEWPORT_RECT.width - graphicsRectangle.width) / 2;
         var y:Number = VIEWPORT_RECT.y + (VIEWPORT_RECT.height - graphicsRectangle.height) / 2;
         RedeemController.openRedeem(view,x,y);
      }
      
      public static function openMagazineInfo(param1:String) : void
      {
         var _loc2_:MagazineInfo = new MagazineInfo(param1);
         WindowStack.showSpriteAsViewStackable(_loc2_ as Sprite,VIEWPORT_RECT.x,VIEWPORT_RECT.y,WindowStack.Z_INFO);
      }
      
      public static function closeMagazineInfo(param1:MagazineInfo) : void
      {
         WindowStack.removeSpriteViewStackable(param1 as Sprite);
      }
      
      public static function openMagazineCongratulations() : void
      {
         FriendshipManager.getInstance().sendBasicEventToFriends(NotificationType.REDEEM_MAGAZINE.type);
         var _loc1_:MagazineRedeemSuccess = new MagazineRedeemSuccess();
         var _loc2_:Number = VIEWPORT_RECT.width / 2 + VIEWPORT_RECT.x - LEVEL_UP_ANIMATION_SIZE / 2;
         var _loc3_:Number = VIEWPORT_RECT.height / 2 + VIEWPORT_RECT.y - LEVEL_UP_ANIMATION_SIZE / 2 + LEVEL_UP_ANIMATION_VERTICAL_OFFSET;
         WindowStack.showSpriteAsViewStackable(_loc1_ as Sprite,_loc2_,_loc3_,WindowStack.Z_NOTICE);
      }
      
      public static function addMagazineAd(param1:DisplayObjectContainer, param2:Rectangle, param3:String) : void
      {
         var _loc5_:UIComponent = null;
         if(param1 is FlexSprite)
         {
            _loc5_ = new UIComponent();
            param1.addChild(_loc5_);
            param1 = _loc5_;
         }
         var _loc4_:MagazineCornerAdvertisement = new MagazineCornerAdvertisement(param3);
         _loc4_.x = param2.x + param2.width;
         _loc4_.y = param2.y + param2.height;
         param1.addChild(_loc4_);
      }
      
      public static function closeCongratulationsRedeem(param1:DisplayObject) : void
      {
         WindowStack.removeSpriteViewStackable(param1 as Sprite);
      }
   }
}

