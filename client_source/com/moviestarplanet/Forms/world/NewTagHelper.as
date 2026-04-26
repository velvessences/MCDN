package com.moviestarplanet.Forms.world
{
   import com.moviestarplanet.worldscreen.INewTagHelper;
   
   public class NewTagHelper implements INewTagHelper
   {
      
      private static var instance:NewTagHelper;
      
      private var newTagFeatureAreas:String;
      
      public function NewTagHelper()
      {
         super();
      }
      
      public function setNewTagAreas(param1:String) : void
      {
         this.newTagFeatureAreas = param1;
      }
      
      public function getIfIsNew(param1:String) : Boolean
      {
         if(this.newTagFeatureAreas == null)
         {
            return false;
         }
         var _loc2_:String = this.newTagFeatureAreas;
         if(_loc2_ == null)
         {
            return false;
         }
         var _loc3_:Array = _loc2_.split(",");
         var _loc4_:int = 0;
         loop0:
         while(true)
         {
            if(_loc4_ >= _loc3_.length)
            {
               return false;
            }
            switch(param1)
            {
               case "beautyGirls":
               case "BeautyBoys":
                  if(_loc3_[_loc4_] == "beautyclinic")
                  {
                     return true;
                  }
                  break;
               default:
                  break loop0;
            }
            _loc4_++;
         }
         return false;
      }
   }
}

