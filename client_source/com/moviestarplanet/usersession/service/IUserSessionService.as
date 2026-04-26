package com.moviestarplanet.usersession.service
{
   public interface IUserSessionService
   {
      
      function SetEmailSettings(param1:int, param2:String, param3:int, param4:Function) : void;
      
      function setMarketingStep(param1:int, param2:int, param3:int, param4:Function = null) : void;
      
      function BadWordCountClear(param1:int) : void;
      
      function BadWordCountAdd(param1:int, param2:int) : void;
      
      function UpdateRetention(param1:int, param2:Function) : void;
      
      function SetFacebookId(param1:Number, param2:String, param3:Function) : void;
      
      function LoadActorDetails(param1:int, param2:Boolean, param3:Function) : void;
      
      function LoadActorDetailsExtended(param1:int, param2:Function) : void;
      
      function GiveAutographAndCalculateTimestamp(param1:Number, param2:Number, param3:Function) : void;
      
      function AwardStartupReward(param1:int, param2:Function) : void;
      
      function DeleteUser(param1:String, param2:String, param3:Boolean, param4:Function) : void;
      
      function DeleteUser2(param1:String, param2:String, param3:Number, param4:Function) : void;
      
      function UndeleteUser(param1:String, param2:String, param3:Number, param4:Function) : void;
      
      function RenameUser(param1:String, param2:String, param3:Number, param4:String, param5:Function) : void;
      
      function UnlockUser(param1:String, param2:String, param3:Number, param4:Function) : void;
      
      function changePassword(param1:int, param2:String, param3:String, param4:Function) : void;
      
      function GetActorIdFromName(param1:String, param2:Function) : void;
      
      function GetActorNameFromId(param1:int, param2:Function) : void;
      
      function deleteBioText(param1:Number, param2:String, param3:String, param4:Function) : void;
      
      function SendEmailValidation(param1:String, param2:int, param3:String, param4:String, param5:int, param6:Function) : void;
      
      function SendNewEmailValidation(param1:String, param2:int, param3:String, param4:String, param5:int, param6:Boolean, param7:Function) : void;
      
      function EmailValidated(param1:int, param2:Function) : void;
      
      function EmailValidatedCancel(param1:int) : void;
      
      function UpdateGift(param1:int, param2:Function) : void;
      
      function GetMarketingStepGift(param1:int, param2:Function) : void;
      
      function UpdateBehaviourStatus(param1:int, param2:int, param3:String, param4:Number, param5:int, param6:Function) : void;
      
      function loadActorEmail(param1:int, param2:Function) : void;
      
      function eraseEmail(param1:String, param2:String, param3:String, param4:Function) : void;
      
      function RecoverUserFromEmailHistory(param1:String, param2:String, param3:Function) : void;
      
      function sendMailConfirmChangeMail(param1:Number, param2:String, param3:Function) : void;
      
      function sendMailConfirmDeleteUser(param1:Number, param2:String, param3:Function) : void;
      
      function forgotPasswordInsideGame(param1:int, param2:String, param3:String, param4:Function) : void;
      
      function forgotPasswordOutsideGame(param1:String, param2:String, param3:Function) : void;
   }
}

