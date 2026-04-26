package com.moviestarplanet.MobileAdd
{
   import com.moviestarplanet.Forms.world.elements.WorldArea;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.membership.UserTypeDeterminator;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.msg.AreaEvent;
   import com.moviestarplanet.payment.PaymentModuleExternalManager;
   import com.moviestarplanet.payment.seasonalSale.SeasonalSale;
   import com.moviestarplanet.utils.ComponentUtilities;
   import com.moviestarplanet.utils.DisplayUtils;
   import com.moviestarplanet.utils.displayobject.BitmapConverter;
   import com.moviestarplanet.utils.swfmapping.PathSelector;
   import com.moviestarplanet.utils.swfmapping.PropertyMappingValue;
   import com.moviestarplanet.utils.swfmapping.SWFPropertyBinder;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mx.core.UIComponent;
   import mx.effects.Glow;
   
   public class MobileAdvertising
   {
      
      private static var _instance:MobileAdvertising;
      
      private var addBinder:SWFPropertyBinder;
      
      private var binder:SWFPropertyBinder;
      
      private var container:DisplayObjectContainer;
      
      public var mobileAddOn:Boolean = false;
      
      public var mobileAddOnInNews:Boolean = false;
      
      private var version:String;
      
      private var _vipSaleIsActive:Boolean;
      
      private var hitUIComponent:UIComponent = new UIComponent();
      
      private var flattenVisualContainer:Sprite = new Sprite();
      
      private var flattenVisualUIComponent:UIComponent = new UIComponent();
      
      private var flattenTriangleUIComponent:UIComponent = new UIComponent();
      
      private var blackTriangleContainer:Sprite = new Sprite();
      
      private var flattenBlackTriangleContainer:Sprite = new Sprite();
      
      public function MobileAdvertising(param1:SingletonBlocker)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use MobileAdvertising.Instance() instead of new.");
         }
         this.container = Main.Instance.mainCanvas.overlayContainer;
         MessageCommunicator.subscribe(AreaEvent.WORLD_AREA_SHOWN,this.onWorldAreaChanged);
         MessageCommunicator.send(new AreaEvent(AreaEvent.WORLD_CHAT));
      }
      
      public static function Instance() : MobileAdvertising
      {
         if(_instance == null)
         {
            _instance = new MobileAdvertising(new SingletonBlocker());
         }
         return _instance;
      }
      
      private function onWorldAreaChanged(param1:AreaEvent) : void
      {
         var _loc2_:WorldArea = param1.data as WorldArea;
         var _loc3_:Boolean = true;
         if(_loc2_)
         {
            if(_loc2_.swfVarName != "")
            {
               _loc3_ = false;
            }
         }
         this.flattenVisualUIComponent.visible = _loc3_;
         this.flattenTriangleUIComponent.visible = _loc3_;
      }
      
      public function addMobileCornerAdd(param1:String) : void
      {
         var _loc3_:String = null;
         this.version = param1;
         var _loc2_:Number = UserTypeDeterminator.determineUserTypeByDaysLimit(ActorSession.loggedInActor.MembershipTimeoutDate);
         this._vipSaleIsActive = SeasonalSale.saleIsActive() && _loc2_ != UserTypeDeterminator.IS_VIP;
         if(this._vipSaleIsActive)
         {
            _loc3_ = SeasonalSale.getSalesCornerAddURL();
         }
         else
         {
            _loc3_ = "mobileAdd/MobileCornerAd.swf";
         }
         if(this.mobileAddOn)
         {
            this.addBinder = new SWFPropertyBinder();
            this.addBinder.addEventListener(MSPEvent.PROPERTY_BINDER_CONTENT_READY,this.initCornerAd);
            this.addBinder.contentUrl = _loc3_;
            if(!this._vipSaleIsActive)
            {
               this.addBinder.addPropertyMapping(new PropertyMappingValue(new PathSelector("TextArea1"),"text",MSPLocaleManagerWeb.getInstance().getString("MOBILE_CORNER_NEW_APP")));
               this.addBinder.addPropertyMapping(new PropertyMappingValue(new PathSelector("TextArea2"),"text",MSPLocaleManagerWeb.getInstance().getString("MOBILE_CORNER_GET_IT_NOW_2")));
            }
            this.flattenVisualUIComponent.name = "Mobile_Corner_Adver_UI_Comp";
            this.flattenVisualContainer.name = "Mobile_Corner_Adver_Sprite";
            this.flattenVisualUIComponent.addChild(this.flattenVisualContainer);
            Main.Instance.mainCanvas.nonInteractiveCanvas.addChild(this.flattenVisualUIComponent);
            Main.Instance.mainCanvas.applicationViewStack.mainView.moviestarContainer.addChild(this.hitUIComponent);
            MessageCommunicator.subscribe(MSPEvent.VIP_TIER_UPDATED,this.onVipChanged);
         }
      }
      
      private function onVipChanged(param1:MsgEvent) : void
      {
         this.flattenVisualUIComponent.removeChildren();
         this.flattenVisualContainer.removeChildren();
         MessageCommunicator.unscribe(MSPEvent.VIP_TIER_UPDATED,this.onVipChanged);
         this.addMobileCornerAdd("");
      }
      
      public function addClickListener() : void
      {
         MessageCommunicator.subscribe(MSPEvent.OPEN_ADVERTISEMENT,this.openAdvertisementEvent);
      }
      
      private function initCornerAd(param1:Object) : void
      {
         var _content:MovieClip;
         var clickable:MovieClip = null;
         var xCoord:int = 0;
         var yCoord:int = 0;
         var xClickArea:int = 0;
         var yClickArea:int = 0;
         var glow:Glow = null;
         var iMobileAddClicked:Function = null;
         var canvas:MovieClip = null;
         var gfxCountry:MovieClip = null;
         var o:Object = param1;
         iMobileAddClicked = function():void
         {
            if(flattenVisualUIComponent.visible)
            {
               if(_vipSaleIsActive)
               {
                  PaymentModuleExternalManager.getInstance().openPurchaseFlow();
               }
               else
               {
                  openAdvertisement(version);
               }
            }
         };
         this.addBinder.removeEventListener(MSPEvent.PROPERTY_BINDER_CONTENT_READY,this.initCornerAd);
         _content = this.addBinder.content;
         if(_content != null && _content.numChildren > 0)
         {
            canvas = _content.getChildAt(0) as MovieClip;
            gfxCountry = canvas["GfxCountry"];
            clickable = canvas["click"];
            if(gfxCountry != null)
            {
               gfxCountry.gotoAndStop(ComponentUtilities.getLanguageLabel(gfxCountry,Config.overrideLanguage));
            }
         }
         if(!this._vipSaleIsActive)
         {
            clickable = this.addBinder.getSubContent(new PathSelector("click")) as MovieClip;
            xCoord = 1021;
            yCoord = 294;
            xClickArea = 1056;
            yClickArea = 380;
         }
         else
         {
            xCoord = 1023;
            yCoord = 384;
            xClickArea = 1025;
            yClickArea = 384;
         }
         this.flattenVisualUIComponent.x = xCoord;
         this.flattenVisualUIComponent.y = yCoord;
         this.moveBlackTriangleBehindCornerAd();
         if(clickable != null)
         {
            clickable.scaleX = clickable.scaleY = 1.5;
            this.hitUIComponent.addChild(clickable);
            this.hitUIComponent.x = xClickArea;
            this.hitUIComponent.y = yClickArea;
         }
         new BitmapConverter(this.addBinder.content,this.flattenVisualContainer);
         glow = new Glow();
         glow.alphaFrom = 0;
         glow.alphaTo = 1;
         glow.blurXTo = 8;
         glow.blurYTo = 8;
         glow.color = 16777215;
         glow.duration = 1;
         this.hitUIComponent.addEventListener(MouseEvent.MOUSE_OVER,function():void
         {
            glow.stop();
            glow.play([flattenVisualUIComponent],false);
         });
         this.hitUIComponent.addEventListener(MouseEvent.MOUSE_OUT,function():void
         {
            glow.stop();
            glow.play([flattenVisualUIComponent],true);
         });
         this.hitUIComponent.addEventListener(MouseEvent.CLICK,iMobileAddClicked);
         this.flattenVisualUIComponent.mouseEnabled = false;
         this.flattenVisualUIComponent.mouseChildren = false;
         this.flattenVisualUIComponent.buttonMode = false;
         this.flattenVisualUIComponent.useHandCursor = false;
         DisplayUtils.removeMouseFromChildren(this.flattenVisualUIComponent);
      }
      
      private function openAdvertisementEvent(param1:Event) : void
      {
         this.openAdvertisement("",true);
      }
      
      public function openAdvertisement(param1:String, param2:Boolean = false) : void
      {
         if(this.mobileAddOn || param2)
         {
            new MobileAdView().showAd(param1);
         }
      }
      
      private function moveBlackTriangleBehindCornerAd() : void
      {
         this.flattenTriangleUIComponent.addChild(this.flattenBlackTriangleContainer);
         Main.Instance.mainCanvas.nonInteractiveCanvas.addChild(this.flattenTriangleUIComponent);
         Main.Instance.mainCanvas.nonInteractiveCanvas.addChild(this.flattenVisualUIComponent);
         this.flattenTriangleUIComponent.x = 1086;
         this.flattenTriangleUIComponent.y = 450;
         var _loc1_:DisplayObject = (this.addBinder.content.getChildAt(0) as DisplayObjectContainer)["BlackTriangle"] as DisplayObject;
         var _loc2_:DisplayObject = (this.addBinder.content.getChildAt(0) as DisplayObjectContainer)["BlackTriangleShadow"] as DisplayObject;
         this.blackTriangleContainer.addChild(_loc1_);
         this.blackTriangleContainer.addChild(_loc2_);
         new BitmapConverter(this.blackTriangleContainer,this.flattenBlackTriangleContainer);
         this.flattenTriangleUIComponent.mouseChildren = false;
         this.flattenTriangleUIComponent.mouseEnabled = false;
         DisplayUtils.removeMouseFromChildren(this.flattenTriangleUIComponent);
      }
   }
}

class SingletonBlocker
{
   
   public function SingletonBlocker()
   {
      super();
   }
}
