package com.moviestarplanet.services.worldthemeservice
{
   public class WorldTheme
   {
      
      public var worldThemeId:int;
      
      public var name:String;
      
      public var folderName:String;
      
      public var themeId:int;
      
      public function WorldTheme(param1:Object = null)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         this.worldThemeId = param1.WorldThemeId;
         this.name = param1.Name;
         this.folderName = param1.FolderName;
         this.themeId = param1.ThemeId;
      }
   }
}

