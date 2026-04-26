package com.moviestarplanet.clientcensor
{
   public class BlackWordAlert
   {
      
      private var newText:String;
      
      private var badWordCounter:int;
      
      public function BlackWordAlert(param1:String, param2:int = 0)
      {
         super();
         this.newText = param1;
         this.badWordCounter = param2;
      }
      
      public function get NewText() : String
      {
         return this.newText;
      }
      
      public function get BadWordCounter() : int
      {
         return this.badWordCounter;
      }
   }
}

