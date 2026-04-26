package com.moviestarplanet.pet.service
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.chatCommunicator.chatHelpers.configuration.InputLocations;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.model.IActorModel;
   import com.moviestarplanet.pet.valueobjects.ActorClickItemRel;
   import com.moviestarplanet.pet.valueobjects.ActorClickItemWithPrice;
   import com.moviestarplanet.pet.valueobjects.ClickItemVO;
   import com.moviestarplanet.pet.valueobjects.PetLocation;
   import com.moviestarplanet.userbehavior.utils.chatfilter.userbehaviorcontrol.UserBehaviorControl;
   import com.moviestarplanet.userbehavior.valueObjects.UserGeneratedContentField;
   import com.moviestarplanet.userbehavior.valueObjects.UserGeneratedContentType;
   import com.moviestarplanet.utils.DateUtils;
   import flash.utils.ByteArray;
   
   public class PetAMFService implements IPetService
   {
      
      private static var amfCaller:AmfCaller = new AmfCaller("MovieStarPlanet.WebService.Pets.AMFPetService");
      
      protected static var petsPettedAlready:Array = new Array();
      
      [Inject]
      public var actorModel:IActorModel;
      
      public function PetAMFService()
      {
         super();
      }
      
      public function CurePet(param1:int, param2:Function) : void
      {
         var webMethodDone:Function = null;
         var actorClickItemRelId:int = param1;
         var doneCallback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            doneCallback(ActorClickItemRel.GetInstance(param1));
         };
         amfCaller.callFunction("CurePet",[actorClickItemRelId],true,webMethodDone);
      }
      
      public function FeedPet(param1:int, param2:int, param3:Function) : void
      {
         var webMethodDone:Function = null;
         var actorClickItemRelId:int = param1;
         var foodPoints:int = param2;
         var doneCallback:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            doneCallback(param1);
         };
         amfCaller.callFunction("FeedPet",[actorClickItemRelId,foodPoints],true,webMethodDone);
      }
      
      public function HatchPet(param1:int, param2:ByteArray, param3:Function) : void
      {
         var webMethodDone:Function = null;
         var actorClickItemRelId:int = param1;
         var configuration:ByteArray = param2;
         var doneCallback:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            doneCallback(ActorClickItemRel.GetInstance(param1));
         };
         amfCaller.callFunction("HatchPet",[actorClickItemRelId,configuration],true,webMethodDone);
      }
      
      public function SaveClickItemLocations(param1:Array, param2:Function) : void
      {
         var pet:ActorClickItemRel = null;
         var webMethodDone:Function = null;
         var changedClickItems:Array = param1;
         var doneCallback:Function = param2;
         webMethodDone = function(param1:int):void
         {
            doneCallback(param1);
         };
         var locations:Array = new Array();
         for each(pet in changedClickItems)
         {
            locations.push(new PetLocation(pet.ActorClickItemRelId,pet.x,pet.y));
         }
         amfCaller.callFunction("SaveClickItemLocations",[locations],true,webMethodDone);
      }
      
      public function PlayedPetGame(param1:int, param2:int, param3:Function) : void
      {
         var webMethodDone:Function = null;
         var actorClickItemRelId:int = param1;
         var playPoints:int = param2;
         var doneCallback:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            doneCallback(param1 as int);
         };
         amfCaller.callFunction("PlayedPetGame",[actorClickItemRelId,playPoints],true,webMethodDone);
      }
      
      public function GetClickItemsForActorWithPrice(param1:int, param2:Function) : void
      {
         var webMethodDone:Function = null;
         var actorid:int = param1;
         var doneCallback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            doneCallback(ActorClickItemWithPrice.GetInstanceArray(param1));
         };
         amfCaller.callFunction("GetClickItemsForActorWithPrice",[actorid],true,webMethodDone);
      }
      
      public function GetClickItemsFromServer(param1:Function) : void
      {
         var webMethodDone:Function = null;
         var doneCallback:Function = param1;
         webMethodDone = function(param1:Object):void
         {
            doneCallback(ClickItemVO.GetInstanceArray(param1));
         };
         amfCaller.callFunction("GetClickItems",[],true,webMethodDone,null);
      }
      
      public function GetActorClickItem(param1:int, param2:Function) : void
      {
         var webMethodDone:Function = null;
         var actorClickItemRelId:int = param1;
         var doneCallback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            doneCallback(ActorClickItemRel.GetInstance(param1));
         };
         amfCaller.callFunction("GetActorClickItem",[actorClickItemRelId],true,webMethodDone,null);
      }
      
      public function BuyClickItem(param1:int, param2:int, param3:Function = null) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var clickItemId:int = param2;
         var doneCallback:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            if(doneCallback != null)
            {
               doneCallback(param1);
            }
         };
         amfCaller.callFunction("BuyClickItem",[actorId,clickItemId],true,webMethodDone);
      }
      
      public function SaveClickItemName(param1:int, param2:String, param3:Function = null) : void
      {
         var webMethodDone:Function = null;
         var actorClickItemRelId:int = param1;
         var name:String = param2;
         var doneCallback:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            if(doneCallback != null)
            {
               doneCallback();
            }
         };
         if(!this.actorModel)
         {
            InjectionManager.manager().injectMe(this);
         }
         amfCaller.callFunction("SavePetName",[actorClickItemRelId,name],true,webMethodDone);
         UserBehaviorControl.getInstance().submitUGC(InputLocations.LOC_PETNAME,actorClickItemRelId,this.actorModel.actorId,[new UserGeneratedContentField(UserGeneratedContentType.DESCR_PETNAME,name,UserGeneratedContentType.TEXT)]);
      }
      
      public function CheckOutPetHotel(param1:int, param2:int, param3:Function = null) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var clickItemRelId:int = param2;
         var done:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:ActorClickItemRel = null;
            if(null != done && param1 != null && Boolean(param1.hasOwnProperty("ActorClickItemRelId")))
            {
               _loc2_ = ActorClickItemRel.GetInstance(param1);
               _loc2_.AtHotelUntil = DateUtils.UTCtoLocalTime(_loc2_.AtHotelUntil);
               done(_loc2_);
            }
         };
         amfCaller.callFunction("CheckOutPetHotel",[actorId,clickItemRelId],true,webMethodDone);
      }
      
      public function CheckInPetHotel(param1:int, param2:int, param3:int, param4:Function = null) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var clickItemRelId:int = param2;
         var stayPeriod:int = param3;
         var done:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:ActorClickItemRel = null;
            if(null != done && param1 != null && Boolean(param1.hasOwnProperty("ActorClickItemRelId")))
            {
               _loc2_ = ActorClickItemRel.GetInstance(param1);
               _loc2_.AtHotelUntil = DateUtils.UTCtoLocalTime(_loc2_.AtHotelUntil);
               done(_loc2_);
            }
         };
         amfCaller.callFunction("CheckInPetHotel",[actorId,clickItemRelId,stayPeriod],true,webMethodDone);
      }
      
      public function GetClickItemsForPetHotel(param1:int, param2:Function = null) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var done:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            if(null != done)
            {
               done(ActorClickItemRel.GetInstanceArray(param1));
            }
         };
         amfCaller.callFunction("GetClickItemsForPetHotel",[actorId],true,webMethodDone);
      }
      
      public function GetClickItemsForActor(param1:int, param2:Function) : void
      {
         var webMethodDone:Function = null;
         var actorid:int = param1;
         var doneCallback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            doneCallback(ActorClickItemRel.GetInstanceArray(param1));
         };
         amfCaller.callFunction("GetClickItemsForActor",[actorid],true,webMethodDone);
      }
      
      public function GetClickItemsForActorThatCanStillGrow(param1:int, param2:Function) : void
      {
         var webMethodDone:Function = null;
         var actorid:int = param1;
         var doneCallback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            doneCallback(ActorClickItemRel.GetInstanceArray(param1));
         };
         amfCaller.callFunction("GetClickItemsForActorThatCanStillGrow",[actorid],true,webMethodDone);
      }
      
      public function GetClickItemsForActorThatCanChange(param1:int, param2:Function) : void
      {
         var webMethodDone:Function = null;
         var actorid:int = param1;
         var doneCallback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            var noEggs:Function = null;
            var data:Object = param1;
            noEggs = function(param1:ActorClickItemRel, param2:int, param3:Array):Boolean
            {
               return param1.Stage > 0;
            };
            var result:Array = ActorClickItemRel.GetInstanceArray(data);
            result = result.filter(noEggs);
            doneCallback(result);
         };
         amfCaller.callFunction("GetClickItemsForActor",[actorid],true,webMethodDone);
      }
      
      public function HarvestPlant(param1:int, param2:int, param3:Function) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var actorClickItemRelId:int = param2;
         var resultCallBack:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:int = 0;
            if(resultCallBack != null)
            {
               _loc2_ = int(int(param1));
               resultCallBack(_loc2_);
            }
         };
         amfCaller.callFunction("HarvestPlant",[actorId,actorClickItemRelId],true,webMethodDone);
      }
      
      public function PetFriendPet(param1:int, param2:int, param3:Function) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var actorClickItemRelId:int = param2;
         var done:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:int = int(param1 as int);
            if(done != null)
            {
               done(_loc2_);
            }
         };
         if(petsPettedAlready.indexOf(actorClickItemRelId) != -1)
         {
            done(0);
         }
         else
         {
            petsPettedAlready.push(actorClickItemRelId);
            amfCaller.callFunction("PetFriendPet",[actorId,actorClickItemRelId],true,webMethodDone);
         }
      }
      
      public function WashPet(param1:int, param2:int, param3:Function) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var actorClickItemRelId:int = param2;
         var done:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            if(done != null)
            {
               done(param1);
            }
         };
         amfCaller.callFunction("WashPet",[actorId,actorClickItemRelId],true,webMethodDone);
      }
      
      public function deletePetName(param1:Number, param2:String, param3:String, param4:Function) : void
      {
         var webMethodDone:Function = null;
         var clickItemId:Number = param1;
         var moderatorName:String = param2;
         var moderatorPass:String = param3;
         var done:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:int = int(int(param1));
            done(_loc2_);
         };
         amfCaller.callFunction("DeletePetName",[clickItemId,moderatorName,moderatorPass],true,webMethodDone);
      }
   }
}

