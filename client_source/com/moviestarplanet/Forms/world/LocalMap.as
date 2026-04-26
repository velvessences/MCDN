package com.moviestarplanet.Forms.world
{
   import com.moviestarplanet.Forms.world.elements.BaseWorldElement;
   import com.moviestarplanet.Forms.world.elements.WorldArea;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.flash.icons.MenuIcons;
   import com.moviestarplanet.giftHunt.IGiftArea;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.managers.SoundManager;
   import com.moviestarplanet.quest.gifthunt.GiftHuntManager;
   import com.moviestarplanet.quest.gifthunt.GiftHuntMapping;
   import com.moviestarplanet.utils.MSP_SWFLoader;
   import com.moviestarplanet.utils.loader.RawUrl;
   import com.moviestarplanet.utils.sound.Sounds;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.worldscreen.INewTagHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   import mx.core.UIComponent;
   import mx.effects.Effect;
   import mx.effects.Parallel;
   import mx.events.EffectEvent;
   
   public class LocalMap extends BaseMap implements IGiftArea
   {
      
      private static const FLASH_TIMES:int = 30;
      
      [Inject]
      public var newTagHelper:INewTagHelper;
      
      protected var worldArea:WorldArea;
      
      private var mapLoaded:Boolean;
      
      private var giftsContainer:UIComponent;
      
      private var para:Parallel = new Parallel();
      
      private var curFlashTime:int = 0;
      
      private var stopFlashing:Boolean = false;
      
      public function LocalMap(param1:WorldArea)
      {
         super();
         InjectionManager.manager().injectMe(this);
         this.mapLoaded = false;
         this.loadMap(param1.swfFileName);
         this.worldArea = param1;
      }
      
      public function isMapLoaded() : Boolean
      {
         return this.mapLoaded;
      }
      
      public function getAreaType() : int
      {
         return this.worldArea.areaType;
      }
      
      public function addGiftsToArea() : void
      {
         var callback:Function = null;
         callback = function(param1:Vector.<GiftHuntMapping>):void
         {
            var _loc2_:int = 0;
            while(_loc2_ < param1.length)
            {
               GiftHuntManager.getInstance().placeGiftFlash(giftsContainer,param1[_loc2_]);
               _loc2_++;
            }
         };
         GiftHuntManager.getInstance().getGiftsMappingFromArea(this,callback);
         GiftHuntManager.getInstance().subscribeToQuestGiftDataReceived(this,callback);
      }
      
      public function getButton(param1:BaseWorldElement) : UIComponent
      {
         if(loadedMap == null || loadedMap[param1.swfVarName] == null)
         {
            return null;
         }
         return loadedMap[param1.swfVarName].parent as UIComponent;
      }
      
      override protected function loadMapComplete(param1:MSP_SWFLoader) : void
      {
         var point:Point;
         var buttons:Vector.<UIComponent> = null;
         var newIcon:DisplayObject = null;
         var realButton:DisplayObject = null;
         var area:BaseWorldElement = null;
         var brandName:String = null;
         var button:UIComponent = null;
         var loader:MSP_SWFLoader = param1;
         var setButtonsVisibility:Function = function(param1:Boolean):void
         {
            var _loc2_:int = 0;
            while(_loc2_ < buttons.length)
            {
               buttons[_loc2_].visible = param1;
               _loc2_++;
            }
         };
         super.loadMapComplete(loader);
         buttons = new Vector.<UIComponent>();
         point = new Point();
         for each(area in this.worldArea.getSubAreas())
         {
            if(area.swfVarName == "cinema")
            {
               this.hideClip(area.swfVarName);
            }
            else
            {
               if(area.swfVarName == "cafe")
               {
                  if(loadedMap[area.swfVarName] != null)
                  {
                     (loadedMap[area.swfVarName] as MovieClip).x += 100;
                  }
               }
               if(area.swfVarName == "beach")
               {
                  if(loadedMap[area.swfVarName] != null)
                  {
                     (loadedMap[area.swfVarName] as MovieClip).x -= 100;
                  }
               }
               if(area.swfVarName == "mall")
               {
                  if(loadedMap[area.swfVarName] != null)
                  {
                     (loadedMap[area.swfVarName] as MovieClip).x -= 100;
                  }
               }
               button = registerMapElement(area.swfVarName,area.localizedStr,area.enter);
               if(button != null)
               {
                  buttons.push(button);
                  if(this.newTagHelper.getIfIsNew(area.swfVarName))
                  {
                     realButton = button.getChildAt(1);
                     point.x = realButton.x;
                     point.y = realButton.y;
                     point = localToGlobal(point);
                     point = button.globalToLocal(point);
                     newIcon = new MenuIcons.NewIcon();
                     newIcon.x = point.x + 100;
                     newIcon.y = point.y + 60;
                     button.addChild(newIcon);
                  }
               }
            }
         }
         setButtonsVisibility(false);
         brandName = Config.getCurrentSiteConfig().brandName;
         try
         {
            if(loadedMap.creativeArea.MSP_Sculpture != null)
            {
               loadedMap.creativeArea.MSP_Sculpture.gotoAndStop(brandName);
            }
            if(loadedMap.creativeArea.MSP_Sign != null)
            {
               loadedMap.creativeArea.MSP_Sign.gotoAndStop(brandName);
            }
         }
         catch(e:Error)
         {
         }
         drawBackground();
         setupResizeRedraw();
         setButtonsVisibility(true);
         this.mapLoaded = true;
         this.addBackBtn();
         if(this.giftsContainer == null)
         {
            this.giftsContainer = new UIComponent();
            addChild(this.giftsContainer);
         }
         setTimeout(this.addGiftsToArea,1);
         MessageCommunicator.send(new MsgEvent(MSPEvent.MAP_LOAD_COMPLETED,this));
      }
      
      private function backClick(param1:MouseEvent) : void
      {
         SoundManager.Instance().playSoundEffect(Sounds.BUTTON_CLICK);
         WorldArea.showWorldArea(WorldArea.OVERVIEW);
      }
      
      private function backOver(param1:MouseEvent) : void
      {
         SoundManager.Instance().playSoundEffect(Sounds.BUTTON_HOVER);
      }
      
      private function addBackBtn() : void
      {
         var _loc1_:MSP_SWFLoader = null;
         if(this.worldArea != WorldArea.OVERVIEW)
         {
            _loc1_ = new MSP_SWFLoader();
            MSP_SWFLoader.RequestLoad(new RawUrl("swf/world/button.swf"),this.onBackBtnLoad,2,false,true);
         }
      }
      
      public function flashButtons(param1:EffectEvent = null) : void
      {
         var onEffectEnd:Function = null;
         var childAnim:Array = null;
         var area:BaseWorldElement = null;
         var curMc:MovieClip = null;
         var curAnim:Effect = null;
         var e:EffectEvent = param1;
         onEffectEnd = function(param1:EffectEvent):void
         {
            para.removeEventListener(EffectEvent.EFFECT_END,onEffectEnd);
            para.play(null,true);
            para.addEventListener(EffectEvent.EFFECT_END,flashButtons);
         };
         this.para.removeEventListener(EffectEvent.EFFECT_END,this.flashButtons);
         if(!this.stopFlashing && this.curFlashTime++ < FLASH_TIMES)
         {
            childAnim = [];
            for each(area in this.worldArea.getSubAreas())
            {
               curMc = loadedMap[area.swfVarName] as MovieClip;
               curAnim = this.getAnim(curMc);
               childAnim.push(curAnim);
            }
            this.para.children = childAnim;
            this.para.startDelay = 500;
            this.para.play(null,false);
            this.para.addEventListener(EffectEvent.EFFECT_END,onEffectEnd);
         }
      }
      
      override protected function handleMouseOver(param1:MouseEvent, param2:Boolean) : void
      {
         super.handleMouseOver(param1,param2);
         this.para.stop();
         this.stopFlashing = true;
      }
      
      private function onBackBtnLoad(param1:MSP_SWFLoader) : void
      {
         var _loc2_:MovieClip = param1.content as MovieClip;
         var _loc3_:UIComponent = new UIComponent();
         _loc3_.addChild(_loc2_);
         addChild(_loc3_);
         setText(MSPLocaleManagerWeb.getInstance().getString("BACK_BTN"),_loc2_.TextArea,_loc2_.button);
         _loc3_.addEventListener(MouseEvent.CLICK,this.backClick,false,0,true);
         _loc3_.addEventListener(MouseEvent.ROLL_OVER,this.backOver,false,0,true);
         _loc2_.mouseChildren = false;
         _loc2_.useHandCursor = _loc2_.buttonMode = _loc3_.useHandCursor = _loc3_.buttonMode = true;
         _loc3_.includeInLayout = false;
         _loc3_.scaleX = 0.7;
         _loc3_.scaleY = 0.7;
         _loc3_.x = width - (_loc2_.width + 60);
         _loc3_.y = 10;
      }
      
      protected function hideMapObjectContaining(param1:Array, param2:String) : Boolean
      {
         var _loc4_:BaseWorldElement = null;
         var _loc3_:Boolean = false;
         for each(_loc4_ in param1)
         {
            if(_loc4_.swfVarName == param2)
            {
               _loc3_ = true;
               break;
            }
         }
         if(_loc3_)
         {
            this.hideClip(param2);
            return true;
         }
         return false;
      }
      
      protected function hideClip(param1:String) : void
      {
         if(loadedMap[param1] != null)
         {
            (loadedMap[param1] as MovieClip).visible = false;
         }
      }
   }
}

