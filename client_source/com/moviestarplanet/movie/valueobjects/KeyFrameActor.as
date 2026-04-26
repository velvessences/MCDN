package com.moviestarplanet.movie.valueobjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class KeyFrameActor
   {
      
      public var KeyFrameId:int;
      
      public var SceneId:int;
      
      public var KeyFrameNumber:int;
      
      public var FigureNumber:int;
      
      public var Line:String;
      
      public var Animation:String;
      
      public var AnimationId:int;
      
      public var X:int;
      
      public var Y:int;
      
      public var Speech:int;
      
      public var Face:String;
      
      public var IsFacingLeft:int;
      
      public var BubbleType:int;
      
      public var rawLine:String;
      
      public var LastUpdated:Date;
      
      public function KeyFrameActor()
      {
         super();
      }
      
      public function get filteredLine() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Line);
      }
   }
}

