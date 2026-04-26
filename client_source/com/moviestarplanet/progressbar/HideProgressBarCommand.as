package com.moviestarplanet.progressbar
{
   import com.moviestarplanet.window.loading.LoadingProgressBarAS;
   
   public class HideProgressBarCommand
   {
      
      public function HideProgressBarCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         var _loc1_:LoadingProgressBarAS = ProgressBarInstance.getExistingInstance();
         if(_loc1_ != null)
         {
            if(_loc1_.parent != null)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
            _loc1_.stop();
            _loc1_ = null;
            ProgressBarInstance.nullifyInstance();
         }
      }
   }
}

