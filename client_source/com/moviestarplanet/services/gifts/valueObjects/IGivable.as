package com.moviestarplanet.services.gifts.valueObjects
{
   import com.moviestarplanet.actor.IClothInfo;
   import com.moviestarplanet.body.ILoadable;
   
   public interface IGivable extends ILoadable, IClothInfo
   {
      
      function get starcoinPrice() : Number;
      
      function get color() : String;
      
      function get receiverName() : String;
      
      function get giverName() : String;
      
      function get receiverActorId() : int;
      
      function get giverActorId() : int;
      
      function get vip() : Boolean;
      
      function get filteredMessage() : String;
   }
}

