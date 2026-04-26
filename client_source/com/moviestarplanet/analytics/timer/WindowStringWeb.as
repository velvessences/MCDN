package com.moviestarplanet.analytics.timer
{
   import com.moviestarplanet.analytics.IAnalytics;
   import com.moviestarplanet.analytics.IFeatureUsage;
   import com.moviestarplanet.window.stack.WindowStack;
   import com.moviestarplanet.window.stack.WindowStackableContainer;
   import com.moviestarplanet.window.stack.WindowStackableInterface;
   import flash.display.DisplayObject;
   
   public class WindowStringWeb implements IWindowString
   {
      
      public function WindowStringWeb()
      {
         super();
      }
      
      public function isWindowString(param1:Object) : Boolean
      {
         return param1 is WindowStackableInterface;
      }
      
      public function getAnalyticsStrings(param1:Object) : Array
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:Array = null;
         if(param1 is WindowStackableInterface)
         {
            _loc3_ = WindowStack.getWindowByType((param1 as WindowStackableInterface).name);
            if(Boolean(_loc3_) && _loc3_ is IAnalytics)
            {
               _loc2_ = (_loc3_ as IAnalytics).getAnalyticsNames();
            }
            else if(_loc3_ is WindowStackableContainer)
            {
               _loc3_ = (_loc3_ as WindowStackableContainer).window;
               if(Boolean(_loc3_) && _loc3_ is IAnalytics)
               {
                  _loc2_ = (_loc3_ as IAnalytics).getAnalyticsNames();
               }
            }
         }
         return _loc2_;
      }
      
      public function getFeatureStrings(param1:Object) : Array
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:Array = null;
         if(param1 is WindowStackableInterface)
         {
            _loc3_ = WindowStack.getWindowByType((param1 as WindowStackableInterface).name);
            if(Boolean(_loc3_) && _loc3_ is IFeatureUsage)
            {
               _loc2_ = (_loc3_ as IFeatureUsage).getFeatureNames();
            }
            else if(_loc3_ is WindowStackableContainer)
            {
               _loc3_ = (_loc3_ as WindowStackableContainer).window;
               if(Boolean(_loc3_) && _loc3_ is IFeatureUsage)
               {
                  _loc2_ = (_loc3_ as IFeatureUsage).getFeatureNames();
               }
            }
         }
         return _loc2_;
      }
   }
}

