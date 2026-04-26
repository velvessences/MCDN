package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.model.ActorModel;
   import com.moviestarplanet.utils.DateUtils;
   
   public class ConfigureDateUtilsCommand
   {
      
      public function ConfigureDateUtilsCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         DateUtils.actorModel = ActorModel.getInstance();
      }
   }
}

