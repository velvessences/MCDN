package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.Forms.world.NewTagHelper;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.worldscreen.INewTagHelper;
   
   public class MapNewTagHelperCommand
   {
      
      public function MapNewTagHelperCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         InjectionManager.mapper().map(INewTagHelper).toSingleton(NewTagHelper);
      }
   }
}

