package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.emoticon.IEmoticonClassLoader;
   import com.moviestarplanet.emoticon.WebEmoticonClassLoader;
   import com.moviestarplanet.injection.InjectionManager;
   
   public class SetupEmoticonsCommand
   {
      
      public function SetupEmoticonsCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         InjectionManager.mapper().map(IEmoticonClassLoader).toSingleton(WebEmoticonClassLoader);
      }
   }
}

