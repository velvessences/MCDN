package com.moviestarplanet.chat
{
   import com.moviestarplanet.contentservices.AMFContentService;
   import com.moviestarplanet.dressing.DressingModuleManager;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.moviestar.utils.ActorCache;
   import com.moviestarplanet.moviestar.valueObjects.Actor;
   import com.moviestarplanet.shopping.ShoppingModuleManager;
   import com.moviestarplanet.utils.chat.ChatLogic;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   import com.moviestarplanet.windowpopup.popup.PromptEvent;
   
   public class ThemeChatRoomControllerWeb
   {
      
      private static var useableIds:Array;
      
      private static var themeId:int;
      
      public function ThemeChatRoomControllerWeb()
      {
         super();
      }
      
      public static function hasRequiredItem(param1:String, param2:Function) : void
      {
         var useableIdsReady:Function = null;
         var onActorData:Function = null;
         var chatRoom:String = param1;
         var callback:Function = param2;
         useableIdsReady = function(param1:Array):void
         {
            useableIds = param1;
            ActorCache.loadActor(ActorSession.loggedInActor.ActorId,onActorData);
         };
         onActorData = function(param1:Actor):void
         {
            var _loc2_:Boolean = wearsClothes(param1.ActorClothesRels);
            if(_loc2_)
            {
               callback();
            }
            else
            {
               ownsThemeCloth(themeId);
            }
         };
         var isItemRequired:Boolean = ChatLogic.GetItemRequiredForChatRoom(chatRoom);
         themeId = ChatRoomType.worldThemeRoomInfo.requiredItemId;
         if(isItemRequired == false || themeId == 0)
         {
            callback();
            return;
         }
         if(useableIds == null || useableIds.length == 0)
         {
            AMFContentService.getItemsInCurrentTheme(themeId,useableIdsReady);
         }
         else
         {
            useableIdsReady(useableIds);
         }
      }
      
      private static function wearsClothes(param1:Array) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(Boolean(param1[_loc2_].IsWearing) && useableIds.indexOf(param1[_loc2_].Cloth.ClothesId) > -1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private static function onOwnsThemeCloth(param1:Boolean) : void
      {
         if(param1)
         {
            Prompt.showFriendly(MSPLocaleManagerWeb.getInstance().getString("CHATROOM_DYNAMIC_WEEKLY_THEME_ITEM_WEAR") + "\n" + MSPLocaleManagerWeb.getInstance().getString("CHATROOM_DYNAMIC_WEEKLY_GOTO_DRESSING_ROOM"),MSPLocaleManagerWeb.getInstance().getString("CHATROOM_DYNAMIC_WEEKLY_THEME_HEADLINE"),9,null,onOpenDressingRoom);
         }
         else
         {
            Prompt.showFriendly(MSPLocaleManagerWeb.getInstance().getString("CHATROOM_DYNAMIC_WEEKLY_THEME_ITEM_WEAR") + "\n" + MSPLocaleManagerWeb.getInstance().getString("CHATROOM_DYNAMIC_WEEKLY_GOTO_CLOTHES_SHOP"),MSPLocaleManagerWeb.getInstance().getString("CHATROOM_DYNAMIC_WEEKLY_THEME_HEADLINE"),9,null,onOpenClothesShop);
         }
      }
      
      private static function onOpenDressingRoom(param1:PromptEvent) : void
      {
         if(param1.detail == Prompt.YES)
         {
            DressingModuleManager.getInstance().openDressingRoom();
         }
      }
      
      private static function onOpenClothesShop(param1:PromptEvent) : void
      {
         if(param1.detail == Prompt.YES)
         {
            ShoppingModuleManager.getInstance().openClothesShop();
         }
      }
      
      private static function ownsThemeCloth(param1:int) : void
      {
         var gotClothes:Function = null;
         var themeId:int = param1;
         gotClothes = function(param1:Array):void
         {
            var _loc2_:* = int(param1.length - 1);
            while(_loc2_ >= 0)
            {
               if(useableIds.indexOf(param1[_loc2_].Cloth.ClothesId) > -1)
               {
                  onOwnsThemeCloth(true);
                  return;
               }
               _loc2_--;
            }
            onOwnsThemeCloth(false);
         };
         ActorCache.getInstance().getActorClothItems(ActorSession.loggedInActor.ActorId,gotClothes);
      }
   }
}

