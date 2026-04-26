package com.moviestarplanet.emoticon.utility
{
   import com.moviestarplanet.emoticon.EmoticonLibrary;
   import com.moviestarplanet.emoticon.valueobjects.Emoticon;
   import com.moviestarplanet.emoticon.valueobjects.EmoticonPackage;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Rectangle;
   
   public class EmoticonUtility extends EventDispatcher
   {
      
      private static var _instance:EmoticonUtility;
      
      public static const EMOTICON_RETRIEVED:String = "EMOTICON_RETRIEVED";
      
      private const CHARACTERS_THAT_NEED_ESCAPE:Array = ["(",")","|","?","*","^","$"];
      
      private var mAllEmoticons:RegExp;
      
      private var mDisallowedEmoticons:Array;
      
      public var emoticonArray:Vector.<Emoticon>;
      
      public function EmoticonUtility(param1:SingletonBlocker)
      {
         super();
         if(param1 == null)
         {
            throw new Error("EmoticonUtility is a singleton; use \'instance\' instead.");
         }
      }
      
      public static function get instance() : EmoticonUtility
      {
         if(_instance == null)
         {
            _instance = new EmoticonUtility(new SingletonBlocker());
         }
         return _instance;
      }
      
      public function getDisallowedEmoticons(param1:String, param2:Boolean) : Array
      {
         var i:int = 0;
         var vipDetermine:Function = null;
         var extractCharacters:Function = null;
         var extractDefinitions:Function = null;
         var availablePackages:Array = null;
         var ownedDefinitions:Array = null;
         var availableEmoticons:Array = null;
         var ownedEmoticons:Array = null;
         var matches:Array = null;
         var nonOwnedCharSequences:Array = null;
         var text:String = param1;
         var isVip:Boolean = param2;
         vipDetermine = function(param1:*, param2:int, param3:Array):Boolean
         {
            var _loc4_:Emoticon = param1 as Emoticon;
            if(_loc4_.VipRequired == false)
            {
               return true;
            }
            return isVip;
         };
         extractCharacters = function(param1:Emoticon, param2:int, param3:Array):String
         {
            return param1.CharSequence;
         };
         extractDefinitions = function(param1:*, param2:int, param3:Array):Array
         {
            return (param1 as EmoticonPackage).emoticons;
         };
         var ownedEmoticonCharacters:Array = [];
         if(!this.mDisallowedEmoticons || EmoticonLibrary.getInstance().getEmoticonPackages().length != this.mDisallowedEmoticons.length)
         {
            availablePackages = EmoticonLibrary.getInstance().getEmoticonPackages();
            ownedDefinitions = availablePackages.filter(this.hasPurchased);
            availableEmoticons = ownedDefinitions.map(extractDefinitions);
            ownedEmoticons = new Array();
            i = 0;
            while(i < availableEmoticons.length)
            {
               ownedEmoticons = ownedEmoticons.concat(availableEmoticons[i]);
               i++;
            }
            if(isVip == false)
            {
               ownedEmoticons = ownedEmoticons.filter(vipDetermine);
            }
            ownedEmoticonCharacters = ownedEmoticons.map(extractCharacters);
            matches = text.match(this.allEmoticonsExpression());
            nonOwnedCharSequences = new Array();
            i = 0;
            while(i < matches.length)
            {
               if(ownedEmoticonCharacters.indexOf(matches[i]) < 0)
               {
                  nonOwnedCharSequences.push(matches[i]);
               }
               i++;
            }
            this.mDisallowedEmoticons = nonOwnedCharSequences;
         }
         return this.mDisallowedEmoticons;
      }
      
      public function removeDisallowedEmoticons(param1:String, param2:Boolean) : String
      {
         var _loc3_:String = param1;
         var _loc4_:Array = this.getDisallowedEmoticons(param1,param2);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc3_ = _loc3_.replace(_loc4_[_loc5_],"");
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function getEmoticonPackageFromCharacters(param1:String) : EmoticonPackage
      {
         var _loc4_:EmoticonPackage = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:Emoticon = null;
         var _loc2_:Array = EmoticonLibrary.getInstance().getEmoticonPackages();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            _loc5_ = _loc4_.emoticons;
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               _loc7_ = _loc5_[_loc6_];
               if(_loc7_.CharSequence == param1)
               {
                  return _loc4_;
               }
               _loc6_++;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getEmoticonFromCharacters(param1:String) : Emoticon
      {
         var _loc3_:Emoticon = null;
         var _loc2_:EmoticonPackage = this.getEmoticonPackageFromCharacters(param1);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.emoticons.length)
         {
            _loc3_ = _loc2_.emoticons[_loc4_];
            if(_loc3_.CharSequence == param1)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getEmoticonPackageFromId(param1:String) : EmoticonPackage
      {
         var _loc3_:EmoticonPackage = null;
         var _loc2_:Array = EmoticonLibrary.getInstance().getEmoticonPackages();
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_];
            if(_loc3_.emoticonPackageId == param1)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function createDisplayObjectFromSymbol(param1:String, param2:Number) : DisplayObject
      {
         var emoticonContainer:Sprite = null;
         var doneLoadingSprite:Function = null;
         var symbol:String = param1;
         var size:Number = param2;
         doneLoadingSprite = function(param1:Sprite):void
         {
            emoticonContainer.addChild(param1);
            dispatchEvent(new Event(EMOTICON_RETRIEVED));
         };
         emoticonContainer = new EmoticonSprite(size,size);
         EmoticonLibrary.getInstance().loadEmoticonSprite(symbol,doneLoadingSprite);
         return emoticonContainer;
      }
      
      public function createDisplayObjectFromCharacterSequence(param1:String, param2:Number) : DisplayObject
      {
         var _loc5_:EmoticonPackage = null;
         var _loc6_:int = 0;
         var _loc7_:Emoticon = null;
         var _loc3_:Array = EmoticonLibrary.getInstance().getEmoticonPackages();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc4_] as EmoticonPackage;
            _loc6_ = 0;
            while(_loc6_ < _loc5_.emoticons.length)
            {
               _loc7_ = _loc5_.emoticons[_loc6_];
               if(_loc7_.CharSequence == param1)
               {
                  return this.createDisplayObjectFromSymbol(_loc7_.Symbol,param2);
               }
               _loc6_++;
            }
            _loc4_++;
         }
         return new Sprite();
      }
      
      public function getEmoticonPackageFromSymbolName(param1:String) : EmoticonPackage
      {
         var _loc3_:EmoticonPackage = null;
         var _loc4_:Emoticon = null;
         var _loc6_:int = 0;
         var _loc2_:Array = EmoticonLibrary.getInstance().getEmoticonPackages();
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc5_] as EmoticonPackage;
            _loc6_ = 0;
            while(_loc6_ < _loc3_.emoticons.length)
            {
               _loc4_ = _loc3_.emoticons[_loc6_];
               if(_loc4_.Symbol == param1)
               {
                  return _loc3_;
               }
               _loc6_++;
            }
            _loc5_++;
         }
         return null;
      }
      
      public function getBoundingBox(param1:Sprite) : Rectangle
      {
         var _loc2_:DisplayObject = null;
         if(param1.getChildByName("boundingbox"))
         {
            _loc2_ = param1.getChildByName("boundingbox");
            return new Rectangle(_loc2_.x,_loc2_.y,_loc2_.width,_loc2_.height);
         }
         return new Rectangle(param1.x,param1.y,param1.width,param1.height);
      }
      
      public function allEmoticonsCharacters() : Array
      {
         var extractDefinitions:Function = null;
         var extractCharSequence:Function = null;
         extractDefinitions = function(param1:*, param2:int, param3:Array):Array
         {
            return (param1 as EmoticonPackage).emoticons;
         };
         extractCharSequence = function(param1:Emoticon, param2:int, param3:Array):String
         {
            return param1.CharSequence;
         };
         var availablePackages:Array = EmoticonLibrary.getInstance().getEmoticonPackages();
         var availableEmoticons:Array = availablePackages.map(extractDefinitions);
         var fullEmoticons:Array = new Array();
         var i:int = 0;
         while(i < availableEmoticons.length)
         {
            fullEmoticons = fullEmoticons.concat(availableEmoticons[i]);
            i++;
         }
         return fullEmoticons.map(extractCharSequence);
      }
      
      public function allEmoticonsExpression() : RegExp
      {
         var sortDefinitions:Function = null;
         var extractDefinitions:Function = null;
         var extractCharSequence:Function = null;
         var availablePackages:Array = null;
         var availableEmoticons:Array = null;
         var fullEmoticons:Array = null;
         var i:int = 0;
         sortDefinitions = function(param1:Emoticon, param2:Emoticon):Number
         {
            return param2.CharSequence.length - param1.CharSequence.length;
         };
         extractDefinitions = function(param1:*, param2:int, param3:Array):Array
         {
            return (param1 as EmoticonPackage).emoticons;
         };
         extractCharSequence = function(param1:Emoticon, param2:int, param3:Array):String
         {
            var _loc4_:String = param1.CharSequence;
            var _loc5_:int = 0;
            while(_loc5_ < CHARACTERS_THAT_NEED_ESCAPE.length)
            {
               _loc4_ = _loc4_.split(CHARACTERS_THAT_NEED_ESCAPE[_loc5_]).join(String.fromCharCode(92) + CHARACTERS_THAT_NEED_ESCAPE[_loc5_]);
               _loc5_++;
            }
            return _loc4_;
         };
         if(this.mAllEmoticons == null)
         {
            availablePackages = EmoticonLibrary.getInstance().getEmoticonPackages();
            if(availablePackages != null)
            {
               availableEmoticons = availablePackages.map(extractDefinitions);
               fullEmoticons = new Array();
               i = 0;
               while(i < availableEmoticons.length)
               {
                  fullEmoticons = fullEmoticons.concat(availableEmoticons[i]);
                  i++;
               }
               this.mAllEmoticons = new RegExp(fullEmoticons.sort(sortDefinitions).map(extractCharSequence).join("|"),"g");
            }
            else
            {
               trace("EmoticonUtility.allEmoticonsExpression() availablePackages is null");
            }
            this.emoticonArray = Vector.<Emoticon>(fullEmoticons);
         }
         return this.mAllEmoticons;
      }
      
      private function hasPurchased(param1:Object, param2:int, param3:Array) : Boolean
      {
         var _loc6_:EmoticonPackage = null;
         var _loc4_:Array = EmoticonLibrary.getInstance().getEmoticonPackages();
         var _loc5_:EmoticonPackage = param1 as EmoticonPackage;
         var _loc7_:int = 0;
         while(_loc7_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc7_] as EmoticonPackage;
            if(_loc5_.emoticonPackageId == _loc6_.emoticonPackageId)
            {
               return _loc6_.hasPurchased;
            }
            _loc7_++;
         }
         return false;
      }
      
      public function isBigEmoticon(param1:String) : Boolean
      {
         var _loc3_:RegExp = null;
         var _loc2_:String = String.fromCharCode(29);
         if(param1 != null && param1.indexOf(_loc2_) == 0 && (param1.indexOf(_loc2_,2) == param1.length - 1 || param1.indexOf(_loc2_,2) == param1.length - 2))
         {
            _loc3_ = /^\(.+\)$/;
            return Boolean(_loc3_.test(param1.substr(1,param1.length - 2))) || Boolean(_loc3_.test(param1.substr(2,param1.length - 4)));
         }
         return false;
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
