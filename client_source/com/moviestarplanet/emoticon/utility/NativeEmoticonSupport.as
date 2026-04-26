package com.moviestarplanet.emoticon.utility
{
   import com.moviestarplanet.analytics.AnalyticsSendEmoticonSelectorCommand;
   import com.moviestarplanet.cache.ObjectPool;
   import com.moviestarplanet.constants.analytics.EmoticonConstants;
   import feathers.controls.TextInput;
   import feathers.events.FeathersEventType;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import starling.events.Event;
   
   public class NativeEmoticonSupport
   {
      
      private static var _instance:NativeEmoticonSupport = null;
      
      private const EMOTICON_TRAIT_1:int = 55357;
      
      private const EMOTICON_TRAIT_2:int = 9786;
      
      private var emoticonMap:Dictionary;
      
      private var cachedEmoticonCharcodes:String;
      
      private var resultPool:ObjectPool;
      
      public function NativeEmoticonSupport(param1:Function = null)
      {
         super();
         if(param1 != singletonBlocker)
         {
            throw new Error("NativeEmoticonSupport is a singleton class, use NativeEmoticonSupport.getInstance() instead!");
         }
         this.initDictionary();
         this.resultPool = new ObjectPool();
         this.resultPool.registerPool(EmoticonConvertResult,0,true);
      }
      
      private static function singletonBlocker() : void
      {
      }
      
      public static function getInstance() : NativeEmoticonSupport
      {
         if(_instance == null)
         {
            _instance = new NativeEmoticonSupport(singletonBlocker);
         }
         return _instance;
      }
      
      public function addSupport(param1:TextField) : void
      {
         param1.addEventListener(FocusEvent.FOCUS_OUT,this.onTextEnteringFinished,false,1,true);
         param1.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false,1,true);
      }
      
      public function removeSupport(param1:TextField) : void
      {
         param1.removeEventListener(FocusEvent.FOCUS_OUT,this.onTextEnteringFinished,false);
         param1.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false);
      }
      
      public function disableNativeEmoticons(param1:TextField) : void
      {
         param1.restrict = String.fromCharCode(32) + "-" + String.fromCharCode(767);
      }
      
      public function addSupportFeathers(param1:TextInput) : void
      {
         param1.addEventListener(FeathersEventType.FOCUS_OUT,this.onTextEnteringFinishedFeathers);
         param1.addEventListener(FeathersEventType.ENTER,this.onTextEnteringFinishedFeathers);
      }
      
      public function removeSupportFeathers(param1:TextInput) : void
      {
         param1.removeEventListener(FeathersEventType.FOCUS_OUT,this.onTextEnteringFinishedFeathers);
         param1.removeEventListener(FeathersEventType.ENTER,this.onTextEnteringFinishedFeathers);
      }
      
      public function disableNativeEmoticonsFeathers(param1:TextInput) : void
      {
         param1.restrict = String.fromCharCode(32) + "-" + String.fromCharCode(767);
      }
      
      public function getEmoticonCharcodesAsString() : String
      {
         var _loc6_:uint = 0;
         if(this.cachedEmoticonCharcodes)
         {
            return this.cachedEmoticonCharcodes;
         }
         var _loc1_:String = "";
         var _loc2_:Vector.<uint> = this.getAllEmoticonChars();
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_.writeUnsignedInt(_loc2_[_loc4_]);
            _loc4_++;
         }
         _loc3_.position = 0;
         var _loc5_:ByteArray = this.convertUTF32ToUTF16(_loc3_);
         _loc5_.position = 0;
         while(_loc5_.bytesAvailable > 0)
         {
            _loc6_ = uint(_loc5_.readInt());
            _loc1_ += String.fromCharCode(_loc6_);
         }
         this.cachedEmoticonCharcodes = _loc1_;
         return _loc1_;
      }
      
      private function convertNativeToMSPEmoticodes(param1:String) : EmoticonConvertResult
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:String = null;
         var _loc2_:EmoticonConvertResult = this.resultPool.getObj(EmoticonConvertResult) as EmoticonConvertResult;
         var _loc5_:String = param1;
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc3_ = uint(_loc5_.charCodeAt(_loc7_));
            if(_loc3_ == this.EMOTICON_TRAIT_1 || _loc3_ == this.EMOTICON_TRAIT_2)
            {
               _loc4_ = uint(_loc5_.charCodeAt(_loc7_));
               _loc4_ = uint(_loc4_ << 16);
               _loc4_ = uint(_loc4_ | _loc5_.charCodeAt(_loc7_ + 1));
               _loc6_ = this.getEmotiCodeMSP(_loc4_);
               _loc5_ = _loc5_.substring(0,_loc7_) + _loc6_ + _loc5_.substring(_loc7_ + 2);
               _loc7_ += _loc6_.length - 1;
               _loc2_.containsEmoticons = true;
            }
            _loc7_++;
         }
         _loc2_.originalText = param1;
         _loc2_.convertedText = _loc5_;
         return _loc2_;
      }
      
      private function getEmotiCodeMSP(param1:uint) : String
      {
         var _loc2_:String = this.emoticonMap[param1];
         if(_loc2_)
         {
            return _loc2_;
         }
         return "";
      }
      
      private function initDictionary() : void
      {
         this.emoticonMap = new Dictionary();
         this.emoticonMap[3627933184] = ":))";
         this.emoticonMap[3627933187] = ":))";
         this.emoticonMap[3627933199] = "(i)";
         this.emoticonMap[3627933190] = ":D";
         this.emoticonMap[3627933189] = ":D";
         this.emoticonMap[3627933186] = ":D";
         this.emoticonMap[3627933188] = ":D";
         this.emoticonMap[641400335] = "|B";
         this.emoticonMap[3627933194] = "|B";
         this.emoticonMap[3627933196] = "|B";
         this.emoticonMap[3627933197] = "(l)";
         this.emoticonMap[3627933212] = ";p";
         this.emoticonMap[3627933195] = ";p";
         this.emoticonMap[3627933193] = ";)";
         this.emoticonMap[3627933213] = ":p";
         this.emoticonMap[3627933211] = ":p";
         this.emoticonMap[3627933208] = "(y)";
         this.emoticonMap[3627933207] = "(y)";
         this.emoticonMap[3627933210] = "(y)";
         this.emoticonMap[3627933209] = "(y)";
         this.emoticonMap[3627933214] = ":(";
         this.emoticonMap[3627933205] = ":s";
         this.emoticonMap[3627933201] = ":s";
         this.emoticonMap[3627933200] = ":s";
         this.emoticonMap[3627933202] = ":^)";
         this.emoticonMap[3627933219] = ":o";
         this.emoticonMap[3627933234] = ":o";
         this.emoticonMap[3627933235] = ":o";
         this.emoticonMap[3627933231] = ":o";
         this.emoticonMap[3627933224] = ":o";
         this.emoticonMap[3627933223] = ":o";
         this.emoticonMap[3627933222] = ":o";
         this.emoticonMap[3627933230] = ":o";
         this.emoticonMap[3627933203] = "\':s";
         this.emoticonMap[3627933204] = ":((";
         this.emoticonMap[3627933215] = ":((";
         this.emoticonMap[3627933218] = ";(";
         this.emoticonMap[3627933221] = ";(";
         this.emoticonMap[3627933226] = ";(";
         this.emoticonMap[3627933232] = ";(";
         this.emoticonMap[3627933185] = ":E(";
         this.emoticonMap[3627933228] = ":E(";
         this.emoticonMap[3627933216] = ":@";
         this.emoticonMap[3627933220] = ":@";
         this.emoticonMap[3627933217] = "X(";
         this.emoticonMap[3627933206] = "X(";
         this.emoticonMap[3627933229] = ":\'(";
         this.emoticonMap[3627933225] = "x-o";
         this.emoticonMap[3627933227] = "x-o";
         this.emoticonMap[3627933233] = "x-o";
         this.emoticonMap[3627933236] = "|)";
         this.emoticonMap[3627933198] = "B))";
         this.emoticonMap[3627933191] = "(a)";
         this.emoticonMap[3627933192] = "(d)";
         this.emoticonMap[3627932799] = "(d)";
      }
      
      private function getAllEmoticonChars() : Vector.<uint>
      {
         return new Vector.<uint>();
      }
      
      private function convertUTF32ToUTF16(param1:ByteArray) : ByteArray
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc2_:ByteArray = new ByteArray();
         while(param1.bytesAvailable > 0)
         {
            _loc3_ = uint(param1.readUnsignedInt());
            _loc5_ = uint(_loc3_ >>> 16);
            _loc3_ <<= 16;
            _loc3_ >>>= 16;
            _loc4_ = _loc3_;
            _loc2_.writeInt(_loc5_);
            _loc2_.writeInt(_loc4_);
         }
         return _loc2_;
      }
      
      private function processAnalytics(param1:EmoticonConvertResult) : void
      {
         var _loc2_:String = null;
         if(param1.containsEmoticons)
         {
            _loc2_ = EmoticonConstants.EMOTICON_SELECTOR + "." + EmoticonConstants.SELECTOR_NATIVE;
            AnalyticsSendEmoticonSelectorCommand.execute(_loc2_);
         }
      }
      
      private function onTextEnteringFinished(param1:flash.events.Event) : void
      {
         var _loc2_:TextField = param1.target as TextField;
         var _loc3_:EmoticonConvertResult = this.convertNativeToMSPEmoticodes(_loc2_.text);
         _loc2_.text = _loc3_.convertedText;
         this.processAnalytics(_loc3_);
         this.resultPool.returnObj(_loc3_);
      }
      
      private function onTextEnteringFinishedFeathers(param1:starling.events.Event) : void
      {
         var _loc2_:TextInput = param1.target as TextInput;
         var _loc3_:EmoticonConvertResult = this.convertNativeToMSPEmoticodes(_loc2_.text);
         _loc2_.text = _loc3_.convertedText;
         this.processAnalytics(_loc3_);
         this.resultPool.returnObj(_loc3_);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            this.onTextEnteringFinished(param1);
         }
      }
   }
}

