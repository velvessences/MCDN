package com.moviestarplanet.scrapblog.valueobjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import flash.utils.ByteArray;
   import mx.collections.ArrayCollection;
   
   public class ScrapBlog
   {
      
      public static const SB_STATUS_PRIVATE:int = 0;
      
      public static const SB_STATUS_PUBLIC:int = 1;
      
      public static const SB_STATUS_NEWS:int = 2;
      
      public static const SB_STATUS_SUBMITTED:int = 3;
      
      public var ScrapBlogId:int;
      
      public var ActorId:int;
      
      public var Created:Date;
      
      public var Name:String;
      
      public var ScrapBlogData:ByteArray;
      
      public var Likes:int;
      
      public var Deleted:int;
      
      public var Complexity:int;
      
      public var Status:int;
      
      public var FameEarned:int;
      
      public var ScrapBlogType:int;
      
      public var TemplateType:int;
      
      public var PublishedDate:Date;
      
      public var CommentsCount:int;
      
      public var ScrapBlogActorLikes:ArrayCollection;
      
      public function ScrapBlog()
      {
         super();
      }
      
      public function setActorLikes(param1:Array) : void
      {
         this.ScrapBlogActorLikes = new ArrayCollection(param1);
      }
      
      public function hasActorLikedIt() : Boolean
      {
         return this.ScrapBlogActorLikes != null && this.ScrapBlogActorLikes.length > 0;
      }
      
      public function get filteredName() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Name);
      }
   }
}

