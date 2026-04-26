package com.moviestarplanet.amf
{
   import flash.net.NetConnection;
   
   public class FluorineNetConnection extends NetConnection
   {
      
      public function FluorineNetConnection()
      {
         super();
      }
      
      public function RequestPersistentHeader(param1:Object) : void
      {
         super.addHeader(param1.name,param1.mustUnderstand,param1.data);
      }
   }
}

