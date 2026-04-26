package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.color.ColorController;
   import com.moviestarplanet.flash.components.container.cloth.FlashClothBox;
   import com.moviestarplanet.scrapitems.pattern.PatternLoader;
   import com.moviestarplanet.scrapitems.pattern.PatternRendererFactoryWeb;
   import com.moviestarplanet.utils.ColorMap;
   import com.moviestarplanet.utils.flash.FlippableFlashLoader;
   import com.moviestarplanet.utils.flash.MSP_FlashLoader;
   
   public class ConfigureVisualsCommand
   {
      
      public function ConfigureVisualsCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         ColorController.applicationContainer = ApplicationReference.getApplicationRoot();
         FlashClothBox.colorReader = ColorMap.getInstance();
         PatternLoader.colorReader = ColorMap.getInstance();
         PatternLoader.rendererFactoryClass = PatternRendererFactoryWeb;
         FlippableFlashLoader.LoaderClass = MSP_FlashLoader;
      }
   }
}

