package com.moviestarplanet.services.worldthemeservice
{
   public class WorldAreaSwf
   {
      
      public static const BACKGROUND:String = "background";
      
      public static const CHAT:String = "chat";
      
      public static const CREATIVE:String = "creative";
      
      public static const GAMES:String = "games";
      
      public static const OVERVIEW:String = "overview";
      
      public static const PETS:String = "pets";
      
      public static const SHOPPING:String = "shopping";
      
      public static const LOGO:String = "logo";
      
      public var AreaName:String;
      
      public var SwfPath:String;
      
      public var WorldThemeAreaId:int;
      
      public function WorldAreaSwf(param1:Object)
      {
         super();
         this.AreaName = param1.AreaName as String;
         this.SwfPath = param1.SwfPath as String;
         if(param1.WorldThemeAreaId != null)
         {
            this.WorldThemeAreaId = param1.WorldThemeAreaId as int;
         }
      }
   }
}

