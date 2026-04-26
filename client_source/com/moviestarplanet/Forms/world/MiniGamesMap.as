package com.moviestarplanet.Forms.world
{
   import com.moviestarplanet.Forms.world.elements.WorldArea;
   import mx.core.UIComponent;
   
   public class MiniGamesMap extends LocalMap
   {
      
      public function MiniGamesMap(param1:WorldArea)
      {
         super(param1);
      }
      
      override protected function registerMapElement(param1:String, param2:String, param3:Function) : UIComponent
      {
         return super.registerMapElement(param1,param2,param3);
      }
   }
}

