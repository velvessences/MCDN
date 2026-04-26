package com.moviestarplanet.bonster.service
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.bonster.valueobjects.ActorBonsterRelItem;
   import com.moviestarplanet.bonster.valueobjects.BonsterInteractionResponse;
   
   public class BonsterAMFService implements IBonsterService
   {
      
      protected static var amfCaller:AmfCaller;
      
      protected static var petsPettedAlready:Array = new Array();
      
      public function BonsterAMFService()
      {
         super();
         if(!amfCaller)
         {
            amfCaller = new AmfCaller("MovieStarPlanet.WebService.Bonster.AMFBonsterService");
         }
      }
      
      public function InstantEvolveBonster(param1:int, param2:int, param3:Function) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var actorBonsterRelId:int = param2;
         var resultCallback:Function = param3;
         webMethodDone = function(param1:BonsterInteractionResponse):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1);
            }
         };
         amfCaller.callFunction("InstantEvolveBonster",[actorId,actorBonsterRelId],true,webMethodDone,null);
      }
      
      public function FeedBonster(param1:int, param2:int, param3:int, param4:Function) : void
      {
         var webMethodDone:Function = null;
         var actorBonsterRelId:int = param1;
         var foodId:int = param2;
         var actorId:int = param3;
         var resultCallback:Function = param4;
         webMethodDone = function(param1:BonsterInteractionResponse):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1);
            }
         };
         amfCaller.callFunction("FeedBonster",[actorBonsterRelId,foodId,actorId],true,webMethodDone,null);
      }
      
      public function PlayWithBonster(param1:int, param2:int, param3:int, param4:Function) : void
      {
         var webMethodDone:Function = null;
         var actorBonsterRelId:int = param1;
         var playPoints:int = param2;
         var actorId:int = param3;
         var resultCallback:Function = param4;
         webMethodDone = function(param1:BonsterInteractionResponse):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1);
            }
         };
         amfCaller.callFunction("PlayWithBonster",[actorBonsterRelId,playPoints,actorId],true,webMethodDone,null);
      }
      
      public function WashBonster(param1:int, param2:int, param3:int, param4:Function) : void
      {
         var webMethodDone:Function = null;
         var actorBonsterRelId:int = param1;
         var washPoints:int = param2;
         var actorId:int = param3;
         var resultCallback:Function = param4;
         webMethodDone = function(param1:BonsterInteractionResponse):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1);
            }
         };
         amfCaller.callFunction("WashBonster",[actorBonsterRelId,washPoints,actorId],true,webMethodDone,null);
      }
      
      public function RenameBonster(param1:int, param2:String, param3:int, param4:Function) : void
      {
         var webMethodDone:Function = null;
         var actorBonsterRelId:int = param1;
         var name:String = param2;
         var actorId:int = param3;
         var resultCallback:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1 as int);
            }
         };
         amfCaller.callFunction("RenameBonster",[actorBonsterRelId,name,actorId],true,webMethodDone,null);
      }
      
      public function DeleteBonsterName(param1:int, param2:Function) : void
      {
         var webMethodDone:Function = null;
         var actorBonsterRelId:int = param1;
         var resultCallback:Function = param2;
         webMethodDone = function(param1:int):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1);
            }
         };
         amfCaller.callFunction("DeleteBonsterName",[actorBonsterRelId],true,webMethodDone,null);
      }
      
      public function GetBonsterTemplateList(param1:Function) : void
      {
         var webMethodDone:Function = null;
         var resultCallback:Function = param1;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:Array = param1 as Array;
            if(resultCallback != null)
            {
               resultCallback(_loc2_);
            }
         };
         amfCaller.callFunction("GetBonsterTemplateList",[],false,webMethodDone);
      }
      
      public function GetBonsterById(param1:int, param2:Function) : void
      {
         var webMethodDone:Function = null;
         var actorBonsterRelId:int = param1;
         var resultCallback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            if(param1 == null)
            {
               return;
            }
            if(resultCallback != null)
            {
               resultCallback(param1 as ActorBonsterRelItem);
            }
         };
         amfCaller.callFunction("GetBonsterById",[actorBonsterRelId],false,webMethodDone,null);
      }
      
      public function GetBonsterListByActor(param1:int, param2:Boolean, param3:Function, param4:Function = null, param5:Boolean = false) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var loadAnimations:Boolean = param2;
         var resultCallback:Function = param3;
         var failCallback:Function = param4;
         var excludeHotel:Boolean = param5;
         webMethodDone = function(param1:Object):void
         {
            if(!param1)
            {
               resultCallback([]);
            }
            var _loc2_:Array = param1 as Array;
            if(resultCallback != null)
            {
               resultCallback(_loc2_);
            }
         };
         amfCaller.callFunction("GetBonsterListByActor",[actorId,loadAnimations,excludeHotel],true,webMethodDone,failCallback);
      }
      
      public function SaveNewAndOldPetsPositionsInMyRoom(param1:int, param2:Array, param3:Array, param4:Function) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var bonsterPositionsList:Array = param2;
         var clickItemsList:Array = param3;
         var resultCallback:Function = param4;
         webMethodDone = function(param1:BonsterInteractionResponse):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1);
            }
         };
         amfCaller.callFunction("SaveNewAndOldPetsPositionsInMyRoom",[actorId,bonsterPositionsList,clickItemsList],true,webMethodDone);
      }
      
      public function HatchBonster(param1:int, param2:int, param3:Function) : void
      {
         var webMethodDone:Function = null;
         var actorBonsterRelId:int = param1;
         var actorId:int = param2;
         var resultCallback:Function = param3;
         webMethodDone = function(param1:int):void
         {
            resultCallback(param1);
         };
         amfCaller.callFunction("HatchBonster",[actorBonsterRelId,actorId],true,webMethodDone,null);
      }
      
      public function GetBonsterCandyPrices(param1:Function) : void
      {
         var webMethodDone:Function = null;
         var resultCallback:Function = param1;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:Array = param1 as Array;
            if(resultCallback != null)
            {
               resultCallback(_loc2_);
            }
         };
         amfCaller.callFunction("GetBonsterCandyPrices",[],false,webMethodDone);
      }
      
      public function PetAnothersBonster(param1:int, param2:int, param3:Function) : void
      {
         if(petsPettedAlready.indexOf(param2) != -1)
         {
            param3(0);
         }
         else
         {
            petsPettedAlready.push(param2);
            amfCaller.callFunction("PetFriendBonster",[param1,param2],true,param3);
         }
      }
      
      public function GetBonsterAnimations(param1:int, param2:int, param3:Function) : void
      {
         amfCaller.callFunction("GetBonsterAnimations",[param1,param2],true,param3);
      }
      
      public function CheckOutBonsterFromPetHotel(param1:int, param2:int, param3:Function) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var actorBonsterRelId:int = param2;
         var resultCallback:Function = param3;
         webMethodDone = function(param1:int):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1);
            }
         };
         amfCaller.callFunction("CheckOutBonsterFromPetHotel",[actorBonsterRelId,actorId],true,webMethodDone);
      }
      
      public function CheckInBonsterAtPetHotel(param1:int, param2:int, param3:int, param4:Function) : void
      {
         var webMethodDone:Function = null;
         var actorBonsterRelId:int = param1;
         var bookTimeAmount:int = param2;
         var actorId:int = param3;
         var resultCallback:Function = param4;
         webMethodDone = function(param1:int):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1);
            }
         };
         amfCaller.callFunction("CheckInBonsterAtPetHotel",[actorBonsterRelId,bookTimeAmount,actorId],true,webMethodDone);
      }
      
      public function AnimationUsed(param1:int, param2:int, param3:int, param4:Function) : void
      {
         var webMethodDone:Function = null;
         var actorBonsterRelId:int = param1;
         var animationId:int = param2;
         var actorId:int = param3;
         var resultCallback:Function = param4;
         webMethodDone = function():void
         {
            if(resultCallback != null)
            {
               resultCallback();
            }
         };
         amfCaller.callFunction("AnimationUsed",[actorBonsterRelId,animationId,actorId],true,webMethodDone);
      }
   }
}

