package com.moviestarplanet.body
{
   import com.moviestarplanet.utils.ColorMap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   
   public class AttachedItem extends EventDispatcher
   {
      
      public static const ATTACHED_ITEM_CLICKED:String = "ATTACHED_ITEM_CLICKED";
      
      protected var _eventsEnabled:Boolean;
      
      protected var _movieStar:IBodyPartDescriptorsProvider;
      
      protected var _rel:IAttachable;
      
      private var _mc:MovieClip;
      
      private var _attachedItemParts:Array = new Array();
      
      public function AttachedItem(param1:IBodyPartDescriptorsProvider, param2:IAttachable, param3:MovieClip, param4:Boolean = true)
      {
         super();
         this._movieStar = param1;
         this._rel = param2;
         this._eventsEnabled = param4;
         this._mc = param3;
         this._attachedItemParts = GetItemPartsFromMovieClip(param3);
      }
      
      public static function CreateAttachedItem(param1:IBodyPartDescriptorsProvider, param2:IAttachable, param3:MovieClip, param4:int) : AttachedItem
      {
         var _loc6_:Boolean = false;
         var _loc5_:Boolean = param2.isHair;
         if(_loc5_)
         {
            _loc6_ = param4 == Body.MODE_CLICK || param4 == Body.MODE_INSPECT;
            return new AttachedHairItem(param1,param2,param3,_loc6_);
         }
         _loc6_ = param4 != Body.MODE_NOCLICK;
         return new AttachedItem(param1,param2,param3,_loc6_);
      }
      
      private static function GetItemPartsFromMovieClip(param1:MovieClip) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:DisplayObject = null;
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         var _loc2_:Array = new Array();
         while(_loc3_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc3_) as DisplayObject;
            _loc5_ = _loc4_.name.toUpperCase();
            _loc6_ = Const.ValidItemPartNames.indexOf(_loc5_) != -1;
            if(_loc6_)
            {
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private static function MapItemPartNameToBodyPartName(param1:String) : String
      {
         var _loc3_:String = null;
         var _loc2_:String = param1.toUpperCase();
         switch(_loc2_)
         {
            case Const.BehindFrontHead:
               _loc3_ = Const.FrontHead;
               break;
            case Const.BehindSideHead:
               _loc3_ = Const.SideHead;
               break;
            default:
               _loc3_ = _loc2_;
         }
         return _loc3_;
      }
      
      public function get Rel() : IAttachable
      {
         return this._rel;
      }
      
      public function get AttachedItemParts() : Array
      {
         return this._attachedItemParts;
      }
      
      public function Attach() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this._attachedItemParts)
         {
            this.AddItemPart(_loc1_);
         }
         this._movieStar.Repaint();
      }
      
      public function Detach() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this._attachedItemParts)
         {
            this.RemoveItemPart(_loc1_);
         }
         this._movieStar.Repaint();
      }
      
      protected function GetItemCategoryId(param1:MovieClip) : int
      {
         return this.Rel.CategoryId;
      }
      
      protected function AddItemPart(param1:MovieClip) : void
      {
         var _loc2_:String = MapItemPartNameToBodyPartName(param1.name);
         var _loc3_:BodyPartDescriptor = this._movieStar.GetBodyPartDescriptor(_loc2_);
         var _loc4_:int = this.GetItemCategoryId(param1);
         _loc3_.AddItemPart(param1,_loc4_);
         if(this._eventsEnabled)
         {
            param1.addEventListener(MouseEvent.CLICK,this.partClicked,false,0,true);
         }
      }
      
      protected function RemoveItemPart(param1:MovieClip) : void
      {
         var _loc2_:String = MapItemPartNameToBodyPartName(param1.name);
         var _loc3_:BodyPartDescriptor = this._movieStar.GetBodyPartDescriptor(_loc2_);
         var _loc4_:int = this.GetItemCategoryId(param1);
         _loc3_.RemoveItemPart(param1,_loc4_);
         if(this._eventsEnabled)
         {
            param1.removeEventListener(MouseEvent.CLICK,this.partClicked);
         }
      }
      
      private function partClicked(param1:Event) : void
      {
         dispatchEvent(new Event(ATTACHED_ITEM_CLICKED));
      }
      
      public function get IsHeadWear() : Boolean
      {
         return this.Rel.isHeadwear;
      }
      
      public function updateColors() : void
      {
         ColorMap.SetColorsOnMovieClip(this._mc,0,this._rel.Color,false);
      }
   }
}

