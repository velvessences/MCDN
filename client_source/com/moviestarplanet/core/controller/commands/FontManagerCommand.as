package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.font.IFontManager;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.utils.FontManager;
   import com.moviestarplanet.utils.translation.TranslationUtilities;
   
   public class FontManagerCommand
   {
      
      public function FontManagerCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         InjectionManager.mapper().map(IFontManager).toSingleton(FontManager);
         TranslationUtilities.fontManager = new FontManager();
      }
   }
}

