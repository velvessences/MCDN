package com.moviestarplanet.services.gifts.valueObjects
{
   import com.moviestarplanet.actor.IClothInfo;
   import com.moviestarplanet.actorutils.ClothInfoUtils;
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class GenericGiftLogItem implements IClothInfo
   {
      
      public var ActorId:int;
      
      public var ActorName:String;
      
      public var ClothesId:int;
      
      public var ClothesName:String;
      
      public var Color:String;
      
      public var DateStr:String;
      
      public var GiftId:int;
      
      public var GiftLogId:int;
      
      public var GiftType:int;
      
      public var GiverId:int;
      
      public var GiverName:String;
      
      public var Message:String;
      
      public var Price:int;
      
      public var GiftCategory:int;
      
      public var AnimationId:int;
      
      public var BackgroundId:int;
      
      private var _ClothesCategoryId:int;
      
      private var _Filename:String;
      
      private var _SWF:String;
      
      public function GenericGiftLogItem()
      {
         super();
      }
      
      public function get filteredMessage() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Message);
      }
      
      public function set SWF(param1:String) : void
      {
         this._SWF = param1;
      }
      
      public function get SWF() : String
      {
         return this._SWF;
      }
      
      public function set Filename(param1:String) : void
      {
         this._Filename = param1;
      }
      
      public function get Filename() : String
      {
         return this._Filename;
      }
      
      public function set ClothesCategoryId(param1:int) : void
      {
         this._ClothesCategoryId = param1;
      }
      
      public function get ClothesCategoryId() : int
      {
         return this._ClothesCategoryId;
      }
      
      public function get isImage() : Boolean
      {
         return ClothInfoUtils.isImage(this);
      }
      
      public function get realSwfName() : String
      {
         return ClothInfoUtils.getRealSwfName(this);
      }
      
      public function get path() : String
      {
         return ClothInfoUtils.getPath(this);
      }
   }
}

