package com.moviestarplanet.session.nudge
{
   import com.moviestarplanet.flowControl.CommandMap;
   
   public class NudgeDispatcher extends CommandMap
   {
      
      private static var instance:NudgeDispatcher;
      
      public function NudgeDispatcher()
      {
         super();
         initializeMap();
      }
      
      public static function getInstance() : NudgeDispatcher
      {
         if(!instance)
         {
            instance = new NudgeDispatcher();
         }
         return instance;
      }
      
      public function dispacthNudge(param1:String) : void
      {
         var _loc2_:Function = getCommand(param1);
         if(_loc2_ != null)
         {
            _loc2_();
         }
         else
         {
            trace("Nudge called an unknown command:",param1);
         }
      }
   }
}

