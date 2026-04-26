package com.moviestarplanet.designer
{
   import com.moviestarplanet.Module.IFlashModule;
   import com.moviestarplanet.model.IActorModel;
   import com.moviestarplanet.scrapitems.IClipArtProvider;
   
   public interface IDesignerModule extends IFlashModule
   {
      
      function openDesignerBrowser() : void;
      
      function createDesign() : void;
      
      function setActorModel(param1:IActorModel) : void;
      
      function setClipArtProvider(param1:IClipArtProvider) : void;
   }
}

