package com.moviestarplanet.valueObjects
{
   import com.moviestarplanet.friendship.valueobjects.BoyFriend;
   
   public class ProfileSummary
   {
      
      public var BoyFriend:com.moviestarplanet.friendship.valueobjects.BoyFriend;
      
      public var SpecialFriends:Array;
      
      public var FavoriteEntities:Array;
      
      public var Created:Date;
      
      public var ProfileDisplays:int;
      
      public var bioId:int;
      
      public function ProfileSummary()
      {
         super();
      }
   }
}

