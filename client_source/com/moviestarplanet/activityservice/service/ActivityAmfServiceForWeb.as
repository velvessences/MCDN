package com.moviestarplanet.activityservice.service
{
   import com.moviestarplanet.activityservice.valueObjects.ActivityUpdater;
   import com.moviestarplanet.activityservice.valueObjects.PagedActivityList;
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.amf.PagerResultObject;
   import com.moviestarplanet.blob.service.IBlobService;
   import com.moviestarplanet.commonvalueobjects.activity.PagedTodoList;
   import com.moviestarplanet.injection.InjectionManager;
   
   public class ActivityAmfServiceForWeb
   {
      
      private var _amfCaller:AmfCaller = new AmfCaller("MovieStarPlanet.WebService.Activity.AMFActivityService");
      
      [Inject]
      public var blobService:IBlobService;
      
      public function ActivityAmfServiceForWeb()
      {
         super();
         InjectionManager.manager().injectMe(this);
      }
      
      public function get amfCaller() : AmfCaller
      {
         return this._amfCaller;
      }
      
      public function getGossipActivities(param1:int, param2:Function, param3:Function) : void
      {
         this.amfCaller.callFunction("GetGossipActivities",[param1],false,param2,param3);
      }
      
      public function getGlobalActivities(param1:int, param2:Function, param3:Function) : void
      {
         this.amfCaller.callFunction("GetGlobalActivities",[param1],true,param2,param3);
      }
      
      public function getGlobalActivitiesTopActors(param1:Array, param2:Function, param3:Function) : void
      {
         this.amfCaller.callFunction("GetGlobalActivitiesTopActors",[param1],false,param2,param3);
      }
      
      public function getActivitiesByType(param1:Object, param2:int, param3:int, param4:Function, param5:Function = null) : void
      {
         var done:Function = null;
         var wsParams:Object = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var onSuccess:Function = param4;
         var onFail:Function = param5;
         done = function(param1:PagedActivityList):void
         {
            var isFullPage:Boolean = false;
            var activity:Object = null;
            var callResultCallback:Function = null;
            var list:PagedActivityList = param1;
            callResultCallback = function():void
            {
               var _loc1_:PagerResultObject = new PagerResultObject(list.totalRecords,isFullPage,list.items,pageIndex);
               onSuccess(_loc1_);
            };
            var lookDataArray:Array = [];
            isFullPage = list.items.length == pageSize;
            for each(activity in list.items)
            {
               if(activity.ActivityLook != null)
               {
                  lookDataArray.push(activity.ActivityLook);
               }
            }
            blobService.FillInWithLookData(lookDataArray,callResultCallback);
         };
         this.amfCaller.callFunction("GetActivitiesByType",[wsParams.actorId,wsParams.activityType,wsParams.isForFriends,pageIndex,pageSize],true,done,onFail);
      }
      
      public function DeleteAllTodos(param1:int, param2:int, param3:Function = null, param4:Function = null) : void
      {
         var done:Function = null;
         var actorId:int = param1;
         var todoType:int = param2;
         var onSuccess:Function = param3;
         var onFail:Function = param4;
         done = function():void
         {
            if(onSuccess != null)
            {
               onSuccess();
            }
         };
         this.amfCaller.callFunction("DeleteAllTodo",[actorId,todoType],true,done,onFail);
      }
      
      public function DeleteTodo(param1:int, param2:int, param3:Function = null, param4:Function = null) : void
      {
         var done:Function = null;
         var actorId:int = param1;
         var todoId:int = param2;
         var onSuccess:Function = param3;
         var onFail:Function = param4;
         done = function(param1:Boolean):void
         {
            if(onSuccess != null)
            {
               onSuccess();
            }
         };
         this.amfCaller.callFunction("DeleteTodo",[actorId,todoId],true,done,onFail);
      }
      
      public function GetInvitationBonus(param1:int, param2:int, param3:Function, param4:Function = null) : void
      {
         var done:Function = null;
         var actorId:int = param1;
         var todoId:int = param2;
         var onSuccess:Function = param3;
         var onFail:Function = param4;
         done = function(param1:Boolean):void
         {
            onSuccess();
         };
         this.amfCaller.callFunction("GetInvitationBonus",[actorId,todoId],true,done,onFail);
      }
      
      public function GetOfflineTodos(param1:int, param2:int, param3:int, param4:Function, param5:Function = null) : void
      {
         var done:Function = null;
         var actorId:int = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var onSuccess:Function = param4;
         var onFail:Function = param5;
         done = function(param1:PagedTodoList):void
         {
            var _loc2_:Boolean = param1.items.length == pageSize;
            var _loc3_:PagerResultObject = new PagerResultObject(param1.totalRecords,_loc2_,param1.items,pageIndex);
            onSuccess(_loc3_);
         };
         this.amfCaller.callFunction("GetOfflineTodos",[actorId,pageIndex,pageSize],true,done,onFail);
      }
      
      public function createActivity(param1:ActivityUpdater, param2:Function, param3:Function = null) : void
      {
         var done:Function = null;
         var activity:ActivityUpdater = param1;
         var onSuccess:Function = param2;
         var onFail:Function = param3;
         done = function():void
         {
            onSuccess();
         };
         this.amfCaller.callFunction("CreateActivity",[activity],true,done,onFail);
      }
   }
}

