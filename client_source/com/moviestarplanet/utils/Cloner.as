package com.moviestarplanet.utils
{
   import flash.geom.Transform;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   
   public class Cloner
   {
      
      public function Cloner()
      {
         super();
      }
      
      public static function clone(param1:*) : *
      {
         var _loc2_:* = ClassesUtils.getClassName(param1);
         var _loc3_:Object = getByteArray(param1);
         switch(_loc2_)
         {
            case "TextFormat":
            default:
               _loc3_ = parseFormat(_loc3_);
               break;
            case "TextField":
               _loc3_ = parseTextField(_loc3_,param1);
         }
         return _loc3_;
      }
      
      private static function getByteArray(param1:Object) : *
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      private static function parseFormat(param1:*) : TextFormat
      {
         var _loc3_:String = null;
         var _loc2_:TextFormat = new TextFormat();
         for(_loc3_ in param1)
         {
            _loc2_[_loc3_] = param1[_loc3_];
         }
         return _loc2_;
      }
      
      private static function parseTextField(param1:Object, param2:TextField) : TextField
      {
         var prop:String = null;
         var _obj:Object = param1;
         var o:TextField = param2;
         var _textField:TextField = new TextField();
         for(prop in _obj)
         {
            if(prop == "transform")
            {
               _textField[prop] = new Transform(o);
            }
            else
            {
               if(prop != "defaultTextFormat")
               {
                  try
                  {
                     _textField[prop] = _obj[prop];
                  }
                  catch(err:Error)
                  {
                     trace("Error Hit: " + err);
                  }
                  continue;
               }
               _textField[prop] = parseFormat(_obj[prop]);
            }
         }
         return _textField;
      }
      
      public static function cloneSimple(param1:Object) : *
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
   }
}

