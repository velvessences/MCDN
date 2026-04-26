package com.moviestarplanet.body
{
   public interface IAttachable
   {
      
      function get CategoryId() : int;
      
      function get isHair() : Boolean;
      
      function get isHeadwear() : Boolean;
      
      function get Color() : String;
      
      function attach() : void;
      
      function get Loadable() : ILoadable;
      
      function get isWearable() : Boolean;
      
      function get isHighHeel() : Boolean;
      
      function get isFootwear() : Boolean;
   }
}

