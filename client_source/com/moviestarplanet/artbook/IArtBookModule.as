package com.moviestarplanet.artbook
{
   import com.moviestarplanet.Module.IFlashModule;
   import com.moviestarplanet.award.visualization.IAwardSpawner;
   import com.moviestarplanet.comments.ICommentsComponent;
   import com.moviestarplanet.font.IFontManager;
   import com.moviestarplanet.model.IActorModel;
   import com.moviestarplanet.scrapitems.IClipArtProvider;
   import flash.display.DisplayObject;
   
   public interface IArtBookModule extends IFlashModule
   {
      
      function openArtBookBrowser() : void;
      
      function openArtBookCreator(param1:int, param2:int) : void;
      
      function openArtBookViewer(param1:int, param2:int = 1) : void;
      
      function openArtBookViewerExternal(param1:int, param2:int) : void;
      
      function openBio(param1:int, param2:int, param3:Boolean = false, param4:int = 5) : void;
      
      function setActorModel(param1:IActorModel) : void;
      
      function setAwardSpawner(param1:IAwardSpawner) : void;
      
      function setCommentsComponent(param1:ICommentsComponent) : void;
      
      function setClipArtProvider(param1:IClipArtProvider) : void;
      
      function setFontManager(param1:IFontManager) : void;
      
      function getContent(param1:Number, param2:Boolean = false, param3:Function = null, param4:Number = 0, param5:Number = 0) : DisplayObject;
   }
}

