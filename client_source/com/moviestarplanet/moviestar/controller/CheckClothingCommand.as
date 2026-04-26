package com.moviestarplanet.moviestar.controller
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.locale.ILocaleManager;
   import com.moviestarplanet.moviestar.ClothingCategories;
   import com.moviestarplanet.moviestar.MovieStarInterface;
   import com.moviestarplanet.moviestar.valueObjects.ActorClothesRel;
   
   public class CheckClothingCommand
   {
      
      public static var malesMustWearTops:Boolean;
      
      [Inject]
      public var localeManager:ILocaleManager;
      
      private var movieStar:MovieStarInterface;
      
      public function CheckClothingCommand(param1:MovieStarInterface)
      {
         super();
         InjectionManager.manager().injectMe(this);
         this.movieStar = param1;
      }
      
      public function isWearingMinimumClothesDoPopup() : Boolean
      {
         if(!this.isWearingMinimumClothing())
         {
            MessageCommunicator.send(new MsgEvent(MSPEvent.SHOW_USER_ALERT,{
               "text":this.localeManager.getString("MUST_WEAR_CLOTHES"),
               "title":""
            }));
            return false;
         }
         return true;
      }
      
      public function isWearingMinimumClothing() : Boolean
      {
         var _loc2_:ActorClothesRel = null;
         var _loc1_:Array = this.movieStar.GetAttachedClothes();
         for each(_loc2_ in _loc1_)
         {
            if(ClothingCategories.isTop(_loc2_.Cloth.ClothesCategoryId) || ClothingCategories.isBottom(_loc2_.Cloth.ClothesCategoryId) && !malesMustWearTops)
            {
               return true;
            }
         }
         return false;
      }
      
      public function allowedToTakeClothOffInPublic(param1:ActorClothesRel, param2:Array) : Boolean
      {
         var _loc4_:ActorClothesRel = null;
         var _loc3_:Boolean = ClothingCategories.isTop(param1.Cloth.ClothesCategoryId);
         if(malesMustWearTops && _loc3_)
         {
            return false;
         }
         for each(_loc4_ in param2)
         {
            if(ClothingCategories.isBottom(_loc4_.Cloth.ClothesCategoryId) && _loc3_ || ClothingCategories.isTop(_loc4_.Cloth.ClothesCategoryId) && !_loc3_)
            {
               return true;
            }
         }
         return false;
      }
   }
}

