package com.moviestarplanet.utils
{
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.earningutils.service.FameSwitch;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.moviestar.valueObjects.Actor;
   import com.moviestarplanet.moviestar.valueObjects.ActorClothesRel;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.utils.clearInterval;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   import mx.collections.ArrayCollection;
   import mx.controls.Alert;
   import mx.controls.ToolTip;
   import mx.core.IToolTip;
   import mx.core.UIComponent;
   import mx.effects.Rotate;
   import mx.effects.Zoom;
   import mx.effects.easing.Elastic;
   import mx.events.FlexEvent;
   import mx.formatters.CurrencyFormatter;
   import mx.managers.ToolTipManager;
   import mx.utils.Base64Decoder;
   import mx.utils.Base64Encoder;
   
   public class Utils
   {
      
      private static var _base64Encoder:Base64Encoder;
      
      private static var _base64Decoder:Base64Decoder;
      
      private static var _thousandFormatter:CurrencyFormatter;
      
      private static var _thousandDecimalFormatter:CurrencyFormatter;
      
      private static var _logData:Array = new Array();
      
      private static var _lastLogTime:int = 0;
      
      public static var logEnabled:Boolean = false;
      
      public static const CANT_GIVE_ITEM_NO_ITEM:int = 0;
      
      public static const CANT_GIVE_ITEM_SENDER_INVALID_LEVEL:int = 1;
      
      public static const CANT_GIVE_ITEM_LAST_HAIR:int = 2;
      
      public static const CANT_GIVE_ITEM_LAST_TOP:int = 3;
      
      public static const CANT_GIVE_ITEM_LAST_BOTTOM:int = 4;
      
      public static const CANT_GIVE_ITEM_RECEIVER_NOT_VIP:int = 5;
      
      public static const CANT_GIVE_ITEM_RECEIVER_IS_FEMALE:int = 6;
      
      public static const CANT_GIVE_ITEM_RECEIVER_IS_MALE:int = 7;
      
      public static const COLOR_WHAT_ARE_YOU_DOING:Number = 16248770;
      
      private static var rotateEffect:Rotate = new Rotate();
      
      private static var zoomEffect:Zoom = new Zoom();
      
      private static var onlyLettersAndSpace:RegExp = /^[a-zA-ZæøåÆØÅ0-9 ]+$/;
      
      private static var homeUrlRequest:URLRequest = null;
      
      private static const _self:String = "_self";
      
      public function Utils()
      {
         super();
      }
      
      public static function getDirectionAngle(param1:Number, param2:Number) : Number
      {
         var _loc4_:Number = NaN;
         var _loc3_:Number = Number(Math.asin(param2 / Math.sqrt(param2 * param2 + param1 * param1)));
         if(_loc3_ != 0)
         {
            _loc3_ /= 1.57;
         }
         if(param1 > 0)
         {
            _loc4_ = 270 - _loc3_ * 90;
         }
         else
         {
            _loc4_ = 90 + _loc3_ * 90;
         }
         return _loc4_;
      }
      
      public static function log(param1:String) : void
      {
         if(logEnabled == false)
         {
            return;
         }
         var _loc2_:int = int(getTimer());
         _logData.push(_loc2_.toString() + "(" + (_loc2_ - _lastLogTime).toString() + ") : " + param1);
         _lastLogTime = _loc2_;
      }
      
      public static function clearLog() : void
      {
         if(logEnabled == false)
         {
            return;
         }
         _logData = [];
      }
      
      public static function showLog(param1:Boolean = false) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(logEnabled == false)
         {
            return;
         }
         for each(_loc3_ in _logData)
         {
            _loc2_ += _loc3_ + "\n";
         }
         Alert.show(_loc2_,"Log");
         if(param1)
         {
            _logData = [];
         }
      }
      
      public static function CreateQueryParams(param1:String) : String
      {
         var _loc2_:String = "un=" + param1;
         var _loc3_:Base64Encoder = new Base64Encoder();
         _loc3_.encode(_loc2_);
         return _loc3_.toString();
      }
      
      public static function get base64Encoder() : Base64Encoder
      {
         if(_base64Encoder == null)
         {
            _base64Encoder = new Base64Encoder();
         }
         return _base64Encoder;
      }
      
      public static function toBase64(param1:String) : String
      {
         base64Encoder.reset();
         base64Encoder.encode(param1);
         return base64Encoder.toString();
      }
      
      public static function get base64Decoder() : Base64Decoder
      {
         if(_base64Decoder == null)
         {
            _base64Decoder = new Base64Decoder();
         }
         return _base64Decoder;
      }
      
      public static function fromBase64(param1:String) : String
      {
         base64Decoder.reset();
         base64Decoder.decode(param1);
         var _loc2_:String = String(base64Decoder.toByteArray());
         return String(_loc2_);
      }
      
      public static function ShowErrorTip(param1:DisplayObject, param2:String, param3:String = "errorTipBelow") : IToolTip
      {
         var _loc4_:Point = new Point(param1.x,param1.y);
         _loc4_ = DisplayObject(param1.parent).localToGlobal(_loc4_);
         var _loc5_:ToolTip = ToolTipManager.createToolTip(param2,_loc4_.x,_loc4_.y + param1.height,param3) as ToolTip;
         var _loc6_:String = "errorTip";
         _loc5_.scaleX = Main.Instance.mainCanvas.scaleX;
         _loc5_.scaleY = Main.Instance.mainCanvas.scaleX;
         zoomEffect.easingFunction = Elastic.easeOut;
         zoomEffect.duration = 2500;
         zoomEffect.play([_loc5_]);
         return _loc5_;
      }
      
      public static function ShowTipAbove(param1:UIComponent, param2:String, param3:String = "errorTipAbove", param4:Number = 0, param5:Number = 0) : IToolTip
      {
         var _loc6_:Point = new Point(param1.x,param1.y);
         _loc6_ = UIComponent(param1.parent).contentToGlobal(_loc6_);
         var _loc7_:Number = Main.Instance.stage.stageHeight / 720;
         var _loc8_:Main = Main.Instance;
         var _loc9_:ToolTip = ToolTipManager.createToolTip(param2,_loc6_.x + param4 * _loc7_,_loc6_.y - 50 + param5 * _loc7_,param3) as ToolTip;
         if(param3 == "errorTipAboveLeft")
         {
            _loc9_.move(_loc9_.x - _loc9_.width + 21,_loc9_.y);
         }
         _loc9_.scaleX = Main.Instance.mainCanvas.scaleX;
         _loc9_.scaleY = Main.Instance.mainCanvas.scaleX;
         zoomEffect.easingFunction = Elastic.easeOut;
         zoomEffect.duration = 2500;
         zoomEffect.play([_loc9_]);
         return _loc9_;
      }
      
      public static function Assert(param1:Boolean, param2:String = "") : void
      {
         if(!param1)
         {
            Alert.show(param2,"Assertion Failed");
         }
      }
      
      public static function WaitForCompletion(param1:MovieClip, param2:Function, param3:int = 10) : void
      {
         var intervalId:int = 0;
         var setIntervalCallback:Function = null;
         var mc:MovieClip = param1;
         var done:Function = param2;
         var pollInterval:int = param3;
         setIntervalCallback = function():void
         {
            clearInterval(intervalId);
            if(Boolean(IsComplete(mc)))
            {
               done(mc);
            }
            else
            {
               intervalId = setInterval(setIntervalCallback,pollInterval);
            }
         };
         var IsComplete:Function = function(param1:DisplayObjectContainer):Boolean
         {
            var _loc3_:DisplayObject = null;
            var _loc2_:int = 0;
            while(_loc2_ < param1.numChildren)
            {
               _loc3_ = param1.getChildAt(_loc2_);
               if(_loc3_ == null)
               {
                  return false;
               }
               if(_loc3_ is DisplayObjectContainer)
               {
                  if(IsComplete(_loc3_ as DisplayObjectContainer) == false)
                  {
                     return false;
                  }
               }
               _loc2_++;
            }
            return true;
         };
         intervalId = int(setInterval(setIntervalCallback,10));
      }
      
      public static function WaitAll(param1:Array, param2:Function) : void
      {
         var doneCount:int = 0;
         var f:Function = null;
         var countDone:Function = null;
         var functionWithDoneCallBack:Array = param1;
         var allDone:Function = param2;
         countDone = function():void
         {
            ++doneCount;
            if(doneCount == functionWithDoneCallBack.length)
            {
               allDone();
            }
         };
         doneCount = 0;
         for each(f in functionWithDoneCallBack)
         {
            f(countDone);
         }
      }
      
      public static function CallBackSequencer(param1:Function, param2:Array, param3:Function) : void
      {
         var max:int = 0;
         var index:int = 0;
         var Next:Function = null;
         var functionWithCallBackToCall:Function = param1;
         var callParameters:Array = param2;
         var done:Function = param3;
         var Execute:Function = function():void
         {
            if(index < max)
            {
               if(callParameters != null && callParameters[index] != null)
               {
                  functionWithCallBackToCall(callParameters[index],Next);
               }
               else
               {
                  Next();
               }
            }
            else if(done != null)
            {
               done();
            }
         };
         Next = function():void
         {
            ++index;
            Execute();
         };
         max = int(callParameters.length);
         index = 0;
         Execute();
      }
      
      public static function IsNameValid(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         if(param1 != null && param1.length > 0)
         {
            _loc2_ = param1.match(onlyLettersAndSpace);
            if(_loc2_ != null && _loc2_.length == 1)
            {
               return true;
            }
         }
         return false;
      }
      
      private static function get thousandFormatter() : CurrencyFormatter
      {
         if(_thousandFormatter == null)
         {
            _thousandFormatter = new CurrencyFormatter();
            _thousandFormatter.currencySymbol = "";
            _thousandFormatter.decimalSeparatorFrom = ",";
            _thousandFormatter.decimalSeparatorTo = ",";
            _thousandFormatter.thousandsSeparatorFrom = ".";
            _thousandFormatter.thousandsSeparatorTo = ".";
         }
         return _thousandFormatter;
      }
      
      private static function get thousandDecimalFormatter() : CurrencyFormatter
      {
         if(_thousandDecimalFormatter == null)
         {
            _thousandDecimalFormatter = new CurrencyFormatter();
            _thousandDecimalFormatter.currencySymbol = "";
            _thousandDecimalFormatter.decimalSeparatorFrom = ",";
            _thousandDecimalFormatter.decimalSeparatorTo = ",";
            _thousandDecimalFormatter.precision = 2;
            _thousandDecimalFormatter.thousandsSeparatorFrom = ".";
            _thousandDecimalFormatter.thousandsSeparatorTo = ".";
         }
         return _thousandDecimalFormatter;
      }
      
      public static function CenterInParent(param1:UIComponent) : void
      {
         if(param1.parent != null)
         {
            param1.x = param1.parent.width / 2 - param1.width / 2;
            param1.y = param1.parent.height / 2 - param1.height / 2;
         }
      }
      
      public static function ThousandString(param1:Object) : String
      {
         var _loc2_:String = thousandFormatter.format(param1.toString());
         if(_loc2_ == ",0" || _loc2_ == ".0")
         {
            return "0";
         }
         return _loc2_;
      }
      
      public static function ThousandDecimalString(param1:Object) : String
      {
         return thousandDecimalFormatter.format(param1);
      }
      
      public static function extractExtension(param1:String) : String
      {
         var _loc2_:Number = Number(param1.lastIndexOf("."));
         if(_loc2_ == -1)
         {
            return "";
         }
         return param1.substr(_loc2_ + 1,param1.length);
      }
      
      public static function getMSPLogo() : String
      {
         return Config.toAbsoluteURL("img/MSPLogo.png",Config.LOCAL_CDN_URL);
      }
      
      public static function getRandomGiftwrap() : String
      {
         var _loc1_:int = Math.random() * 5 + 1;
         return "Gift_item_" + _loc1_.toString() + ".swf";
      }
      
      public static function getAnimatedGiftwrapPath() : String
      {
         return "swf/gifts/animated/";
      }
      
      public static function getMediumGiftwrapPath() : String
      {
         return "swf/gifts/medium/";
      }
      
      public static function DynTxtFindAndReplace(param1:DisplayObjectContainer, param2:Boolean) : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:Number = NaN;
         var _loc6_:Object = null;
         var _loc7_:DisplayObjectContainer = null;
         var _loc8_:TextField = null;
         if(param1.numChildren > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < param1.numChildren)
            {
               _loc6_ = param1.getChildAt(_loc5_);
               _loc7_ = _loc6_ as DisplayObjectContainer;
               if(_loc7_ != null)
               {
                  DynTxtFindAndReplace(_loc7_,param2);
               }
               else
               {
                  _loc8_ = _loc6_ as TextField;
                  if(_loc8_ != null && _loc8_.name.indexOf("dyntxt") >= 0)
                  {
                     FontManager.remapFonts(_loc8_);
                     _loc8_.mouseEnabled = false;
                     _loc3_ = MSPLocaleManagerWeb.getInstance().getString(_loc8_.name.toUpperCase());
                     if(_loc3_ == null)
                     {
                        _loc3_ = _loc8_.name.toUpperCase();
                     }
                     _loc4_ = _loc3_.split("#");
                     if(_loc4_.length == 2)
                     {
                        _loc8_.autoSize = _loc4_[1] as String;
                     }
                     else
                     {
                        _loc8_.autoSize = "center";
                     }
                     _loc3_ = _loc4_[0] as String;
                     _loc8_.text = _loc3_;
                  }
               }
               _loc5_++;
            }
         }
      }
      
      public static function isItemGiveable(param1:Actor, param2:ActorClothesRel, param3:ArrayCollection) : ValidationResult
      {
         var _loc9_:Boolean = false;
         var _loc10_:ActorClothesRel = null;
         var _loc4_:ValidationResult = new ValidationResult();
         if(null == param2)
         {
            _loc4_.errorMessage = "No item has been selected.";
            _loc4_.addReason(CANT_GIVE_ITEM_NO_ITEM);
            _loc4_.isValid = false;
         }
         var _loc5_:Boolean = param1.isVip;
         var _loc6_:Boolean = ActorSession.loggedInActor.isVip;
         var _loc7_:int = FameSwitch.IsFameOverhaulSwitchOn ? 6 : 3;
         if(false == _loc6_ && ActorSession.loggedInActor.Level < _loc7_)
         {
            _loc4_.errorMessage = "You are not VIP, if you wish to give items while not being VIP you have to be level 3 or higher.";
            _loc4_.addReason(CANT_GIVE_ITEM_SENDER_INVALID_LEVEL);
            _loc4_.isValid = false;
         }
         if(param2.Cloth.ClothesCategory.SlotTypeId >= 1 && param2.Cloth.ClothesCategory.SlotTypeId <= 3)
         {
            _loc9_ = false;
            for each(_loc10_ in param3)
            {
               if(_loc10_.Cloth.ClothesCategory.SlotTypeId == param2.Cloth.ClothesCategory.SlotTypeId && _loc10_ != param2)
               {
                  _loc9_ = true;
                  break;
               }
            }
            if(false == _loc9_)
            {
               switch(param2.Cloth.ClothesCategory.SlotTypeId)
               {
                  case 1:
                     _loc4_.addReason(CANT_GIVE_ITEM_LAST_HAIR);
                     break;
                  case 2:
                     _loc4_.addReason(CANT_GIVE_ITEM_LAST_TOP);
                     break;
                  case 3:
                     _loc4_.addReason(CANT_GIVE_ITEM_LAST_BOTTOM);
               }
               _loc4_.errorMessage = "Cannot trade your last item of that type.";
               _loc4_.isValid = false;
            }
         }
         if(Boolean(param2.Cloth.Vip) && false == _loc5_)
         {
            _loc4_.errorMessage = param1.Name + " is not a VIP and cannot receive VIP items.";
            _loc4_.addReason(CANT_GIVE_ITEM_RECEIVER_NOT_VIP);
            _loc4_.isValid = false;
         }
         var _loc8_:int = param1.SkinSWF == "femaleskin" ? 1 : 2;
         if(param2.Cloth.SkinId != 0 && param2.Cloth.SkinId != _loc8_)
         {
            _loc4_.errorMessage = "Cannot give item because " + param1.Name + " is a ";
            if(1 == _loc8_)
            {
               _loc4_.errorMessage += "female.";
               _loc4_.addReason(CANT_GIVE_ITEM_RECEIVER_IS_FEMALE);
            }
            else
            {
               _loc4_.errorMessage += "male.";
               _loc4_.addReason(CANT_GIVE_ITEM_RECEIVER_IS_MALE);
            }
            _loc4_.isValid = false;
         }
         return _loc4_;
      }
      
      public static function removeExtension(param1:String) : String
      {
         var _loc2_:Number = Number(param1.lastIndexOf("."));
         if(_loc2_ == -1)
         {
            return param1;
         }
         return param1.substr(0,_loc2_);
      }
      
      private static function FindShapeSibling(param1:DisplayObjectContainer) : Shape
      {
         var _loc3_:Shape = null;
         var _loc2_:Number = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc2_) as Shape;
            if(_loc3_ != null)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public static function waitForEvent(param1:EventDispatcher, param2:String, param3:Function, param4:int = 0) : void
      {
         var iComplete:Function = null;
         var dispatcher:EventDispatcher = param1;
         var event:String = param2;
         var callback:Function = param3;
         var priority:int = param4;
         iComplete = function(param1:Event):void
         {
            dispatcher.removeEventListener(event,iComplete);
            callback(param1);
         };
         dispatcher.addEventListener(event,iComplete,false,priority);
      }
      
      public static function waitForComponentCompletion(param1:UIComponent, param2:Function) : void
      {
         var iComplete:Function;
         var component:UIComponent = param1;
         var callback:Function = param2;
         if(component.initialized == false)
         {
            iComplete = function():void
            {
               callback();
            };
            Utils.waitForEvent(component,FlexEvent.CREATION_COMPLETE,iComplete);
         }
         else
         {
            callback();
         }
      }
      
      public static function getClass(param1:Object) : Class
      {
         return Class(getDefinitionByName(getQualifiedClassName(param1)));
      }
   }
}

