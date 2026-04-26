package com.moviestarplanet.dressing
{
   import com.moviestarplanet.Module.IFlashModule;
   import com.moviestarplanet.model.IActorModel;
   
   public interface IDressingModule extends IFlashModule
   {
      
      function openDressingRoom(param1:Number = 0, param2:Function = null, param3:Boolean = false) : void;
      
      function setActorModel(param1:IActorModel) : void;
   }
}

