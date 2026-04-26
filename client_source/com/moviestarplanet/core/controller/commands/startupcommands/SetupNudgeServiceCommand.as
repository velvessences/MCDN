package com.moviestarplanet.core.controller.commands.startupcommands
{
   import com.moviestarplanet.configurations.NudgeCommands;
   
   public class SetupNudgeServiceCommand
   {
      
      private var nudgeCommands:NudgeCommands;
      
      public function SetupNudgeServiceCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         this.nudgeCommands = new NudgeCommands();
         this.nudgeCommands.setupSharedCommands();
      }
   }
}

