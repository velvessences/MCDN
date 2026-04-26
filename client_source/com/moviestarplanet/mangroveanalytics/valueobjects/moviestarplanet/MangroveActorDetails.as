package com.moviestarplanet.mangroveanalytics.valueobjects.moviestarplanet
{
   import com.moviestarplanet.mangroveanalytics.valueobjects.MangroveBaseDetails;
   
   public class MangroveActorDetails extends MangroveBaseDetails
   {
      
      public var IsFemale:Boolean;
      
      public var Fame:int;
      
      public var Fortune:int;
      
      public var Diamonds:int;
      
      public var Money:int;
      
      public var BestFriendsCount:int;
      
      public var BoyFriendsCount:int;
      
      public function MangroveActorDetails()
      {
         super();
      }
      
      public function get Gender() : String
      {
         return IsFemale ? "female" : "male";
      }
   }
}

