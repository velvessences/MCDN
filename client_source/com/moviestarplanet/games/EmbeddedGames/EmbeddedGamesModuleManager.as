package com.moviestarplanet.games.EmbeddedGames
{
   import com.moviestarplanet.Module.AbstractModuleManager;
   import com.moviestarplanet.Module.ModuleInterface;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.msg.events.CareerQuestEvent;
   import com.moviestarplanet.msg.events.CareerQuestsGoToDestinations;
   
   public class EmbeddedGamesModuleManager extends AbstractModuleManager
   {
      
      private static var instance:EmbeddedGamesModuleManager;
      
      public function EmbeddedGamesModuleManager()
      {
         super();
      }
      
      public static function getInstance() : EmbeddedGamesModuleManager
      {
         if(instance == null)
         {
            instance = new EmbeddedGamesModuleManager();
         }
         return instance;
      }
      
      override protected function getLoadingThemeColor() : uint
      {
         return 0;
      }
      
      override protected function get moduleName() : String
      {
         return "EmbeddedGamesModule";
      }
      
      private function get embeddedGamesModuleI() : IEmbeddedGamesModule
      {
         return getModule() as IEmbeddedGamesModule;
      }
      
      private function getEmbeddedGameModule(param1:Function) : void
      {
         var moduleComplete:Function;
         var callback:Function = param1;
         var module:ModuleInterface = getModule();
         if(module == null)
         {
            moduleComplete = function():void
            {
               callback(IEmbeddedGamesModule(getModule()));
            };
            loadModule(moduleComplete);
         }
         else
         {
            callback(IEmbeddedGamesModule(module));
         }
      }
      
      public function openEmbeddedGames(param1:int = 0) : void
      {
         var moduleReturned:Function = null;
         var loadGameId:int = param1;
         moduleReturned = function(param1:IEmbeddedGamesModule):void
         {
            param1.openEmbeddedGames(new EmbeddedGamesMainManager(),loadGameId);
         };
         MessageCommunicator.send(new MsgEvent(CareerQuestEvent.USER_CLICKED_BUTTON,CareerQuestsGoToDestinations.ENTER_ARCADE));
         this.getEmbeddedGameModule(moduleReturned);
      }
      
      public function get isPlaying() : Boolean
      {
         var _loc1_:IEmbeddedGamesModule = getModule() as IEmbeddedGamesModule;
         if(_loc1_ == null)
         {
            return false;
         }
         return _loc1_.isPlaying;
      }
      
      public function closeGame() : void
      {
         var _loc1_:IEmbeddedGamesModule = getModule() as IEmbeddedGamesModule;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.closeGame();
      }
   }
}

