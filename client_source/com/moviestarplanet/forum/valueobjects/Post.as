package com.moviestarplanet.forum.valueobjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class Post
   {
      
      public var PostId:int;
      
      public var TopicId:int;
      
      public var Message:String;
      
      public var ActorId:int;
      
      public var PostDate:Date;
      
      public var IsDeleted:int;
      
      public var ColorCode:int;
      
      public var ForumAuthor:com.moviestarplanet.forum.valueobjects.ForumAuthor;
      
      public var ChatLogId:Number;
      
      public function Post()
      {
         super();
      }
      
      public function get filteredMessage() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Message);
      }
   }
}

