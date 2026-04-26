package com.moviestarplanet.commonaccesspoints
{
   import com.moviestarplanet.debug.IDebugTool;
   
   public class DebugAccessPoint
   {
      
      public static var instance:IDebugTool;
      
      public static var instanceCreator:Function;
      
      public static var debugEnabled:Boolean = false;
      
      public function DebugAccessPoint()
      {
         super();
      }
      
      private static function getInstance() : IDebugTool
      {
         if(instance == null && instanceCreator != null)
         {
            instanceCreator();
         }
         return instance;
      }
      
      public static function setupNewInstantiator(param1:Function) : void
      {
         instanceCreator = param1;
         instance = null;
      }
      
      public static function log(param1:String) : void
      {
         if(debugEnabled)
         {
            trace(param1);
            if(getInstance() != null)
            {
               getInstance().log(param1);
            }
         }
      }
      
      public static function addSlashCommand(param1:String, param2:*) : void
      {
         if(getInstance() == null)
         {
            return;
         }
         getInstance().addSlashCommand(param1,param2);
      }
      
      public static function showDebugPopup() : void
      {
         if(debugEnabled)
         {
            getInstance().showDebugPopup();
         }
      }
   }
}

