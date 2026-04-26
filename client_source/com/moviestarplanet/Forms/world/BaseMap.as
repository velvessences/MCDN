package com.moviestarplanet.Forms.world
{
   import com.moviestarplanet.Forms.world.elements.WorldArea;
   import com.moviestarplanet.managers.SoundManager;
   import com.moviestarplanet.services.wrappers.SessionService;
   import com.moviestarplanet.utils.MSP_SWFLoader;
   import com.moviestarplanet.utils.displayobject.DisplayObjectUtilities;
   import com.moviestarplanet.utils.displayobject.FlattenUtilities;
   import com.moviestarplanet.utils.loader.ContentUrl;
   import com.moviestarplanet.utils.loader.MSP_LoaderManager;
   import com.moviestarplanet.utils.sound.Sounds;
   import com.moviestarplanet.utils.ui.ImageTweenUtils;
   import com.moviestarplanet.window.loading.LoadingBar;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import mx.containers.Canvas;
   import mx.controls.Alert;
   import mx.core.FlexGlobals;
   import mx.core.ScrollPolicy;
   import mx.core.UIComponent;
   import mx.effects.Effect;
   import mx.events.ResizeEvent;
   
   public class BaseMap extends Canvas
   {
      
      private static var loadingbar:LoadingBar = new LoadingBar("Loading...");
      
      private var swfPath:String;
      
      private var mapLoader:MSP_SWFLoader = new MSP_SWFLoader();
      
      protected var loadedMap:MovieClip = null;
      
      private var hasAlreadyShownBoarder:Boolean = false;
      
      private var showPictureUpload:Boolean = true;
      
      private const FRAME_WITHOUT_PICTURE_UPLOAD:int = 2;
      
      private const FRAME_WITH_PICTURE_UPLOAD:int = 1;
      
      private var tweeners:Object = {};
      
      public function BaseMap()
      {
         super();
         this.horizontalScrollPolicy = ScrollPolicy.OFF;
         this.verticalScrollPolicy = ScrollPolicy.OFF;
      }
      
      public function getLoadedMap() : MovieClip
      {
         return this.loadedMap;
      }
      
      protected function showBorder() : void
      {
         if(!this.hasAlreadyShownBoarder)
         {
            this.setStyle("borderStyle","solid");
            this.setStyle("borderThickness",4);
            this.setStyle("borderColor",0);
         }
      }
      
      protected function loadMap(param1:String) : void
      {
         this.swfPath = param1;
         this.mapLoader.LoadCallBack = this.loadMapComplete;
         this.mapLoader.LoadUrl(new ContentUrl(param1,ContentUrl.WORLD),MSP_LoaderManager.PRIORITY_UI);
         loadingbar.show();
      }
      
      protected function loadMapComplete(param1:MSP_SWFLoader) : void
      {
         var setShowPictureUpload:Function;
         var loader:MSP_SWFLoader = param1;
         loadingbar.hide();
         this.loadedMap = this.mapLoader.content as MovieClip;
         this.loadedMap.cacheAsBitmap = true;
         if(this.swfPath == WorldArea.creativeSWFFileName)
         {
            setShowPictureUpload = function(param1:String):void
            {
               var s:String = param1;
               showPictureUpload = s == "true";
               if(!showPictureUpload)
               {
                  try
                  {
                     loadedMap.gotoAndStop(FRAME_WITHOUT_PICTURE_UPLOAD);
                  }
                  catch(e:Error)
                  {
                     loadedMap.gotoAndStop(FRAME_WITH_PICTURE_UPLOAD);
                  }
               }
            };
            SessionService.GetAppSetting("ImageUpload",setShowPictureUpload);
         }
      }
      
      protected function setupResizeRedraw() : void
      {
         FlexGlobals.topLevelApplication.addEventListener(ResizeEvent.RESIZE,this.mapResized,false,0,true);
      }
      
      private function mapResized(param1:Event) : void
      {
         this.drawBackground();
      }
      
      protected function drawBackground() : void
      {
         if(stage == null)
         {
            addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
            return;
         }
         var _loc1_:Number = stage.stageWidth / 1240;
         var _loc2_:Number = stage.stageHeight / 720;
         var _loc3_:Number = Number(Math.min(_loc1_,_loc2_));
         var _loc4_:Number = Number(this.mapLoader.content.loaderInfo.width);
         var _loc5_:Number = Number(this.mapLoader.content.loaderInfo.height);
         if(this.mapLoader.content is MovieClip)
         {
            if(!this.showPictureUpload)
            {
               (this.mapLoader.content as MovieClip).gotoAndStop(this.FRAME_WITHOUT_PICTURE_UPLOAD);
            }
            else
            {
               (this.mapLoader.content as MovieClip).gotoAndStop(this.FRAME_WITH_PICTURE_UPLOAD);
            }
         }
         var _loc6_:DisplayObject = this.mapLoader.content as DisplayObject;
         DisplayObjectUtilities.drawScaledBitmap(_loc6_,this,_loc4_,_loc5_,_loc3_);
      }
      
      private function addedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
         this.drawBackground();
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         if(this.mapLoader != null && this.mapLoader.content != null)
         {
            this.showBorder();
            this.height = this.mapLoader.height = this.mapLoader.content.loaderInfo.height;
            this.width = this.mapLoader.width = this.mapLoader.content.loaderInfo.width;
         }
      }
      
      protected function registerMapElement(param1:String, param2:String, param3:Function) : UIComponent
      {
         var dis:MovieClip;
         var text:TextField;
         var mouseArea:Sprite;
         var holder:UIComponent;
         var scale:Number;
         var mouseListener:Function = null;
         var glow:Sprite = null;
         var disRect:Rectangle = null;
         var mouseAreaRect:Rectangle = null;
         var filterFix:Sprite = null;
         var mapVarName:String = param1;
         var localeText:String = param2;
         var clickCallback:Function = param3;
         mouseListener = function(param1:Event):void
         {
            clickCallback();
            SoundManager.Instance().playSoundEffect(Sounds.BUTTON_CLICK);
         };
         if(this.loadedMap == null)
         {
            Alert.show("Map was not loaded!");
         }
         dis = this.loadedMap[mapVarName] as MovieClip;
         if(dis == null)
         {
            if(mapVarName != "BuilderGame")
            {
               Alert.show("Map var not found: " + mapVarName);
            }
            return null;
         }
         text = dis["textArea"] as TextField;
         if(text == null)
         {
            text = dis["TextArea"] as TextField;
         }
         this.setText(localeText,text,dis["button"] as MovieClip);
         dis.useHandCursor = dis.buttonMode = false;
         dis.mouseChildren = false;
         dis.mouseEnabled = false;
         dis.cacheAsBitmap = true;
         mouseArea = dis;
         holder = new UIComponent();
         this.loadedMap.removeChild(dis);
         scale = ApplicationReference.getApplicationScale();
         if(true == dis.hasOwnProperty("icon"))
         {
            FlattenUtilities.flattenSprite(dis.icon as Sprite,scale,true);
            if(dis.hasOwnProperty("glow"))
            {
               FlattenUtilities.flattenSprite(dis.glow as Sprite,scale,true);
            }
            if(dis.hasOwnProperty("button"))
            {
               FlattenUtilities.flattenSprite(dis.button as Sprite,scale,true);
            }
         }
         else
         {
            if(dis.hasOwnProperty("glow"))
            {
               disRect = dis.getRect(dis.parent);
               glow = dis.glow;
               dis.removeChild(glow);
               FlattenUtilities.flattenSprite(glow,scale,true);
               mouseAreaRect = DisplayObjectUtilities.getVisibleBounds(dis);
               filterFix = new Sprite();
               filterFix.graphics.beginFill(0,0);
               filterFix.graphics.drawRect(disRect.x,disRect.y,disRect.width,disRect.height);
               filterFix.graphics.endFill();
               mouseArea = new Sprite();
               mouseArea.graphics.beginFill(0,0);
               mouseArea.graphics.drawRect(mouseAreaRect.x,mouseAreaRect.y,mouseAreaRect.width,mouseAreaRect.height);
               mouseArea.graphics.endFill();
               dis.addChild(filterFix);
               FlattenUtilities.flattenSprite(dis as Sprite,scale,true);
               holder.addChild(mouseArea);
               mouseArea.x += dis.x;
               mouseArea.y += dis.y;
               mouseArea.scaleX = mouseArea.scaleY = dis.scaleX;
            }
            else
            {
               FlattenUtilities.flattenSprite(dis as Sprite,scale,true);
            }
            if(glow)
            {
               dis.addChildAt(glow,0);
            }
         }
         mouseArea.addEventListener(MouseEvent.CLICK,mouseListener);
         mouseArea.addEventListener(MouseEvent.ROLL_OVER,this.mouseOver);
         mouseArea.addEventListener(MouseEvent.ROLL_OUT,this.mouseOut);
         mouseArea.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
         mouseArea.useHandCursor = mouseArea.buttonMode = true;
         mouseArea.mouseChildren = false;
         mouseArea.mouseEnabled = true;
         holder.useHandCursor = holder.buttonMode = false;
         holder.mouseChildren = true;
         holder.mouseEnabled = false;
         holder.addChildAt(dis,0);
         this.addChild(holder);
         holder.width = dis.width;
         holder.height = dis.height;
         this.switchGlow(dis,false);
         return holder;
      }
      
      protected function getAnim(param1:MovieClip) : Effect
      {
         var _loc2_:Object = this.tweeners[param1.name];
         if(_loc2_ == null)
         {
            this.tweeners[param1.name] = _loc2_ = {
               "anim":ImageTweenUtils.getGlowAnim(),
               "lastWasBackwards":false
            };
         }
         var _loc3_:Effect = _loc2_.anim as Effect;
         _loc3_.target = param1.parent;
         return _loc3_;
      }
      
      protected function setText(param1:String, param2:TextField, param3:MovieClip) : void
      {
         if(param2 == null || param3 == null)
         {
            return;
         }
         if(param1 == null)
         {
            param1 = "Back";
         }
         param2.text = param1;
         param2.width = param2.textWidth + 10;
         var _loc4_:int = 30;
         param3.width = param2.width + _loc4_;
         param2.x = param3.x + _loc4_ / 2 - param3.width / 2;
      }
      
      private function switchGlow(param1:MovieClip, param2:Boolean) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         if(param1 != null && Boolean(param1.hasOwnProperty("glow")))
         {
            _loc3_ = param1["glow"] as MovieClip;
            _loc4_ = this.loadedMap[param1.name + "_glow"] as MovieClip;
            if(_loc4_ != null)
            {
               _loc4_.visible = param2;
            }
            _loc5_ = param1["icon"] as MovieClip;
            if(_loc5_ != null)
            {
               _loc5_.visible = param2;
            }
            _loc3_.visible = param2;
         }
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         this.handleMouseOver(param1,true);
      }
      
      protected function handleMouseOver(param1:MouseEvent, param2:Boolean) : void
      {
         var _loc3_:MovieClip = param1.target.parent.getChildAt(0) as MovieClip;
         if(_loc3_ is MovieClip)
         {
            if(param2)
            {
               SoundManager.Instance().playSoundEffect(Sounds.BUTTON_HOVER);
            }
            this.switchGlow(_loc3_ as MovieClip,param2);
         }
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         this.handleMouseOver(param1,false);
      }
   }
}

