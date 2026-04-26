package com.moviestarplanet.pet.service
{
   import flash.utils.ByteArray;
   
   public interface IPetService
   {
      
      function CurePet(param1:int, param2:Function) : void;
      
      function FeedPet(param1:int, param2:int, param3:Function) : void;
      
      function HatchPet(param1:int, param2:ByteArray, param3:Function) : void;
      
      function SaveClickItemLocations(param1:Array, param2:Function) : void;
      
      function PlayedPetGame(param1:int, param2:int, param3:Function) : void;
      
      function GetClickItemsForActorWithPrice(param1:int, param2:Function) : void;
      
      function GetClickItemsFromServer(param1:Function) : void;
      
      function GetActorClickItem(param1:int, param2:Function) : void;
      
      function BuyClickItem(param1:int, param2:int, param3:Function = null) : void;
      
      function SaveClickItemName(param1:int, param2:String, param3:Function = null) : void;
      
      function CheckOutPetHotel(param1:int, param2:int, param3:Function = null) : void;
      
      function CheckInPetHotel(param1:int, param2:int, param3:int, param4:Function = null) : void;
      
      function GetClickItemsForPetHotel(param1:int, param2:Function = null) : void;
      
      function GetClickItemsForActor(param1:int, param2:Function) : void;
      
      function GetClickItemsForActorThatCanStillGrow(param1:int, param2:Function) : void;
      
      function GetClickItemsForActorThatCanChange(param1:int, param2:Function) : void;
      
      function HarvestPlant(param1:int, param2:int, param3:Function) : void;
      
      function PetFriendPet(param1:int, param2:int, param3:Function) : void;
      
      function WashPet(param1:int, param2:int, param3:Function) : void;
      
      function deletePetName(param1:Number, param2:String, param3:String, param4:Function) : void;
   }
}

