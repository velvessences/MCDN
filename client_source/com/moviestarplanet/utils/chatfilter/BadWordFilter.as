package com.moviestarplanet.utils.chatfilter
{
   import com.moviestarplanet.clientcensor.WhiteListBase;
   import flash.display.DisplayObject;
   import mx.controls.textClasses.TextRange;
   import mx.core.UIComponent;
   
   public class BadWordFilter extends WhiteListBase
   {
      
      public function BadWordFilter(param1:Function)
      {
         super(param1);
      }
      
      override protected function defaultColor(param1:String, param2:DisplayObject) : void
      {
         var _loc3_:TextRange = null;
         if(param1 != null && param1.length > 0)
         {
            _loc3_ = new TextRange(param2 as UIComponent,false,0,param1.length);
            _loc3_.color = UIComponent(param2).getStyle("color");
         }
      }
      
      override protected function setupUserSpecificWordList() : void
      {
      }
   }
}

