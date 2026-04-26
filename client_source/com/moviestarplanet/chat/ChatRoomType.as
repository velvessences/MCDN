package com.moviestarplanet.chat
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.configuration.InputLocations;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.locale.ILocaleManager;
   import com.moviestarplanet.services.worldthemeservice.WorldThemeChatRoomInfo;
   
   public class ChatRoomType
   {
      
      public static var worldThemeRoomInfo:WorldThemeChatRoomInfo;
      
      private static var _allTypes:Array;
      
      private static var _beach:ChatRoomType;
      
      private static var _park:ChatRoomType;
      
      private static var _cafe:ChatRoomType;
      
      private static var _skatepark:ChatRoomType;
      
      private static var _mall:ChatRoomType;
      
      private static var _club:ChatRoomType;
      
      private static var _videoChatroom:ChatRoomType;
      
      private static var _themeRoom:ChatRoomType;
      
      private static var _school:ChatRoomType;
      
      private static const THEMEROOMS_BASE_PATH:String = "graphics/themeRoom/";
      
      [Inject]
      public var _localeManager:ILocaleManager;
      
      private var _ident:String;
      
      private var _locale:String;
      
      private var _background:String;
      
      private var _maxY:int;
      
      private var _minX:int;
      
      private var _roomLocId:int;
      
      public function ChatRoomType(param1:String, param2:String, param3:String, param4:int, param5:int, param6:int, param7:Boolean)
      {
         super();
         InjectionManager.manager().injectMe(this);
         if(param7)
         {
            this._locale = this._localeManager.getString(param2);
         }
         else
         {
            this._locale = param2;
         }
         this._ident = param1;
         this._background = param3;
         this._maxY = param4;
         this._minX = param5;
         this._roomLocId = param6;
      }
      
      public static function getChatType(param1:String) : ChatRoomType
      {
         var _loc2_:ChatRoomType = null;
         for each(_loc2_ in allChatTypes)
         {
            if(param1.indexOf(_loc2_.ident) != -1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private static function get allChatTypes() : Array
      {
         if(_allTypes == null)
         {
            _allTypes = new Array();
            _allTypes.push(BEACH);
            _allTypes.push(PARK);
            _allTypes.push(CAFE);
            _allTypes.push(SKATEPARK);
            _allTypes.push(MALL);
            _allTypes.push(CLUB);
            _allTypes.push(VIDEO_CHATROOM);
            _allTypes.push(THEMEROOM);
            _allTypes.push(SCHOOL);
         }
         return _allTypes;
      }
      
      public static function get BEACH() : ChatRoomType
      {
         if(_beach == null)
         {
            _beach = new ChatRoomType("theBeach","BEACH","graphics/the_Beach_2.swf",300,0,InputLocations.LOC_CHAT_BEACH,true);
         }
         return _beach;
      }
      
      public static function get PARK() : ChatRoomType
      {
         if(_park == null)
         {
            _park = new ChatRoomType("thePark","PET_PARK","graphics/park_1.swf",290,0,InputLocations.LOC_CHAT_PARK,true);
         }
         return _park;
      }
      
      public static function get CAFE() : ChatRoomType
      {
         if(_cafe == null)
         {
            _cafe = new ChatRoomType("theCafe","CAFE","graphics/cafe_1.swf",290,300,InputLocations.LOC_CHAT_CAFE,true);
         }
         return _cafe;
      }
      
      public static function get SKATEPARK() : ChatRoomType
      {
         if(_skatepark == null)
         {
            _skatepark = new ChatRoomType("theSkatePark","SKATE","graphics/skate_2.swf",315,0,InputLocations.LOC_CHAT_SKATE,true);
         }
         return _skatepark;
      }
      
      public static function get MALL() : ChatRoomType
      {
         if(_mall == null)
         {
            _mall = new ChatRoomType("theMall","LEVEL_8_MALL","graphics/ShoppingMall.swf",290,0,InputLocations.LOC_CHAT_MALL,true);
         }
         return _mall;
      }
      
      public static function get CLUB() : ChatRoomType
      {
         if(_club == null)
         {
            _club = new ChatRoomType("theClub","VIP_CLUB","graphics/MSP_Club_1.swf",300,0,InputLocations.LOC_CHAT_CLUB,true);
         }
         return _club;
      }
      
      public static function get VIDEO_CHATROOM() : ChatRoomType
      {
         if(_videoChatroom == null)
         {
            _videoChatroom = new ChatRoomType("videoTop","CINEMA","swf/chat/chatroom/New_YouTube_Chatroom6_2012_ms.swf",290,0,InputLocations.LOC_CHAT_CINEMA,true);
         }
         return _videoChatroom;
      }
      
      public static function get THEMEROOM() : ChatRoomType
      {
         var _loc1_:String = null;
         if(_themeRoom == null)
         {
            if(worldThemeRoomInfo.isDefaultTheme)
            {
               _loc1_ = worldThemeRoomInfo.backgroundFilePath;
            }
            else
            {
               _loc1_ = THEMEROOMS_BASE_PATH + worldThemeRoomInfo.backgroundFilePath;
            }
            _themeRoom = new ChatRoomType("themeRoom",worldThemeRoomInfo.roomName,_loc1_,290,0,InputLocations.LOC_CHAT_THEMEROOM,false);
         }
         return _themeRoom;
      }
      
      public static function get SCHOOL() : ChatRoomType
      {
         if(_school == null)
         {
            _school = new ChatRoomType("theSchool","SCHOOL_YARD","graphics/school_yard.swf",290,0,InputLocations.LOC_CHAT_SCHOOL,true);
         }
         return _school;
      }
      
      public function get ident() : String
      {
         return this._ident;
      }
      
      public function get localeText() : String
      {
         return this._locale;
      }
      
      public function get background() : String
      {
         return this._background;
      }
      
      public function get maxYCord() : int
      {
         return this._maxY;
      }
      
      public function get minXCord() : int
      {
         return this._minX;
      }
      
      public function get roomLocId() : int
      {
         return this._roomLocId;
      }
   }
}

