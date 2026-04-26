package com.moviestarplanet.emoticon.purchase
{
   import com.moviestarplanet.amf.valueobjects.AmfServiceResult;
   import com.moviestarplanet.analytics.AnalyticsSpendCurrencyCommand;
   import com.moviestarplanet.analytics.constants.AnalyticsConstants;
   import com.moviestarplanet.controls.buttons.CloseButton;
   import com.moviestarplanet.core.model.actor.reload.ActorReload;
   import com.moviestarplanet.emoticon.display.EmoticonGrid;
   import com.moviestarplanet.emoticon.service.EmoticonService;
   import com.moviestarplanet.emoticon.utility.EmoticonUtility;
   import com.moviestarplanet.emoticon.valueobjects.Emoticon;
   import com.moviestarplanet.emoticon.valueobjects.EmoticonPackage;
   import com.moviestarplanet.flash.components.popups.GetDiamondsPopUp;
   import com.moviestarplanet.icons.CurrencyIconsShared;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.usersession.valueobjects.ActorDetails;
   import com.moviestarplanet.utils.MSP_SWFLoader;
   import com.moviestarplanet.utils.displayobject.DisplayObjectUtilities;
   import com.moviestarplanet.utils.loader.RawUrl;
   import com.moviestarplanet.utils.sound.Sounds;
   import com.moviestarplanet.utils.translation.TranslationUtilities;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import mx.controls.SWFLoader;
   
   public class EmoticonPurchasePopup extends Sprite
   {
      
      private static const EMOTICONS_PER_LINE:int = 10;
      
      private static const EMOTICON_MARGIN:int = 7;
      
      private static const EMOTICON_SIZE:Number = 17;
      
      private var normalGrid:EmoticonGrid;
      
      private var vipGrid:EmoticonGrid;
      
      private var griddimensions:Rectangle;
      
      private var purchaseGraphics:DisplayObjectContainer;
      
      private var buybutton:MovieClip;
      
      private var complete:Function;
      
      private var pd:EmoticonPackage;
      
      private var ep:EmoticonPackage;
      
      public function EmoticonPurchasePopup(param1:EmoticonPackage, param2:Function)
      {
         super();
         this.pd = param1;
         this.complete = param2;
         this.ep = EmoticonUtility.instance.getEmoticonPackageFromId(param1.emoticonPackageId);
         MSP_SWFLoader.RequestLoad(new RawUrl("swf/emoticons/purchasepopup.swf"),this.loadGraphicsComplete);
      }
      
      private function loadGraphicsComplete(param1:SWFLoader) : void
      {
         var _loc4_:Class = null;
         var _loc2_:Array = [{
            "symbol":"PurchaseGraphics",
            "property":"purchaseGraphics"
         }];
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = param1.content.loaderInfo.applicationDomain.getDefinition(_loc2_[_loc3_].symbol) as Class;
            this[_loc2_[_loc3_].property] = new _loc4_();
            _loc3_++;
         }
         this.hookupToGraphics();
      }
      
      private function hookupToGraphics() : void
      {
         var _loc2_:CloseButton = null;
         TranslationUtilities.translateDisplayObject(this.purchaseGraphics,true,false);
         var _loc1_:DisplayObject = this.purchaseGraphics["closeposition"];
         _loc1_.visible = false;
         _loc2_ = new CloseButton();
         _loc2_.addEventListener(MouseEvent.CLICK,this.denyclicked,false,0,true);
         _loc2_.x = _loc1_.x;
         _loc2_.y = _loc1_.y;
         var _loc3_:DisplayObject = this.purchaseGraphics["gridposition"];
         _loc3_.visible = false;
         this.griddimensions = new Rectangle(_loc3_.x,_loc3_.y,_loc3_.width,_loc3_.height);
         this.normalGrid = new EmoticonGrid(EMOTICONS_PER_LINE,EMOTICON_MARGIN,EMOTICON_SIZE,EmoticonGrid.EXPANDABLE_VERTICAL);
         this.vipGrid = new EmoticonGrid(EMOTICONS_PER_LINE,EMOTICON_MARGIN,EMOTICON_SIZE,EmoticonGrid.EXPANDABLE_VERTICAL);
         this.setupEmoticonPackage();
         this.normalGrid.x = this.griddimensions.x;
         this.normalGrid.y = this.griddimensions.y;
         this.vipGrid.x = this.griddimensions.x;
         this.vipGrid.y = this.griddimensions.y + this.normalGrid.height;
         var _loc4_:DisplayObject = this.purchaseGraphics["gridbackground"];
         _loc4_.x = this.normalGrid.x;
         _loc4_.y = this.normalGrid.y;
         _loc4_.height = this.normalGrid.height + this.vipGrid.height;
         this.buybutton = this.purchaseGraphics["buybutton"];
         this.buybutton.y = this.vipGrid.y + this.vipGrid.height + 5;
         DisplayObjectUtilities.buttonizeFrames(this.buybutton as MovieClip,this.purchaseclicked,true,Sounds.DIAMONDS_SPEND_DIAMONDS);
         var _loc5_:DisplayObject = this.buybutton["diamondPosition"];
         _loc5_.visible = false;
         var _loc6_:DisplayObject = new CurrencyIconsShared.DiamondIcon();
         var _loc7_:Number = Number(Math.min(_loc5_.width / _loc6_.width,_loc5_.height / _loc6_.height));
         _loc6_.x = _loc5_.x;
         _loc6_.y = _loc5_.y;
         _loc6_.scaleX = _loc6_.scaleY = _loc7_;
         this.buybutton.addChild(_loc6_);
         var _loc8_:TextField = this.buybutton["pricetext"];
         _loc8_.text = this.ep.hardCurrencyPrice.toString();
         var _loc9_:DisplayObject = this.purchaseGraphics["background"];
         _loc9_.height = this.buybutton.y + this.buybutton.height + 10;
         this.purchaseGraphics.addChild(_loc2_);
         this.purchaseGraphics.addChild(this.normalGrid);
         this.purchaseGraphics.addChild(this.vipGrid);
         addChild(this.purchaseGraphics);
      }
      
      private function setupEmoticonPackage() : void
      {
         var _loc5_:Emoticon = null;
         var _loc6_:DisplayObject = null;
         var _loc1_:Array = new Array();
         var _loc2_:Array = new Array();
         var _loc3_:EmoticonPackage = this.pd;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.emoticons.length)
         {
            _loc5_ = _loc3_.emoticons[_loc4_];
            _loc6_ = EmoticonUtility.instance.createDisplayObjectFromSymbol(_loc5_.Symbol,EMOTICON_SIZE);
            if(_loc5_.VipRequired == true)
            {
               _loc2_.push(_loc6_);
            }
            else
            {
               _loc1_.push(_loc6_);
            }
            _loc4_++;
         }
         this.normalGrid.addItems(_loc1_);
         this.vipGrid.addItems(_loc2_);
      }
      
      private function setnavigationenabled(param1:Boolean) : void
      {
         DisplayObjectUtilities.setButtonizedEnabled(this.buybutton,param1,true);
      }
      
      private function denyclicked(param1:MouseEvent) : void
      {
         this.complete();
      }
      
      private function purchaseclicked(param1:MouseEvent) : void
      {
         var serviceresult:Function = null;
         var event:MouseEvent = param1;
         serviceresult = function(param1:AmfServiceResult):void
         {
            if(param1.Code == 0)
            {
               ep.hasPurchased = true;
               AnalyticsSpendCurrencyCommand.execute(AnalyticsConstants.EMOTICONPACK + ep.emoticonPackageId,AnalyticsConstants.DIAMONDS,ep.hardCurrencyPrice);
            }
            if(complete != null)
            {
               ActorReload.getInstance().requestReload();
               complete();
            }
            setnavigationenabled(true);
         };
         var ownactor:ActorDetails = ActorSession.loggedInActor;
         if(ownactor.Diamonds < this.ep.hardCurrencyPrice)
         {
            GetDiamondsPopUp.Show();
         }
         else
         {
            this.setnavigationenabled(false);
            EmoticonService.instance.buyEmoticonPackage(ActorSession.loggedInActor.ActorId,this.ep.specialsItemId,serviceresult);
         }
      }
   }
}

