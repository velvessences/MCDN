package com.moviestarplanet.schoolfriends.valueobjects
{
   public class ActorSchoolInformation
   {
      
      public var SchoolName:String;
      
      public var SchoolId:int;
      
      public var ActorId:int;
      
      public var SchoolYear:int;
      
      public var SchoolClass:int;
      
      public var LastModificationDate:Date;
      
      public var FirstName:String;
      
      public var SecondsUntilSchoolCanBeChanged:int;
      
      public var IsDeleted:Boolean;
      
      public function ActorSchoolInformation(param1:String = "", param2:int = -1, param3:int = -1, param4:int = -1, param5:int = -1, param6:Date = null, param7:String = "", param8:int = 0, param9:Boolean = false)
      {
         super();
         this.SchoolName = param1;
         this.SchoolId = param2;
         this.ActorId = param3;
         this.SchoolYear = param4;
         this.SchoolClass = param5;
         this.LastModificationDate = param6;
         this.SecondsUntilSchoolCanBeChanged = param8;
         this.IsDeleted = param9;
      }
   }
}

