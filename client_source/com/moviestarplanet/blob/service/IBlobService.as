package com.moviestarplanet.blob.service
{
   import flash.utils.ByteArray;
   
   public interface IBlobService
   {
      
      function SaveLook(param1:Number, param2:ByteArray, param3:Function) : void;
      
      function RequestLoad(param1:Array, param2:Function, param3:Array = null) : void;
      
      function FillInWithLookData(param1:Array, param2:Function) : void;
   }
}

