package com.moviestarplanet.blob.service
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.model.IActorModel;
   import com.moviestarplanet.service.ISessionAmfService;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class AmfBlobService implements IBlobService
   {
      
      private static var amfCaller:AmfCaller = new AmfCaller("Website.AmfBlobService");
      
      [Inject]
      public var service:ISessionAmfService;
      
      [Inject]
      public var actorModel:IActorModel;
      
      public var BlobServiceHostName:String;
      
      public function AmfBlobService()
      {
         super();
         InjectionManager.manager().injectMe(this);
      }
      
      public function SaveLook(param1:Number, param2:ByteArray, param3:Function) : void
      {
         var onBlobserviceName:Function = null;
         var lookId:Number = param1;
         var data:ByteArray = param2;
         var resultCallback:Function = param3;
         onBlobserviceName = function(param1:String):void
         {
            if(param1 != null)
            {
               BlobServiceHostName = param1;
               amfCaller.callFunction("SaveLookData",[actorModel.actorId,lookId,data],true,resultCallback,null,param1);
            }
            else
            {
               resultCallback();
            }
         };
         if(!this.BlobServiceHostName)
         {
            this.service.GetAppSetting("BlobServiceHostName",onBlobserviceName);
         }
         else
         {
            onBlobserviceName(this.BlobServiceHostName);
         }
      }
      
      public function RequestLoad(param1:Array, param2:Function, param3:Array = null) : void
      {
         new BlobLoader().RequestLoad("look",param1,param2,null,2,true,param3);
      }
      
      public function FillInWithLookData(param1:Array, param2:Function) : void
      {
         var lookDataLoaded:Function;
         var listOfIds:Array = null;
         var listOfDatestamps:Array = null;
         var i:int = 0;
         var list:Array = param1;
         var doneCallback:Function = param2;
         if(list != null && list.length > 0)
         {
            lookDataLoaded = function(param1:Dictionary):void
            {
               var _loc2_:int = 0;
               while(_loc2_ < list.length)
               {
                  if(list[_loc2_] != null)
                  {
                     list[_loc2_].LookData = param1[list[_loc2_].LookId];
                  }
                  _loc2_++;
               }
               doneCallback();
            };
            listOfIds = new Array();
            listOfDatestamps = new Array();
            i = 0;
            while(i < list.length)
            {
               if(list[i] != null)
               {
                  listOfIds.push(list[i].LookId);
                  listOfDatestamps.push(list[i].LastEditedOn);
               }
               i++;
            }
            this.RequestLoad(listOfIds,lookDataLoaded,listOfDatestamps);
         }
         else
         {
            doneCallback();
         }
      }
   }
}

