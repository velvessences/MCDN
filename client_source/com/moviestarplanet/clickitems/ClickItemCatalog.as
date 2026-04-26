package com.moviestarplanet.clickitems
{
   import com.moviestarplanet.pet.service.PetAMFService;
   import com.moviestarplanet.pet.valueobjects.ClickItemVO;
   
   public class ClickItemCatalog
   {
      
      public static var ClickItems:Array = new Array();
      
      public function ClickItemCatalog()
      {
         super();
         throw new Error("ClickItemCatalog should not be instantiated");
      }
      
      public static function init(param1:Function = null) : void
      {
         var done:Function = null;
         var callback:Function = param1;
         done = function(param1:Array):void
         {
            if(null != callback)
            {
               callback();
            }
         };
         if(ClickItems.length == 0)
         {
            loadClickItems(done);
         }
         else
         {
            done(null);
         }
      }
      
      public static function itemAt(param1:int) : ClickItemVO
      {
         return ClickItems[param1] as ClickItemVO;
      }
      
      public static function getClickItems(param1:Function) : void
      {
         if(ClickItems.length == 0)
         {
            loadClickItems(param1);
         }
         else
         {
            param1(ClickItems);
         }
      }
      
      private static function loadClickItems(param1:Function = null) : void
      {
         var done:Function = null;
         var callback:Function = param1;
         done = function(param1:Array):void
         {
            var _loc2_:ClickItemVO = null;
            for each(_loc2_ in param1)
            {
               ClickItems[_loc2_.ClickItemId] = _loc2_;
            }
            if(callback != null)
            {
               callback(ClickItems);
            }
         };
         var pet:PetAMFService = new PetAMFService();
         pet.GetClickItemsFromServer(done);
      }
   }
}

