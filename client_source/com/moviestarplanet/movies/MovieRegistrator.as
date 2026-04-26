package com.moviestarplanet.movies
{
   import com.moviestarplanet.commoninterfaces.IRegistrator;
   import com.moviestarplanet.movie.valueobjects.ActorRateListVO;
   import com.moviestarplanet.movie.valueobjects.KeyFrameActor;
   import com.moviestarplanet.movie.valueobjects.KeyFrameProp;
   import com.moviestarplanet.movie.valueobjects.Movie;
   import com.moviestarplanet.movie.valueobjects.MovieActorRel;
   import com.moviestarplanet.movie.valueobjects.MovieListItem;
   import com.moviestarplanet.movie.valueobjects.PagedMovieList;
   import com.moviestarplanet.movie.valueobjects.PagedMovieReviewList;
   import com.moviestarplanet.movie.valueobjects.Prop;
   import com.moviestarplanet.movie.valueobjects.RateMovie;
   import com.moviestarplanet.movie.valueobjects.RateMovieList;
   import com.moviestarplanet.movie.valueobjects.Scene;
   import com.moviestarplanet.moviestar.valueObjects.ActorClothesRel;
   import flash.net.registerClassAlias;
   import mx.collections.ArrayCollection;
   
   public class MovieRegistrator implements IRegistrator
   {
      
      private static var hasRegistered:Boolean = false;
      
      public function MovieRegistrator()
      {
         super();
      }
      
      public function registerClassAliases() : void
      {
         if(!hasRegistered)
         {
            registerClassAlias("ArrayOfScene",ArrayCollection);
            registerClassAlias("ArrayOfProp",ArrayCollection);
            registerClassAlias("ArrayOfKeyFrameActor",ArrayCollection);
            registerClassAlias("ArrayOfActorClothesRel",ArrayCollection);
            registerClassAlias("ArrayOfMovieActorRel",ArrayCollection);
            registerClassAlias("ArrayOfKeyFrameProp",ArrayCollection);
            registerClassAlias("MovieStarPlanet.DBML.ActorClothesRel",ActorClothesRel);
            registerClassAlias("MovieStarPlanet.DBML.ActorClothesContextRel",ActorClothesRel);
            registerClassAlias("Scene",Scene);
            registerClassAlias("Prop",Prop);
            registerClassAlias("KeyFrameActor",KeyFrameActor);
            registerClassAlias("MovieStarPlanet.DBML.MovieActorRel",MovieActorRel);
            registerClassAlias("KeyFrameProp",KeyFrameProp);
            registerClassAlias("MovieActorRel",MovieActorRel);
            registerClassAlias("MovieStarPlanet.DBML.Movie",Movie);
            registerClassAlias("MovieStarPlanet.Model.Movies.RateMovie",RateMovie);
            registerClassAlias("MovieStarPlanet.Model.Movies.RateMovieList",RateMovieList);
            registerClassAlias("MovieStarPlanet.WebService.MovieService.PagedMovieReviewList",PagedMovieReviewList);
            registerClassAlias("MovieStarPlanet.WebService.MovieService.PagedMovieList",PagedMovieList);
            registerClassAlias("MovieStarPlanet.WebService.MovieService.MovieListItem",MovieListItem);
            registerClassAlias("MovieStarPlanet.Model.Movies.ActorRateList",ActorRateListVO);
            hasRegistered = true;
         }
      }
   }
}

