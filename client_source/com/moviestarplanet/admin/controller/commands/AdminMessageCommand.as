package com.moviestarplanet.admin.controller.commands
{
   import com.moviestarplanet.admin.module.AdminModuleManager;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.msg.events.AdminEvent;
   import com.moviestarplanet.utils.ReportUtils;
   
   public class AdminMessageCommand
   {
      
      public function AdminMessageCommand()
      {
         super();
      }
      
      public static function reportEntity(param1:AdminEvent) : void
      {
         var _loc2_:int = int(param1.data.actorId as int);
         var _loc3_:int = int(param1.data.entityType as int);
         var _loc4_:int = int(param1.data.entityId as int);
         var _loc5_:String = param1.data.entityTitle as String;
         ReportUtils.reportEntity(_loc2_,_loc3_,_loc4_,_loc5_);
      }
      
      public static function autoWarning(param1:AdminEvent) : void
      {
         var _loc2_:int = int(param1.data.actorId as int);
         var _loc3_:String = param1.data.lockedText as String;
         var _loc4_:int = int(param1.data.loc as int);
         AdminModuleManager.getInstance().giveAutoWarning(_loc2_,_loc3_,_loc4_);
      }
      
      public function execute() : void
      {
         MessageCommunicator.subscribe(AdminEvent.REPORT_ENTITY,reportEntity);
         MessageCommunicator.subscribe(AdminEvent.AUTO_WARNING,autoWarning);
      }
   }
}

