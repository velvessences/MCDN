package com.moviestarplanet.Forms.world.elements
{
   import com.moviestarplanet.Forms.world.MapHolder;
   import com.moviestarplanet.constants.world.WorldAreaWebConstants;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.msg.AreaEvent;
   import com.moviestarplanet.msg.events.CareerQuestEvent;
   import com.moviestarplanet.msg.events.CareerQuestsGoToDestinations;
   import com.moviestarplanet.popup.OldPopupHandler;
   import com.moviestarplanet.quest.gifthunt.GiftHuntAreas;
   import com.moviestarplanet.services.worldthemeservice.WorldAreaSwf;
   import com.moviestarplanet.utils.loader.ContentUrl;
   import com.moviestarplanet.window.stack.WindowStack;
   import com.moviestarplanet.worldscreen.IWorldArea;
   import mx.styles.CSSStyleDeclaration;
   
   public class WorldArea extends BaseWorldElement implements IWorldArea
   {
      
      public static var GAMES:WorldArea;
      
      public static var CHAT:WorldArea;
      
      public static var CREATIVE:WorldArea;
      
      public static var SHOPPING:WorldArea;
      
      public static var PETS:WorldArea;
      
      public static var OVERVIEW:WorldArea;
      
      public static var BACKGROUND_SWF_PATH:String;
      
      public static var LOGO_SWF_PATH:String;
      
      public static var creativeSWFFileName:String;
      
      public static const THEME_ELEMENT_MSP_LOGO:String = "mspLogo";
      
      public static var theme:CSSStyleDeclaration = null;
      
      private static var worldItems:Array = [];
      
      private var _subAreas:Array;
      
      private var _swfName:String;
      
      private var _areaType:int;
      
      public function WorldArea(param1:String, param2:String, param3:String, param4:Array, param5:int)
      {
         super(param1,param2);
         worldItems.push(this);
         this._swfName = param3;
         this._subAreas = param4;
         this._areaType = param5;
      }
      
      public static function get allWorldElements() : Array
      {
         var _loc1_:Array = [];
         return _loc1_.concat(worldItems);
      }
      
      public static function initWorldAreas(param1:Array) : void
      {
         var _loc2_:WorldAreaSwf = null;
         var _loc3_:WorldAreaSwf = null;
         for each(_loc2_ in param1)
         {
            switch(_loc2_.AreaName)
            {
               case WorldAreaSwf.CHAT:
                  CHAT = new WorldArea("DYNTXT_LAYOUT_BUTTONS_CHAT","chat",_loc2_.SwfPath,ChatElement.allItems,GiftHuntAreas.GIFT_AREA_WEB_WORLDSCREEN_CHAT);
                  break;
               case WorldAreaSwf.GAMES:
                  GAMES = new WorldArea("DYNTXT_LAYOUT_BUTTONS_GAMES","games",_loc2_.SwfPath,MiniGameType.allMiningameTypes,GiftHuntAreas.GIFT_AREA_WEB_WORLDSCREEN_GAMES);
                  break;
               case WorldAreaSwf.CREATIVE:
                  creativeSWFFileName = _loc2_.SwfPath;
                  CREATIVE = new WorldArea("DYNTXT_LAYOUT_BUTTONS_CREATIVE","creative",_loc2_.SwfPath,CreativeElement.allItems,GiftHuntAreas.GIFT_AREA_WEB_WORLDSCREEN_CREATIVE);
                  break;
               case WorldAreaSwf.SHOPPING:
                  SHOPPING = new WorldArea("DYNTXT_LAYOUT_BUTTONS_SHOPPING","shopping",_loc2_.SwfPath,ShoppingElement.allItems,GiftHuntAreas.GIFT_AREA_WEB_WORLDSCREEN_SHOPPING);
                  break;
               case WorldAreaSwf.PETS:
                  PETS = new WorldArea("PETS","pets",_loc2_.SwfPath,PetElement.allItems,GiftHuntAreas.GIFT_AREA_WEB_WORLDSCREEN_PETS);
                  break;
               case WorldAreaSwf.BACKGROUND:
                  BACKGROUND_SWF_PATH = new ContentUrl(_loc2_.SwfPath,ContentUrl.WORLD).toString();
                  break;
               case WorldAreaSwf.LOGO:
                  LOGO_SWF_PATH = new ContentUrl(_loc2_.SwfPath,ContentUrl.WORLD).toString();
            }
            InjectionManager.mapper().map(IWorldArea).toValue(CHAT);
         }
         for each(_loc3_ in param1)
         {
            if(_loc3_.AreaName == WorldAreaSwf.OVERVIEW)
            {
               OVERVIEW = new WorldArea("","",_loc3_.SwfPath,allWorldElements,GiftHuntAreas.GIFT_AREA_WEB_WORLDSCREEN_OVERVIEW);
            }
         }
      }
      
      public static function showWorldArea(param1:WorldArea = null) : void
      {
         WindowStack.clearViewStack();
         OldPopupHandler.getInstance().closeMainPopup();
         var _loc2_:MapHolder = Main.Instance.mainCanvas.mapArea;
         _loc2_.width = 1000;
         _loc2_.height = 600;
         _loc2_.x = 235;
         _loc2_.y = 80;
         _loc2_.show(param1);
         MessageCommunicator.send(new AreaEvent(AreaEvent.WORLD_AREA_SHOWN,param1));
         if(param1 == WorldArea.GAMES)
         {
            MessageCommunicator.send(new MsgEvent(CareerQuestEvent.USER_CLICKED_BUTTON,CareerQuestsGoToDestinations.ENTER_GAMES));
            MessageCommunicator.send(new AreaEvent(AreaEvent.WORLD_GAME));
         }
         else if(param1 == WorldArea.CHAT)
         {
            MessageCommunicator.send(new MsgEvent(CareerQuestEvent.USER_CLICKED_BUTTON,CareerQuestsGoToDestinations.CHAT_AREA));
            MessageCommunicator.send(new AreaEvent(AreaEvent.WORLD_CHAT));
         }
         else if(param1 == WorldArea.CREATIVE)
         {
            MessageCommunicator.send(new AreaEvent(AreaEvent.WORLD_CREATIVE));
         }
         else if(param1 == WorldArea.SHOPPING)
         {
            MessageCommunicator.send(new AreaEvent(AreaEvent.WORLD_SHOPPING));
         }
         if(param1 != null)
         {
            Main.Instance.mainCanvas.applicationViewStack.mainView.christmasContainer.visible = param1 == WorldArea.OVERVIEW;
         }
      }
      
      public function getWorldAreaFromId(param1:int) : IWorldArea
      {
         switch(param1)
         {
            case WorldAreaWebConstants.ID_CHAT:
               return CHAT;
            case WorldAreaWebConstants.ID_CREATIVE:
               return CREATIVE;
            case WorldAreaWebConstants.ID_GAMES:
               return GAMES;
            case WorldAreaWebConstants.ID_OVERVIEW:
               return OVERVIEW;
            case WorldAreaWebConstants.ID_PETS:
               return PETS;
            case WorldAreaWebConstants.ID_SHOPPING:
               return SHOPPING;
            default:
               return null;
         }
      }
      
      override public function enter() : void
      {
         showWorldArea(this);
      }
      
      public function get swfFileName() : String
      {
         return this._swfName;
      }
      
      public function getSubAreas() : Array
      {
         return this._subAreas;
      }
      
      public function get areaType() : int
      {
         return this._areaType;
      }
   }
}

