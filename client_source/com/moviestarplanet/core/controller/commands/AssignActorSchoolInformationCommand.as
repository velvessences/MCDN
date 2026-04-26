package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.schoolfriends.valueobjects.ActorSchoolInformation;
   
   public class AssignActorSchoolInformationCommand
   {
      
      public function AssignActorSchoolInformationCommand()
      {
         super();
      }
      
      public function execute(param1:ActorSchoolInformation) : void
      {
         InjectionManager.mapper().map(ActorSchoolInformation).toValue(param1);
      }
   }
}

