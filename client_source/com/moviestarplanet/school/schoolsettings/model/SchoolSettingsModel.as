package com.moviestarplanet.school.schoolsettings.model
{
   import com.moviestarplanet.IDestroyable;
   import com.moviestarplanet.school.schoolsettings.controller.SchoolSettingsController;
   import com.moviestarplanet.school.schoolsettings.view.SchoolSettingsView;
   import com.moviestarplanet.schoolfriends.valueobjects.ActorSchoolInformation;
   
   public class SchoolSettingsModel implements IDestroyable
   {
      
      private const INVALID_INT:int = -1;
      
      private const INVALID_STRING:String = "";
      
      private var view:SchoolSettingsView;
      
      private var controller:SchoolSettingsController;
      
      public var actorId:int;
      
      public var firstNameEnabled:Boolean;
      
      public var firstName:String;
      
      public var schoolYear:int;
      
      public var schoolClass:int;
      
      public var schoolId:int;
      
      public var schoolName:String;
      
      public var lastModificationDate:Date;
      
      public var secondsUntilSchoolCanBeChanged:int = 0;
      
      public var isDeleted:Boolean = false;
      
      private var loadedSchooInformation:ActorSchoolInformation;
      
      public function SchoolSettingsModel()
      {
         super();
      }
      
      public function initialize() : void
      {
         this.schoolId = this.INVALID_INT;
         this.schoolYear = this.INVALID_INT;
         this.schoolClass = this.INVALID_INT;
         this.firstName = this.INVALID_STRING;
         this.schoolName = this.INVALID_STRING;
      }
      
      public function mvc(param1:SchoolSettingsView, param2:SchoolSettingsController) : void
      {
         this.view = param1;
         this.controller = param2;
      }
      
      public function dataIsValid() : Boolean
      {
         return this.schoolId != this.INVALID_INT && this.schoolYear != this.INVALID_INT && this.schoolClass != this.INVALID_INT && (!this.firstNameEnabled || this.firstName != null && this.firstName != this.INVALID_STRING);
      }
      
      public function dataHasChanged() : Boolean
      {
         var _loc1_:Boolean = this.schoolId != this.loadedSchooInformation.SchoolId || this.schoolYear != this.loadedSchooInformation.SchoolYear || this.schoolClass != this.loadedSchooInformation.SchoolClass;
         if(this.firstNameEnabled)
         {
            return _loc1_ || this.firstName != this.loadedSchooInformation.FirstName;
         }
         return _loc1_;
      }
      
      public function setActorSchoolInfo(param1:ActorSchoolInformation) : void
      {
         if(param1.SchoolId == 0)
         {
            this.schoolId = this.INVALID_INT;
         }
         else
         {
            this.schoolId = param1.SchoolId;
         }
         this.actorId = param1.ActorId;
         this.schoolName = param1.SchoolName;
         this.firstName = param1.FirstName;
         this.schoolYear = param1.SchoolYear;
         this.schoolClass = param1.SchoolClass;
         this.lastModificationDate = param1.LastModificationDate;
         this.loadedSchooInformation = param1;
         this.secondsUntilSchoolCanBeChanged = param1.SecondsUntilSchoolCanBeChanged;
         this.isDeleted = param1.IsDeleted;
      }
      
      public function dataLoaded() : Boolean
      {
         return this.loadedSchooInformation != null;
      }
      
      public function resetSchool() : void
      {
         this.schoolId = this.INVALID_INT;
      }
      
      public function getSchoolId() : int
      {
         return this.schoolId;
      }
      
      public function getLastModificationDate() : Date
      {
         return this.lastModificationDate;
      }
      
      public function destroy() : void
      {
         this.view = null;
         this.controller = null;
      }
   }
}

