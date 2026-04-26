package com.moviestarplanet.utils.input
{
   import com.moviestarplanet.clientcensor.textfield.TextFieldInputRestricted;
   import flash.display.Sprite;
   import flash.events.IEventDispatcher;
   
   public interface InputAreaInterface extends IEventDispatcher
   {
      
      function get fontColorButton() : Sprite;
      
      function get emoticonBtn() : Sprite;
      
      function get textArea() : TextFieldInputRestricted;
   }
}

