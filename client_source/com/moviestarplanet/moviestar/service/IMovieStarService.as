package com.moviestarplanet.moviestar.service
{
   public interface IMovieStarService
   {
      
      function loadMovieStarActor(param1:int, param2:Function, param3:Function = null) : void;
      
      function loadMovieStarActorFlat(param1:int, param2:Function, param3:Function = null) : void;
      
      function loadMovieStarActorList(param1:Array, param2:Function) : void;
      
      function getActorClothesByCategories(param1:Number, param2:Array, param3:Function, param4:Function) : void;
      
      function LoadActorItems(param1:int, param2:Function, param3:Function = null) : void;
   }
}

