package com.moviestarplanet.Components.Character
{
   import com.moviestarplanet.activityservice.valueObjects.Todo;
   import com.moviestarplanet.anchorCharacters.AnchorCharacters;
   import com.moviestarplanet.anchorCharacters.valueobjects.AnchorCharacterInfoVO;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.msg.ActionEvent;
   import com.moviestarplanet.msg.events.CareerQuestEvent;
   import com.moviestarplanet.msg.events.CareerQuestsGoToDestinations;
   import com.moviestarplanet.window.stack.WindowStack;
   import com.moviestarplanet.window.stack.WindowStackableInterface;
   import com.moviestarplanet.window.utils.PopupUtils;
   import flash.events.Event;
   import mx.containers.Canvas;
   import mx.controls.Alert;
   import mx.core.UIComponent;
   
   public class CharacterContainer extends Canvas implements WindowStackableInterface
   {
      
      private static var previousCC:CharacterContainer;
      
      public static var todos:Array = new Array();
      
      private static var prevPosX:Number = 235;
      
      private static var prevPosY:Number = 80;
      
      private static var defaultPosX:Number = 235;
      
      private static var defaultPosY:Number = 80;
      
      private static const POPUP_WIDTH:Number = 600;
      
      private static const POPUP_HEIGHT:Number = 400;
      
      private var characterPopUp:CharacterPopUp;
      
      public function CharacterContainer(param1:int)
      {
         var _loc2_:int = 0;
         super();
         if(AnchorCharacters.isSpecialCharacter(param1))
         {
            _loc2_ = AnchorCharacters.getSpecialCharacterInfo(param1).CharacterType;
            if(_loc2_ == AnchorCharacterInfoVO.TYPE_SPONSORED)
            {
               this.characterPopUp = new SponsorCharacterPopup(this);
            }
            else
            {
               this.characterPopUp = new AnchorCharacterPopup(this);
            }
         }
         else
         {
            this.characterPopUp = new CharacterPopUp(this);
         }
         this.characterPopUp.actorId = param1;
      }
      
      public static function addToDo(param1:Todo) : void
      {
         todos.push(param1);
      }
      
      public static function showMyPopUpDefault(param1:int) : void
      {
         showMyPopUp(param1,defaultPosX,defaultPosY);
      }
      
      public static function showMyPopUpPreviousCoords(param1:int) : void
      {
         showMyPopUp(param1,prevPosX,prevPosY);
      }
      
      public static function showMyPopUp(param1:int, param2:Number = 900, param3:Number = 275) : void
      {
         if(previousCC != null)
         {
            PopupUtils.removePopup(previousCC);
         }
         var _loc4_:CharacterContainer = new CharacterContainer(param1);
         previousCC = _loc4_;
         if(ActorSession.getActorId() == param1)
         {
            _loc4_.characterPopUp.vipTier = ActorSession.loggedInActor.VipTier;
            MessageCommunicator.send(new MsgEvent(CareerQuestEvent.USER_CLICKED_BUTTON,CareerQuestsGoToDestinations.MY_MOVIESTAR_CLICKED));
         }
         else
         {
            MessageCommunicator.send(new MsgEvent(CareerQuestEvent.USER_CLICKED_BUTTON,CareerQuestsGoToDestinations.ANOTHER_MOVIESTAR_CLICKED));
         }
         PopupUtils.addPopupUnderMouse(_loc4_,POPUP_WIDTH,POPUP_HEIGHT,null,WindowStack.Z_MSPOPUP);
         var _loc5_:UIComponent = new UIComponent();
         _loc4_.addChild(_loc5_);
         _loc5_.addChild(_loc4_.characterPopUp);
         MessageCommunicator.send(new ActionEvent(ActionEvent.CLICK_MY_PROFILE));
      }
      
      public static function closePreviousPopUp() : void
      {
         if(previousCC != null)
         {
            previousCC.close();
         }
      }
      
      private function onCloseClick(param1:Event) : void
      {
         this.close();
      }
      
      public function close() : void
      {
         PopupUtils.removePopup(this);
      }
      
      public function closeOLD() : void
      {
         WindowStack.removeViewStackable(this);
      }
      
      public function closeWithMessage(param1:String) : void
      {
         Alert.show(param1,"");
      }
   }
}

