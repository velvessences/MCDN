package com.moviestarplanet.Forms.world.elements
{
   import com.moviestarplanet.Forms.minigame.queue.RoomRequester;
   import com.moviestarplanet.access.perform.AccessPerformer;
   import com.moviestarplanet.access.restriction.AccessRestrictor;
   import com.moviestarplanet.chat.ChatRoomController;
   import com.moviestarplanet.chat.ChatRoomType;
   import com.moviestarplanet.earningutils.service.FameSwitch;
   
   public class ChatElement extends BaseWorldElement
   {
      
      private static var _allItems:Array;
      
      private static var _beach:ChatElement;
      
      private static var _cinema:ChatElement;
      
      private static var _cafe:ChatElement;
      
      private static var _mall:ChatElement;
      
      private static var _skatepark:ChatElement;
      
      private static var _park:ChatElement;
      
      private static var _club:ChatElement;
      
      private static var _themeRoom:ChatElement;
      
      private static var _school:ChatElement;
      
      private var accessRestrictor:AccessRestrictor;
      
      private var accessPerformer:AccessPerformer;
      
      private var _roomType:ChatRoomType;
      
      private var _chatRoomTypeStr:String;
      
      public function ChatElement(param1:String, param2:String, param3:String, param4:ChatRoomType, param5:Boolean = true)
      {
         super(param1,param2,param5);
         this.accessRestrictor = new AccessRestrictor();
         this.accessPerformer = new AccessPerformer();
         this._chatRoomTypeStr = param3;
         this._roomType = param4;
      }
      
      public static function get allItems() : Array
      {
         if(_allItems == null)
         {
            _allItems = new Array();
            _allItems.push(BEACH);
            _allItems.push(CINEMA);
            _allItems.push(CAFE);
            _allItems.push(MALL);
            _allItems.push(SKATEPARK);
            _allItems.push(THEMEROOM);
            _allItems.push(PARK);
            _allItems.push(CLUB);
         }
         return _allItems;
      }
      
      public static function get BEACH() : ChatElement
      {
         if(_beach == null)
         {
            _beach = new ChatElement("BEACH","beach",ChatRoomType.BEACH.ident,ChatRoomType.BEACH);
         }
         return _beach;
      }
      
      public static function get CINEMA() : ChatElement
      {
         if(_cinema == null)
         {
            _cinema = new ChatElement("CINEMA","cinema",ChatRoomType.VIDEO_CHATROOM.ident,ChatRoomType.VIDEO_CHATROOM);
         }
         return _cinema;
      }
      
      public static function get CAFE() : ChatElement
      {
         if(_cafe == null)
         {
            _cafe = new ChatElement("CAFE","cafe",ChatRoomType.CAFE.ident,ChatRoomType.CAFE);
         }
         return _cafe;
      }
      
      public static function get MALL() : ChatElement
      {
         if(_mall == null)
         {
            _mall = new ChatElement(FameSwitch.IsFameOverhaulSwitchOn ? "NEW_LEVEL_5_MALL" : "LEVEL_5_MALL","mall",ChatRoomType.MALL.ident,ChatRoomType.MALL);
         }
         return _mall;
      }
      
      public static function get SKATEPARK() : ChatElement
      {
         if(_skatepark == null)
         {
            _skatepark = new ChatElement("DYNTXT_LAYOUT_BUTTONS_SKATEPARK","skatePark",ChatRoomType.SKATEPARK.ident,ChatRoomType.SKATEPARK);
         }
         return _skatepark;
      }
      
      public static function get PARK() : ChatElement
      {
         if(_park == null)
         {
            _park = new ChatElement("PET_PARK","park",ChatRoomType.PARK.ident,ChatRoomType.PARK);
         }
         return _park;
      }
      
      public static function get CLUB() : ChatElement
      {
         if(_club == null)
         {
            _club = new ChatElement("VIP_CLUB","club",ChatRoomType.CLUB.ident,ChatRoomType.CLUB);
         }
         return _club;
      }
      
      public static function get THEMEROOM() : ChatElement
      {
         if(_themeRoom == null)
         {
            _themeRoom = new ChatElement(ChatRoomType.worldThemeRoomInfo.roomName,"school",ChatRoomType.THEMEROOM.ident,ChatRoomType.THEMEROOM,false);
         }
         return _themeRoom;
      }
      
      public static function get SCHOOL() : ChatElement
      {
         if(_school == null)
         {
            _school = new ChatElement("SCHOOL_YARD","school",ChatRoomType.SCHOOL.ident,ChatRoomType.SCHOOL);
         }
         return _school;
      }
      
      override public function enter() : void
      {
         if(CINEMA == this)
         {
            if(false == this.accessRestrictor.youtubeRestrictions())
            {
               this.accessPerformer.youtubePerform();
               return;
            }
         }
         RoomRequester.requestRoom(this._roomType.ident,function(param1:String):void
         {
            ChatRoomController.enterChatRoom(param1);
         });
      }
   }
}

