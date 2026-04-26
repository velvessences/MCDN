package com.moviestarplanet.bonster.service
{
   public interface IBonsterService
   {
      
      function InstantEvolveBonster(param1:int, param2:int, param3:Function) : void;
      
      function FeedBonster(param1:int, param2:int, param3:int, param4:Function) : void;
      
      function PlayWithBonster(param1:int, param2:int, param3:int, param4:Function) : void;
      
      function WashBonster(param1:int, param2:int, param3:int, param4:Function) : void;
      
      function RenameBonster(param1:int, param2:String, param3:int, param4:Function) : void;
      
      function DeleteBonsterName(param1:int, param2:Function) : void;
      
      function GetBonsterTemplateList(param1:Function) : void;
      
      function GetBonsterCandyPrices(param1:Function) : void;
      
      function GetBonsterById(param1:int, param2:Function) : void;
      
      function GetBonsterListByActor(param1:int, param2:Boolean, param3:Function, param4:Function = null, param5:Boolean = false) : void;
      
      function SaveNewAndOldPetsPositionsInMyRoom(param1:int, param2:Array, param3:Array, param4:Function) : void;
      
      function HatchBonster(param1:int, param2:int, param3:Function) : void;
      
      function PetAnothersBonster(param1:int, param2:int, param3:Function) : void;
      
      function GetBonsterAnimations(param1:int, param2:int, param3:Function) : void;
      
      function CheckOutBonsterFromPetHotel(param1:int, param2:int, param3:Function) : void;
      
      function CheckInBonsterAtPetHotel(param1:int, param2:int, param3:int, param4:Function) : void;
      
      function AnimationUsed(param1:int, param2:int, param3:int, param4:Function) : void;
   }
}

