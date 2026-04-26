package com.moviestarplanet.bonster.valueobjects
{
   import com.moviestarplanet.bonster.BonsterTemplateCache;
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class ActorBonsterRelItem
   {
      
      public var ActorBonsterRelId:int;
      
      public var ActorId:int;
      
      public var BonsterId:int;
      
      private var _ColorPalette:Array;
      
      private var _PatternPalette:Array;
      
      public var Name:String;
      
      public var Experience:int;
      
      public var ExperienceToNextLevel:int;
      
      public var ExperienceToCurrentLevel:int;
      
      public var Level:int;
      
      public var EvolutionStage:int;
      
      public var Personality:int;
      
      public var FoodPoints:int;
      
      public var LastFeedTime:Date;
      
      public var WashPoints:int;
      
      public var LastWashTime:Date;
      
      public var PlayPoints:int;
      
      public var LastPlayTime:Date;
      
      public var AtHotelUntil:Date;
      
      public var MyRoomX:int;
      
      public var MyRoomY:int;
      
      public var IsInMyRoom:Boolean;
      
      public var ArmatureName:String;
      
      public var VIPExclusive:Boolean;
      
      public var SpecialEggCrate:Boolean;
      
      public var Scale:String;
      
      public var ScaleWeb:String;
      
      public var BonsterTemplateId:int;
      
      private var _SkeletonPath:String;
      
      public var ActorBonsterAnimRels:Array;
      
      public function ActorBonsterRelItem()
      {
         super();
      }
      
      public function get SkeletonPath() : String
      {
         var _loc1_:BonsterTemplateObject = null;
         if(this._SkeletonPath == null)
         {
            _loc1_ = BonsterTemplateCache.instance.getTemplate(this.BonsterTemplateId);
            if(_loc1_ != null)
            {
               this._SkeletonPath = _loc1_.SkeletonPath;
            }
         }
         return this._SkeletonPath;
      }
      
      public function set SkeletonPath(param1:String) : void
      {
         this._SkeletonPath = param1;
      }
      
      public function get isBoonie() : Boolean
      {
         return this.BonsterTemplateId == 0;
      }
      
      public function set isBoonie(param1:Boolean) : void
      {
         trace("Error: trying to overwrite a readonly property");
      }
      
      public function get isInCrate() : Boolean
      {
         if(this.EvolutionStage == 0 && this.isBoonie == false)
         {
            return true;
         }
         return false;
      }
      
      public function get isInEgg() : Boolean
      {
         return this.EvolutionStage == 0 && this.isBoonie == true;
      }
      
      public function set ColorPalette(param1:Array) : void
      {
         var _loc3_:String = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in param1)
         {
            _loc2_.push(new uint(_loc3_));
         }
         this._ColorPalette = _loc2_;
      }
      
      public function get ColorPalette() : Array
      {
         return this._ColorPalette;
      }
      
      public function set PatternPalette(param1:Array) : void
      {
         var _loc3_:String = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in param1)
         {
            _loc2_.push(new uint(_loc3_));
         }
         this._PatternPalette = _loc2_;
      }
      
      public function get PatternPalette() : Array
      {
         return this._PatternPalette;
      }
      
      public function destroy() : void
      {
      }
      
      public function get filteredName() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Name);
      }
   }
}

