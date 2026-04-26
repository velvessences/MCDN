package com.moviestarplanet.controls.buttons
{
   import com.moviestarplanet.utils.MSP_SWFLoader;
   import com.moviestarplanet.utils.loader.AssetUrl;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class CloseButton extends Sprite
   {
      
      private var loadCompleteCallback:Function;
      
      private var button:DisplayObject;
      
      private var myheight:int = 0;
      
      private var mywidth:int = 0;
      
      public function CloseButton(param1:Function = null)
      {
         super();
         this.loadCompleteCallback = param1;
         this.load();
      }
      
      private function load() : void
      {
         var loadComplete:Function = null;
         loadComplete = function(param1:MSP_SWFLoader):void
         {
            button = param1.content;
            if(myheight)
            {
               button.height = myheight;
               button.width = mywidth;
            }
            addChild(button);
            if(loadCompleteCallback != null)
            {
               loadCompleteCallback();
            }
         };
         MSP_SWFLoader.RequestLoad(new AssetUrl("quest/close_button.swf",AssetUrl.SWF),loadComplete);
         useHandCursor = true;
         buttonMode = true;
      }
      
      override public function set height(param1:Number) : void
      {
         if(this.button)
         {
            this.button.height = param1;
         }
         this.myheight = param1;
      }
      
      override public function set width(param1:Number) : void
      {
         if(this.button)
         {
            this.button.width = param1;
         }
         this.mywidth = param1;
      }
   }
}

