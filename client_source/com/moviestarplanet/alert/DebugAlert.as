package com.moviestarplanet.alert
{
   import com.moviestarplanet.debug.IsCurrentUserDebugUser;
   import mx.controls.Alert;
   
   public class DebugAlert
   {
      
      public function DebugAlert()
      {
         super();
      }
      
      public function show(param1:Object) : void
      {
         if(new IsCurrentUserDebugUser().execute())
         {
            if(param1.hasOwnProperty("text"))
            {
               this.doShow(param1.text,param1.title);
            }
            else
            {
               this.doShow(param1 as String,"DEBUG ALERT!");
            }
         }
      }
      
      private function doShow(param1:String, param2:String) : void
      {
         if(param1.indexOf("snapshots/") >= 0)
         {
            return;
         }
         Alert.show(param1,param2);
      }
   }
}

