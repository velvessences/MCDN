package com.moviestarplanet.services.userservice.valueObjects
{
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   import com.moviestarplanet.usersession.valueobjects.ActorDetails;
   
   public class LoginStatus2
   {
      
      public var loginStatus:LoginStatus;
      
      public var hDetails:String;
      
      public var hash:String;
      
      public function LoginStatus2()
      {
         super();
      }
      
      public static function fromObject(param1:Object) : LoginStatus2
      {
         var _loc2_:LoginStatus2 = new LoginStatus2();
         _loc2_.loginStatus = LoginStatus.fromObject(param1.loginStatus);
         _loc2_.hDetails = param1.hDetails;
         _loc2_.hash = param1.hash;
         return _loc2_;
      }
      
      public function isTamperedWith() : Boolean
      {
         return SerializeUtils.checkHash("idu!2*;d" + this.getToHashValues(),this.hash) == false;
      }
      
      private function getToHashValues() : String
      {
         var _loc1_:ActorDetails = this.loginStatus.actor;
         return this.loginStatus.status + _loc1_.ActorId + _loc1_.getLoginModeratorStatusForCheckOnLogin() + _loc1_.Money + _loc1_.Diamonds + _loc1_.Fame + _loc1_.Level;
      }
   }
}

