package com.moviestarplanet.scrapblog
{
   import com.moviestarplanet.scrapblog.flash.bio.IBioContainer;
   import com.moviestarplanet.valueObjects.NewsUpdate;
   import com.moviestarplanet.window.stack.WindowStackableEditorInterface;
   import flash.events.IEventDispatcher;
   import mx.core.UIComponent;
   
   public interface IScrapBlogView extends IEventDispatcher, WindowStackableEditorInterface
   {
      
      function set actorId(param1:Number) : void;
      
      function showSubmissableList(param1:Number) : void;
      
      function createScrapBlog(param1:int, param2:int = 0, param3:int = 0) : void;
      
      function createTemplate(param1:int, param2:int, param3:int) : void;
      
      function viewScrapBlog(param1:Number, param2:int) : void;
      
      function viewScrapBlogExternal(param1:Number, param2:int) : UIComponent;
      
      function closeViewScrapBlog() : void;
      
      function getContent(param1:Number) : UIComponent;
      
      function getNews(param1:Number) : UIComponent;
      
      function createNews(param1:Function) : void;
      
      function editNews(param1:Number, param2:NewsUpdate, param3:Function) : void;
      
      function createClubLogo(param1:Function) : void;
      
      function editClubLogo(param1:int, param2:Function) : void;
      
      function createClubBackground(param1:Function) : void;
      
      function editClubBackground(param1:int, param2:Function) : void;
      
      function getClubBackground(param1:int) : UIComponent;
      
      function createFromTemplate(param1:int) : UIComponent;
      
      function loadTemplate(param1:int, param2:Number) : UIComponent;
      
      function loadBio(param1:Number) : UIComponent;
      
      function getBioContainer() : IBioContainer;
   }
}

