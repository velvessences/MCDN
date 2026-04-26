package com.moviestarplanet.userbehavior.services
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.amf.ServiceUrlUtil;
   import com.moviestarplanet.amf.TicketGenerator;
   import com.moviestarplanet.userbehavior.valueObjects.EvaluateResponse;
   import com.moviestarplanet.userbehavior.valueObjects.FilteredResponse;
   import com.moviestarplanet.userbehavior.valueObjects.ProtectedEvaluateResponse;
   import com.moviestarplanet.userbehavior.valueObjects.UserGeneratedContentField;
   import flash.net.registerClassAlias;
   
   public class UserBehaviorAmfService
   {
      
      private static var country:String;
      
      private static var _site:String;
      
      private static var _sessionID:String;
      
      private static var amfEvaluateCaller:AmfCaller = new AmfCaller("UserBehaviourService.AMFEvaluate");
      
      private static var amfEventCaller:AmfCaller = new AmfCaller("UserBehaviourService.AMFEvent");
      
      private static var amfUserGeneratedContentCaller:AmfCaller = new AmfCaller("UserBehaviourService.AMFUserGeneratedContent");
      
      private static var amfServerInfoUtils:AmfCaller = new AmfCaller("UserBehaviourService.AMFServerInfoUtils");
      
      registerClassAlias("UserBehaviourService.UserGeneratedContentService+UserGeneratedContentField",UserGeneratedContentField);
      registerClassAlias("UserBehaviourService.EvaluateResponse",EvaluateResponse);
      registerClassAlias("UserBehaviourService.FilteredResponse",FilteredResponse);
      registerClassAlias("UserBehaviourService.ProtectedEvaluateResponse",ProtectedEvaluateResponse);
      
      public function UserBehaviorAmfService()
      {
         super();
      }
      
      public static function setCountry(param1:String) : void
      {
         if(param1 != "dev" && param1 != "test")
         {
            country = param1.toUpperCase();
         }
         else
         {
            country = param1;
         }
         _site = null;
      }
      
      public static function getCrispServerLanguage(param1:Function) : void
      {
         amfServerInfoUtils.callFunction("GetCrispServerLanguage",[site],false,param1,null,ServiceUrlUtil.userBehaviorServiceHostName);
      }
      
      public static function messageEvaluate(param1:int, param2:String, param3:int, param4:String, param5:int, param6:Boolean, param7:int, param8:String, param9:Function, param10:Function) : void
      {
         var _loc11_:Boolean = !param6;
         var _loc12_:String = ServiceUrlUtil.userBehaviorServiceHostName;
         amfEvaluateCaller.callFunction("MessageEvaluateWithStringReceiver",[sessionID,param1,site,param2,param3,param4,param5,_loc11_,param8,param7],false,param9,param10,_loc12_);
      }
      
      public static function logEventService(param1:String, param2:int, param3:String = null) : void
      {
         amfEventCaller.callFunction("SendEvent",[sessionID,param1,site,param2,param3],false,null,null,ServiceUrlUtil.userBehaviorServiceHostName);
      }
      
      public static function submitUGC(param1:int, param2:int, param3:int, param4:Array, param5:String = "") : void
      {
         var _loc6_:String = param1.toString() + "_" + param2.toString();
         amfUserGeneratedContentCaller.callFunction("SubmitUGC",[sessionID,_loc6_,site,param3,param4,param5],false,null,null,ServiceUrlUtil.userBehaviorServiceHostName);
      }
      
      public static function reportAbuse(param1:int, param2:int, param3:String, param4:String) : void
      {
         amfUserGeneratedContentCaller.callFunction("ReportAbuse",[sessionID,param1,param2,site,param3,param4],false,null,null,ServiceUrlUtil.userBehaviorServiceHostName);
      }
      
      public static function nameEvaluate(param1:String, param2:Function) : void
      {
         amfEvaluateCaller.callFunction("NameEvaluate",[site,param1],false,param2,null,ServiceUrlUtil.userBehaviorServiceHostName);
      }
      
      public static function get sessionID() : String
      {
         return TicketGenerator.createTicketHeader().Ticket;
      }
      
      public static function get site() : String
      {
         if(_site == null)
         {
            _site = "MSP." + country;
         }
         return _site;
      }
   }
}

