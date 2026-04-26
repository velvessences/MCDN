package com.moviestarplanet.news.module
{
   import com.moviestarplanet.commoninterfaces.IRegistrator;
   import com.moviestarplanet.news.valueobjects.News;
   import com.moviestarplanet.news.valueobjects.NewsCountryRel;
   import com.moviestarplanet.news.valueobjects.NewsMovieCompetition;
   import com.moviestarplanet.news.valueobjects.PagedNewsList;
   import flash.net.registerClassAlias;
   
   public class NewsRegistrator implements IRegistrator
   {
      
      private static var hasRegistered:Boolean = false;
      
      public function NewsRegistrator()
      {
         super();
      }
      
      public function registerClassAliases() : void
      {
         if(!hasRegistered)
         {
            registerClassAlias("News",News);
            registerClassAlias("NewsCountryRel",NewsCountryRel);
            registerClassAlias("NewsMovieCompetition",NewsMovieCompetition);
            registerClassAlias("PagedNewsList",PagedNewsList);
            hasRegistered = true;
         }
      }
   }
}

