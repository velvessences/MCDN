package com.moviestarplanet.color.tooltipwrapper
{
   import com.moviestarplanet.injection.InjectionManager;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   public class ColorTooltip
   {
      
      private static var wrapper:IColorTooltip;
      
      public function ColorTooltip()
      {
         super();
      }
      
      public static function isFlex(param1:DisplayObjectContainer) : Boolean
      {
         ensureCreated();
         return wrapper.isFlex(param1);
      }
      
      public static function createWrapperFor(param1:DisplayObjectContainer) : DisplayObject
      {
         ensureCreated();
         return wrapper.createWrapperFor(param1);
      }
      
      private static function ensureCreated() : void
      {
         if(wrapper == null)
         {
            wrapper = InjectionManager.manager().getInstance(IColorTooltip) as IColorTooltip;
         }
      }
   }
}

