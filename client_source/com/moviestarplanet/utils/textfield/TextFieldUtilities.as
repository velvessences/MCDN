package com.moviestarplanet.utils.textfield
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.getQualifiedClassName;
   
   public class TextFieldUtilities
   {
      
      private static var _tmpOriginalSelectedValue:Boolean;
      
      public function TextFieldUtilities()
      {
         super();
         throw new Error("Do not instantiate " + getQualifiedClassName(this));
      }
      
      public static function truncateLines(param1:TextField, param2:int, param3:String = "...") : void
      {
         var _loc4_:int = 0;
         if(param1.numLines > param2)
         {
            _loc4_ = param1.getLineOffset(param2) - 1;
            _loc4_ = _loc4_ - param3.length;
            _loc4_ = int(param1.text.substring(0,_loc4_ + 1).search(/\S\s*$/));
            param1.text = param1.text.substring(0,_loc4_) + param3;
         }
      }
      
      public static function truncateLen(param1:TextField, param2:int, param3:String = "...") : void
      {
         if(param1.text.length > param2)
         {
            param1.text = param1.text.substring(0,param2 - param3.length) + param3;
         }
      }
      
      public static function setBold(param1:Array) : void
      {
         var _loc2_:TextField = null;
         var _loc3_:TextFormat = null;
         for each(_loc2_ in param1)
         {
            _loc3_ = _loc2_.defaultTextFormat;
            _loc3_.bold = true;
            _loc2_.defaultTextFormat = _loc3_;
         }
      }
      
      public static function interactiveTextField(param1:TextField, param2:uint) : void
      {
         var hasinput:Boolean = false;
         var originalText:String = null;
         var originalTextFormat:TextFormat = null;
         var originalFocus:InteractiveObject = null;
         var focusoutRef:Function = null;
         var focusinRef:Function = null;
         var removedRef:Function = null;
         var removed:Function = null;
         var focusout:Function = null;
         var focusin:Function = null;
         var tf:TextField = param1;
         var focusColor:uint = param2;
         removed = function(param1:Event):void
         {
            tf.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,focusoutRef);
            tf.removeEventListener(MouseEvent.CLICK,focusinRef);
            tf.removeEventListener(Event.REMOVED_FROM_STAGE,removedRef);
         };
         focusout = function(param1:Event):void
         {
            var _loc2_:String = tf.text;
            if(_loc2_ == null || _loc2_.length <= 0)
            {
               hasinput = false;
               tf.text = originalText;
               tf.stage.focus = originalFocus;
               tf.defaultTextFormat = originalTextFormat;
               tf.setTextFormat(originalTextFormat);
            }
         };
         focusin = function(param1:Event):void
         {
            if(hasinput == false)
            {
               hasinput = true;
               tf.text = "";
               tf.defaultTextFormat = new TextFormat(null,null,focusColor);
               tf.setTextFormat(new TextFormat(null,null,focusColor));
            }
         };
         hasinput = false;
         originalText = tf.text;
         originalTextFormat = tf.getTextFormat();
         originalFocus = tf.stage ? tf.stage.focus : null;
         focusoutRef = focusout;
         focusinRef = focusin;
         removedRef = removed;
         tf.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,focusoutRef);
         tf.addEventListener(MouseEvent.CLICK,focusinRef);
         tf.addEventListener(Event.REMOVED_FROM_STAGE,removedRef);
      }
      
      public static function truncateExcessiveLineBreaks(param1:TextField) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = param1.text;
         do
         {
            _loc3_ = _loc2_;
            _loc2_ = _loc3_.replace("\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r","\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r");
         }
         while(_loc3_ != _loc2_);
         param1.text = _loc2_;
      }
      
      public static function fixPolishCharIssue(param1:Object) : void
      {
         if(param1.hasOwnProperty("selectable"))
         {
            param1.addEventListener(KeyboardEvent.KEY_DOWN,polishKeyDownListener,false,-1,true);
            param1.addEventListener(KeyboardEvent.KEY_UP,polishKeyUpListener,false,1,true);
         }
      }
      
      private static function polishKeyDownListener(param1:KeyboardEvent) : void
      {
         var _loc2_:Object = param1.currentTarget as Object;
         if(param1.altKey)
         {
            _tmpOriginalSelectedValue = _loc2_.selectable;
            _loc2_.selectable = false;
         }
      }
      
      private static function polishKeyUpListener(param1:KeyboardEvent) : void
      {
         var _loc2_:Object = param1.currentTarget as Object;
         if(param1.altKey)
         {
            _loc2_.selectable = _tmpOriginalSelectedValue;
         }
      }
      
      public static function autoResizeText(param1:TextField, param2:int = 0, param3:int = 0) : void
      {
         var _loc6_:Number = NaN;
         var _loc4_:Number = 3;
         var _loc5_:TextFormat = param1.getTextFormat();
         var _loc7_:Boolean = Boolean(param1.multiline);
         var _loc8_:Number = param1.height - param2;
         var _loc9_:Number = param1.width - param3;
         if(_loc5_.align == TextFormatAlign.CENTER)
         {
            param1.autoSize = TextFieldAutoSize.CENTER;
         }
         else if(_loc5_.align == TextFormatAlign.RIGHT)
         {
            param1.autoSize = TextFieldAutoSize.RIGHT;
         }
         else
         {
            param1.autoSize = TextFieldAutoSize.LEFT;
         }
         if(_loc5_ == null)
         {
            _loc6_ = 100;
            _loc5_ = new TextFormat();
         }
         else
         {
            _loc6_ = _loc5_.size ? Number(_loc5_.size as int) : 12;
         }
         while(_loc6_ > _loc4_)
         {
            _loc5_.size = _loc6_;
            param1.setTextFormat(_loc5_);
            if(_loc7_ && param1.textHeight <= _loc8_)
            {
               break;
            }
            if(!_loc7_ && param1.textWidth <= _loc9_)
            {
               break;
            }
            _loc6_--;
         }
      }
   }
}

