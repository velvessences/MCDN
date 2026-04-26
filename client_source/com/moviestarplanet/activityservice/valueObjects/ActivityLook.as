package com.moviestarplanet.activityservice.valueObjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import flash.utils.ByteArray;
   
   public class ActivityLook
   {
      
      public var LookId:int;
      
      public var ActorId:int;
      
      public var Headline:String;
      
      public var LookData:ByteArray;
      
      public var Likes:int;
      
      public var Sells:int;
      
      public var CreatorId:int;
      
      public var actorName:String;
      
      public var LastEditedOn:Date;
      
      public function ActivityLook()
      {
         super();
      }
      
      public function get filteredName() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Headline);
      }
   }
}

