package com.moviestarplanet.admin.module
{
   import com.moviestarplanet.Module.ModuleInterface;
   import com.moviestarplanet.admin.valueobjects.ReportReader;
   import com.moviestarplanet.moviestar.valueObjects.Cloth;
   import com.moviestarplanet.moviestar.valueObjects.FacePart;
   import com.moviestarplanet.usersession.valueobjects.ActorPersonalInfo;
   
   public interface IAdminModuleInfo extends ModuleInterface
   {
      
      function openAdminWindow() : void;
      
      function giveWarning(param1:int, param2:String, param3:Number, param4:Function = null) : void;
      
      function giveAutoWarning(param1:int, param2:String, param3:int) : void;
      
      function lockUserOut(param1:int, param2:int, param3:String, param4:Number, param5:Function = null) : void;
      
      function OpenChatLog(param1:int, param2:ReportReader = null, param3:Number = 0, param4:Number = 0, param5:Function = null, param6:Function = null) : void;
      
      function lockActor(param1:Number) : void;
      
      function unLockActor(param1:Number) : void;
      
      function disconnectActor(param1:Number) : void;
      
      function showParentalAdministration(param1:ActorPersonalInfo) : void;
      
      function editClothes(param1:Cloth, param2:Boolean = false) : void;
      
      function editFaceparts(param1:FacePart) : void;
   }
}

