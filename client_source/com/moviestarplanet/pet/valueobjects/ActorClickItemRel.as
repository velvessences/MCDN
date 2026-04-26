package com.moviestarplanet.pet.valueobjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import flash.utils.ByteArray;
   
   public class ActorClickItemRel
   {
      
      public var ActorClickItemRelId:int;
      
      public var ActorId:int;
      
      public var ClickItemId:int;
      
      public var FoodPoints:int;
      
      public var Stage:int;
      
      public var Name:String;
      
      public var LastFeedTime:Date;
      
      public var Data:ByteArray;
      
      public var x:int;
      
      public var y:int;
      
      public var LastWashTime:Date;
      
      public var PlayPoints:int;
      
      public var AtHotelUntil:Date;
      
      public function ActorClickItemRel()
      {
         super();
      }
      
      public static function GetInstance(param1:Object) : ActorClickItemRel
      {
         if(!param1)
         {
            return null;
         }
         var _loc2_:ActorClickItemRel = new ActorClickItemRel();
         _loc2_.ActorClickItemRelId = param1.ActorClickItemRelId;
         _loc2_.ActorId = param1.ActorId;
         _loc2_.ClickItemId = param1.ClickItemId;
         _loc2_.FoodPoints = param1.FoodPoints;
         _loc2_.Stage = param1.Stage;
         _loc2_.Name = param1.Name;
         _loc2_.LastFeedTime = param1.LastFeedTime;
         _loc2_.Data = param1.Data;
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         _loc2_.LastWashTime = param1.LastWashTime;
         _loc2_.PlayPoints = param1.PlayPoints;
         _loc2_.AtHotelUntil = param1.AtHotelUntil;
         return _loc2_;
      }
      
      public static function GetInstanceArray(param1:Object) : Array
      {
         var _loc4_:Object = null;
         var _loc2_:Array = param1 as Array;
         var _loc3_:Array = new Array();
         for each(_loc4_ in _loc2_)
         {
            _loc3_.push(GetInstance(_loc4_));
         }
         return _loc3_;
      }
      
      public function get filteredName() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Name);
      }
   }
}

