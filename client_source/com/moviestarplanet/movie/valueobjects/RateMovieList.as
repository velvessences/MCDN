package com.moviestarplanet.movie.valueobjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class RateMovieList
   {
      
      public var RateMovieId:int;
      
      public var MovieId:int;
      
      public var ActorId:int;
      
      public var Score:int;
      
      public var RateDate:Date;
      
      public var ActorRateList:ActorRateListVO;
      
      public var Comment:String;
      
      public function RateMovieList()
      {
         super();
      }
      
      public function get filteredComment() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Comment);
      }
   }
}

