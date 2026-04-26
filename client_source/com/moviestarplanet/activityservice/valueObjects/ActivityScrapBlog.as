package com.moviestarplanet.activityservice.valueObjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class ActivityScrapBlog
   {
      
      public var ScrapBlogId:int;
      
      public var ActorId:int;
      
      public var Created:Date;
      
      public var Name:String;
      
      public var Likes:int;
      
      public var FameEarned:int;
      
      public var ScrapBlogType:int;
      
      public var Activities:Object;
      
      public function ActivityScrapBlog()
      {
         super();
      }
      
      public function get filteredName() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Name);
      }
   }
}

