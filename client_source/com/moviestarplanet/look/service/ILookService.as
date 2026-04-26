package com.moviestarplanet.look.service
{
   import com.moviestarplanet.look.valueobjects.LookItem;
   
   public interface ILookService
   {
      
      function LookDelete(param1:Number, param2:Function) : void;
      
      function GetLooksForActor(param1:Array, param2:int, param3:int, param4:Function) : void;
      
      function GetLooksByOthers(param1:Array, param2:int, param3:int, param4:Function) : void;
      
      function GetLooksForOthers(param1:Array, param2:int, param3:int, param4:Function) : void;
      
      function GetLooksCreatedBy(param1:Array, param2:int, param3:int, param4:Function) : void;
      
      function SaveLook(param1:LookItem, param2:Array, param3:Function) : void;
      
      function GetLookById(param1:Number, param2:Function) : void;
      
      function GetAnyLookById(param1:Number, param2:Function) : void;
   }
}

