package com.moviestarplanet.entities.valueobjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class EntityCommentList
   {
      
      public var EntityCommentId:int;
      
      public var EntityType:int;
      
      public var EntityId:int;
      
      public var ActorId:int;
      
      public var Created:Date;
      
      public var Comment:String;
      
      public var IsDeleted:int;
      
      public var ActorEntityCommentList:com.moviestarplanet.entities.valueobjects.ActorEntityCommentList;
      
      public function EntityCommentList()
      {
         super();
      }
      
      public function get filteredComment() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Comment);
      }
   }
}

