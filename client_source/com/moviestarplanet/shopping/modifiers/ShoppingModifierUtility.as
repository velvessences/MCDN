package com.moviestarplanet.shopping.modifiers
{
   import com.moviestarplanet.utils.MSP_SWFLoader;
   import com.moviestarplanet.utils.loader.MSP_LoaderManager;
   import com.moviestarplanet.utils.loader.RawUrl;
   import com.moviestarplanet.utils.tooltips.MSP_ToolTipManager;
   import com.moviestarplanet.utils.translation.LocaleHelper;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ShoppingModifierUtility
   {
      
      public static var serverCdnPrefix:String;
      
      public function ShoppingModifierUtility()
      {
         super();
      }
      
      public static function convertPrice(param1:IModifier, param2:Number) : Number
      {
         return param1.getPriceMultiplier() * param2;
      }
      
      public static function changeFormat(param1:IModifier, param2:TextFormat) : TextFormat
      {
         param2.color = param1.getColorChange();
         return param2;
      }
      
      public static function getAutoloadedIconContent(param1:IModifier, param2:Function = null) : DisplayObject
      {
         var iComplete:Function = null;
         var modifier:IModifier = param1;
         var complete:Function = param2;
         iComplete = function(param1:*):void
         {
            var _loc2_:DisplayObject = param1.content;
            if(complete != null)
            {
               complete(_loc2_);
            }
         };
         var loader:DisplayObject = null;
         loader = MSP_SWFLoader.RequestLoad(new RawUrl(serverCdnPrefix + modifier.getIconUrl()),iComplete);
         MSP_ToolTipManager.add(loader,LocaleHelper.getInstance().getString(modifier.getResourceId()));
         return loader;
      }
      
      public static function getAutoLoadedIconFlash(param1:IModifier, param2:int, param3:int) : DisplayObject
      {
         var graphicComplete:Function = null;
         var sprite:Sprite = null;
         var modifier:IModifier = param1;
         var width:int = param2;
         var height:int = param3;
         graphicComplete = function(param1:*):void
         {
            var _loc2_:DisplayObject = param1.content;
            _loc2_.scaleX = _loc2_.scaleY = Math.min(width / _loc2_.width,height / _loc2_.height);
            sprite.addChild(_loc2_);
         };
         sprite = new Sprite();
         MSP_SWFLoader.RequestLoad(new RawUrl(serverCdnPrefix + modifier.getIconUrl()),graphicComplete,MSP_LoaderManager.PRIORITY_LOW,true,true);
         MSP_ToolTipManager.add(sprite,LocaleHelper.getInstance().getString(modifier.getResourceId()));
         return sprite;
      }
      
      public static function getAutoloadedIcon(param1:IModifier) : DisplayObject
      {
         var _loc2_:DisplayObject = null;
         _loc2_ = MSP_SWFLoader.RequestLoad(new RawUrl(serverCdnPrefix + param1.getIconUrl()),null);
         MSP_ToolTipManager.add(_loc2_,LocaleHelper.getInstance().getString(param1.getResourceId()));
         _loc2_.x = 45;
         _loc2_.y = 12;
         _loc2_.width = 100 / 2.7;
         _loc2_.height = 84 / 2.7;
         return _loc2_;
      }
      
      public static function applyShoppingSpreeTextFormatToTextField(param1:TextFormat, param2:TextField, param3:Boolean) : void
      {
         var _loc4_:TextFormat = null;
         var _loc5_:IModifier = null;
         if(param3)
         {
            _loc4_ = param2.defaultTextFormat;
            _loc5_ = ShoppingModifiers.getModifier(ShoppingModifiers.MODIFIER_SHOPPING_SPREE);
            _loc4_ = ShoppingModifierUtility.changeFormat(_loc5_,_loc4_);
         }
         else
         {
            _loc4_ = param1;
         }
         param2.setTextFormat(_loc4_);
         param2.defaultTextFormat = _loc4_;
      }
   }
}

