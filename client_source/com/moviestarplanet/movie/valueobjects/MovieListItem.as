package com.moviestarplanet.movie.valueobjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class MovieListItem
   {
      
      public var movieId:int;
      
      public var name:String;
      
      public var movieState:int;
      
      public var movieGuid:String;
      
      public var directorId:int;
      
      public var date:Date;
      
      public var instructorName:String;
      
      public var watchTotalCount:int;
      
      public var ratedCount:int;
      
      public var ratedTotalScore:int;
      
      public var starCoinsEarned:int;
      
      public var membershipTimeoutDate:Date;
      
      public var VipTier:int;
      
      public var watched:Boolean;
      
      public var rated:Boolean;
      
      public function MovieListItem()
      {
         super();
      }
      
      public function get filteredName() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.name);
      }
   }
}

