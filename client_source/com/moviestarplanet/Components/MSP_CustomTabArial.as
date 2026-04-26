package com.moviestarplanet.Components
{
   public class MSP_CustomTabArial extends MSP_CustomTab
   {
      
      public function MSP_CustomTabArial()
      {
         super();
      }
      
      override protected function onCreationComplete() : void
      {
         labelComponent.setStyle("fontFamily","EmbedArial");
      }
   }
}

