package com.moviestarplanet.mainview
{
   import flash.external.ExternalInterface;
   
   public class SetFocusOnApplicationCommand
   {
      
      public function SetFocusOnApplicationCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("eval","document.getElementById(\'" + ExternalInterface.objectID + "\').tabIndex=0");
               ExternalInterface.call("eval","document.getElementById(\'" + ExternalInterface.objectID + "\').focus()");
            }
         }
         catch(error:Error)
         {
         }
      }
   }
}

