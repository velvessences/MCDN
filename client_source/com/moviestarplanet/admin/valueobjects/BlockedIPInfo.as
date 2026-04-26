package com.moviestarplanet.admin.valueobjects
{
   public class BlockedIPInfo
   {
      
      public var BlockedIPInfoID:int;
      
      public var IP:int;
      
      public var ModeratorName:String;
      
      public var RecordDate:Date;
      
      public var BlockedDays:int;
      
      public var Comment:String;
      
      public function BlockedIPInfo()
      {
         super();
      }
   }
}

