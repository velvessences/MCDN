package com.moviestarplanet.utils.tooltips.interfaces
{
   import com.moviestarplanet.utils.tooltips.ToolTipsElement;
   import mx.core.IToolTip;
   import mx.managers.ToolTipManager;
   
   public class TooltipWrapperWeb implements ITooltipWrapper
   {
      
      private var currentToolTip:IToolTip;
      
      public function TooltipWrapperWeb()
      {
         super();
      }
      
      public function createTooltip(param1:ToolTipsElement) : void
      {
         this.currentToolTip = ToolTipManager.createToolTip(param1.toolTipText,0,0);
      }
      
      public function setPosition(param1:Number, param2:Number) : void
      {
         this.currentToolTip.x = param1;
         this.currentToolTip.y = param2;
      }
      
      public function hasToolTip() : Boolean
      {
         return this.currentToolTip != null;
      }
      
      public function get width() : Number
      {
         return this.currentToolTip.width;
      }
      
      public function get height() : Number
      {
         return this.currentToolTip.height;
      }
      
      public function destroy() : void
      {
         if(this.currentToolTip != null)
         {
            ToolTipManager.destroyToolTip(this.currentToolTip);
            this.currentToolTip = null;
         }
      }
   }
}

