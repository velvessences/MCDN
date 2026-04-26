package com.moviestarplanet.flowControl
{
   import flash.utils.Dictionary;
   
   public class CommandMap
   {
      
      private static var commandMap:Dictionary;
      
      public function CommandMap()
      {
         super();
      }
      
      protected function initializeMap(param1:Dictionary = null) : void
      {
         commandMap = param1;
         if(commandMap == null)
         {
            commandMap = new Dictionary();
         }
      }
      
      public function addCommand(param1:String, param2:Function) : void
      {
         commandMap[param1] = param2;
      }
      
      protected function getCommand(param1:String) : Function
      {
         return commandMap[param1];
      }
   }
}

