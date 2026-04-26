package com.moviestarplanet.club.valueobjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class Club
   {
      
      public var ClubId:int;
      
      public var Name:String;
      
      public var BadgeScrapBlogId:int;
      
      public var DescriptionScrapBlogId:int;
      
      public var Created:Date;
      
      public var LastActivity:Date;
      
      public var MemberCount:int;
      
      public var Deleted:int;
      
      public var ClubType:int;
      
      public var Category:int;
      
      public function Club()
      {
         super();
      }
      
      public function get filteredName() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Name);
      }
   }
}

