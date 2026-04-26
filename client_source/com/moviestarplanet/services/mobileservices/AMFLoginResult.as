package com.moviestarplanet.services.mobileservices
{
   import com.moviestarplanet.valueObjects.LoginStatus2;
   
   public class AMFLoginResult
   {
      
      public var ticket:String;
      
      public var status:LoginStatus2;
      
      public function AMFLoginResult()
      {
         super();
      }
   }
}

