package com.moviestarplanet.body
{
   import flash.display.MovieClip;
   
   public class AttachedHairItem extends AttachedItem
   {
      
      private var multiFrameItemNames:Array = [Const.FrontHead,Const.SideHead,Const.BehindFrontHead,Const.BehindSideHead];
      
      private var multiFrameItemParts:Array = new Array(4);
      
      public function AttachedHairItem(param1:IBodyPartDescriptorsProvider, param2:IAttachable, param3:MovieClip, param4:Boolean = true)
      {
         super(param1,param2,param3,param4);
      }
      
      override protected function GetItemCategoryId(param1:MovieClip) : int
      {
         var _loc2_:String = param1.name.toUpperCase();
         if(_loc2_ == Const.BehindFrontHead || _loc2_ == Const.BehindSideHead)
         {
            return -1;
         }
         return super.GetItemCategoryId(param1);
      }
      
      override protected function AddItemPart(param1:MovieClip) : void
      {
         var _loc2_:String = param1.name.toUpperCase();
         var _loc3_:int = int(this.multiFrameItemNames.indexOf(_loc2_));
         if(_loc3_ != -1)
         {
            this.multiFrameItemParts[_loc3_] = param1;
         }
         this.UpdateHairMode();
         super.AddItemPart(param1);
      }
      
      override protected function RemoveItemPart(param1:MovieClip) : void
      {
         var _loc2_:String = param1.name.toUpperCase();
         var _loc3_:int = int(this.multiFrameItemNames.indexOf(_loc2_));
         if(_loc3_ != -1)
         {
            this.multiFrameItemParts[_loc3_] = null;
         }
         super.RemoveItemPart(param1);
      }
      
      public function UpdateHairMode() : void
      {
         var _loc3_:MovieClip = null;
         var _loc1_:Boolean = _movieStar.HeadWearCount > 0;
         var _loc2_:int = _loc1_ ? 2 : 1;
         for each(_loc3_ in this.multiFrameItemParts)
         {
         }
      }
   }
}

