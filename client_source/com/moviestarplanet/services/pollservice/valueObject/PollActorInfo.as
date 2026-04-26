package com.moviestarplanet.services.pollservice.valueObject
{
   public class PollActorInfo
   {
      
      public var Answered:Boolean;
      
      public function PollActorInfo(param1:* = null)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         this.Answered = param1.Answered;
      }
   }
}

