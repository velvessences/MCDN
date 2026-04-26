package com.moviestarplanet.utils.tooltips.interfaces
{
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.utils.tooltips.ToolTipsElement;
   
   public class TooltipWrapper
   {
      
      private static var wrapper:ITooltipWrapper;
      
      public function TooltipWrapper()
      {
         super();
      }
      
      public static function createTooltip(param1:ToolTipsElement) : void
      {
         if(wrapper == null)
         {
            wrapper = InjectionManager.manager().getInstance(ITooltipWrapper);
         }
         wrapper.createTooltip(param1);
      }
      
      public static function setPosition(param1:Number, param2:Number) : void
      {
         if(wrapper != null)
         {
            wrapper.setPosition(param1,param2);
         }
      }
      
      public static function hasToolTip() : Boolean
      {
         return wrapper != null && wrapper.hasToolTip();
      }
      
      public static function get width() : Number
      {
         return wrapper == null ? 0 : wrapper.width;
      }
      
      public static function get height() : Number
      {
         return wrapper == null ? 0 : wrapper.height;
      }
      
      public static function destroy() : void
      {
         if(wrapper != null)
         {
            wrapper.destroy();
         }
      }
   }
}

