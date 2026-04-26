package com.moviestarplanet.scrapblog.valueobjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class ScrapBlogListItem
   {
      
      public var ScrapBlogId:int;
      
      public var ActorId:int;
      
      public var Created:Date;
      
      public var Name:String;
      
      public var Likes:int;
      
      public var Deleted:int;
      
      public var Status:int;
      
      public var FameEarned:int;
      
      public var ScrapBlogType:int;
      
      public var TemplateType:int;
      
      public var PublishedDate:Date;
      
      public var CommentsCount:int;
      
      public var ScrapBlogActorName:ScrapBlogActorNameValueObject;
      
      public function ScrapBlogListItem()
      {
         super();
      }
      
      public function get filteredName() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Name);
      }
   }
}

