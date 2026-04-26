package com.moviestarplanet.usersession.service
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.combat.valueobject.CombatCategorisation;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.services.gifts.valueObjects.GiftSwfAndNameAndGiver;
   import com.moviestarplanet.usersession.valueobjects.ActorDetailSecure;
   import com.moviestarplanet.usersession.valueobjects.ActorDetailsExtended;
   import com.moviestarplanet.usersession.valueobjects.ActorDetailsVersion;
   import com.moviestarplanet.usersession.valueobjects.ActorEmail;
   import com.moviestarplanet.usersession.valueobjects.ActorModerationStatus;
   import com.moviestarplanet.usersession.valueobjects.ActorStatus;
   import com.moviestarplanet.version.CheckVersion;
   import flash.net.registerClassAlias;
   
   public class UserSessionAMFService implements IUserSessionService
   {
      
      private static var _instance:UserSessionAMFService;
      
      private static var _amfCaller:AmfCaller;
      
      public function UserSessionAMFService(param1:SingletonEnforcer)
      {
         super();
         _amfCaller = new AmfCaller("MovieStarPlanet.WebService.UserSession.AMFUserSessionService");
         registerClassAlias("MovieStarPlanet.WebService.UserSession.ActorDetailsVersion",ActorDetailsVersion);
         registerClassAlias("MovieStarPlanet.WebService.UserSession.ActorDetailsExtended",ActorDetailsExtended);
         registerClassAlias("MovieStarPlanet.DBML.ActorModerationStatus",ActorModerationStatus);
         registerClassAlias("MovieStarPlanet.WebService.WebService.GiftSwfAndNameAndGiver",GiftSwfAndNameAndGiver);
         registerClassAlias("MovieStarPlanet.DBML.ActorStatus",ActorStatus);
         registerClassAlias("UserBehaviourService.Model.Combat.ValueObjects.CombatCategorisation",CombatCategorisation);
      }
      
      public static function get instance() : UserSessionAMFService
      {
         if(_instance == null)
         {
            _instance = new UserSessionAMFService(new SingletonEnforcer());
         }
         return _instance;
      }
      
      public function UpdateMySchool(param1:int, param2:String, param3:int, param4:int, param5:Function) : void
      {
         var onFail:Function = null;
         var done:Function = null;
         var actorId:int = param1;
         var passwordHash:String = param2;
         var schoolId:int = param3;
         var schoolYear:int = param4;
         var resultCallBack:Function = param5;
         onFail = function(param1:*):void
         {
            trace(param1.description);
         };
         done = function(param1:String):void
         {
            if(resultCallBack != null)
            {
               resultCallBack(param1);
            }
         };
         _amfCaller.callFunction("UpdateMySchool",[actorId,passwordHash,schoolId,schoolYear],true,done,onFail);
      }
      
      public function SetEmailSettings(param1:int, param2:String, param3:int, param4:Function) : void
      {
         var done:Function = null;
         var actorId:int = param1;
         var actorName:String = param2;
         var emailSettings:int = param3;
         var resultCallBack:Function = param4;
         done = function(param1:int):void
         {
            if(resultCallBack != null)
            {
               resultCallBack(param1);
            }
         };
         _amfCaller.callFunction("SetEmailSettings",[actorId,actorName,emailSettings],true,done);
      }
      
      public function setMarketingStep(param1:int, param2:int, param3:int, param4:Function = null) : void
      {
         _amfCaller.callFunction("SetMarketingStep",[param1,param2,param3],true,param4);
      }
      
      public function BadWordCountClear(param1:int) : void
      {
         _amfCaller.callFunction("BadWordCountClear",[param1],true,null);
      }
      
      public function BadWordCountAdd(param1:int, param2:int) : void
      {
         _amfCaller.callFunction("BadWordCountAdd",[param1,param2],true,null);
      }
      
      public function UpdateRetention(param1:int, param2:Function) : void
      {
         var done:Function = null;
         var actorId:int = param1;
         var resultCallBack:Function = param2;
         done = function(param1:int):void
         {
            if(resultCallBack != null)
            {
               resultCallBack(param1);
            }
         };
         _amfCaller.callFunction("UpdateRetention",[actorId],true,done);
      }
      
      public function SetFacebookId(param1:Number, param2:String, param3:Function) : void
      {
         _amfCaller.callFunction("SetFacebookId",[param1,param2],true,null);
      }
      
      public function LoadActorDetails(param1:int, param2:Boolean, param3:Function) : void
      {
         var done:Function = null;
         var actorId:int = param1;
         var updateProfileDisplayCount:Boolean = param2;
         var resultCallBack:Function = param3;
         done = function(param1:Object):void
         {
            if(resultCallBack != null)
            {
               MessageCommunicator.sendMessage(MSPEvent.CHECK_VERSION,new CheckVersion(param1.Version));
               resultCallBack(param1.ActorDetails);
            }
         };
         _amfCaller.callFunction("LoadActorDetailsVersion",[actorId,updateProfileDisplayCount],true,done);
      }
      
      public function LoadActorDetails2(param1:int, param2:Boolean, param3:int, param4:Function) : void
      {
         var done:Function = null;
         var actorId:int = param1;
         var updateProfileDisplayCount:Boolean = param2;
         var callerId:int = param3;
         var resultCallBack:Function = param4;
         done = function(param1:Object):void
         {
            if(resultCallBack != null)
            {
               resultCallBack(param1);
            }
         };
         _amfCaller.callFunction("LoadActorDetails2",[actorId,updateProfileDisplayCount,callerId],true,done);
      }
      
      public function LoadActorDetailsExtended(param1:int, param2:Function) : void
      {
         var done:Function = null;
         var actorId:int = param1;
         var resultCallBack:Function = param2;
         done = function(param1:Object):void
         {
            if(param1.Details.ActorId != actorId)
            {
               return;
            }
            if(resultCallBack != null)
            {
               MessageCommunicator.sendMessage(MSPEvent.CHECK_VERSION,new CheckVersion(param1.Version));
               resultCallBack(param1 as ActorDetailsExtended);
            }
         };
         _amfCaller.callFunction("LoadActorDetailsExtended",[actorId],true,done);
      }
      
      public function GiveAutographAndCalculateTimestamp(param1:Number, param2:Number, param3:Function) : void
      {
         _amfCaller.callFunction("GiveAutographAndCalculateTimestamp",[param1,param2],true,param3);
      }
      
      public function AwardStartupReward(param1:int, param2:Function) : void
      {
         _amfCaller.callFunction("AwardStartupReward",[param1],true,param2);
      }
      
      public function DeleteUser(param1:String, param2:String, param3:Boolean, param4:Function) : void
      {
         _amfCaller.callFunction("DeleteUser",[param1,param2,param3],true,param4);
      }
      
      public function DeleteUser2(param1:String, param2:String, param3:Number, param4:Function) : void
      {
         _amfCaller.callFunction("DeleteUser2",[param3,param1,param2],true,param4);
      }
      
      public function MassDeleteUsers(param1:Array, param2:String, param3:String, param4:Function) : void
      {
         var done:Function = null;
         var usersIdsTobeDeleted:Array = param1;
         var userName:String = param2;
         var password:String = param3;
         var resultCallBack:Function = param4;
         done = function(param1:Object):void
         {
            if(resultCallBack != null)
            {
               resultCallBack(param1);
            }
         };
         _amfCaller.callFunction("MassDeleteUsers",[usersIdsTobeDeleted,userName,password],true,done);
      }
      
      public function UndeleteUser(param1:String, param2:String, param3:Number, param4:Function) : void
      {
         var done:Function = null;
         var userName:String = param1;
         var password:String = param2;
         var userIdTobeDeleted:Number = param3;
         var resultCallBack:Function = param4;
         done = function(param1:Object):void
         {
            var _loc2_:ActorDetailSecure = null;
            if(resultCallBack != null)
            {
               _loc2_ = new ActorDetailSecure();
               _loc2_.parseObject(param1);
               resultCallBack(_loc2_);
            }
         };
         _amfCaller.callFunction("UndeleteUser",[userIdTobeDeleted,userName,password],true,done);
      }
      
      public function RenameUser(param1:String, param2:String, param3:Number, param4:String, param5:Function) : void
      {
         var done:Function = null;
         var moderatorName:String = param1;
         var moderatorPass:String = param2;
         var actorId:Number = param3;
         var newActorName:String = param4;
         var resultCallBack:Function = param5;
         done = function(param1:int):void
         {
            if(resultCallBack != null)
            {
               resultCallBack(param1);
            }
         };
         _amfCaller.callFunction("RenameUser",[actorId,newActorName,moderatorName,moderatorPass],true,done);
      }
      
      public function UnlockUser(param1:String, param2:String, param3:Number, param4:Function) : void
      {
         var done:Function = null;
         var moderatorName:String = param1;
         var moderatorPass:String = param2;
         var actorId:Number = param3;
         var resultCallBack:Function = param4;
         done = function(param1:Object):void
         {
            var _loc2_:int = 0;
            if(resultCallBack != null)
            {
               _loc2_ = int(int(param1));
               resultCallBack(_loc2_);
            }
         };
         _amfCaller.callFunction("UnlockUser",[actorId,moderatorName,moderatorPass],true,done);
      }
      
      public function changePassword(param1:int, param2:String, param3:String, param4:Function) : void
      {
         _amfCaller.callFunction("ChangePasswordNew",[param1,param2,param3],true,param4);
      }
      
      public function GetActorIdFromName(param1:String, param2:Function) : void
      {
         var done:Function = null;
         var name:String = param1;
         var resultCallBack:Function = param2;
         done = function(param1:Object):void
         {
            var _loc2_:Number = NaN;
            if(resultCallBack != null)
            {
               _loc2_ = Number(Number(param1.result));
               resultCallBack(_loc2_);
            }
         };
         _amfCaller.callFunction("GetActorIdFromName",[name],true,done);
      }
      
      public function GetActorNameFromId(param1:int, param2:Function) : void
      {
         var done:Function = null;
         var actorId:int = param1;
         var resultCallBack:Function = param2;
         done = function(param1:Object):void
         {
            var _loc2_:Number = NaN;
            if(resultCallBack != null)
            {
               _loc2_ = Number(Number(param1.result));
               resultCallBack(_loc2_);
            }
         };
         _amfCaller.callFunction("GetActorNameFromId",[actorId],true,done);
      }
      
      public function deleteBioText(param1:Number, param2:String, param3:String, param4:Function) : void
      {
         var done:Function = null;
         var actorId:Number = param1;
         var moderatorName:String = param2;
         var moderatorPass:String = param3;
         var resultCallBack:Function = param4;
         done = function(param1:Object):void
         {
            var _loc2_:int = 0;
            if(resultCallBack != null)
            {
               _loc2_ = int(int(param1.result));
               resultCallBack(_loc2_);
            }
         };
         _amfCaller.callFunction("deleteBioText",[actorId,moderatorName,moderatorPass],true,done);
      }
      
      public function SendEmailValidation(param1:String, param2:int, param3:String, param4:String, param5:int, param6:Function) : void
      {
         _amfCaller.callFunction("SendEmailValidation",[param1,param2,param3,param4,param5],true,param6);
      }
      
      public function SendUserParentEmailValidation(param1:String, param2:String, param3:int, param4:String, param5:String, param6:int, param7:Function) : void
      {
         _amfCaller.callFunction("SendUserParentEmailValidation",[param1,param2,param3,param4,param5,param6],true,param7);
      }
      
      public function SendNewEmailValidation(param1:String, param2:int, param3:String, param4:String, param5:int, param6:Boolean, param7:Function) : void
      {
         _amfCaller.callFunction("SendNewEmailValidation",[param1,param2,param3,param4,param5,param6],true,param7);
      }
      
      public function EmailChanged(param1:int, param2:String, param3:String, param4:String, param5:int, param6:Function) : void
      {
         var done:Function = null;
         var actorId:int = param1;
         var mail:String = param2;
         var username:String = param3;
         var password:String = param4;
         var emailSettings:int = param5;
         var resultCallBack:Function = param6;
         done = function(param1:int):void
         {
            if(resultCallBack != null)
            {
               resultCallBack(param1);
            }
         };
         _amfCaller.callFunction("EmailChanged",[actorId,mail,username,password,emailSettings],false,done);
      }
      
      public function EmailValidated(param1:int, param2:Function) : void
      {
         var done:Function = null;
         var actorId:int = param1;
         var resultCallBack:Function = param2;
         done = function(param1:Object):void
         {
            var _loc2_:Boolean = false;
            if(resultCallBack != null)
            {
               _loc2_ = Boolean(Boolean(param1));
               resultCallBack(_loc2_);
            }
         };
         _amfCaller.callFunction("EmailValidated",[actorId],false,done);
      }
      
      public function EmailValidatedCancel(param1:int) : void
      {
         _amfCaller.callFunction("EmailValidatedCancel",[param1],false,null);
      }
      
      public function UpdateGift(param1:int, param2:Function) : void
      {
         var done:Function = null;
         var actorId:int = param1;
         var resultCallBack:Function = param2;
         done = function(param1:Object):void
         {
            var _loc2_:GiftSwfAndNameAndGiver = new GiftSwfAndNameAndGiver();
            _loc2_.Name = param1.Name;
            _loc2_.Giver = param1.Giver;
            _loc2_.swf = param1.swf;
            resultCallBack(_loc2_);
         };
         _amfCaller.callFunction("UpdateGift",[actorId],true,done);
      }
      
      public function GetMarketingStepGift(param1:int, param2:Function) : void
      {
         _amfCaller.callFunction("GetMarketingStepGift",[param1],true,param2);
      }
      
      public function UpdateBehaviourStatus(param1:int, param2:int, param3:String, param4:Number, param5:int, param6:Function) : void
      {
         var done:Function = null;
         var actorId:int = param1;
         var behaviourStatus:int = param2;
         var lockedText:String = param3;
         var chatLogId:Number = param4;
         var handledByActorId:int = param5;
         var resultCallBack:Function = param6;
         done = function(param1:int):void
         {
            if(resultCallBack != null)
            {
               resultCallBack(param1);
            }
         };
         _amfCaller.callFunction("UpdateBehaviourStatusNew",[actorId,behaviourStatus,lockedText,chatLogId,handledByActorId],true,done);
      }
      
      public function loadActorEmail(param1:int, param2:Function) : void
      {
         var done:Function = null;
         var actorId:int = param1;
         var resultCallBack:Function = param2;
         done = function(param1:ActorEmail):void
         {
            if(resultCallBack != null)
            {
               resultCallBack(param1);
            }
         };
         _amfCaller.callFunction("loadActorEmail",[actorId],true,done);
      }
      
      public function eraseEmail(param1:String, param2:String, param3:String, param4:Function) : void
      {
         var done:Function = null;
         var email:String = param1;
         var moderatorName:String = param2;
         var moderatorPass:String = param3;
         var resultCallBack:Function = param4;
         done = function(param1:int):void
         {
            if(resultCallBack != null)
            {
               resultCallBack(param1);
            }
         };
         _amfCaller.callFunction("eraseEmail",[email,moderatorName,moderatorPass],true,done);
      }
      
      public function RecoverUserFromEmailHistory(param1:String, param2:String, param3:Function) : void
      {
         var done:Function = null;
         var actorName:String = param1;
         var email:String = param2;
         var resultCallBack:Function = param3;
         done = function(param1:int):void
         {
            if(resultCallBack != null)
            {
               resultCallBack(param1);
            }
         };
         _amfCaller.callFunction("RecoverUserFromEmailHistory",[actorName,email],true,done);
      }
      
      public function sendMailConfirmChangeMail(param1:Number, param2:String, param3:Function) : void
      {
         var done:Function = null;
         var actorId:Number = param1;
         var queryparams:String = param2;
         var resultCallBack:Function = param3;
         done = function(param1:int):void
         {
            if(resultCallBack != null)
            {
               resultCallBack(param1);
            }
         };
         _amfCaller.callFunction("SendMailConfirmChangeMail",[actorId,queryparams],true,done);
      }
      
      public function sendMailConfirmDeleteUser(param1:Number, param2:String, param3:Function) : void
      {
         var done:Function = null;
         var actorId:Number = param1;
         var queryparams:String = param2;
         var resultCallBack:Function = param3;
         done = function(param1:int):void
         {
            if(resultCallBack != null)
            {
               resultCallBack(param1);
            }
         };
         _amfCaller.callFunction("SendMailConfirmDeleteUser",[actorId,queryparams],true,done);
      }
      
      public function forgotPasswordOutsideGame(param1:String, param2:String, param3:Function) : void
      {
         var done:Function = null;
         var actorName:String = param1;
         var email:String = param2;
         var resultCallBack:Function = param3;
         done = function(param1:int):void
         {
            if(resultCallBack != null)
            {
               resultCallBack(param1);
            }
         };
         _amfCaller.callFunction("ForgotPasswordOutsideGame",[actorName,email],true,done);
      }
      
      public function forgotPasswordInsideGame(param1:int, param2:String, param3:String, param4:Function) : void
      {
         var done:Function = null;
         var actorId:int = param1;
         var actorName:String = param2;
         var email:String = param3;
         var resultCallBack:Function = param4;
         done = function(param1:int):void
         {
            if(resultCallBack != null)
            {
               resultCallBack(param1);
            }
         };
         _amfCaller.callFunction("ForgotPasswordInsideGame",[actorId,actorName,email],true,done);
      }
      
      public function redeemBooninho(param1:int, param2:Function) : void
      {
         var done:Function = null;
         var actorId:int = param1;
         var resultCallBack:Function = param2;
         done = function(param1:int):void
         {
            if(resultCallBack != null)
            {
               resultCallBack(param1);
            }
         };
         _amfCaller.callFunction("AddBooninhoToActorBonsterRel",[actorId],true,done);
      }
   }
}

class SingletonEnforcer
{
   
   public function SingletonEnforcer()
   {
      super();
   }
}
