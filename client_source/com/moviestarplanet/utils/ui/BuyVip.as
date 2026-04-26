package com.moviestarplanet.utils.ui
{
   import com.moviestarplanet.Components.MSP_Image;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.payment.seasonalSale.SeasonalSale;
   import com.moviestarplanet.utils.Utils;
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import mx.binding.*;
   import mx.core.FlexLoader;
   import mx.core.IFlexModuleFactory;
   import mx.core.mx_internal;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class BuyVip extends MSP_Image implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function BuyVip()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         bindings = this._BuyVip_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_com_moviestarplanet_utils_ui_BuyVipWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return BuyVip[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.autoLoad = true;
         this.width = 80;
         this.height = 80;
         this.addEventListener("complete",this.___BuyVip_MSP_Image1_complete);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         BuyVip._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
      }
      
      override public function initialize() : void
      {
         super.initialize();
      }
      
      private function onComplete() : void
      {
         var tryAddSaleBadge:Function = null;
         var i:int = 0;
         tryAddSaleBadge = function(param1:MovieClip):void
         {
            removeChildren();
            addChild(param1);
         };
         if(Config.getCurrentSiteConfig().country == "de")
         {
            i = 0;
            (this.getChildAt(0) as FlexLoader).content["vip"].x = 23;
            (this.getChildAt(0) as FlexLoader).content["vip"].y = 17;
            (this.getChildAt(0) as FlexLoader).content["dyntxt_become"].x = 19;
            (this.getChildAt(0) as FlexLoader).content["dyntxt_become"].y = 39;
         }
         Utils.DynTxtFindAndReplace(this,false);
         SeasonalSale.getSalesBadge(SeasonalSale.BADGE_TYPE_TOP_RIGHT_CORNER_ON_WEB,tryAddSaleBadge);
      }
      
      public function ___BuyVip_MSP_Image1_complete(param1:Event) : void
      {
         this.onComplete();
      }
      
      private function _BuyVip_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/world/frameIcons/buy_VIP.swf",Config.LOCAL_CDN_URL);
         },null,"this.source");
         return result;
      }
   }
}

