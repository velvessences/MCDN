package com.moviestarplanet.movie.valueobjects
{
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import flash.utils.ByteArray;
   import mx.collections.ArrayCollection;
   
   public class Movie
   {
      
      public var MovieId:int;
      
      public var Name:String;
      
      public var ActorId:int;
      
      public var Guid:String;
      
      public var State:int;
      
      public var WatchedTotalCount:int;
      
      public var WatchedActorCount:int;
      
      public var RatedCount:int;
      
      public var RatedTotalScore:int;
      
      public var CreatedDate:Date;
      
      public var PublishedDate:Date;
      
      public var AverageRating:Number;
      
      public var StarCoinsEarned:int;
      
      public var MovieData:ByteArray;
      
      public var Complexity:int;
      
      public var CompetitionDate:Date;
      
      public var ActorClothesData:ByteArray;
      
      public var MovieActorRels:ArrayCollection;
      
      public var Scenes:ArrayCollection;
      
      public function Movie()
      {
         super();
      }
      
      public function get filteredName() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Name);
      }
      
      public function get movieURL() : String
      {
         return "https://" + Config.CurrentDomain + "?sm=" + this.Guid;
      }
   }
}

