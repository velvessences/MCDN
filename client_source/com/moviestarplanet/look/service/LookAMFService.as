package com.moviestarplanet.look.service
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.amf.PagerResultObject;
   import com.moviestarplanet.blob.service.IBlobService;
   import com.moviestarplanet.chatCommunicator.chatHelpers.configuration.InputLocations;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.look.valueobjects.LookItem;
   import com.moviestarplanet.look.valueobjects.PagedLookList;
   import com.moviestarplanet.model.IActorModel;
   import com.moviestarplanet.userbehavior.utils.chatfilter.userbehaviorcontrol.UserBehaviorControl;
   import com.moviestarplanet.userbehavior.valueObjects.UserGeneratedContentField;
   import com.moviestarplanet.userbehavior.valueObjects.UserGeneratedContentType;
   
   public class LookAMFService implements ILookService
   {
      
      private static var amfCaller:AmfCaller = new AmfCaller("MovieStarPlanet.WebService.Looks.AMFLookService");
      
      [Inject]
      public var blobService:IBlobService;
      
      [Inject]
      public var actorModel:IActorModel;
      
      public function LookAMFService()
      {
         super();
         InjectionManager.manager().injectMe(this);
      }
      
      public function LookDelete(param1:Number, param2:Function) : void
      {
         var webMethodDone:Function = null;
         var lookId:Number = param1;
         var resultCallBack:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:Boolean = false;
            if(resultCallBack != null)
            {
               _loc2_ = Boolean(Boolean(param1));
               resultCallBack(_loc2_);
            }
         };
         amfCaller.callFunction("LookDelete",[lookId,this.actorModel.actorId],true,webMethodDone);
      }
      
      public function GetLooksForActor(param1:Array, param2:int, param3:int, param4:Function) : void
      {
         var webMethodDone:Function = null;
         var params:Array = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var resultCallBack:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            var pagerResultObject:PagerResultObject = null;
            var callResultCallback:Function = null;
            var data:Object = param1;
            callResultCallback = function():void
            {
               resultCallBack(pagerResultObject);
            };
            var list:PagedLookList = data as PagedLookList;
            var isFullPage:Boolean = list.items.length == pageSize;
            pagerResultObject = new PagerResultObject(list.totalRecords,isFullPage,list.items,pageIndex);
            blobService.FillInWithLookData(list.items,callResultCallback);
         };
         var actorId:int = int(params[0]);
         var orderBy:String = params[1];
         amfCaller.callFunction("GetLooksForActor",[actorId,this.actorModel.actorId,orderBy,pageIndex,pageSize],true,webMethodDone);
      }
      
      public function GetLooksByOthers(param1:Array, param2:int, param3:int, param4:Function) : void
      {
         var webMethodDone:Function = null;
         var params:Array = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var resultCallBack:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            var pagerResultObject:PagerResultObject = null;
            var callResultCallback:Function = null;
            var data:Object = param1;
            callResultCallback = function():void
            {
               resultCallBack(pagerResultObject);
            };
            var list:PagedLookList = PagedLookList(data);
            var isFullPage:Boolean = list.items.length == pageSize;
            pagerResultObject = new PagerResultObject(list.totalRecords,isFullPage,list.items,pageIndex);
            blobService.FillInWithLookData(list.items,callResultCallback);
         };
         var actorId:int = int(params[0]);
         var orderBy:String = params[1];
         amfCaller.callFunction("GetLooksByOthers",[actorId,this.actorModel.actorId,orderBy,pageIndex,pageSize],true,webMethodDone);
      }
      
      public function GetLooksForOthers(param1:Array, param2:int, param3:int, param4:Function) : void
      {
         var webMethodDone:Function = null;
         var params:Array = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var resultCallBack:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            var pagerResultObject:PagerResultObject = null;
            var callResultCallback:Function = null;
            var data:Object = param1;
            callResultCallback = function():void
            {
               resultCallBack(pagerResultObject);
            };
            var list:PagedLookList = PagedLookList(data);
            var isFullPage:Boolean = list.items.length == pageSize;
            pagerResultObject = new PagerResultObject(list.totalRecords,isFullPage,list.items,pageIndex);
            blobService.FillInWithLookData(list.items,callResultCallback);
         };
         var actorId:int = int(params[0]);
         var orderBy:String = params[1];
         amfCaller.callFunction("GetLooksForOthers",[actorId,this.actorModel.actorId,orderBy,pageIndex,pageSize],true,webMethodDone);
      }
      
      public function GetLooksCreatedBy(param1:Array, param2:int, param3:int, param4:Function) : void
      {
         var webMethodDone:Function = null;
         var params:Array = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var resultCallBack:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            var pagerResultObject:PagerResultObject = null;
            var callResultCallback:Function = null;
            var data:Object = param1;
            callResultCallback = function():void
            {
               resultCallBack(pagerResultObject);
            };
            var list:PagedLookList = PagedLookList(data);
            var isFullPage:Boolean = list.items.length == pageSize;
            pagerResultObject = new PagerResultObject(list.totalRecords,isFullPage,list.items,pageIndex);
            blobService.FillInWithLookData(list.items,callResultCallback);
         };
         var actorId:int = int(params[0]);
         var orderBy:String = params[1];
         amfCaller.callFunction("GetLooksCreatedBy",[actorId,this.actorModel.actorId,orderBy,pageIndex,pageSize],true,webMethodDone);
      }
      
      public function SaveLook(param1:LookItem, param2:Array, param3:Function) : void
      {
         var dataObj:Object = null;
         var webMethodDone:Function = null;
         var look:LookItem = param1;
         var clotheIds:Array = param2;
         var resultCallBack:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            var blobServiceSaveLook:Function = null;
            var data:Object = param1;
            blobServiceSaveLook = function():void
            {
               if(resultCallBack != null)
               {
                  resultCallBack(dataObj);
               }
            };
            dataObj = data;
            var result:Number = Number(Number(data.lookId));
            blobService.SaveLook(result,look.LookData,blobServiceSaveLook);
         };
         amfCaller.callFunction("SaveLookWithClothes",[look,clotheIds],true,webMethodDone);
         UserBehaviorControl.getInstance().submitUGC(InputLocations.LOC_LOOK_NAME,look.LookId,look.CreatorId,[new UserGeneratedContentField(UserGeneratedContentType.DESCR_LOOK_NAME,look.filteredName,UserGeneratedContentType.TEXT)]);
      }
      
      public function GetAnyLookById(param1:Number, param2:Function) : void
      {
         var webMethodDone:Function = null;
         var lookId:Number = param1;
         var resultCallBack:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            var callDoneCallback:Function;
            var created:Date = null;
            var data:Object = param1;
            if(resultCallBack != null)
            {
               callDoneCallback = function():void
               {
                  resultCallBack(data);
               };
               created = data.Created;
               if(created.time > new Date(2013,0,1).time)
               {
                  blobService.FillInWithLookData([data],callDoneCallback);
               }
               else
               {
                  resultCallBack(data);
               }
            }
         };
         amfCaller.callFunction("GetLookById",[lookId],true,webMethodDone);
      }
      
      public function GetLookById(param1:Number, param2:Function) : void
      {
         var webMethodDone:Function = null;
         var lookId:Number = param1;
         var resultCallBack:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            var callDoneCallback:Function;
            var created:Date = null;
            var data:Object = param1;
            if(resultCallBack != null)
            {
               callDoneCallback = function():void
               {
                  resultCallBack(data);
               };
               created = data.Created;
               if(created.time > new Date(2013,0,1).time)
               {
                  blobService.FillInWithLookData([data],callDoneCallback);
               }
               else
               {
                  resultCallBack(data);
               }
            }
         };
         amfCaller.callFunction("GetLookById",[lookId,this.actorModel.actorId],true,webMethodDone);
      }
      
      public function GetRandomLookByLikes(param1:Number, param2:Function) : void
      {
         var webMethodDone:Function = null;
         var poolSize:Number = param1;
         var resultCallBack:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            var callDoneCallback:Function;
            var data:Object = param1;
            if(resultCallBack != null)
            {
               callDoneCallback = function():void
               {
                  resultCallBack(data);
               };
               blobService.FillInWithLookData([data],callDoneCallback);
            }
         };
         amfCaller.callFunction("GetRandomLookByLikes",[poolSize],true,webMethodDone,null);
      }
   }
}

