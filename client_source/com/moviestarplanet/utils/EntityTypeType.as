package com.moviestarplanet.utils
{
   public class EntityTypeType
   {
      
      public static const LOOK:int = 1;
      
      public static const ROOM:int = 2;
      
      public static const MOVIE:int = 3;
      
      public static const MOVIESTAR:int = 4;
      
      public static const MOVIECOMPETITION:int = 5;
      
      public static const ROOMCOMPETITION:int = 6;
      
      public static const SCRAPBLOG:int = 7;
      
      public static const YOUTUBE:int = 8;
      
      public static const CLUBS:int = 9;
      
      public static const PLAYLIST:int = 10;
      
      public static const FULLSIZEMOVIESTAR:int = 11;
      
      public static const FULLSIZELOOK:int = 12;
      
      public static const WALLPOST:int = 13;
      
      public static const DIAMONDSPECIAL:int = 14;
      
      public static const EMBEDDEDGAME:int = 15;
      
      public static const FORUM:int = 16;
      
      public static const BACKGROUND:int = 17;
      
      public static const ANIMATION:int = 18;
      
      public static const ITEM:int = 19;
      
      public static const CLOTHE:int = 20;
      
      public static const PET:int = 21;
      
      public static const DESIGN:int = 22;
      
      public static const APP:int = 23;
      
      public static const SCRAPBLOG_BIG:int = 33;
      
      public static const ROOM_MEDIUM:int = 34;
      
      public static const ROOM_PROFILE:int = 35;
      
      public static const MOVIE_BIG:int = 36;
      
      public static const SOCIALSHOPPING:int = 25;
      
      public static const BOONIEVERSE:int = 26;
      
      public static const BOONIEVERSE_SMALL:int = 27;
      
      public static const IMAGE_UPLOAD:int = 28;
      
      public static const FRIEND:int = 29;
      
      public static const CONTEST:int = 30;
      
      public static const EXTERNAL_VIDEO_ACTOR_REL:int = 31;
      
      public static const EXTERNAL_VIDEO_PLAYLIST_REL:int = 32;
      
      public static const ROBOBLAST_AVATAR_REPORT:int = 100;
      
      public static const ROBOBLAST_VEHICLE_REPORT:int = 101;
      
      public static const ROBOBLAST_LEVEL_REPORT:int = 102;
      
      public static const ROBOBLAST_PREFAB_REPORT:int = 103;
      
      public static const ROBOBLAST_ROBOTPART_REPORT:int = 104;
      
      public static const ROBOBLAST_AVATAR:int = 110;
      
      public static const ROBOBLAST_VEHICLE:int = 111;
      
      public static const ROBOBLAST_LEVEL:int = 112;
      
      public static const ROBOBLAST_PREFAB:int = 113;
      
      public static const ROBOBLAST_ROBOTPART:int = 114;
      
      public static const BOONIEVERSE_USER_REPORT:int = 200;
      
      public function EntityTypeType()
      {
         super();
      }
      
      public static function EntityTypeAsInt(param1:String) : Number
      {
         var _loc2_:Number = -1;
         switch(param1)
         {
            case "fullSizeMovieStar":
               return FULLSIZEMOVIESTAR;
            case "fullSizeLook":
               return FULLSIZELOOK;
            case "look":
               return LOOK;
            case "room":
               return ROOM;
            case "roomMedium":
               return ROOM_MEDIUM;
            case "roomProfile":
               return ROOM_PROFILE;
            case "movie":
               return MOVIE;
            case "movieBig":
               return MOVIE_BIG;
            case "moviestar":
               return MOVIESTAR;
            case "moviecompetition":
               return MOVIECOMPETITION;
            case "scrapblog":
               return SCRAPBLOG;
            case "scrapblogBig":
               return SCRAPBLOG_BIG;
            case "youtube":
               return YOUTUBE;
            case "clubs":
               return CLUBS;
            case "playlist":
               return PLAYLIST;
            case "wallpost":
               return WALLPOST;
            case "diamondspecial":
               return DIAMONDSPECIAL;
            case "embeddedgame":
               return EMBEDDEDGAME;
            case "background":
               return BACKGROUND;
            case "animation":
               return ANIMATION;
            case "item":
               return ITEM;
            case "clothes":
               return CLOTHE;
            case "pets":
               return PET;
            case "design":
               return DESIGN;
            case "app":
               return APP;
            case "socialShopping":
               return SOCIALSHOPPING;
            case "boonieverse":
               return BOONIEVERSE;
            case "boonieversesmall":
               return BOONIEVERSE_SMALL;
            case "pictureUpload":
               return IMAGE_UPLOAD;
            case "friend":
               return FRIEND;
            case "contest":
               return CONTEST;
            case "externalVideoActorRel":
               return EXTERNAL_VIDEO_ACTOR_REL;
            case "externalVideoPlaylistRel":
               return EXTERNAL_VIDEO_PLAYLIST_REL;
            default:
               return -1;
         }
      }
      
      public static function EntityTypeAsString(param1:int) : String
      {
         switch(param1)
         {
            case FULLSIZEMOVIESTAR:
               return "fullSizeMovieStar";
            case FULLSIZELOOK:
               return "fullSizeLook";
            case LOOK:
               return "look";
            case ROOM:
               return "room";
            case ROOM_MEDIUM:
               return "roomMedium";
            case ROOM_PROFILE:
               return "roomProfile";
            case MOVIE:
               return "movie";
            case MOVIE_BIG:
               return "movieBig";
            case MOVIESTAR:
               return "moviestar";
            case MOVIECOMPETITION:
               return "moviecompetition";
            case SCRAPBLOG:
               return "scrapblog";
            case SCRAPBLOG_BIG:
               return "scrapblogBig";
            case YOUTUBE:
               return "youtube";
            case CLUBS:
               return "clubs";
            case PLAYLIST:
               return "playlist";
            case WALLPOST:
               return "wallpost";
            case DIAMONDSPECIAL:
               return "diamondspecial";
            case EMBEDDEDGAME:
               return "embeddedgame";
            case BACKGROUND:
               return "background";
            case ANIMATION:
               return "animation";
            case ITEM:
               return "item";
            case CLOTHE:
               return "clothes";
            case PET:
               return "pets";
            case DESIGN:
               return "design";
            case APP:
               return "app";
            case SOCIALSHOPPING:
               return "socialShopping";
            case BOONIEVERSE:
               return "boonieverse";
            case BOONIEVERSE_SMALL:
               return "boonieversesmall";
            case IMAGE_UPLOAD:
               return "pictureUpload";
            case ROBOBLAST_AVATAR:
               return "buildergame-avatar-ext";
            case ROBOBLAST_AVATAR_REPORT:
               return "buildergame-avatar-report";
            case ROBOBLAST_LEVEL_REPORT:
               return "buildergame-level-report";
            case ROBOBLAST_VEHICLE_REPORT:
               return "buildergame-vehicle-report";
            case ROBOBLAST_PREFAB_REPORT:
               return "buildergame-prefab-report";
            case ROBOBLAST_ROBOTPART_REPORT:
               return "buildergame-robotpart-report";
            case EXTERNAL_VIDEO_ACTOR_REL:
               return "externalVideoActorRel";
            case EXTERNAL_VIDEO_PLAYLIST_REL:
               return "externalVideoPlaylistRel";
            default:
               return "";
         }
      }
   }
}

