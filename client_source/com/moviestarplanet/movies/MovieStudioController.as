package com.moviestarplanet.movies
{
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.movie.valueobjects.Movie;
   import com.moviestarplanet.moviestudio.MovieStudio;
   
   public class MovieStudioController
   {
      
      private static var instance:MovieStudioController;
      
      public var currentMovie:Movie;
      
      public var currentMovieStudioInEditMode:MovieStudio;
      
      public function MovieStudioController(param1:SingletonEnforcer)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Do not instantiate. Use getInstance().");
         }
      }
      
      public static function getInstance() : MovieStudioController
      {
         if(instance == null)
         {
            instance = new MovieStudioController(new SingletonEnforcer());
         }
         return instance;
      }
      
      public function updateMarkEditMovieInFriendList() : void
      {
         MessageCommunicator.sendMessage(MovieStudio.MovieStudioEditModeActiveChanged,null);
      }
      
      public function markEditMovieInFriendList(param1:Movie) : void
      {
         this.currentMovie = param1;
         this.updateMarkEditMovieInFriendList();
      }
      
      public function addActorToMovie(param1:Number) : void
      {
         this.currentMovieStudioInEditMode.addNewActorToScene(param1);
         this.updateMarkEditMovieInFriendList();
      }
      
      public function removeActorFromMovie(param1:Number) : void
      {
         MovieStudioController.getInstance().currentMovieStudioInEditMode.removeNewActorFromScene(param1);
         this.updateMarkEditMovieInFriendList();
      }
   }
}

class SingletonEnforcer
{
   
   public function SingletonEnforcer()
   {
      super();
   }
}
