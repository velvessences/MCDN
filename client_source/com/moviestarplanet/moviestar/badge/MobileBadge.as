package com.moviestarplanet.moviestar.badge
{
   import com.greensock.TweenMax;
   import com.moviestarplanet.Components.MSP_Image;
   import com.moviestarplanet.utils.loader.AssetUrl;
   import com.moviestarplanet.utils.tooltips.MSP_ToolTipManager;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.utils.ui.AdHandler;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MobileBadge extends MSP_Image implements IMovieStarBadge
   {
      
      public static const PLATFORM_BADGE_TYPE_MOBILE:int = 2;
      
      public function MobileBadge()
      {
         super();
         MSP_ToolTipManager.add(this,MSPLocaleManagerWeb.getInstance().getString("MOBILE_CLICK_TO_GET"));
         source = new AssetUrl("MobileActivity.swf",AssetUrl.ICON);
         this.addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
         this.useHandCursor = this.buttonMode = true;
      }
      
      public function glow() : void
      {
         TweenMax.killTweensOf(this,true);
         TweenMax.to(this,0.25,{
            "glowFilter":{
               "color":16711680,
               "alpha":1,
               "blurX":10,
               "blurY":10,
               "strength":2,
               "quality":1
            },
            "yoyo":true,
            "repeat":5
         });
      }
      
      private function onClick(param1:Event) : void
      {
         param1.stopPropagation();
         AdHandler.Instance.openAd(AdHandler.MOBILEAD);
      }
   }
}

