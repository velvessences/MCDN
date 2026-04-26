package com.moviestarplanet.utils.ui
{
   import com.moviestarplanet.Components.Character.CharacterContainer;
   import com.moviestarplanet.Forms.GamesManager;
   import com.moviestarplanet.anchorCharacters.AnchorActivityManager;
   import com.moviestarplanet.chat.ChatRoomController;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.moviestar.MovieStar;
   import com.moviestarplanet.moviestar.MovieStarInterface;
   import com.moviestarplanet.moviestar.badge.MobileBadge;
   
   public class MovieStarOperator
   {
      
      public function MovieStarOperator()
      {
         super();
      }
      
      public static function wireup() : void
      {
         MessageCommunicator.subscribe(MSPEvent.MOVIESTAR_CLICKED,onMoviestarClick);
      }
      
      private static function onMoviestarClick(param1:MsgEvent) : void
      {
         var _loc3_:MovieStar = null;
         var _loc4_:Boolean = false;
         var _loc2_:MovieStarInterface = param1.data;
         if(!_loc2_.movieStarPopupEnabled || ChatRoomController.isPlayingChatroomGame || !AnchorActivityManager.isAnchorAdded)
         {
            return;
         }
         if(_loc2_.isInChatRoom && !ChatRoomController.chatRoomView.isInMinigame)
         {
            _loc3_ = _loc2_ as MovieStar;
            _loc4_ = GamesManager.getSelectedGame() != GamesManager.NO_GAME;
            if(Boolean(_loc3_) && Boolean(_loc4_) && _loc3_.platformType == MobileBadge.PLATFORM_BADGE_TYPE_MOBILE)
            {
               _loc3_.platformBadge.glow();
               return;
            }
            GamesManager.selectedActor = _loc2_.actor;
            if(!GamesManager.runSelectedGame(_loc2_.actor.ActorId))
            {
               CharacterContainer.showMyPopUp(_loc2_.actor.ActorId,200,200);
            }
            return;
         }
         CharacterContainer.showMyPopUp(_loc2_.actor.ActorId,Main.Instance.mouseX,Main.Instance.mouseY);
      }
   }
}

