package com.moviestarplanet.Components.ClickItems
{
   import com.moviestarplanet.clickitems.ClickItem;
   import com.moviestarplanet.clickitems.ClickItemFactoryImpl;
   import com.moviestarplanet.pet.utils.PlantConstants;
   import com.moviestarplanet.pet.valueobjects.ActorClickItemRel;
   import flash.display.DisplayObject;
   
   public class MainAppClickItemFactoryImpl extends ClickItemFactoryImpl
   {
      
      public function MainAppClickItemFactoryImpl()
      {
         super();
      }
      
      override public function create(param1:ActorClickItemRel) : DisplayObject
      {
         var _loc2_:ClickItem = null;
         var _loc3_:Monster = null;
         switch(param1.ClickItemId)
         {
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 7:
               return new Pet(param1);
            case 6:
            case 8:
               _loc2_ = new Monster(param1);
               _loc3_ = _loc2_ as Monster;
               _loc3_.IS_PLANT = isClickItemPlant(param1);
               _loc3_.FOODPRICE = PlantConstants.FOODPRICE;
               _loc3_.MEDICINPRICE = PlantConstants.MEDICINPRICE;
               _loc3_.MEDICINPRICE2 = PlantConstants.MEDICINPRICE2;
               _loc3_.FOODPOINT = PlantConstants.FOODPOINT;
               _loc3_.VIPFOODPOINTS = PlantConstants.VIPFOODPOINTS;
               _loc3_.MIN_FEEDING_INTERVAL_MS = PlantConstants.MIN_FEEDING_INTERVAL_MS;
               _loc3_.MAX_FEEDING_INTERVAL_MS = PlantConstants.MAX_FEEDING_INTERVAL_MS;
               _loc3_.FOODPOINTS_PER_STAGE = PlantConstants.FOODPOINTS_PER_STAGE;
               _loc3_.FOODPOINT_SICK_LEVEL = PlantConstants.FOODPOINT_SICK_LEVEL;
               _loc3_.monsterGraphicsDriver.adjustConfigurationOptions(param1.ClickItemId);
               _loc2_.update();
               return _loc2_;
            case 19:
               return new Puppy(param1);
            default:
               return new XMasBoonie(param1);
         }
      }
   }
}

