package com.moviestarplanet.bonster.valueobjects
{
   import com.moviestarplanet.bonster.BonsterTemplateCache;
   
   public class BonsterObject
   {
      
      public var BonsterId:int;
      
      public var BonsterTemplateId:int;
      
      public var Name:String;
      
      public var Price:int;
      
      public var DiamondsPrice:int;
      
      public var VIPExclusive:Boolean;
      
      public var Deleted:Boolean;
      
      public var Popularity:int;
      
      public var UploadDate:Date;
      
      public var ArmaturePath:String;
      
      public var Scale:String;
      
      private var _SkeletonPath:String;
      
      public function BonsterObject()
      {
         super();
      }
      
      public function set ActorBonsterRels(param1:*) : void
      {
      }
      
      public function set BonsterTemplate(param1:*) : void
      {
      }
      
      public function get SkeletonPath() : String
      {
         var _loc1_:BonsterTemplateObject = null;
         if(this._SkeletonPath == null)
         {
            _loc1_ = BonsterTemplateCache.instance.getTemplate(this.BonsterTemplateId);
            this._SkeletonPath = _loc1_.SkeletonPath;
         }
         return this._SkeletonPath;
      }
   }
}

