package com.moviestarplanet.userbehavior
{
   public interface ICensor
   {
      
      function censorText(param1:String, param2:int = -1) : String;
      
      function set whitelistEnabled(param1:Boolean) : void;
      
      function get whitelistEnabled() : Boolean;
      
      function get userMuted() : Boolean;
      
      function checkForBadWordsAndRedify(param1:IRedifyableTextInputComponent) : Boolean;
      
      function redify(param1:IRedifyableTextInputComponent) : void;
      
      function containsPassword(param1:String) : int;
      
      function get isModerator() : Boolean;
   }
}

