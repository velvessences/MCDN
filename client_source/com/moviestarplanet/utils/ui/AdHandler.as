package com.moviestarplanet.utils.ui
{
   import com.moviestarplanet.MobileAdd.MobileAdvertising;
   import com.moviestarplanet.magazine.MagazineController;
   import com.moviestarplanet.safety.SafetyHandler;
   import com.moviestarplanet.safety.SafetyPopUp;
   import com.moviestarplanet.valueObjectsCustom.AdControlData;
   import flash.geom.Rectangle;
   import mx.collections.ArrayCollection;
   
   public class AdHandler
   {
      
      private static var instance:AdHandler;
      
      private static var activeAds:ArrayCollection;
      
      public static const MOBILEAD:String = "advertisementMobile";
      
      public static const SAFETYAD:String = "advertisementSafety";
      
      public static const MAGAZINEAD:String = "advertisementMagazine";
      
      private static const CORNERAD_MOBILEAD:String = "cornerMobile";
      
      private static const CORNERAD_MOBILEAD_NEWS:String = "cornerMobileNews";
      
      private static const CORNERAD_SAFETY:String = "cornerSafety";
      
      private static const CORNERAD_MAGAZINE:String = "cornerMagazine";
      
      public function AdHandler(param1:SingleTonBlocker)
      {
         super();
         if(!param1)
         {
            throw new Error("Use instance - do not instansiate with NEW");
         }
      }
      
      public static function get Instance() : AdHandler
      {
         if(instance == null)
         {
            instance = new AdHandler(new SingleTonBlocker());
         }
         return instance;
      }
      
      public function setupAdvertisement(param1:ArrayCollection) : void
      {
         var _loc2_:AdControlData = null;
         MobileAdvertising.Instance().addClickListener();
         activeAds = param1;
         for each(_loc2_ in param1)
         {
            switch(_loc2_.Type)
            {
               case CORNERAD_MOBILEAD:
                  this.showMobileCornerAd(_loc2_.Version);
                  return;
               case CORNERAD_MOBILEAD_NEWS:
                  this.showMobileCornerAdNews();
                  return;
               case CORNERAD_SAFETY:
                  this.showSafetyCornerAd(_loc2_.Version);
                  return;
               case CORNERAD_MAGAZINE:
                  this.showMagazineCornerAd(_loc2_.Version);
                  return;
            }
         }
      }
      
      public function openAd(param1:String) : void
      {
         var _loc2_:AdControlData = null;
         for each(_loc2_ in activeAds)
         {
            if(_loc2_.Type != param1)
            {
               continue;
            }
            switch(_loc2_.Type)
            {
               case MOBILEAD:
                  MobileAdvertising.Instance().openAdvertisement(_loc2_.Version,true);
                  return;
               case SAFETYAD:
                  SafetyPopUp.show(_loc2_.Version);
                  return;
               case MAGAZINEAD:
                  MagazineController.openMagazineInfo(_loc2_.Version);
                  return;
               default:
                  return;
            }
         }
      }
      
      private function showMagazineCornerAd(param1:String) : void
      {
         MagazineController.addMagazineAd(Main.Instance.mainCanvas.applicationViewStack.mainView.moviestarContainer,new Rectangle(235,80,980,500),param1);
      }
      
      private function showMobileCornerAdNews() : void
      {
         MobileAdvertising.Instance().mobileAddOnInNews = true;
      }
      
      private function showMobileCornerAd(param1:String) : void
      {
         MobileAdvertising.Instance().mobileAddOn = true;
         MobileAdvertising.Instance().addMobileCornerAdd(param1);
      }
      
      private function showSafetyCornerAd(param1:String) : void
      {
         SafetyHandler.getInstance().addCornerAd(param1);
      }
   }
}

class SingleTonBlocker
{
   
   public function SingleTonBlocker()
   {
      super();
   }
}
