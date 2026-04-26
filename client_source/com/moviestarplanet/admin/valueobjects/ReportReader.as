package com.moviestarplanet.admin.valueobjects
{
   public class ReportReader
   {
      
      public var ReportId:int;
      
      public var ComplainerActorId:int;
      
      public var ReportedActorId:int;
      
      public var Comment:String;
      
      public var ReportedDate:Date;
      
      public var HandledDate:Date;
      
      public var Conclusion:String;
      
      public var EntityType:int;
      
      public var EntityId:int;
      
      public var HandledByActorId:int;
      
      public var HandledStatus:int;
      
      public var CategoryId:int;
      
      public var ComplainerActor:ActorReport;
      
      public var ReportedActor:ActorReport;
      
      public var ProcessingBy:int;
      
      public var ProcessingDate:Date;
      
      public var ComplainerCountry:String;
      
      public var ReportedCountry:String;
      
      public function ReportReader()
      {
         super();
      }
      
      public function isCrossCountryReport() : Boolean
      {
         return this.ComplainerCountry != this.ReportedCountry;
      }
   }
}

