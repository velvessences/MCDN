package com.moviestarplanet.anchorCharacters.service
{
   import com.moviestarplanet.amf.AmfCaller;
   
   public class AMFSponsoredCharacterService
   {
      
      protected var amfCaller:AmfCaller;
      
      public function AMFSponsoredCharacterService()
      {
         super();
         this.amfCaller = new AmfCaller("MovieStarPlanet.WebService.AnchorCharacter.AMFAnchorCharacterService");
      }
      
      public function getSponsoredCharactersList(param1:Function) : void
      {
         var webRequestDone:Function = null;
         var onSuccess:Function = param1;
         webRequestDone = function(param1:Object):void
         {
            onSuccess(param1);
         };
         this.amfCaller.callFunction("GetAnchorCharacterList",[],false,webRequestDone);
      }
      
      public function requestFriendship(param1:int, param2:Function, param3:Function) : void
      {
         var webRequestDone:Function = null;
         var anchorCharacterId:int = param1;
         var onSuccess:Function = param2;
         var onFail:Function = param3;
         webRequestDone = function(param1:Object):void
         {
            if(param1.Code == 0)
            {
               onSuccess(param1.Data);
            }
            else
            {
               onFail(param1.Code);
            }
         };
         this.amfCaller.callFunction("RequestFriendship",[anchorCharacterId],true,webRequestDone);
      }
      
      public function acceptGifts(param1:int, param2:Function, param3:Function) : void
      {
         var webRequestDone:Function = null;
         var anchorCharacterId:int = param1;
         var onSuccess:Function = param2;
         var onFail:Function = param3;
         webRequestDone = function(param1:Object):void
         {
            if(param1.Code == 0)
            {
               if(param1.Data == null)
               {
                  param1.Data = new Array();
               }
               onSuccess(param1.Data);
            }
            else
            {
               onFail(param1.Code);
            }
         };
         this.amfCaller.callFunction("AcceptGifts",[anchorCharacterId],true,webRequestDone);
      }
      
      public function cancelFriendship(param1:int, param2:Function) : void
      {
         var webRequestDone:Function = null;
         var anchorCharacterId:int = param1;
         var onSuccess:Function = param2;
         webRequestDone = function(param1:Object):void
         {
            onSuccess(param1);
         };
         this.amfCaller.callFunction("CancelFriendship",[anchorCharacterId],true,webRequestDone);
      }
      
      public function acceptFriendship(param1:int, param2:Function, param3:Function) : void
      {
         var webRequestDone:Function = null;
         var anchorCharacterId:int = param1;
         var onSuccess:Function = param2;
         var onFail:Function = param3;
         webRequestDone = function(param1:Object):void
         {
            if(param1.Code == 0)
            {
               onSuccess(param1.Data);
            }
            else
            {
               onFail(param1.Code);
            }
         };
         this.amfCaller.callFunction("AcceptFriendship",[anchorCharacterId],true,webRequestDone);
      }
      
      public function updateLastStatusSeen(param1:int) : void
      {
         this.amfCaller.callFunction("UpdateLastStatusSeen",[param1],true,null);
      }
      
      public function updateLastInviteSent(param1:int, param2:Boolean = false) : void
      {
         this.amfCaller.callFunction("UpdateLastInviteSent",[param1,param2],true,null);
      }
   }
}

