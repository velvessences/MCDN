package com.moviestarplanet.moviestar.controller
{
   import com.moviestarplanet.actorutils.ClothInfoUtils;
   import com.moviestarplanet.moviestar.ClothingCategories;
   import com.moviestarplanet.moviestar.service.MovieStarService;
   import com.moviestarplanet.moviestar.utils.ActorCache;
   
   public class InitializeMovieStarServiceCommand
   {
      
      public function InitializeMovieStarServiceCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         ActorCache.movieStarService = new MovieStarService();
         ClothInfoUtils.categoryInfo = new ClothingCategories();
      }
   }
}

