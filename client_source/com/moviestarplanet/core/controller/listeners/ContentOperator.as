package com.moviestarplanet.core.controller.listeners
{
   import com.moviestarplanet.Components.Character.CharacterContainer;
   import com.moviestarplanet.Components.LooksOverview;
   import com.moviestarplanet.artbook.ArtBookModuleManager;
   import com.moviestarplanet.chat.ChatRoomController;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.designer.DesignerModuleManager;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.look.service.LookAMFService;
   import com.moviestarplanet.look.valueobjects.LookItem;
   import com.moviestarplanet.messaging.MessagingManager;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.movies.Module.MovieModuleManager;
   import com.moviestarplanet.moviestar.utils.ActorCache;
   import com.moviestarplanet.moviestar.valueObjects.Actor;
   import com.moviestarplanet.pictures.PicturesModuleManager;
   import com.moviestarplanet.school.schoolsettings.SchoolSettings;
   import com.moviestarplanet.schoolfriends.service.SchoolFriendsSwitch;
   import com.moviestarplanet.scrapblog.ScrapBlogManager;
   import com.moviestarplanet.video.module.VideoModuleManager;
   import com.moviestarplanet.window.stack.WebWindowOpener;
   import flash.geom.Point;
   
   public class ContentOperator
   {
      
      public function ContentOperator()
      {
         super();
      }
      
      public static function wireup() : void
      {
         MessageCommunicator.subscribe(MSPEvent.OPEN_ROOM,onOpenRoom);
         MessageCommunicator.subscribe(MSPEvent.OPEN_CHAT,onOpenChat);
         MessageCommunicator.subscribe(MSPEvent.OPEN_MINI_PROFILE,onOpenMiniProfile);
         MessageCommunicator.subscribe(MSPEvent.OPEN_SCRAPBLOG,onOpenScrapblog);
         MessageCommunicator.subscribe(MSPEvent.OPEN_OLD_SCRAPBLOG,onOpenOldScrapblog);
         MessageCommunicator.subscribe(MSPEvent.OPEN_YOUTUBE,OnOpenYoutube);
         MessageCommunicator.subscribe(MSPEvent.OPEN_YOUTUBE_SINGLE_VIDEO,OnOpenYoutubeSingleVideo);
         MessageCommunicator.subscribe(MSPEvent.OPEN_LOOK,OnOpenLook);
         MessageCommunicator.subscribe(MSPEvent.OPEN_LOOK_OTHERS,OnOpenLookOthers);
         MessageCommunicator.subscribe(MSPEvent.OPEN_MOVIE,OnOpenMovie);
         MessageCommunicator.subscribe(MSPEvent.CLOSE_MOVIE,OnCloseMovie);
         MessageCommunicator.subscribe(MSPEvent.OPEN_MY_SCHOOL,onOpenMySchool);
         MessageCommunicator.subscribe(MSPEvent.OPEN_LOOK_CREATION,OnOpenLookCreation);
         MessageCommunicator.subscribe(MSPEvent.OPEN_MOVIE_CREATION,OnOpenMovieCreation);
         MessageCommunicator.subscribe(MSPEvent.OPEN_DESIGN_CREATION,OnOpenDesignCreation);
         MessageCommunicator.subscribe(MSPEvent.OPEN_ARTBOOK_CREATION,OnOpenArtbookCreation);
         MessageCommunicator.subscribe(MSPEvent.OPEN_CHARACTER_POP_UP,OnOpenArtBookAuthor);
         MessageCommunicator.subscribe(MSPEvent.OPEN_PHOTO,onOpenPhoto);
      }
      
      private static function OnOpenLookOthers(param1:MsgEvent) : void
      {
         var _loc2_:Array = param1.data as Array;
         new LookAMFService().GetLookById(param1.data as int,onOtherLookLoaded);
      }
      
      private static function onOtherLookLoaded(param1:LookItem) : void
      {
         var onActorLoaded:Function = null;
         var look:LookItem = param1;
         onActorLoaded = function(param1:Actor):void
         {
            LooksOverview.show(look.CreatorId,param1.Name,look.ActorId,look.LookId,true);
         };
         ActorCache.loadActor(look.ActorId,onActorLoaded);
      }
      
      private static function onOpenMySchool(param1:MsgEvent) : void
      {
         if(SchoolFriendsSwitch.switchEnabled)
         {
            WebWindowOpener.instance().openWindow(new SchoolSettings(null,new Point(0,0)));
         }
      }
      
      private static function onOpenRoom(param1:MsgEvent) : void
      {
         ChatRoomController.showPublicProfile(param1.data,"");
      }
      
      private static function onOpenChat(param1:MsgEvent) : void
      {
         MessagingManager.openMessagingViewWithActor(param1.data);
      }
      
      private static function onOpenMiniProfile(param1:MsgEvent) : void
      {
         CharacterContainer.showMyPopUpDefault(param1.data);
      }
      
      private static function onOpenScrapblog(param1:MsgEvent) : void
      {
         ArtBookModuleManager.getInstance().openArtBookViewer(param1.data);
      }
      
      private static function onOpenPhoto(param1:MsgEvent) : void
      {
         PicturesModuleManager.getInstance().openPictureUpload(param1.data);
      }
      
      private static function onOpenOldScrapblog(param1:MsgEvent) : void
      {
         ScrapBlogManager.getInstance().viewScrapBlog(param1.data);
      }
      
      private static function OnOpenYoutube(param1:MsgEvent) : void
      {
         VideoModuleManager.getInstance().playYouTubeList(param1.data);
      }
      
      private static function OnOpenYoutubeSingleVideo(param1:MsgEvent) : void
      {
         VideoModuleManager.getInstance().playYouTubeVideo(param1.data);
      }
      
      private static function OnOpenLook(param1:MsgEvent) : void
      {
         var _loc2_:Array = param1.data as Array;
         LooksOverview.show(ActorSession.getActorId(),ActorSession.actorName,ActorSession.getActorId(),param1.data,true);
      }
      
      private static function OnOpenMovie(param1:MsgEvent) : void
      {
         MovieModuleManager.getInstance().PlayMovieInParent(param1.data,Main.Instance);
      }
      
      private static function OnCloseMovie(param1:MsgEvent) : void
      {
         MovieModuleManager.getInstance().CloseMovie();
      }
      
      private static function OnOpenArtbookCreation(param1:MsgEvent) : void
      {
         ArtBookModuleManager.getInstance().openArtBookCreator();
      }
      
      private static function OnOpenArtBookAuthor(param1:MsgEvent) : void
      {
         var _loc2_:Object = param1.data;
         CharacterContainer.showMyPopUp(_loc2_.actorId,_loc2_.stageX,_loc2_.stageY);
      }
      
      private static function OnOpenMovieCreation(param1:MsgEvent) : void
      {
         MovieModuleManager.getInstance().NewMovie(false);
      }
      
      private static function OnOpenLookCreation(param1:MsgEvent) : void
      {
         LooksOverview.show(ActorSession.getActorId(),ActorSession.actorName,ActorSession.getActorId(),NaN,true);
      }
      
      private static function OnOpenDesignCreation(param1:MsgEvent) : void
      {
         DesignerModuleManager.getInstance().openDesignerBrowser();
      }
   }
}

