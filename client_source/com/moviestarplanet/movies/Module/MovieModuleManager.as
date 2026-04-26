package com.moviestarplanet.movies.Module
{
   import com.moviestarplanet.Module.AbstractModuleManager;
   import com.moviestarplanet.Module.ModuleInterface;
   import com.moviestarplanet.dailyCompetition.DailyCompetition;
   import flash.display.DisplayObjectContainer;
   
   public class MovieModuleManager extends AbstractModuleManager
   {
      
      private static var instance:MovieModuleManager;
      
      public function MovieModuleManager()
      {
         super();
      }
      
      public static function getInstance() : MovieModuleManager
      {
         if(instance == null)
         {
            instance = new MovieModuleManager();
         }
         return instance;
      }
      
      override protected function getLoadingThemeColor() : uint
      {
         return 0;
      }
      
      override protected function get moduleName() : String
      {
         return "MovieModule";
      }
      
      private function getMovieModule(param1:Function) : void
      {
         var moduleComplete:Function;
         var callback:Function = param1;
         var module:ModuleInterface = getModule();
         if(module == null)
         {
            moduleComplete = function():void
            {
               callback(IMovieModuleInfo(getModule()));
            };
            loadModule(moduleComplete);
         }
         else
         {
            callback(IMovieModuleInfo(module));
         }
      }
      
      public function openMovieBrowser() : void
      {
         var moduleLoaded:Function = null;
         moduleLoaded = function(param1:IMovieModuleInfo):void
         {
            param1.openMovieBrowser();
         };
         this.getMovieModule(moduleLoaded);
      }
      
      public function PlayMovie(param1:int) : void
      {
         var moduleLoaded:Function = null;
         var movieId:int = param1;
         moduleLoaded = function(param1:IMovieModuleInfo):void
         {
            param1.PlayMovie(movieId);
         };
         this.getMovieModule(moduleLoaded);
      }
      
      public function PlayMovieInParent(param1:int, param2:DisplayObjectContainer) : void
      {
         var moduleLoaded:Function = null;
         var movieId:int = param1;
         var parent:DisplayObjectContainer = param2;
         moduleLoaded = function(param1:IMovieModuleInfo):void
         {
            param1.PlayMovieInParent(movieId,parent);
            DailyCompetition.hide();
         };
         this.getMovieModule(moduleLoaded);
      }
      
      public function CloseMovie() : void
      {
         var moduleLoaded:Function = null;
         moduleLoaded = function(param1:IMovieModuleInfo):void
         {
            param1.CloseMovie();
         };
         this.getMovieModule(moduleLoaded);
      }
      
      public function EditMovieDetails(param1:int, param2:Boolean = true) : void
      {
         var moduleLoaded:Function = null;
         var movieId:int = param1;
         var closePopups:Boolean = param2;
         moduleLoaded = function(param1:IMovieModuleInfo):void
         {
            param1.EditMovieDetails(movieId,closePopups);
         };
         this.getMovieModule(moduleLoaded);
      }
      
      public function NewMovie(param1:Boolean = true) : void
      {
         var moduleLoaded:Function = null;
         var closePopups:Boolean = param1;
         moduleLoaded = function(param1:IMovieModuleInfo):void
         {
            param1.NewMovie(closePopups);
         };
         this.getMovieModule(moduleLoaded);
      }
      
      public function closeDownCurrentlyLoadingMovieDetails() : void
      {
         var moduleLoaded:Function = null;
         moduleLoaded = function(param1:IMovieModuleInfo):void
         {
            param1.closeDownCurrentlyLoadingMovieDetails();
         };
         this.getMovieModule(moduleLoaded);
      }
      
      public function EditMovie(param1:int, param2:Boolean = false, param3:Boolean = false, param4:Boolean = true) : void
      {
         var moduleLoaded:Function = null;
         var movieId:int = param1;
         var useEditSpeechMode:Boolean = param2;
         var gotoMovieStudioInitially:Boolean = param3;
         var closePopups:Boolean = param4;
         moduleLoaded = function(param1:IMovieModuleInfo):void
         {
            param1.EditMovie(movieId,useEditSpeechMode,gotoMovieStudioInitially,closePopups);
         };
         this.getMovieModule(moduleLoaded);
      }
      
      public function selectMovieItem(param1:int, param2:int, param3:int, param4:Boolean = true, param5:String = "") : void
      {
         var moduleLoaded:Function = null;
         var authorId:int = param1;
         var movieId:int = param2;
         var movieState:int = param3;
         var closePopups:Boolean = param4;
         var contentName:String = param5;
         moduleLoaded = function(param1:IMovieModuleInfo):void
         {
            param1.selectMovieItem(authorId,movieId,movieState,closePopups,contentName);
         };
         this.getMovieModule(moduleLoaded);
      }
      
      public function setIsOpeningMovieStudioToFalse() : void
      {
         var moduleLoaded:Function = null;
         moduleLoaded = function(param1:IMovieModuleInfo):void
         {
            param1.setIsOpeningMovieStudioToFalse();
         };
         this.getMovieModule(moduleLoaded);
      }
      
      public function loadAutoSavedMovie(param1:Number) : void
      {
         var moduleLoaded:Function = null;
         var movieId:Number = param1;
         moduleLoaded = function(param1:IMovieModuleInfo):void
         {
            param1.loadAutoSavedMovie(movieId);
         };
         this.getMovieModule(moduleLoaded);
      }
      
      public function setIsLoadingAutoSavedMovieInitially(param1:Boolean) : void
      {
         var moduleLoaded:Function = null;
         var value:Boolean = param1;
         moduleLoaded = function(param1:IMovieModuleInfo):void
         {
            param1.setIsLoadingAutoSavedMovieInitially(value);
         };
         this.getMovieModule(moduleLoaded);
      }
   }
}

