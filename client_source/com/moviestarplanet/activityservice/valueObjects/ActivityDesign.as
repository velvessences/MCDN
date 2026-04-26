package com.moviestarplanet.activityservice.valueObjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class ActivityDesign
   {
      
      public var DesignId:int;
      
      public var ActorId:int;
      
      public var ActorName:String;
      
      public var Name:String;
      
      public var Likes:int;
      
      public var FameEarned:int;
      
      public function ActivityDesign()
      {
         super();
      }
      
      public function get FilteredName() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Name);
      }
   }
}

