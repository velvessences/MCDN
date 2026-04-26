package com.moviestarplanet.look.valueobjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import flash.utils.ByteArray;
   import mx.collections.ArrayCollection;
   
   public class LookItem
   {
      
      public var LookId:int;
      
      public var ActorId:int;
      
      public var actorName:String;
      
      public var CreatorId:int;
      
      public var creatorName:String;
      
      public var Created:Date;
      
      public var Headline:String;
      
      public var Likes:int;
      
      public var Sells:int;
      
      public var LookActorLikes:ArrayCollection;
      
      public var LastEditedOn:Date;
      
      private var _lookData:ByteArray;
      
      public function LookItem()
      {
         super();
      }
      
      public function get filteredName() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Headline);
      }
      
      public function set LookData(param1:ByteArray) : void
      {
         this._lookData = param1;
      }
      
      public function get LookData() : ByteArray
      {
         return this._lookData;
      }
   }
}

