package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.services.wrappers.call.FaultHandler;
   
   public class SetupAmfCommand
   {
      
      public function SetupAmfCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         AmfCaller.defaultFailHandler = FaultHandler.handleErrorWithObject;
      }
   }
}

