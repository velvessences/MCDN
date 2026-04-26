package com.moviestarplanet.model.contentJoiner
{
   import com.moviestarplanet.model.friends.IContentActorInfo;
   
   public class ContentActorInfo implements IContentActorInfo
   {
      
      public var ActorId:int;
      
      public var Name:String;
      
      public var IsVIP:Boolean;
      
      public var VipTier:int;
      
      public var Level:int;
      
      public function ContentActorInfo()
      {
         super();
      }
      
      public static function fromValues(param1:String, param2:Boolean, param3:int, param4:int) : ContentActorInfo
      {
         var _loc5_:ContentActorInfo = new ContentActorInfo();
         _loc5_.Name = param1;
         _loc5_.IsVIP = param2;
         _loc5_.VipTier = param3;
         _loc5_.Level = param4;
         return _loc5_;
      }
      
      public function get getActorId() : int
      {
         return this.ActorId;
      }
      
      public function get getName() : String
      {
         return this.Name;
      }
      
      public function get getVIP() : Boolean
      {
         return this.IsVIP;
      }
      
      public function get getVipTier() : int
      {
         return this.VipTier;
      }
      
      public function get getLevel() : int
      {
         return this.Level;
      }
   }
}

