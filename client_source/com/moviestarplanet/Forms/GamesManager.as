package com.moviestarplanet.Forms
{
   import com.moviestarplanet.Components.GamesSelector.PlayerSelectorInfo;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.moviestar.valueObjects.Actor;
   import com.moviestarplanet.popup.OldPopupHandler;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   
   public class GamesManager
   {
      
      private static var gameLabel:String;
      
      private static var playerSelectorInfo:PlayerSelectorInfo;
      
      private static var _selectedActor:Actor;
      
      public static const REQUEST_DANCE_BATTLE_CHATROOM_GAME:String = "REQUEST_DANCE_BATTLE_CHATROOM_GAME";
      
      public static const REQUEST_FIGHT_BATTLE_CHATROOM_GAME:String = "REQUEST_FIGHT_BATTLE_CHATROOM_GAME";
      
      public static const REQUEST_FLASH_BATTLE_CHATROOM_GAME:String = "REQUEST_FLASH_BATTLE_CHATROOM_GAME";
      
      public static const REQUEST_FLASH_BATTLE_ADVANCED_CHATROOM_GAME:String = "REQUEST_FLASH_BATTLE_ADVANCED_CHATROOM_GAME";
      
      public static const REQUEST_CATCH_STARS_CHATROOM_GAME:String = "REQUEST_CATCH_STARS_CHATROOM_GAME";
      
      public static const REQUEST_QUIZ_CHATROOM_GAME:String = "REQUEST_QUIZ_CHATROOM_GAME";
      
      public static const NO_GAME:int = 0;
      
      public static const DANCE_BATTLE_CHATROOM_GAME:int = 1;
      
      public static const FIGHT_BATTLE_CHATROOM_GAME:int = 2;
      
      public static const FLASH_BATTLE_CHATROOM_GAME:int = 3;
      
      public static const FLASH_BATTLE_ADVANCED_CHATROOM_GAME:int = 4;
      
      public static const CATCH_STARS_CHATROOM_GAME:int = 5;
      
      public static const QUIZ_CHATROOM_GAME:int = 6;
      
      private static var selectedGame:int = 0;
      
      public function GamesManager()
      {
         super();
      }
      
      public static function set selectedActor(param1:Actor) : void
      {
         _selectedActor = param1;
      }
      
      public static function get selectedActor() : Actor
      {
         return _selectedActor;
      }
      
      public static function openPlayerSelectorInfo() : void
      {
         if(playerSelectorInfo == null)
         {
            playerSelectorInfo = new PlayerSelectorInfo();
         }
         playerSelectorInfo.gameLabel = gameLabel;
         OldPopupHandler.getInstance().showPopup(playerSelectorInfo,545,95,false);
      }
      
      public static function requestDanceBattleChatroomGame() : void
      {
         selectedGame = DANCE_BATTLE_CHATROOM_GAME;
         gameLabel = MSPLocaleManagerWeb.getInstance().getString("DANCE_BATTLE");
      }
      
      public static function requestFightBattleChatroomGame() : void
      {
         selectedGame = FIGHT_BATTLE_CHATROOM_GAME;
         gameLabel = MSPLocaleManagerWeb.getInstance().getString("FIGHT_BATTLE");
      }
      
      public static function requestFlashBattleChatroomGame() : void
      {
         selectedGame = FLASH_BATTLE_CHATROOM_GAME;
         gameLabel = MSPLocaleManagerWeb.getInstance().getString("CATCH_HEARTS");
      }
      
      public static function requestFlashBattleChatroomGameAdvanced() : void
      {
         selectedGame = FLASH_BATTLE_ADVANCED_CHATROOM_GAME;
         gameLabel = MSPLocaleManagerWeb.getInstance().getString("SHOOT_STARS");
      }
      
      public static function requestCatchStarsChatroomGameAdvanced() : void
      {
         selectedGame = CATCH_STARS_CHATROOM_GAME;
         gameLabel = MSPLocaleManagerWeb.getInstance().getString("MONEY_RAIN");
      }
      
      public static function requestQuizChatroomGame() : void
      {
         selectedGame = QUIZ_CHATROOM_GAME;
         gameLabel = MSPLocaleManagerWeb.getInstance().getString("QUIZ_GAME");
      }
      
      public static function runSelectedGame(param1:int) : Boolean
      {
         if(!selectedGame)
         {
            return false;
         }
         switch(selectedGame)
         {
            case DANCE_BATTLE_CHATROOM_GAME:
               MessageCommunicator.sendMessage(REQUEST_DANCE_BATTLE_CHATROOM_GAME,param1);
               break;
            case FIGHT_BATTLE_CHATROOM_GAME:
               MessageCommunicator.sendMessage(REQUEST_FIGHT_BATTLE_CHATROOM_GAME,param1);
               break;
            case FLASH_BATTLE_CHATROOM_GAME:
               MessageCommunicator.sendMessage(REQUEST_FLASH_BATTLE_CHATROOM_GAME,param1);
               break;
            case FLASH_BATTLE_ADVANCED_CHATROOM_GAME:
               MessageCommunicator.sendMessage(REQUEST_FLASH_BATTLE_ADVANCED_CHATROOM_GAME,param1);
               break;
            case CATCH_STARS_CHATROOM_GAME:
               MessageCommunicator.sendMessage(REQUEST_CATCH_STARS_CHATROOM_GAME,param1);
               break;
            case QUIZ_CHATROOM_GAME:
               MessageCommunicator.sendMessage(REQUEST_QUIZ_CHATROOM_GAME,param1);
         }
         playerSelectorInfo.closeWindow();
         return true;
      }
      
      public static function resetSelectedGame() : void
      {
         selectedGame = 0;
      }
      
      public static function getSelectedGame() : int
      {
         return selectedGame;
      }
   }
}

