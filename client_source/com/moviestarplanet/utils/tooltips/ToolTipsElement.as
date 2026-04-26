package com.moviestarplanet.utils.tooltips
{
   public class ToolTipsElement
   {
      
      public var toolTipText:String;
      
      public var delay:Boolean;
      
      public var orientation:String;
      
      public function ToolTipsElement(param1:String, param2:Boolean, param3:String)
      {
         super();
         this.toolTipText = param1;
         this.delay = param2;
         this.orientation = param3;
      }
   }
}

