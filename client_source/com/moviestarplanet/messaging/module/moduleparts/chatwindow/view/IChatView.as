package com.moviestarplanet.messaging.module.moduleparts.chatwindow.view
{
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   
   public interface IChatView extends IEventDispatcher
   {
      
      function get isDisplayed() : Boolean;
      
      function get x() : Number;
      
      function get y() : Number;
      
      function destroy() : void;
      
      function close(param1:MouseEvent = null) : void;
   }
}

