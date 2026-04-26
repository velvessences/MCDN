package com.moviestarplanet.utils
{
   import com.boostworthy.animation.easing.Transitions;
   import com.boostworthy.animation.management.AnimationManager;
   import com.boostworthy.animation.rendering.RenderMethod;
   import com.moviestarplanet.Components.MSP_Image;
   import com.moviestarplanet.activespecials.ActiveSpecialsHandler;
   import com.moviestarplanet.activespecials.ActiveSpecialsType;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.flash.icons.CurrencyIcons;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextLineMetrics;
   import flash.utils.Timer;
   import mx.collections.ArrayCollection;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.Text;
   import mx.core.Container;
   import mx.core.FlexGlobals;
   import mx.core.UIComponent;
   import mx.effects.Sequence;
   import mx.effects.Zoom;
   import mx.events.EffectEvent;
   
   public class DisplayUtils
   {
      
      private static var m_objAnimationManager:AnimationManager;
      
      private static const MOVE_DURATION:int = 1000;
      
      private static const IMAGE_TIMEOUT:int = 2000;
      
      private static const MOVE_Y_TO:int = -200;
      
      private static var imgMap:Object = new Object();
      
      private static var lblMap:Object = new Object();
      
      private static var timerMap:Object = new Object();
      
      private static const FAME_SWF:String = Config.toAbsoluteURL("swf/world/frameIcons/FameStar_2012_30x30.swf",Config.LOCAL_CDN_URL);
      
      private static const FAME_BOOSTER_SWF:String = Config.toAbsoluteURL("swf/Icons/FameBoosterStar.swf",Config.LOCAL_CDN_URL);
      
      private static const MONEY_SWF:String = Config.toAbsoluteURL("img/Icons/icon_starcoin.swf",Config.LOCAL_CDN_URL);
      
      public static const MEASURE_HEIGHT:int = 0;
      
      public static const MEASURE_WIDTH:int = 1;
      
      private static var traverseDisplayListHelper:Array = [];
      
      public function DisplayUtils()
      {
         super();
      }
      
      public static function showMoneyImage(param1:String, param2:DisplayObjectContainer) : void
      {
         var img:UIComponent;
         var rect:Rectangle;
         var coinX:Number;
         var lbl:TextField;
         var swfLoc:String = null;
         var icon:DisplayObjectContainer = null;
         var amountString:String = param1;
         var container:DisplayObjectContainer = param2;
         swfLoc = "GameIcons.StarCoin_Amount";
         var timer:Timer = timerMap[swfLoc];
         if(timer != null)
         {
            timer.reset();
         }
         else
         {
            timer = new Timer(IMAGE_TIMEOUT,1);
            timerMap[swfLoc] = timer;
            timer.addEventListener(TimerEvent.TIMER,function(param1:Event):void
            {
               removeImg(swfLoc);
            });
         }
         img = imgMap[swfLoc];
         if(img == null)
         {
            icon = CurrencyIcons.createIcon(CurrencyIcons.ICON_STARCOIN_W_TEXT) as DisplayObjectContainer;
            icon.width = 48;
            icon.height = 48;
            img = new UIComponent();
            img.width = 48;
            img.height = 48;
            img.addChild(icon);
            imgMap[swfLoc] = img;
         }
         else
         {
            icon = img.getChildAt(0) as DisplayObjectContainer;
         }
         container.addChild(img);
         if(container.scaleY < 1)
         {
            img.scaleX = 1 / container.scaleX;
            img.scaleY = 1 / container.scaleY;
         }
         rect = container.getBounds(container.parent);
         coinX = 0;
         img.move(coinX,0);
         lbl = lblMap[swfLoc];
         if(lbl == null)
         {
            lbl = icon[CurrencyIcons.ICON_STARCOIN_INAME_TEXT];
            FontManager.remapFonts(lbl);
            lblMap[swfLoc] = lbl;
         }
         lbl.text = amountString;
         moveImage(img,timer);
      }
      
      private static function removeImg(param1:String) : void
      {
         var _loc2_:DisplayObject = imgMap[param1] as DisplayObject;
         if(_loc2_.parent != null)
         {
            _loc2_.parent.removeChild(_loc2_);
         }
      }
      
      public static function showPointImage(param1:String, param2:DisplayObjectContainer) : void
      {
         if(ActiveSpecialsHandler.hasActiveSpecial(ActiveSpecialsType.FAMEBOOSTER))
         {
            showImage(FAME_BOOSTER_SWF,-3,0,param1,param2);
         }
         else
         {
            showImage(FAME_SWF,-3,0,param1,param2);
         }
      }
      
      private static function showImage(param1:String, param2:int, param3:int, param4:String, param5:DisplayObjectContainer) : void
      {
         var img:Image;
         var rect:Rectangle;
         var coinX:Number;
         var lbl:Label;
         var swfLoc:String = param1;
         var offX:int = param2;
         var offY:int = param3;
         var points:String = param4;
         var container:DisplayObjectContainer = param5;
         var timer:Timer = timerMap[swfLoc];
         if(timer != null)
         {
            timer.reset();
         }
         else
         {
            timer = new Timer(IMAGE_TIMEOUT,1);
            timerMap[swfLoc] = timer;
            timer.addEventListener(TimerEvent.TIMER,function(param1:Event):void
            {
               removeImg(swfLoc);
            });
         }
         img = imgMap[swfLoc];
         if(img == null)
         {
            img = new MSP_Image();
            img.source = swfLoc;
            img.width = 48;
            img.height = 48;
            imgMap[swfLoc] = img;
         }
         container.addChild(img);
         if(container.scaleY < 1)
         {
            img.scaleX = 1 / container.scaleX;
            img.scaleY = 1 / container.scaleY;
         }
         rect = container.getBounds(container.parent);
         coinX = 0;
         img.move(coinX,0);
         lbl = lblMap[swfLoc];
         if(lbl == null)
         {
            lbl = createLabelForImage(img,offX,offY);
            lblMap[swfLoc] = lbl;
         }
         lbl.text = points;
         moveImage(img,timer);
      }
      
      private static function createLabelForImage(param1:Image, param2:Number = 0, param3:Number = 0) : Label
      {
         var _loc4_:Label = new Label();
         _loc4_.setStyle("fontSize","18");
         _loc4_.setStyle("fontWeight","bold");
         _loc4_.setStyle("color","0x000000");
         _loc4_.setStyle("textAlign","center");
         _loc4_.height = 20;
         _loc4_.width = 40;
         _loc4_.alpha = 0.7;
         param1.addChild(_loc4_);
         _loc4_.move(param1.width / 2 - 20 + param2,param1.height / 2 - 10 + param3);
         return _loc4_;
      }
      
      private static function moveImage(param1:DisplayObject, param2:Timer) : void
      {
         if(!m_objAnimationManager)
         {
            m_objAnimationManager = new AnimationManager();
         }
         m_objAnimationManager.move(param1,param1.x,MOVE_Y_TO,MOVE_DURATION,Transitions.CUBIC_OUT,RenderMethod.ENTER_FRAME);
         param2.start();
      }
      
      public static function addZoomEffect(param1:DisplayObject, param2:Number = 500, param3:Number = 0.1) : void
      {
         var bigger:Zoom;
         var smaller:Zoom;
         var sequenceZoom:Sequence = null;
         var savedX:Number = NaN;
         var savedY:Number = NaN;
         var object:DisplayObject = param1;
         var duration:Number = param2;
         var zoomIncrease:Number = param3;
         var currentScale:Number = (object.scaleX + object.scaleY) / 2;
         sequenceZoom = new Sequence();
         sequenceZoom.duration = duration;
         bigger = new Zoom();
         bigger.zoomWidthFrom = currentScale;
         bigger.zoomWidthTo = currentScale + zoomIncrease;
         bigger.zoomHeightFrom = currentScale;
         bigger.zoomHeightTo = currentScale + zoomIncrease;
         smaller = new Zoom();
         smaller.zoomWidthFrom = currentScale + zoomIncrease;
         smaller.zoomWidthTo = currentScale;
         smaller.zoomHeightFrom = currentScale + zoomIncrease;
         smaller.zoomHeightTo = currentScale;
         sequenceZoom.addChild(bigger);
         sequenceZoom.addChild(smaller);
         savedX = 0;
         savedY = 0;
         object.addEventListener(MouseEvent.ROLL_OVER,function(param1:MouseEvent):void
         {
            var _loc2_:DisplayObject = null;
            if(false == sequenceZoom.isPlaying)
            {
               _loc2_ = param1.currentTarget as DisplayObject;
               savedX = _loc2_.x;
               savedY = _loc2_.y;
               sequenceZoom.play([_loc2_]);
            }
         });
         sequenceZoom.addEventListener(EffectEvent.EFFECT_END,function():void
         {
            object.x = savedX;
            object.y = savedY;
         });
      }
      
      public static function applyStyle(param1:UIComponent, param2:Class, param3:String) : void
      {
         var _loc4_:ArrayCollection = null;
         if(param1.initialized == false)
         {
            FlexGlobals.topLevelApplication.callLater(applyStyle,[param1,param2,param3]);
         }
         else
         {
            _loc4_ = getMatchingNodes(param1);
            _loc4_.addItem(param1);
            for each(param1 in _loc4_)
            {
               if(param1 is param2)
               {
                  param1.styleName = param3;
               }
            }
         }
      }
      
      private static function getMatchingNodes(param1:UIComponent) : ArrayCollection
      {
         var _loc4_:Object = null;
         var _loc2_:ArrayCollection = new ArrayCollection();
         var _loc3_:int = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc3_);
            if(_loc4_ is UIComponent)
            {
               _loc2_.addItem(_loc4_);
            }
            if(_loc4_ is Container)
            {
               _loc2_.addAll(getMatchingNodes(UIComponent(_loc4_)));
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function getLargestComponentSize(param1:UIComponent) : Number
      {
         var _loc3_:UIComponent = null;
         var _loc4_:Number = NaN;
         var _loc2_:Number = param1.width;
         if(param1 is Container)
         {
            for each(_loc3_ in Container(param1).getChildren())
            {
               _loc4_ = getLargestComponentSize(_loc3_);
               _loc2_ = Number(Math.max(_loc2_,_loc4_));
            }
         }
         return _loc2_;
      }
      
      public static function getLargestTextSize(param1:UIComponent, param2:int = 1) : Number
      {
         var _loc7_:Object = null;
         var _loc8_:Number = NaN;
         var _loc3_:String = "";
         if(param1 is Button)
         {
            _loc3_ = Button(param1).label;
         }
         else if(param1 is Text)
         {
            _loc3_ = Text(param1).text;
         }
         else if(param1 is Label)
         {
            _loc3_ = Label(param1).text;
         }
         var _loc4_:TextLineMetrics = param1.measureText(_loc3_);
         var _loc5_:Number = 0;
         switch(param2)
         {
            case MEASURE_HEIGHT:
               _loc5_ = Number(_loc4_.height);
               break;
            case MEASURE_WIDTH:
               _loc5_ = Number(_loc4_.width);
         }
         var _loc6_:int = 0;
         while(_loc6_ < param1.numChildren)
         {
            _loc7_ = param1.getChildAt(_loc6_);
            if(_loc7_ is UIComponent)
            {
               _loc8_ = getLargestTextSize(UIComponent(_loc7_),param2);
               _loc5_ = Number(Math.max(_loc5_,_loc8_));
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public static function center(param1:DisplayObject, param2:DisplayObjectContainer) : void
      {
         param1.x = (param2.width / param2.scaleX - param1.width) / 2;
         param1.y = (param2.height / param2.scaleY - param1.height) / 2;
      }
      
      public static function centerInRectangle(param1:DisplayObject, param2:Rectangle) : void
      {
         param1.x = param2.x + (param2.width - param1.width) / 2;
         param1.y = param2.y + (param2.height - param1.height) / 2;
      }
      
      public static function removeMouseFromChildren(param1:DisplayObject) : void
      {
         var _loc2_:Object = null;
         var _loc3_:DisplayObjectContainer = null;
         var _loc4_:int = 0;
         var _loc5_:DisplayObject = null;
         if(param1 is DisplayObjectContainer)
         {
            traverseDisplayListHelper.length = 0;
            _loc3_ = param1 as DisplayObjectContainer;
            _loc4_ = 0;
            traverseDisplayListHelper[0] = _loc3_;
            while(traverseDisplayListHelper.length)
            {
               _loc2_ = traverseDisplayListHelper.pop();
               if(param1 != _loc2_)
               {
                  if("mouseEnabled" in _loc2_)
                  {
                     _loc2_["mouseEnabled"] = false;
                  }
                  if("mouseChildren" in _loc2_)
                  {
                     _loc2_["mouseChildren"] = false;
                  }
               }
               if(_loc2_ is DisplayObjectContainer)
               {
                  _loc4_ = 0;
                  while(_loc4_ < _loc2_.numChildren)
                  {
                     _loc5_ = _loc2_.getChildAt(_loc4_);
                     traverseDisplayListHelper.push(_loc5_);
                     _loc4_++;
                  }
               }
            }
         }
      }
   }
}

