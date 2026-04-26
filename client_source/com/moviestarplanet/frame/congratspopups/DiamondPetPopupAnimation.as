package com.moviestarplanet.frame.congratspopups
{
   import com.moviestarplanet.Forms.minigame.queue.RoomRequester;
   import com.moviestarplanet.chat.ChatRoomController;
   import com.moviestarplanet.chat.ChatRoomType;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.flash.components.buttons.ButtonWithFrames;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.pet.valueobjects.ActorClickItemRel;
   import com.moviestarplanet.pets.MyClickItem;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class DiamondPetPopupAnimation extends CongratsPopupAnimation
   {
      
      private var yourRoomButton:ButtonWithFrames;
      
      private var petParkButton:ButtonWithFrames;
      
      public function DiamondPetPopupAnimation(param1:String = "")
      {
         super(param1,500);
      }
      
      override protected function get animationUrl() : String
      {
         return "swf/congrats/LevelUpPetsDiamond.swf";
      }
      
      override protected function get closeButtonPosition() : Point
      {
         return new Point(387,254);
      }
      
      override protected function animationLoaded(param1:MsgEvent) : void
      {
         super.animationLoaded(param1);
         this.yourRoomButton = new ButtonWithFrames(animation.content.YourRoomButton,this.roomButtonClickHandler,true);
         this.petParkButton = new ButtonWithFrames(animation.content.PetParkButton,this.petParkButtonClickHandler,true);
      }
      
      private function roomButtonClickHandler(param1:MouseEvent) : void
      {
         this.close();
         ChatRoomController.showPublicProfile(ActorSession.getActorId(),ActorSession.actorName);
      }
      
      protected function get finalPetClickItemData() : ActorClickItemRel
      {
         throw new Error("Must override this getter and return the final pet ActorClickItemRel in the subclass!");
      }
      
      private function petParkButtonClickHandler(param1:MouseEvent) : void
      {
         var me:MouseEvent = param1;
         this.close();
         MyClickItem.string = this.finalPetClickItemData.ActorClickItemRelId.toString();
         RoomRequester.requestRoom(ChatRoomType.PARK.ident,function(param1:String):void
         {
            ChatRoomController.enterChatRoom(param1);
         },false,"","",true);
      }
      
      override protected function close(param1:MouseEvent = null) : void
      {
         this.yourRoomButton.destroy();
         this.petParkButton.destroy();
         super.close();
      }
   }
}

