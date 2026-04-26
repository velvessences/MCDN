package com.moviestarplanet.movies.Module
{
   import com.moviestarplanet.Module.ModuleInterface;
   import flash.display.DisplayObjectContainer;
   
   public interface IMovieModuleInfo extends ModuleInterface
   {
      
      function openMovieBrowser() : void;
      
      function PlayMovie(param1:int) : void;
      
      function PlayMovieInParent(param1:int, param2:DisplayObjectContainer) : void;
      
      function CloseMovie() : void;
      
      function EditMovieDetails(param1:int, param2:Boolean = true) : void;
      
      function NewMovie(param1:Boolean = true) : void;
      
      function closeDownCurrentlyLoadingMovieDetails() : void;
      
      function EditMovie(param1:int, param2:Boolean = false, param3:Boolean = false, param4:Boolean = true) : void;
      
      function selectMovieItem(param1:int, param2:int, param3:int, param4:Boolean = true, param5:String = "") : void;
      
      function setIsOpeningMovieStudioToFalse() : void;
      
      function loadAutoSavedMovie(param1:Number) : void;
      
      function setIsLoadingAutoSavedMovieInitially(param1:Boolean) : void;
   }
}

