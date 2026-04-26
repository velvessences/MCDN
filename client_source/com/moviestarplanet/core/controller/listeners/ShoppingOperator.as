package com.moviestarplanet.core.controller.listeners
{
   import com.moviestarplanet.Components.Friends.FriendshipManager;
   import com.moviestarplanet.Components.TreeBasedShopEditor;
   import com.moviestarplanet.Components.pushcontent.frienddisplayer.FriendDisplayerListItemForSocialShopping;
   import com.moviestarplanet.Forms.ActorOnlineStatusEvent;
   import com.moviestarplanet.admin.module.AdminModuleManager;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.friends.FriendsManager;
   import com.moviestarplanet.media.valueobjects.Background;
   import com.moviestarplanet.messaging.ChatViewManager;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.model.notification.NotificationType;
   import com.moviestarplanet.moviestar.valueObjects.FacePart;
   import com.moviestarplanet.payment.Module.PaymentManager;
   import com.moviestarplanet.payment.PaymentModuleExternalManager;
   import com.moviestarplanet.services.wrappers.SessionService;
   import com.moviestarplanet.shopping.hiddenShop.managers.SettingsManager;
   import com.moviestarplanet.shopping.hiddenShop.rendering.SelectionWindow;
   import com.moviestarplanet.shopping.module.ShoppingModuleManager;
   import com.moviestarplanet.shopping.module.clothesshop.service.SocialShoppingFMSConnection;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import flash.display.Sprite;
   import mx.managers.PopUpManager;
   
   public class ShoppingOperator
   {
      
      private static var _socialShoppingFMSConnection:SocialShoppingFMSConnection;
      
      public static var friendActorId:int = -1;
      
      private static var messageId:int = 0;
      
      private static var creatingConnection:Boolean = false;
      
      private static var sessionIndex:int = 0;
      
      public function ShoppingOperator()
      {
         super();
      }
      
      public static function wireup() : void
      {
         MessageCommunicator.subscribe(MSPEvent.OPEN_ANIMATION_SHOP,onOpenAnimationShop);
         MessageCommunicator.subscribe(MSPEvent.OPEN_OFFERS_VIEW,onOpenOffersView);
         MessageCommunicator.subscribe(MSPEvent.PAY_CERTIFICATE,onOpenCertificatePayView);
         MessageCommunicator.subscribe(MSPEvent.SOCIAL_SHOPPING_INITIALIZED,onSocialShoppingInitialized);
         MessageCommunicator.subscribe(MSPEvent.SOCIAL_SHOPPING_ENDED,resetSocialShopping);
         MessageCommunicator.subscribe(MSPEvent.GO_FROM_SOCIAL_TO_SINGLE_SHOPPING,onSocialShoppingEnded);
         MessageCommunicator.subscribe(MSPEvent.SOCIAL_SHOPPING_I_CHANGED_CLOTHES,onChangedClothes);
         MessageCommunicator.subscribe(MSPEvent.OPEN_ADMIN_THEME_SELECT,onClickAdminSortSearch);
         MessageCommunicator.subscribe(MSPEvent.SOCIAL_SHOPPING_CANCEL_INVITATIONS,cancelSocialShoppingRequests);
         MessageCommunicator.subscribe(MSPEvent.EDIT_BACKGROUND,onEditBackground);
         MessageCommunicator.subscribe(MSPEvent.BEAUTYCLINIC_EDIT_FACEPART,onClickEditFacePart);
      }
      
      private static function onClickEditFacePart(param1:MsgEvent) : void
      {
         var _loc2_:FacePart = param1.data != null ? param1.data.facePart : null;
         AdminModuleManager.getInstance().editFacepart(_loc2_);
      }
      
      private static function onEditBackground(param1:MsgEvent) : void
      {
         var _loc2_:Background = param1.data as Background;
         var _loc3_:TreeBasedShopEditor = new TreeBasedShopEditor();
         _loc3_.item = _loc2_;
         _loc3_.x = 800;
         _loc3_.y = 200;
         PopUpManager.addPopUp(_loc3_,Main.Instance);
      }
      
      private static function onClickAdminSortSearch(param1:MsgEvent) : void
      {
         var gotData:Function = null;
         var findThemes:Function = null;
         var e:MsgEvent = param1;
         findThemes = function(param1:Array):void
         {
            var _loc2_:Sprite = new SelectionWindow(gotData,param1,[]);
            gotThemeWindow(_loc2_);
         };
         var gotThemeWindow:Function = e.data.gotThemeWindow;
         gotData = e.data.gotData;
         SettingsManager.getThemes(findThemes,false);
      }
      
      private static function onOpenCertificatePayView(param1:MsgEvent) : void
      {
         if(param1.data.isFrontPage)
         {
            PaymentManager.getInstance().openSelectPaymentView(param1.data.domainObject,param1.data.country,param1.data.extraParams,false,param1.data.isFrontPage);
         }
         else
         {
            PaymentManager.getInstance().openSelectPaymentView(param1.data.domainObject,param1.data.country,param1.data.extraParams,false);
         }
      }
      
      private static function onOpenAnimationShop(param1:MsgEvent) : void
      {
         ShoppingModuleManager.getInstance().openAnimationShop();
      }
      
      private static function onOpenOffersView(param1:MsgEvent) : void
      {
         PaymentModuleExternalManager.getInstance().openPurchaseFlow();
      }
      
      private static function onSocialShoppingInitialized(param1:MsgEvent) : void
      {
         FriendDisplayerListItemForSocialShopping.clearInvitedFriends();
         MessageCommunicator.subscribe(MSPEvent.SOCIAL_SHOPPING_CONNECTING_YOU,tryConnectToFriend);
         MessageCommunicator.subscribe(MSPEvent.SOCIAL_SHOPPING_STOP_CONNECTING,stopTryingToConnectToFriend);
         FriendsManager.getInstance().addListener(ActorOnlineStatusEvent.ON_ACTOR_OFFLINE,FriendWentOffline,false,0,true);
         var _loc2_:Object = param1.data;
         friendActorId = _loc2_.actorId;
         ChatViewManager.getInstance().showChatForm(47,225,null,friendActorId);
      }
      
      private static function getRoomName(param1:int, param2:int) : String
      {
         var _loc3_:String = null;
         if(param1 > param2)
         {
            _loc3_ = param2 + "_" + param1;
         }
         else
         {
            _loc3_ = param1 + "_" + param2;
         }
         return "socshop_" + _loc3_ + "_" + Config.getCurrentSiteConfig().Language;
      }
      
      public static function onSocialShoppingEnded(param1:MsgEvent = null, param2:int = -1) : void
      {
         var _loc3_:int = 0;
         if(param2 != -1)
         {
            _loc3_ = param2;
         }
         else
         {
            _loc3_ = param1.data;
         }
         creatingConnection = false;
         FriendshipManager.getInstance().sendBasicEventToFriends(NotificationType.SOCIALSHOPPING_FRIEND_LEFT.type);
         resetSocialShopping();
         FriendsManager.getInstance().removeListener(ActorOnlineStatusEvent.ON_ACTOR_OFFLINE,FriendWentOffline);
         ++messageId;
      }
      
      private static function resetSocialShopping(param1:MsgEvent = null) : void
      {
         if(friendActorId == -1)
         {
            return;
         }
         friendActorId = -1;
         if(_socialShoppingFMSConnection)
         {
            _socialShoppingFMSConnection.disconnect();
            _socialShoppingFMSConnection.destroy();
            _socialShoppingFMSConnection = null;
         }
         stopTryingToConnectToFriend(null);
      }
      
      private static function onChangedClothes(param1:MsgEvent) : void
      {
         var _loc2_:Object = param1.data.msAppearanceData;
         var _loc3_:int = int(param1.data.shoppingFriendId);
         var _loc4_:Object = new Object();
         _loc4_.type = "SOCIALSHOPPING_CHANGED_CLOTHES";
         _loc4_.msAppearanceData = _loc2_;
         _loc4_.action = param1.data.action;
         var _loc5_:String = ActorSession.getActorId().toString() + "::" + _loc3_.toString() + ":" + messageId.toString() + ":";
         _socialShoppingFMSConnection.sendRawData(_loc5_,_loc4_);
         ++messageId;
      }
      
      private static function setupConnection(param1:Function, param2:int) : void
      {
         var onChatServerName:Function = null;
         var onConnected:Function = null;
         var onJoinFail:Function = null;
         var onJoined:Function = null;
         var connectionReady:Function = param1;
         var friendId:int = param2;
         onChatServerName = function(param1:String):void
         {
            _socialShoppingFMSConnection = new SocialShoppingFMSConnection(ActorSession.getActorId(),Config.getCurrentSiteConfig().Language,param1);
            var _loc2_:String = getRoomName(friendId,ActorSession.getActorId());
            _socialShoppingFMSConnection.connect("socialShopping",_loc2_,onConnected);
         };
         onConnected = function(param1:Boolean):void
         {
            _socialShoppingFMSConnection.joinSpecific(onJoined,onJoinFail,null);
         };
         onJoinFail = function():void
         {
         };
         onJoined = function(param1:Object):void
         {
            connectionReady();
         };
         SessionService.GetAppSetting("chatFMSServer",onChatServerName);
      }
      
      private static function FriendWentOffline(param1:ActorOnlineStatusEvent) : void
      {
         if(param1.friend.userId == friendActorId)
         {
            MessageCommunicator.sendMessage(MSPEvent.SOCIAL_SHOPPING_FRIEND_LEFT,null);
            resetSocialShopping();
         }
      }
      
      private static function tryConnectToFriend(param1:MsgEvent) : void
      {
         var onConnectionReady:Function = null;
         var e:MsgEvent = param1;
         onConnectionReady = function():void
         {
            creatingConnection = false;
            var _loc1_:Object = new Object();
            _loc1_.type = "SOCIALSHOPPING_CONNECTING";
            _loc1_.shoppingFriendId = ActorSession.getActorId();
            _loc1_.friendIsConnected = e.data.friendIsConnected;
            _loc1_.bothAreReady = e.data.bothAreReady;
            _loc1_.readyToSynch = e.data.readyToSynch;
            var _loc2_:int = int(e.data.shoppingFriendId);
            ++messageId;
            var _loc3_:String = ActorSession.getActorId().toString() + "::" + _loc2_.toString() + ":" + messageId.toString() + ":";
            FriendshipManager.getInstance().sendLegacyObjectEventToFriend(_loc1_,_loc2_);
         };
         if(creatingConnection)
         {
            return;
         }
         if(!_socialShoppingFMSConnection)
         {
            creatingConnection = true;
            setupConnection(onConnectionReady,e.data.shoppingFriendId);
         }
         else
         {
            onConnectionReady();
         }
      }
      
      private static function stopTryingToConnectToFriend(param1:MsgEvent) : void
      {
         MessageCommunicator.unscribe(MSPEvent.SOCIAL_SHOPPING_CONNECTING_YOU,tryConnectToFriend);
         MessageCommunicator.unscribe(MSPEvent.SOCIAL_SHOPPING_STOP_CONNECTING,stopTryingToConnectToFriend);
      }
      
      private static function cancelSocialShoppingRequests(param1:MsgEvent) : void
      {
         var _loc5_:String = null;
         var _loc2_:Array = param1.data.invitedFriendsIds;
         var _loc3_:int = int(param1.data.shoppingFriendId);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            FriendshipManager.getInstance().sendBasicEventToFriend(NotificationType.SOCIALSHOPPING_INVITATION_REJECTED.type,_loc2_[_loc4_]);
            if(_loc3_ != _loc2_[_loc4_])
            {
               _loc5_ = MSPLocaleManagerWeb.getInstance().getString("SHOP_SOCIAL_INVITATIONCANCELLED_TOOLTIP");
               Main.Instance.mainCanvas.applicationViewStack.mainView.friendActivityListComponent.switchActivityAppearence(_loc2_[_loc4_],NotificationType.SOCIALSHOPPING_FRIEND_HAS_RECEIVED_REQUEST.type,Config.toAbsoluteURL("img/statusPopup/shoppingBagDisappearing.swf",Config.LOCAL_CDN_URL),_loc5_);
            }
            else
            {
               Main.Instance.mainCanvas.applicationViewStack.mainView.friendActivityListComponent.removeActivity(_loc3_,NotificationType.SOCIALSHOPPING_FRIEND_HAS_RECEIVED_REQUEST.type);
            }
            ++messageId;
            _loc4_++;
         }
         FriendDisplayerListItemForSocialShopping.clearInvitedFriends();
      }
   }
}

