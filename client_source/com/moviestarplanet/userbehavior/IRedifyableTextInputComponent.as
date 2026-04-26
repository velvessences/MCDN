package com.moviestarplanet.userbehavior
{
   public interface IRedifyableTextInputComponent
   {
      
      function get text() : String;
      
      function set text(param1:String) : void;
      
      function doRedify(param1:Array) : void;
      
      function removeRedified() : void;
      
      function enableUserInput() : void;
      
      function disableUserInput() : void;
      
      function get isEnabled() : Boolean;
   }
}

