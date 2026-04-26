package com.moviestarplanet.valueObjectsCustom
{
   import com.moviestarplanet.usersession.valueobjects.ActorDetails;
   
   public class BuyClothesResponse
   {
      
      private var _items:Array;
      
      private var _actorDetails:ActorDetails;
      
      private var _awardedFame:int;
      
      public function BuyClothesResponse()
      {
         super();
      }
      
      public function get items() : Array
      {
         return this._items;
      }
      
      public function get actorDetails() : ActorDetails
      {
         return this._actorDetails;
      }
      
      public function get awardedFame() : int
      {
         return this._awardedFame;
      }
      
      public function clearAssociations() : void
      {
      }
      
      public function set items(param1:*) : void
      {
         if(param1 is Array)
         {
            this._items = param1;
         }
         else if((param1 as Object).hasOwnProperty("toArray"))
         {
            this._items = (param1 as Object)["toArray"]();
         }
      }
      
      public function set actorDetails(param1:ActorDetails) : void
      {
         this._actorDetails = param1;
      }
      
      public function set awardedFame(param1:int) : void
      {
         this._awardedFame = param1;
      }
   }
}

