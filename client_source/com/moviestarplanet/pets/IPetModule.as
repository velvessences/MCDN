package com.moviestarplanet.pets
{
   import com.moviestarplanet.Module.IFlashModule;
   
   public interface IPetModule extends IFlashModule
   {
      
      function openPetPopUp(param1:int, param2:Number, param3:Number, param4:Object) : void;
   }
}

