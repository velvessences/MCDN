package com.moviestarplanet.core.controller.commands.startupcommands
{
   import com.moviestarplanet.utils.StageReference;
   
   public class SetStageReferenceCommand
   {
      
      public function SetStageReferenceCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         StageReference.setStage(Main.Instance.stage);
      }
   }
}

