package com.moviestarplanet.Forms.world.elements
{
   import com.moviestarplanet.Forms.minigame.MiniGameBase;
   import com.moviestarplanet.Forms.minigame.PrivateGameWindow;
   import com.moviestarplanet.Forms.minigame.casting.CastingMiniGame;
   import com.moviestarplanet.Forms.minigame.queue.RoomRequester;
   import com.moviestarplanet.Forms.minigame.quiz.QuizMiniGame;
   import com.moviestarplanet.Forms.minigame.votegame.dressup.DressupMiniGame;
   import com.moviestarplanet.Forms.minigame.votegame.dressup.exclusivedressup.ExclusiveDressup;
   import com.moviestarplanet.Forms.minigame.votegame.word.WordRelationMinigame;
   import com.moviestarplanet.chat.ChatRoomController;
   import com.moviestarplanet.chatCommunicator.chatHelpers.configuration.InputLocations;
   import com.moviestarplanet.earningutils.service.FameSwitch;
   import com.moviestarplanet.games.EmbeddedGames.EmbeddedGamesModuleManager;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import mx.core.UIComponent;
   
   public class MiniGameType extends BaseWorldElement
   {
      
      private static var minigames:Array = [];
      
      public static const CASTING_MINIGAME:MiniGameType = new MiniGameType("AUDITION_GAME_HEADLINE","theStage",new CastingMiniGame(),"graphics/CastingGameBg.swf","Casting",InputLocations.LOC_CHAT_CASTING);
      
      public static const QUIZ_MINIGAME:MiniGameType = new MiniGameType("QUIZ_MINIGAME_HEADLINE","theQuiz",new QuizMiniGame(),"graphics/QuizGameBg.swf","Quiz",InputLocations.LOC_CHAT_QUIZ);
      
      public static const DRESSUP_MINIGAME:MiniGameType = new MiniGameType("DRESSUP_MINIGAME_HEADLINE","theDressup",new DressupMiniGame(),"graphics/DressUpBg.swf","DressUp",InputLocations.LOC_CHAT_DRESSUP);
      
      public static const CATWALK_MINIGAME:MiniGameType = new MiniGameType(FameSwitch.IsFameOverhaulSwitchOn ? "NEW_DYNTXT_LAYOUT_BUTTONS_CATWALK" : "DYNTXT_LAYOUT_BUTTONS_CATWALK","theExclusiveDressup",new ExclusiveDressup(),"graphics/DressUpVipBg.swf","Catwalk",InputLocations.LOC_CHAT_CATWALK);
      
      public static const CRAZYWORD_MINIGAME:MiniGameType = new MiniGameType("DYNTXT_LAYOUT_BUTTONS_CRAZYWORD","theWordRelation",new WordRelationMinigame(),"graphics/WordGameBg.swf","CrazyCards",InputLocations.LOC_CHAT_CRAZY_CARDS);
      
      public static const FRIEND_GAME:MiniGameType = new MiniGameType("DYNTXT_LAYOUT_BUTTONS_FRIENDGAME",null,null,null,"FriendGames",-1);
      
      public static const ARCADE_GAME:MiniGameType = new MiniGameType("DYNTXT_LAYOUT_BUTTONS_ARCADE","theArcade",null,null,"Arcade",InputLocations.LOC_ARCADE);
      
      private var _roomLocId:int;
      
      private var _bgSwfName:String;
      
      private var _minigameRoomStr:String;
      
      private var _minigameClass:MiniGameBase;
      
      private var _localizeRoomName:String;
      
      public function MiniGameType(param1:String, param2:String, param3:MiniGameBase, param4:String, param5:String, param6:int)
      {
         super(param1,param5);
         minigames.push(this);
         this._minigameRoomStr = param2;
         this._minigameClass = param3;
         this._bgSwfName = param4;
         this._localizeRoomName = MSPLocaleManagerWeb.getInstance().getString(param1);
         this._roomLocId = param6;
      }
      
      public static function getMinigameByClass(param1:MiniGameBase) : MiniGameType
      {
         var _loc2_:MiniGameType = null;
         for each(_loc2_ in minigames)
         {
            if(param1 == _loc2_.instance)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getMinigameByRoomStr(param1:String) : MiniGameType
      {
         var _loc2_:MiniGameType = null;
         for each(_loc2_ in minigames)
         {
            if(param1 != null && param1.indexOf(_loc2_.minigameRoomStr) != -1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function get allMiningameTypes() : Array
      {
         var _loc1_:Array = [];
         return _loc1_.concat(minigames);
      }
      
      public function get roomLocId() : int
      {
         return this._roomLocId;
      }
      
      public function get localizedRoomName() : String
      {
         return this._localizeRoomName;
      }
      
      public function get instance() : MiniGameBase
      {
         return this._minigameClass;
      }
      
      public function get backgroundSwfName() : String
      {
         return this._bgSwfName;
      }
      
      public function get minigameRoomStr() : String
      {
         return this._minigameRoomStr;
      }
      
      override public function enter() : void
      {
         var mainCanvas:UIComponent = null;
         switch(this)
         {
            case MiniGameType.FRIEND_GAME:
               mainCanvas = Main.Instance.mainCanvas;
               PrivateGameWindow.show(mainCanvas.mouseX,mainCanvas.mouseY);
               break;
            case MiniGameType.ARCADE_GAME:
               EmbeddedGamesModuleManager.getInstance().openEmbeddedGames();
               break;
            default:
               RoomRequester.requestGameRoom(this.minigameRoomStr,function(param1:String):void
               {
                  ChatRoomController.enterChatRoom(param1);
               });
         }
      }
   }
}

