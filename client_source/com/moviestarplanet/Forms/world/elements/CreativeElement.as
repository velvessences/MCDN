package com.moviestarplanet.Forms.world.elements
{
   import com.moviestarplanet.Clubs.ClubsManager;
   import com.moviestarplanet.Components.LooksOverview;
   import com.moviestarplanet.Components.MovieCompetition.MovieCompetitionOverview;
   import com.moviestarplanet.artbook.ArtBookModuleManager;
   import com.moviestarplanet.club.valueobjects.ClubActor;
   import com.moviestarplanet.designer.DesignerModuleManager;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.movies.Module.MovieModuleManager;
   import com.moviestarplanet.pictures.PicturesModuleManager;
   import com.moviestarplanet.services.wrappers.SessionService;
   
   public class CreativeElement extends BaseWorldElement
   {
      
      private static var showPictureUpload:Boolean;
      
      private static var _allItems:Array = [];
      
      public static var ART_BOOK:CreativeElement = new CreativeElement("DYNTXT_LAYOUT_BUTTONS_ARTBOOK","artbook");
      
      public static var MY_LOOKS:CreativeElement = new CreativeElement("DYNTXT_LAYOUT_BUTTONS_MYLOOKS","myLooks");
      
      public static var MOVIES:CreativeElement = new CreativeElement("DYNTXT_LAYOUT_BUTTONS_MOVIES","movies");
      
      public static var COMPETITION:CreativeElement = new CreativeElement("DYNTXT_LAYOUT_BUTTONS_COMPETITIONS","competitions");
      
      public static var DESIGN_CLOTHES:CreativeElement = new CreativeElement("DYNTXT_LAYOUT_BUTTONS_DESIGNSTUDIO","DesignStudio");
      
      public static var CLUBS:CreativeElement = new CreativeElement("CLUBS_BTN","clubs");
      
      public static var PHOTOS:CreativeElement = new CreativeElement("PICTURE_UPLOAD","photos");
      
      public function CreativeElement(param1:String, param2:String)
      {
         var setShowPictureUpload:Function;
         var localeStr:String = param1;
         var swfVarName:String = param2;
         if(swfVarName == "photos")
         {
            setShowPictureUpload = function(param1:String):void
            {
               showPictureUpload = param1 == "true";
            };
            SessionService.GetAppSetting("ImageUpload",setShowPictureUpload);
         }
         if(swfVarName != "photos" || showPictureUpload)
         {
            _allItems.push(this);
            super(localeStr,swfVarName);
         }
      }
      
      public static function get allItems() : Array
      {
         return _allItems;
      }
      
      override public function enter() : void
      {
         switch(this)
         {
            case ART_BOOK:
               ArtBookModuleManager.getInstance().openArtBookBrowser();
               break;
            case MY_LOOKS:
               LooksOverview.show(ActorSession.getActorId(),ActorSession.actorName,ActorSession.getActorId(),NaN,true);
               break;
            case MOVIES:
               MovieModuleManager.getInstance().openMovieBrowser();
               break;
            case DESIGN_CLOTHES:
               DesignerModuleManager.getInstance().openDesignerBrowser();
               break;
            case COMPETITION:
               MovieCompetitionOverview.getInstance().showMovieCompetitions();
               break;
            case CLUBS:
               ClubsManager.GetClubActor(ActorSession.getActorId(),this.iActorFetched);
               break;
            case PHOTOS:
               PicturesModuleManager.getInstance().openPictureUpload();
         }
      }
      
      private function iActorFetched(param1:ClubActor) : void
      {
         ClubsManager.getInstance().openLatestActivity();
      }
   }
}

