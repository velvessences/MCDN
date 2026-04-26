package com.moviestarplanet.services.pollservice.valueObject
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class PollData
   {
      
      public var PollId:int;
      
      public var NextPollId:int;
      
      public var Question:String;
      
      public var Answers:Array;
      
      public var Counts:Array;
      
      private var _filteredAnswers:Array;
      
      public function PollData(param1:Object = null)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         this.PollId = param1.PollId;
         this.NextPollId = param1.NextPollId;
         this.Question = param1.Question;
         this.Answers = param1.Answers;
         this.Counts = param1.Counts;
      }
      
      public function get filteredQuestion() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Question);
      }
      
      public function get filteredAnswers() : Array
      {
         var _loc1_:int = 0;
         if(this._filteredAnswers == null)
         {
            this._filteredAnswers = new Array();
            _loc1_ = 0;
            while(_loc1_ < this.Answers.length)
            {
               this._filteredAnswers[_loc1_] = UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Answers[_loc1_]);
               _loc1_++;
            }
         }
         return this._filteredAnswers;
      }
   }
}

