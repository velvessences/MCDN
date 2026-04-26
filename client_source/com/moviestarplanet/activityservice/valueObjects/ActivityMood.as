package com.moviestarplanet.activityservice.valueObjects
{
   public class ActivityMood
   {
      
      public var ActorId:int;
      
      public var FigureAnimation:String;
      
      public var FaceAnimation:String;
      
      public var MouthAnimation:String;
      
      public var TextLine:String;
      
      public var SpeechLine:Boolean;
      
      public var IsBrag:Boolean;
      
      public var TextLineWhitelisted:String;
      
      public var TextLineBlacklisted:String;
      
      public var TextLineLastFiltered:Date;
      
      public var Activities:Object;
      
      public var WallPostLinks:Object;
      
      public function ActivityMood()
      {
         super();
      }
   }
}

