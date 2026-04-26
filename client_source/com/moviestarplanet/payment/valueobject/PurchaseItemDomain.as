package com.moviestarplanet.payment.valueobject
{
   import com.moviestarplanet.actor.IClothInfo;
   import com.moviestarplanet.actor.IGenderSpecific;
   import com.moviestarplanet.actorutils.ClothInfoUtils;
   import com.moviestarplanet.utils.StringUtilities;
   
   public class PurchaseItemDomain implements IClothInfo, IGenderSpecific
   {
      
      public var Type:String;
      
      public var CategoryId:int;
      
      private var _filename:String;
      
      public var Gender:int;
      
      public var Id:int;
      
      public function PurchaseItemDomain()
      {
         super();
      }
      
      public function set Filename(param1:String) : void
      {
         this._filename = param1;
      }
      
      public function get Filename() : String
      {
         return this._filename;
      }
      
      public function get path() : String
      {
         var _loc1_:String = ClothInfoUtils.getPath(this);
         if(_loc1_.indexOf(".swf") == -1)
         {
            _loc1_ += ".swf";
         }
         return _loc1_;
      }
      
      public function get SWF() : String
      {
         return null;
      }
      
      public function get isFemale() : Boolean
      {
         return this.Gender == 1;
      }
      
      public function get SkinSWF() : String
      {
         return "";
      }
      
      public function get ClothesCategoryId() : int
      {
         return this.CategoryId;
      }
      
      public function parseObject(param1:Object) : void
      {
         this.Type = StringUtilities.trim(param1.Type as String);
         this.CategoryId = param1.CategoryId as int;
         this.Filename = StringUtilities.trim(param1.Filename as String);
         this.Gender = param1.Gender as int;
         this.Id = param1.Id as int;
      }
   }
}

