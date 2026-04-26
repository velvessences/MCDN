package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.injection.InjectionManager;
   
   public class SetIsStartupScreenCommand
   {
      
      public function SetIsStartupScreenCommand()
      {
         super();
      }
      
      public function execute(param1:Boolean) : void
      {
         InjectionManager.mapper().map(Boolean,"isStartupScreen").toValue(param1);
      }
   }
}

