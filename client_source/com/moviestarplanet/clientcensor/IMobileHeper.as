package com.moviestarplanet.clientcensor
{
   public interface IMobileHeper
   {
      
      function initalizeBlacklistCSVFromCache(param1:String, param2:Function, param3:Function = null) : void;
      
      function get localCSV() : CSV;
      
      function get globalCSV() : CSV;
      
      function get instantBlockingData() : String;
      
      function saveLocalCSV(param1:String, param2:CSV) : void;
      
      function saveGlobalCSV(param1:CSV) : void;
      
      function saveInstantBlocking(param1:String) : void;
   }
}

