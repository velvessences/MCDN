package com.moviestarplanet.utils.ui
{
   import com.moviestarplanet.configurations.AppSettings;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.payment.seasonalSale.SeasonalSale;
   import com.moviestarplanet.payment.timedOffer.SpecialOffer;
   import com.moviestarplanet.startup.PostLoginSequence;
   import com.moviestarplanet.utils.CountdownHourClock;
   import com.moviestarplanet.utils.FontManager;
   import com.moviestarplanet.utils.MSP_SWFLoader;
   import com.moviestarplanet.utils.loader.RawUrl;
   import com.moviestarplanet.utils.translation.LocaleHelper;
   import com.moviestarplanet.utils.translation.TranslationUtilities;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import mx.core.UIComponent;
   
   public class SpecialOfferIcon extends UIComponent
   {
      
      public var swf:String;
      
      public function SpecialOfferIcon()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAdded);
      }
      
      protected function onAdded(param1:Event) : void
      {
         var loader:MSP_SWFLoader = null;
         var loadComplete:Function = null;
         var event:Event = param1;
         loadComplete = function(param1:Event):void
         {
            var _loc4_:SpecialOffer = null;
            var _loc2_:DisplayObjectContainer = loader.content as DisplayObjectContainer;
            _loc2_.x = -10;
            try
            {
               if(_loc2_["container"] != null)
               {
                  if(_loc2_["container"]["badge"] != null)
                  {
                     if(_loc2_["container"]["badge"].totalFrames > 1)
                     {
                        _loc2_["container"]["badge"].gotoAndStop(Config.GetLanguage.substr(0,2));
                     }
                  }
                  if(_loc2_["container"]["timeLeft"] != null)
                  {
                     _loc2_["container"]["timeLeft"].text = "";
                  }
               }
            }
            catch(e:Error)
            {
            }
            addChild(_loc2_);
            TranslationUtilities.translateDisplayObject(_loc2_,true);
            FontManager.remapAllFontsForDisplayObject(_loc2_);
            var _loc3_:String = AppSettings.getInstance().getSetting(AppSettings.SHOW_OFFER_COUNTDOWN);
            if(_loc3_ == "true")
            {
               PostLoginSequence.tellMeWhenOfferIsReady(offerReady);
            }
            else
            {
               hideTimeStuff();
            }
            _loc4_ = SpecialOffer.activeOffer;
            if(_loc4_.OfferId != SpecialOffer.TOP_UP)
            {
               SeasonalSale.getSalesBadge(SeasonalSale.BADGE_TYPE_TOP_RIGHT_CORNER_ON_WEB,tryAddSaleBadge);
            }
         };
         removeEventListener(Event.ADDED_TO_STAGE,this.onAdded);
         loader = new MSP_SWFLoader();
         loader.addEventListener(Event.COMPLETE,loadComplete);
         loader.LoadUrl(new RawUrl(this.swf));
      }
      
      private function tryAddSaleBadge(param1:MovieClip) : void
      {
         addChild(param1);
      }
      
      private function hideTimeStuff() : void
      {
         (getChildAt(0)["container"]["timeLeft"] as DisplayObject).visible = false;
      }
      
      private function offerReady(param1:SpecialOffer) : void
      {
         var onTick:Function = null;
         var onTimeEnd:Function = null;
         var offer:SpecialOffer = param1;
         onTick = function(param1:int, param2:Boolean = true):void
         {
            var _loc3_:int = 0;
            if(param2)
            {
               _loc3_ = int(int(param1 / 24));
               if(_loc3_ > 0)
               {
                  _loc3_++;
                  getChildAt(0)["container"]["timeLeft"].text = LocaleHelper.getInstance().getString("TIMELIMITEDOFFERS_BANNER_TIMER_DAYS",[_loc3_]);
               }
               else if(param1 > 1)
               {
                  getChildAt(0)["container"]["timeLeft"].text = LocaleHelper.getInstance().getString("TIMELIMITEDOFFERS_BANNER_TIMER_HOURS",[param1]);
               }
               else
               {
                  getChildAt(0)["container"]["timeLeft"].text = LocaleHelper.getInstance().getString("TIMELIMITEDOFFERS_BANNER_TIMER_HOUR",[param1]);
               }
            }
            else
            {
               getChildAt(0)["container"]["timeLeft"].text = LocaleHelper.getInstance().getString("TIMELIMITEDOFFERS_BANNER_TIMER_MINUTES",[param1]);
            }
         };
         onTimeEnd = function():void
         {
         };
         if(offer != null)
         {
            new CountdownHourClock(offer.SecondsRemaining,onTick,onTimeEnd);
         }
      }
   }
}

