package com.moviestarplanet.progressbar
{
   import com.moviestarplanet.window.loading.LoadingProgressBarAS;
   
   internal class ProgressBarInstance
   {
      
      private static var instance:LoadingProgressBarAS;
      
      public function ProgressBarInstance()
      {
         super();
      }
      
      public static function getInstance() : LoadingProgressBarAS
      {
         if(instance == null)
         {
            instance = new LoadingProgressBarAS();
         }
         return instance;
      }
      
      public static function getExistingInstance() : LoadingProgressBarAS
      {
         return instance;
      }
      
      public static function nullifyInstance() : void
      {
         instance = null;
      }
   }
}

