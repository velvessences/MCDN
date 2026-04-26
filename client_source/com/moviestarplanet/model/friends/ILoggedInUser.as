package com.moviestarplanet.model.friends
{
   public interface ILoggedInUser
   {
      
      function get userId() : int;
      
      function get ticket() : String;
      
      function get name() : String;
      
      function get isVip() : Boolean;
      
      function get chatEnabled() : Boolean;
      
      function get hardCurrencyAmount() : int;
   }
}

