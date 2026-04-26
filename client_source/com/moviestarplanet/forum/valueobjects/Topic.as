package com.moviestarplanet.forum.valueobjects
{
   import com.moviestarplanet.services.pollservice.valueObject.PollResult;
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class Topic
   {
      
      public var TopicId:int;
      
      public var ForumId:int;
      
      public var Subject:String;
      
      public var DateCreated:Date;
      
      public var ActorId:int;
      
      public var PostCount:int;
      
      public var Type:int;
      
      public var ActorName:String;
      
      public var MembershipTimeoutDate:Date;
      
      public var Moderator:int;
      
      public var PollResult:com.moviestarplanet.services.pollservice.valueObject.PollResult;
      
      public var PollTaken:Boolean;
      
      public var VipTier:int;
      
      public var ChatLogId:Number;
      
      public function Topic()
      {
         super();
      }
      
      public function get filteredSubject() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Subject);
      }
   }
}

