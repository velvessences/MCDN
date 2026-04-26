package com.moviestarplanet.Forms.world
{
   import com.moviestarplanet.Forms.world.elements.WorldArea;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.commonvalueobjects.login.PostLoginData;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.constants.events.EventsConstants;
   import com.moviestarplanet.controls.utils.Buttonizer;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.flash.icons.SystemIcons;
   import com.moviestarplanet.quest.gifthunt.GiftHuntEventFlash;
   import com.moviestarplanet.quest.gifthunt.GiftHuntManager;
   import com.moviestarplanet.quest.special.SpecialQuestContext;
   import com.moviestarplanet.quest.valueobjects.SpecialQuestInitialUpdate;
   import com.moviestarplanet.utils.MSP_SWFLoader;
   import com.moviestarplanet.utils.displayobject.FlattenUtilities;
   import com.moviestarplanet.utils.loader.RawUrl;
   import com.moviestarplanet.utils.sound.Sounds;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import mx.core.UIComponent;
   
   public class OverviewMap extends LocalMap
   {
      
      private var specialQuestBtn:UIComponent;
      
      private var loadMapCompleted:Boolean;
      
      private var specialEventInitialData:SpecialQuestInitialUpdate;
      
      private var giftHints:Dictionary = new Dictionary();
      
      public function OverviewMap(param1:WorldArea)
      {
         super(param1);
         MessageCommunicator.subscribe(EventsConstants.POST_LOGIN_BUNDLE_RECEIVED,this.onPostLoginDataLoaded);
      }
      
      private function onPostLoginDataLoaded(param1:MsgEvent) : void
      {
         MessageCommunicator.unscribe(EventsConstants.POST_LOGIN_BUNDLE_RECEIVED,this.onPostLoginDataLoaded);
         var _loc2_:PostLoginData = param1.data as PostLoginData;
         this.specialEventInitialData = _loc2_.SpecialEvent;
         this.checkIfSpecialQuestBtnCanBeShown();
      }
      
      override protected function loadMapComplete(param1:MSP_SWFLoader) : void
      {
         super.loadMapComplete(param1);
         this.loadMapCompleted = true;
         this.checkIfSpecialQuestBtnCanBeShown();
         MessageCommunicator.subscribe(GiftHuntEventFlash.GIFT_DATA_UPDATED,this.updateGiftHintIcons);
      }
      
      private function updateGiftHintIcons(param1:MsgEvent) : void
      {
         var overviewSubAreas:Array = null;
         var subArea:WorldArea = null;
         var e:MsgEvent = param1;
         try
         {
            overviewSubAreas = worldArea.getSubAreas();
            for each(subArea in overviewSubAreas)
            {
               if(GiftHuntManager.getInstance().hasUnopenedGiftsByAreaType(subArea.areaType) > 0)
               {
                  this.showGiftHintAt(subArea.swfVarName);
               }
               else
               {
                  this.hideGiftHintAt(subArea.swfVarName);
               }
            }
         }
         catch(err:Error)
         {
            if(Config.IsRunningInDevelopment)
            {
               throw err;
            }
         }
      }
      
      private function showGiftHintAt(param1:String) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:Sprite = null;
         if(this.giftHints[param1] == null)
         {
            _loc2_ = new SystemIcons.GiftIcon() as DisplayObject;
            _loc2_.scaleX = _loc2_.scaleY = 2;
            _loc3_ = new Sprite();
            _loc3_.name = "OverviewMap_GiftHint_" + param1;
            _loc3_.addChild(_loc2_);
            if(param1 == "pets")
            {
               _loc3_.x = 188 - loadedMap[param1].button.width * 0.5;
               _loc3_.y = 240;
            }
            else
            {
               _loc3_.x = 195 - loadedMap[param1].button.width * 0.5;
               _loc3_.y = 190;
            }
            FlattenUtilities.flattenSprite(_loc3_);
            loadedMap[param1].addChild(_loc3_);
            this.giftHints[param1] = _loc3_;
         }
         else
         {
            this.giftHints[param1].visible = true;
         }
      }
      
      private function hideGiftHintAt(param1:String) : void
      {
         if(this.giftHints[param1] != null)
         {
            this.giftHints[param1].visible = false;
         }
      }
      
      private function checkIfSpecialQuestBtnCanBeShown() : void
      {
         if(Boolean(this.specialEventInitialData) && Boolean(this.loadMapCompleted) && (this.specialEventInitialData.TeaserActive || this.specialEventInitialData.EventActive))
         {
            this.addSpecialQuestBtn();
         }
      }
      
      private function addSpecialQuestBtn() : void
      {
         var _loc1_:MSP_SWFLoader = new MSP_SWFLoader();
         var _loc2_:String = "swf/quest/" + this.specialEventInitialData.EventName + "/world_button";
         if(this.specialEventInitialData.TeaserActive)
         {
            _loc2_ += "_coming_soon";
         }
         _loc2_ += ".swf";
         MSP_SWFLoader.RequestLoad(new RawUrl(_loc2_),this.onSpecialQuestBtnLoad,2,false,true);
      }
      
      private function onSpecialQuestBtnLoad(param1:MSP_SWFLoader) : void
      {
         var _loc2_:MovieClip = (param1.content as MovieClip).getChildAt(0) as MovieClip;
         this.specialQuestBtn = new UIComponent();
         this.specialQuestBtn.addChild(_loc2_);
         addChild(this.specialQuestBtn);
         this.specialQuestBtn.includeInLayout = false;
         this.specialQuestBtn.x = 60;
         this.specialQuestBtn.y = 58;
         if(this.specialEventInitialData.EventActive)
         {
            Buttonizer.buttonizeFrames(_loc2_,this.specialQuestClick,false,Sounds.BUTTON_CLICK);
         }
         else
         {
            _loc2_.gotoAndStop(0);
         }
         this.specialEventUpdateLanguage();
         if(Config.IsRunningInDevelopment)
         {
            MessageCommunicator.subscribe(MSPEvent.TESTING_FORM_LANGUAGE_CHANGED,this.specialEventUpdateLanguage);
         }
      }
      
      private function specialEventUpdateLanguage(param1:MsgEvent = null) : void
      {
         var btnMC:MovieClip = null;
         var e:MsgEvent = param1;
         btnMC = this.specialQuestBtn.getChildAt(0) as MovieClip;
         if(btnMC.hasOwnProperty("InnerContainer"))
         {
            try
            {
               btnMC.InnerContainer.gotoAndStop(Config.overrideLanguage);
            }
            catch(e:Error)
            {
               btnMC.InnerContainer.gotoAndStop(0);
            }
         }
      }
      
      private function specialQuestClick(param1:MouseEvent = null) : void
      {
         SpecialQuestContext.instance.openSpecialQuestMenu();
      }
   }
}

