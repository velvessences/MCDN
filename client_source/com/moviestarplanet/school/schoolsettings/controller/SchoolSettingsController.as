package com.moviestarplanet.school.schoolsettings.controller
{
   import com.moviestarplanet.IDestroyable;
   import com.moviestarplanet.chatCommunicator.chatHelpers.configuration.InputLocations;
   import com.moviestarplanet.clientcensor.textfield.TextFieldInputRestricted;
   import com.moviestarplanet.configurations.AppSettings;
   import com.moviestarplanet.core.controller.commands.AssignActorSchoolInformationCommand;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.school.schoolsettings.model.SchoolSettingsModel;
   import com.moviestarplanet.school.schoolsettings.view.SchoolSettingsView;
   import com.moviestarplanet.schoolfriends.service.SchoolFriendsService;
   import com.moviestarplanet.schoolfriends.valueobjects.ActorSchoolInformation;
   import com.moviestarplanet.schoolfriends.valueobjects.SchoolSuggestionsList;
   import com.moviestarplanet.schoolfriends.valueobjects.SchoolValueObject;
   import com.moviestarplanet.userbehavior.UserBehaviorResult;
   import com.moviestarplanet.userbehavior.utils.chatfilter.userbehaviorcontrol.UserBehaviorControl;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   import com.moviestarplanet.windowpopup.popup.PromptEvent;
   
   public class SchoolSettingsController implements IDestroyable
   {
      
      private var view:SchoolSettingsView;
      
      private var model:SchoolSettingsModel;
      
      private var onClosedCallback:Function;
      
      private var destroyed:Boolean;
      
      private var typedString:String;
      
      private var dummyTextField:TextFieldInputRestricted;
      
      private var okClickedCallback:Function;
      
      public function SchoolSettingsController(param1:Function, param2:Function)
      {
         super();
         this.onClosedCallback = param1;
         this.okClickedCallback = param2;
         this.dummyTextField = new TextFieldInputRestricted();
      }
      
      public function mvc(param1:SchoolSettingsModel, param2:SchoolSettingsView) : void
      {
         this.view = param2;
         this.model = param1;
      }
      
      public function initialize(param1:Function) : void
      {
         this.model.initialize();
         this.loadNameVisibility();
         this.view.initialize(param1);
         this.loadSchoolInfo();
      }
      
      public function firstNameValueChangedHandler(param1:String) : void
      {
         if(!this.destroyed)
         {
            this.model.firstName = param1;
         }
      }
      
      private function loadSchoolInfo() : void
      {
         SchoolFriendsService.retrieveMySchoolInformation(ActorSession.getActorId(),this.schoolInfoRetrieved);
      }
      
      private function loadNameVisibility() : void
      {
         var _loc1_:String = AppSettings.getInstance().getSetting(AppSettings.MY_SCHOOL_FIRST_NAME_ENABLED);
         var _loc2_:Boolean = "true" == _loc1_;
         this.model.firstNameEnabled = _loc2_;
      }
      
      private function setupView() : void
      {
         this.view.setFirstNameEnabled(this.model.firstNameEnabled);
         var _loc1_:Boolean = false;
         if(this.model.isDeleted)
         {
            if(this.model.secondsUntilSchoolCanBeChanged != 0)
            {
               this.view.setLocked(this.model.secondsUntilSchoolCanBeChanged);
               _loc1_ = false;
               return;
            }
         }
         if(this.model.schoolId != -1)
         {
            this.view.setAlreadyHasData(this.model.schoolYear,this.model.schoolClass,this.model.schoolName);
         }
         else
         {
            this.view.setEditable(true);
         }
      }
      
      public function schoolInfoRetrieved(param1:ActorSchoolInformation) : void
      {
         if(this.destroyed)
         {
            return;
         }
         this.model.setActorSchoolInfo(param1);
         new AssignActorSchoolInformationCommand().execute(param1);
         if(this.view.isAssetLoaded)
         {
            this.setupView();
            this.view.placeAssets();
            this.view.hideLoading();
         }
      }
      
      public function deletSchoolSettings() : void
      {
         var _loc1_:String = this.view.localeManager.getString("MSP_MY_SCHOOL_DELETE_TEXT2") + "\n\n" + this.view.localeManager.getString("MSP_MY_SCHOOL_DETETE_INFO");
         Prompt.showFriendly(_loc1_,this.view.localeManager.getString("MSP_MY_SCHOOL_DELETE_HEADLINE"),Prompt.YES | Prompt.NO,null,this.deleteCloseHandler,null,Prompt.NO);
      }
      
      private function deleteCloseHandler(param1:PromptEvent) : void
      {
         if(param1.detail == Prompt.YES)
         {
            SchoolFriendsService.deleteMySchoolInformation(this.model.actorId,this.deleteMySchoolResult);
            this.okButtonClickedHandler();
         }
         else if(param1.detail == Prompt.NO)
         {
         }
      }
      
      private function deleteMySchoolResult(param1:int) : void
      {
      }
      
      public function viewLoadedHandler() : void
      {
         if(this.destroyed)
         {
            return;
         }
         if(this.model.dataLoaded())
         {
            this.setupView();
            this.view.placeAssets();
            this.view.hideLoading();
         }
      }
      
      public function schoolInputChangedHandler(param1:String) : void
      {
         if(this.destroyed)
         {
            return;
         }
         this.typedString = param1;
         this.model.resetSchool();
         this.view.toggleOkButton(false);
         if(param1.length > 0)
         {
            SchoolFriendsService.retrieveSchoolSuggestions(param1,this.schoolSuggestionsGotten);
         }
         else
         {
            this.view.autoComplete.updateDataProvider(new Array());
         }
      }
      
      private function schoolSuggestionsGotten(param1:SchoolSuggestionsList) : void
      {
         var _loc3_:SchoolValueObject = null;
         if(this.destroyed)
         {
            return;
         }
         var _loc2_:Array = new Array();
         if(this.typedString != "")
         {
            for each(_loc3_ in param1.valuesList)
            {
               _loc2_.push({
                  "label":_loc3_.Name,
                  "data":_loc3_.SchoolId
               });
            }
         }
         this.view.autoComplete.updateDataProvider(_loc2_);
      }
      
      public function okButtonClickedHandler() : void
      {
         if(this.model.dataIsValid())
         {
            if(this.model.dataHasChanged())
            {
               if(this.okClickedCallback != null)
               {
                  this.okClickedCallback();
               }
               this.view.toggleOkButton(false);
               if(this.model.firstNameEnabled)
               {
                  this.dummyTextField.text = this.model.firstName;
                  UserBehaviorControl.getInstance().blacklistFilter(this.dummyTextField,this.userBehaviorCallback,this.userBehaviorFailed,ActorSession.getActorId(),String(0),InputLocations.LOC_MYSCHOOL_REALNAME);
               }
               else
               {
                  this.sendSchoolInfoToServer();
               }
            }
            else
            {
               this.updateSchoolCallback(SchoolFriendsService.CODE_ERROR_DATA_NOT_CHANGED);
            }
         }
      }
      
      private function userBehaviorFailed() : void
      {
      }
      
      private function userBehaviorCallback(param1:UserBehaviorResult) : void
      {
         this.view.showLoading();
         this.model.firstName = param1.blacklistedMessage;
         this.sendSchoolInfoToServer();
      }
      
      private function sendSchoolInfoToServer() : void
      {
         SchoolFriendsService.updateMySchool(ActorSession.getActorId(),this.model.schoolId,this.model.schoolYear,this.model.schoolClass,this.model.firstName,this.updateSchoolCallback);
      }
      
      private function updateSchoolCallback(param1:int) : void
      {
         if(!this.destroyed)
         {
            this.view.hideLoading();
            switch(param1)
            {
               case SchoolFriendsService.CODE_SUCCESS:
                  new AssignActorSchoolInformationCommand().execute(new ActorSchoolInformation(this.model.schoolName,this.model.schoolId,ActorSession.getActorId(),this.model.schoolYear,this.model.schoolClass,this.model.lastModificationDate,this.model.firstName));
                  if(this.onClosedCallback != null)
                  {
                     this.onClosedCallback();
                  }
                  break;
               default:
                  if(this.onClosedCallback != null)
                  {
                     this.onClosedCallback();
                  }
            }
         }
      }
      
      public function isInputValid() : Boolean
      {
         return this.model.dataIsValid() && this.model.dataHasChanged();
      }
      
      public function destroy() : void
      {
         this.destroyed = true;
         this.view = null;
         this.model = null;
         this.onClosedCallback = null;
         this.okClickedCallback = null;
      }
   }
}

