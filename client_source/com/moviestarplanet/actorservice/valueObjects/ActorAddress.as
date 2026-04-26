package com.moviestarplanet.actorservice.valueObjects
{
   public class ActorAddress
   {
      
      public var ActorId:int;
      
      public var Name:String;
      
      public var Street:String;
      
      public var ZipCode:String;
      
      public var County:String;
      
      public var Country:String;
      
      public function ActorAddress()
      {
         super();
      }
      
      public static function GetInstance(param1:Object) : ActorAddress
      {
         var _loc2_:ActorAddress = new ActorAddress();
         if(param1 == null)
         {
            return null;
         }
         _loc2_.ActorId = param1.ActorId;
         _loc2_.Name = param1.Name;
         _loc2_.Street = param1.Street;
         _loc2_.ZipCode = param1.ZipCode;
         _loc2_.County = param1.County;
         _loc2_.Country = param1.Country;
         return _loc2_;
      }
   }
}

