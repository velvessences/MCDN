package com.moviestarplanet.entities.valueobjects
{
   public class EntityComment
   {
      
      public var EntityCommentId:int;
      
      public var EntityType:int;
      
      public var EntityId:int;
      
      public var ActorId:int;
      
      public var Created:Date;
      
      public var IsDeleted:int;
      
      public var Comment:String;
      
      public function EntityComment()
      {
         super();
      }
   }
}

