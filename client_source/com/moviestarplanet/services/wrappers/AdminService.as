package com.moviestarplanet.services.wrappers
{
   import com.moviestarplanet.amf.PagerResultObject;
   import com.moviestarplanet.forum.valueobjects.Topic;
   import com.moviestarplanet.services.service.Service;
   import com.moviestarplanet.services.wrappers.call.RpcFaultHandler;
   import com.moviestarplanet.valueObjects.PagedLocaleResourceList;
   import mx.collections.ArrayCollection;
   import mx.rpc.CallResponder;
   
   public class AdminService extends WebService
   {
      
      public function AdminService()
      {
         super();
      }
      
      public static function forceEntityNameChange(param1:int, param2:int, param3:int, param4:String, param5:String, param6:Function = null) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var entityId:int = param1;
         var type:int = param2;
         var handledById:int = param3;
         var adminUserName:String = param4;
         var adminPassword:String = param5;
         var resultHandler:Function = param6;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            if(resultHandler != null)
            {
               resultHandler(param1.result);
            }
         };
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.ForceEntityNameChange(entityId,handledById,type,adminUserName,adminPassword),webMethodDone);
      }
      
      public static function deleteTwitterText(param1:Number, param2:String, param3:String, param4:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorId:Number = param1;
         var moderatorName:String = param2;
         var moderatorPass:String = param3;
         var resultCallBack:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            var _loc2_:int = int(int(param1.result));
            resultCallBack(_loc2_);
         };
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.deleteTwitterText(actorId,moderatorName,moderatorPass),webMethodDone);
      }
      
      public static function getLoginHistory(param1:int, param2:String, param3:String, param4:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var adminUserName:String = param2;
         var adminPassword:String = param3;
         var resultCallBack:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            resultCallBack(param1.result as ArrayCollection);
         };
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.getLoginHistory(actorId,adminUserName,adminPassword),webMethodDone);
      }
      
      public static function giveAutoWarning(param1:int, param2:String, param3:int, param4:int, param5:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var lockedText:String = param2;
         var loc:int = param3;
         var handledByActorId:int = param4;
         var resultCallBack:Function = param5;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:int = 0;
            clearResponder(responder,webMethodDone);
            if(resultCallBack != null)
            {
               _loc2_ = int(int(param1.result));
               resultCallBack(_loc2_);
            }
         };
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.GiveAutoWarning(actorId,lockedText,loc,handledByActorId),webMethodDone);
      }
      
      public static function LockOutUser(param1:int, param2:int, param3:String, param4:Number, param5:int, param6:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var numberOfDays:int = param2;
         var lockedText:String = param3;
         var chatLogId:Number = param4;
         var handledByActorId:int = param5;
         var resultCallBack:Function = param6;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:int = 0;
            clearResponder(responder,webMethodDone);
            if(resultCallBack != null)
            {
               _loc2_ = int(int(param1.result));
               resultCallBack(_loc2_);
            }
         };
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.LockOutUser(actorId,numberOfDays,lockedText,chatLogId,handledByActorId),webMethodDone);
      }
      
      public static function GetLocaleResources(param1:Array, param2:int, param3:int, param4:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var params:Array = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var resultCallBack:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            var _loc2_:PagedLocaleResourceList = PagedLocaleResourceList(param1.result);
            var _loc3_:Boolean = _loc2_.items.length == pageSize;
            var _loc4_:PagerResultObject = new PagerResultObject(_loc2_.totalRecords,_loc3_,_loc2_.items.toArray(),pageIndex);
            resultCallBack(_loc4_);
         };
         var locale:String = params[0];
         var filterBy:String = params[1];
         var filterValue:String = params[2];
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.GetLocaleResources(locale,filterBy,filterValue,pageIndex,pageSize),webMethodDone);
      }
      
      public static function SaveLocaleResources(param1:ArrayCollection, param2:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var localeResources:ArrayCollection = param1;
         var resultCallBack:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            var _loc2_:Number = Number(Number(param1.result));
            if(resultCallBack != null)
            {
               resultCallBack(_loc2_);
            }
         };
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.SaveLocaleResources(localeResources),webMethodDone);
      }
      
      public static function deleteTopic(param1:Number, param2:String, param3:String, param4:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var topicId:Number = param1;
         var moderatorName:String = param2;
         var moderatorPass:String = param3;
         var resultCallBack:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            var _loc2_:int = int(int(param1.result));
            resultCallBack(_loc2_);
         };
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.deleteTopic(topicId,moderatorName,moderatorPass),webMethodDone);
      }
      
      public static function deletePost(param1:Number, param2:String, param3:String, param4:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var postId:Number = param1;
         var moderatorName:String = param2;
         var moderatorPass:String = param3;
         var resultCallBack:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            var _loc2_:int = int(int(param1.result));
            resultCallBack(_loc2_);
         };
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.DeletePost(postId,moderatorName,moderatorPass),webMethodDone);
      }
      
      public static function moderatorUpdateTopic(param1:Topic, param2:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var topic:Topic = param1;
         var done:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone,RpcFaultHandler.faultHandlerNoLogout);
            done();
         };
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.moderatorUpdateTopic(topic),webMethodDone,RpcFaultHandler.faultHandlerNoLogout);
      }
      
      public static function getActorLocale(param1:Number, param2:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var actorId:Number = param1;
         var callback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            callback(param1.result);
         };
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.GetActorLocale(actorId),webMethodDone);
      }
   }
}

