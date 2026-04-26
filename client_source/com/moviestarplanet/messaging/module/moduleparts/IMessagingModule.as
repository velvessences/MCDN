package com.moviestarplanet.messaging.module.moduleparts
{
   import com.moviestarplanet.Module.ModuleInterface;
   
   public interface IMessagingModule extends ModuleInterface
   {
      
      function openMessagingViewWithConversation(param1:String) : void;
      
      function openMessagingViewWithActor(param1:int) : void;
      
      function openMessagingView() : void;
   }
}

