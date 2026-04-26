package com.moviestarplanet.services.pollservice.valueObject
{
   public class PollResult
   {
      
      public var Data:PollData;
      
      public var Info:PollActorInfo;
      
      public function PollResult(param1:* = null)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         this.Data = new PollData(param1.Data);
         this.Info = new PollActorInfo(param1.Info);
      }
   }
}

