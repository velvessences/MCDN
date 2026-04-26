package com.moviestarplanet.body
{
   import com.moviestarplanet.body.bodyparts.BodyPartBase;
   import com.moviestarplanet.utils.FlashUtils;
   import flash.display.DisplayObject;
   
   public class BodyPartDescriptor
   {
      
      public var bodyPartId:String;
      
      private var _isDirty:Boolean;
      
      private var HairBehindParts:Array = new Array();
      
      private var SkinParts:Array = new Array();
      
      private var FaceParts:Array = new Array();
      
      private var TattooParts:Array = new Array();
      
      private var BeardParts:Array = new Array();
      
      private var NoseEarRingParts:Array = new Array();
      
      private var HairParts:Array = new Array();
      
      private var HeadWearParts:Array = new Array();
      
      private var TightPantsParts:Array = new Array();
      
      private var SmallFootwearParts:Array = new Array();
      
      private var LargeFootwearParts:Array = new Array();
      
      private var BaggyPantsParts:Array = new Array();
      
      private var TopParts:Array = new Array();
      
      private var StuffParts:Array = new Array();
      
      private var OnTopAlwaysParts:Array = new Array();
      
      private var RegularPantsParts:Array = new Array();
      
      public function BodyPartDescriptor()
      {
         super();
      }
      
      public function Repaint(param1:Body) : void
      {
         var _loc2_:BodyPartBase = param1.GetBodyPart(this.bodyPartId);
         if(_loc2_ != null)
         {
            _loc2_.blockFlatten = false;
            this.PaintItems(_loc2_,this.HairBehindParts,0);
            this.PaintItems(_loc2_,this.SkinParts);
            this.PaintItems(_loc2_,this.FaceParts);
            this.PaintItems(_loc2_,this.TattooParts);
            this.PaintItems(_loc2_,this.BeardParts);
            this.PaintItems(_loc2_,this.NoseEarRingParts);
            this.PaintItems(_loc2_,this.HairParts);
            this.PaintItems(_loc2_,this.HeadWearParts);
            this.PaintItems(_loc2_,this.TightPantsParts);
            this.PaintItems(_loc2_,this.SmallFootwearParts);
            this.PaintItems(_loc2_,this.RegularPantsParts);
            this.PaintItems(_loc2_,this.LargeFootwearParts);
            this.PaintItems(_loc2_,this.BaggyPantsParts);
            this.PaintItems(_loc2_,this.TopParts);
            this.PaintItems(_loc2_,this.StuffParts);
            this.PaintItems(_loc2_,this.OnTopAlwaysParts);
         }
         this._isDirty = false;
      }
      
      private function PaintItems(param1:BodyPartBase, param2:Array, param3:Number = -1) : void
      {
         var _loc4_:DisplayObject = null;
         for each(_loc4_ in param2)
         {
            _loc4_.x = 0;
            _loc4_.y = 0;
            if((_loc4_ as Object).blockFlatten)
            {
               param1.blockFlatten = true;
            }
            if(param3 == -1)
            {
               param1.addChild(_loc4_);
            }
            else
            {
               param1.addChildAt(_loc4_,param3);
            }
         }
      }
      
      public function AddItemPart(param1:DisplayObject, param2:int) : void
      {
         var _loc3_:Array = this.GetBodyPartDescriptorArray(param2);
         if(!_loc3_)
         {
            trace("ERROR - - - - - - A MOVIESTAR ON THE SCREEN IT\'S TRYING TO WEAR A CLOTH THAT IS NOT POSSIBLE TO WEAR");
            return;
         }
         FlashUtils.Assert(_loc3_.indexOf(param1) == -1,"item part added twice: " + param1.name);
         _loc3_.push(param1);
         this._isDirty = true;
      }
      
      public function RemoveItemPart(param1:DisplayObject, param2:int) : void
      {
         var _loc3_:Array = this.GetBodyPartDescriptorArray(param2);
         var _loc4_:int = int(_loc3_.indexOf(param1));
         if(_loc4_ != -1)
         {
            _loc3_.splice(_loc4_,1);
         }
         else
         {
            FlashUtils.Assert(false,"Item part not found in BodyPartDescriptor: " + param1.name + " category = " + param2);
         }
         if(param1.parent != null)
         {
            param1.parent.removeChild(param1);
         }
         else
         {
            this._isDirty = true;
         }
      }
      
      public function canBeFlattened() : Boolean
      {
         return this.OnTopAlwaysParts.length == 0;
      }
      
      private function GetBodyPartDescriptorArray(param1:int) : Array
      {
         var _loc2_:Array = null;
         switch(param1)
         {
            case -1:
               _loc2_ = this.HairBehindParts;
               break;
            case Const.CLOTHES_CATEGORY_HAIR:
               _loc2_ = this.HairParts;
               break;
            case 2:
            case 6:
            case 7:
               _loc2_ = this.TopParts;
               break;
            case 3:
            case 8:
            case 9:
               _loc2_ = this.RegularPantsParts;
               break;
            case 5:
               _loc2_ = this.BeardParts;
               break;
            case 10:
            case 11:
            case Const.CLOTHES_CATEGORY_SMALL_HIGHHEEL:
               _loc2_ = this.SmallFootwearParts;
               break;
            case 12:
            case Const.CLOTHES_CATEGORY_LARGE_HIGHHEEL:
               _loc2_ = this.LargeFootwearParts;
               break;
            case 13:
            case 14:
            case 15:
               _loc2_ = this.HeadWearParts;
               break;
            case 25:
            case 27:
            case 29:
            case 30:
            case 32:
            case 45:
            case 46:
               _loc2_ = this.StuffParts;
               break;
            case 26:
            case 28:
               _loc2_ = this.NoseEarRingParts;
               break;
            case 31:
            case 34:
            case 35:
            case 36:
            case 37:
            case 38:
            case 39:
            case 40:
            case 41:
            case 42:
            case 43:
            case 44:
               _loc2_ = this.TattooParts;
               break;
            case Const.CLOTHES_CATEGORY_DIAMOND_EFFECT:
               _loc2_ = this.OnTopAlwaysParts;
               break;
            case Const.CLOTHES_CATEGORY_TIGHT_PANTS:
               _loc2_ = this.TightPantsParts;
               break;
            case Const.CLOTHES_CATEGORY_BAGGY_PANTS:
               _loc2_ = this.BaggyPantsParts;
         }
         return _loc2_;
      }
   }
}

