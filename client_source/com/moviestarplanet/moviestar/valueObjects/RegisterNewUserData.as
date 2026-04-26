package com.moviestarplanet.moviestar.valueObjects
{
   public class RegisterNewUserData
   {
      
      private var _eyes:Array;
      
      private var _noses:Array;
      
      private var _mouths:Array;
      
      private var _eyeShadows:Array;
      
      private var _clothes:Array;
      
      public function RegisterNewUserData()
      {
         super();
      }
      
      public function get eyes() : Array
      {
         return this._eyes;
      }
      
      public function get noses() : Array
      {
         return this._noses;
      }
      
      public function get mouths() : Array
      {
         return this._mouths;
      }
      
      public function get clothes() : Array
      {
         return this._clothes;
      }
      
      public function get eyeShadows() : Array
      {
         return this._eyeShadows;
      }
      
      public function set eyes(param1:*) : void
      {
         if(param1 is Array)
         {
            this._eyes = param1;
         }
         else if((param1 as Object).hasOwnProperty("toArray"))
         {
            this._eyes = (param1 as Object)["toArray"]();
         }
      }
      
      public function set noses(param1:*) : void
      {
         if(param1 is Array)
         {
            this._noses = param1;
         }
         else if((param1 as Object).hasOwnProperty("toArray"))
         {
            this._noses = (param1 as Object)["toArray"]();
         }
      }
      
      public function set mouths(param1:*) : void
      {
         if(param1 is Array)
         {
            this._mouths = param1;
         }
         else if((param1 as Object).hasOwnProperty("toArray"))
         {
            this._mouths = (param1 as Object)["toArray"]();
         }
      }
      
      public function set eyeShadows(param1:*) : void
      {
         if(param1 is Array)
         {
            this._eyeShadows = param1;
         }
         else if((param1 as Object).hasOwnProperty("toArray"))
         {
            this._eyeShadows = (param1 as Object)["toArray"]();
         }
      }
      
      public function set clothes(param1:*) : void
      {
         if(param1 is Array)
         {
            this._clothes = param1;
         }
         else if((param1 as Object).hasOwnProperty("toArray"))
         {
            this._clothes = (param1 as Object)["toArray"]();
         }
      }
   }
}

