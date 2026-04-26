package com.moviestarplanet.admin
{
   import com.moviestarplanet.admin.valueobjects.ActorName;
   import com.moviestarplanet.admin.valueobjects.ActorNamePass;
   import com.moviestarplanet.admin.valueobjects.ActorReport;
   import com.moviestarplanet.admin.valueobjects.BlockedIPInfo;
   import com.moviestarplanet.admin.valueobjects.BlockedName;
   import com.moviestarplanet.admin.valueobjects.ChatLog;
   import com.moviestarplanet.admin.valueobjects.IPListItem;
   import com.moviestarplanet.admin.valueobjects.PagedBadWordActorList;
   import com.moviestarplanet.admin.valueobjects.PagedChatLogList;
   import com.moviestarplanet.admin.valueobjects.PagedIPList;
   import com.moviestarplanet.admin.valueobjects.PagedReportList;
   import com.moviestarplanet.admin.valueobjects.PagedUserList;
   import com.moviestarplanet.admin.valueobjects.PagedWarningCounts;
   import com.moviestarplanet.admin.valueobjects.PasswordLog;
   import com.moviestarplanet.admin.valueobjects.ReportOverview;
   import com.moviestarplanet.admin.valueobjects.ReportReader;
   import com.moviestarplanet.admin.valueobjects.WarningCountItem;
   import com.moviestarplanet.commoninterfaces.IRegistrator;
   import flash.net.registerClassAlias;
   
   public class AdminRegistrator implements IRegistrator
   {
      
      private static var hasRegistered:Boolean = false;
      
      public function AdminRegistrator()
      {
         super();
      }
      
      public function registerClassAliases() : void
      {
         if(!hasRegistered)
         {
            registerClassAlias("MovieStarPlanet.DBML.PasswordLog",PasswordLog);
            registerClassAlias("MovieStarPlanet.DBML.BlockedName",BlockedName);
            registerClassAlias("MovieStarPlanet.DBML.BlockedIPInfo",BlockedIPInfo);
            registerClassAlias("MovieStarPlanet.DBML.ReportOverview",ReportOverview);
            registerClassAlias("MovieStarPlanet.WebService.WebService+ActorNamePass",ActorNamePass);
            registerClassAlias("MovieStarPlanet.WebService.WebService+ActorName",ActorName);
            registerClassAlias("MovieStarPlanet.WebService.WebService+PagedBadWordActorList",PagedBadWordActorList);
            registerClassAlias("MovieStarPlanet.WebService.Admin.AMFAdminService+PagedReportList",PagedReportList);
            registerClassAlias("MovieStarPlanet.WebService.Admin.AMFAdminService+PagedIPList",PagedIPList);
            registerClassAlias("MovieStarPlanet.WebService.Admin.AMFAdminService+WarningCountItem",WarningCountItem);
            registerClassAlias("MovieStarPlanet.WebService.Admin.AMFAdminService+PagedChatLogList",PagedChatLogList);
            registerClassAlias("MovieStarPlanet.WebService.Admin.AMFAdminService+PagedUserList",PagedUserList);
            registerClassAlias("MovieStarPlanet.WebService.Admin.AMFAdminService+PagedWarningCounts",PagedWarningCounts);
            registerClassAlias("MovieStarPlanet.WebService.Admin.AMFAdminService+IPListItem",IPListItem);
            registerClassAlias("MovieStarPlanet.DBML.ReportReader",ReportReader);
            registerClassAlias("MovieStarPlanet.DBML.ActorReport",ActorReport);
            registerClassAlias("MovieStarPlanet.DBML.ChatLog",ChatLog);
            hasRegistered = true;
         }
      }
   }
}

