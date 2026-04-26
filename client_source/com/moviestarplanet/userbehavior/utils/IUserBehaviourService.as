package com.moviestarplanet.userbehavior.utils
{
   public interface IUserBehaviourService
   {
      
      function messageEvaluate(param1:int, param2:String, param3:int, param4:String, param5:int, param6:Boolean, param7:int, param8:String, param9:Function, param10:Function) : void;
      
      function logUserBehavior(param1:String, param2:int, param3:String = null) : void;
   }
}

