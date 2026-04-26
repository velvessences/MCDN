package com.moviestarplanet.emoticon.selector
{
   import com.moviestarplanet.window.utils.PopupUtils;
   import flash.display.DisplayObjectContainer;
   import flash.utils.Dictionary;
   import mx.core.UIComponent;
   
   public class EmoticonSelectorControllerWeb
   {
      
      private static var viewToContainer:Dictionary = new Dictionary(true);
      
      public function EmoticonSelectorControllerWeb()
      {
         super();
      }
      
      public static function OpenEmoticonSelector(param1:DisplayObjectContainer, param2:Number, param3:Number, param4:Function, param5:int = 1, param6:Boolean = false) : void
      {
         var _loc9_:UIComponent = null;
         var _loc7_:EmoticonSelectorModelWeb = new EmoticonSelectorModelWeb(param4);
         var _loc8_:EmoticonSelectorViewWeb = new EmoticonSelectorViewWeb(_loc7_,param6);
         viewToContainer[_loc8_] = param1;
         if(param1 is UIComponent)
         {
            _loc9_ = new UIComponent();
            _loc9_.addChild(_loc8_);
            _loc9_.height = _loc8_.height;
            _loc9_.width = _loc8_.width;
            param1.addChild(_loc9_);
            PopupUtils.positionInQuadrant(_loc8_,param1,param2,param3,param5);
         }
         else
         {
            param1.addChild(_loc8_);
            PopupUtils.positionInQuadrant(_loc8_,param1,param2,param3,param5);
         }
      }
      
      public static function CloseEmoticonSelector(param1:EmoticonSelectorViewWeb) : void
      {
         var _loc2_:DisplayObjectContainer = viewToContainer[param1];
         if(_loc2_ is UIComponent)
         {
            _loc2_.removeChild(param1.parent);
         }
         else
         {
            _loc2_.removeChild(param1);
         }
      }
   }
}

