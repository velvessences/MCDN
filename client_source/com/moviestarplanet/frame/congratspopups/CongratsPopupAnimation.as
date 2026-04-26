package com.moviestarplanet.frame.congratspopups
{
   import com.moviestarplanet.Components.CloseButton;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.frame.congratspopups.fireworks.FireworksSpawner;
   import com.moviestarplanet.managers.SoundManager;
   import com.moviestarplanet.utils.ComponentUtilities;
   import com.moviestarplanet.utils.sound.Sounds;
   import com.moviestarplanet.utils.swfmapping.PathSelector;
   import com.moviestarplanet.utils.swfmapping.PropertyMappingAction;
   import com.moviestarplanet.utils.swfmapping.PropertyMappingValue;
   import com.moviestarplanet.utils.swfmapping.SWFPropertyBinder;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.window.stack.WindowStack;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import mx.containers.Canvas;
   
   public class CongratsPopupAnimation
   {
      
      private static const ANIMATION_VERTICAL_OFFSET:int = -50;
      
      private static const ANIMATION_DURATION:int = 12000;
      
      private static const ANIMATION_SIZE_DEFAULT:int = 1000;
      
      private static const VIEWPORT_RECT:Rectangle = new Rectangle(235,80,980,500);
      
      protected var animationSize:int;
      
      protected var animationX:Number;
      
      protected var animationY:Number;
      
      protected var useFirework:Boolean = false;
      
      private var fireworksMid:FireworksSpawner;
      
      private var fireworksRight:FireworksSpawner;
      
      private var fireworksLeft:FireworksSpawner;
      
      private var modal:Canvas;
      
      private var blocker:Canvas;
      
      protected var animation:SWFPropertyBinder;
      
      public function CongratsPopupAnimation(param1:String = "", param2:int = 1000)
      {
         super();
         this.animationSize = param2;
         this.animation = new SWFPropertyBinder();
         this.animation.addEventListener(MSPEvent.PROPERTY_BINDER_CONTENT_READY,this.animationLoaded);
         this.animation.width = param2;
         this.animation.height = param2;
         this.animation.url = this.animationUrl;
         this.animation.addPropertyMapping(new PropertyMappingValue(new PathSelector("TextArea1"),"text",MSPLocaleManagerWeb.getInstance().getString("CONGRATS") + "!"));
         this.animation.addPropertyMapping(new PropertyMappingValue(new PathSelector("TextArea2"),"text",param1));
         this.animation.addPropertyMapping(new PropertyMappingAction(new PathSelector("close"),this.close));
         this.animation.horizontalScrollPolicy = "off";
         this.animation.verticalScrollPolicy = "off";
      }
      
      protected function get animationUrl() : String
      {
         this.useFirework = true;
         return "swf/congrats/LevelUp.swf";
      }
      
      protected function get closeButtonPosition() : Point
      {
         return new Point(637,571);
      }
      
      protected function animationLoaded(param1:MsgEvent) : void
      {
         this.initClose(this.close,this.animation);
         SoundManager.Instance().playSoundEffect(Sounds.CONGRATULATIONS);
         this.animationX = VIEWPORT_RECT.width / 2 + VIEWPORT_RECT.x - this.animationSize / 2;
         this.animationY = VIEWPORT_RECT.height / 2 + VIEWPORT_RECT.y - this.animationSize / 2 + ANIMATION_VERTICAL_OFFSET;
         WindowStack.showViewStackable(this.animation,this.animationX,this.animationY,WindowStack.Z_NOTICE);
         if(this.useFirework)
         {
            this.addFireworks();
         }
      }
      
      private function addFireworks() : void
      {
         this.fireworksMid = new FireworksSpawner(500);
         this.fireworksRight = new FireworksSpawner(500);
         this.fireworksLeft = new FireworksSpawner(500);
         var _loc1_:MovieClip = this.animation.content["CongratsPopup"]["top"]["launcherMid"];
         _loc1_.addChild(this.fireworksMid);
         var _loc2_:MovieClip = this.animation.content["CongratsPopup"]["top"]["launcherRight"];
         _loc2_.addChild(this.fireworksRight);
         var _loc3_:MovieClip = this.animation.content["CongratsPopup"]["top"]["launcherLeft"];
         _loc3_.addChild(this.fireworksLeft);
      }
      
      protected function close(param1:MouseEvent = null) : void
      {
         if(this.useFirework)
         {
            this.fireworksMid.destroy();
            this.fireworksRight.destroy();
            this.fireworksLeft.destroy();
         }
         WindowStack.removeViewStackable(this.animation);
         ComponentUtilities.invokePropertyOnClasses(this.animation.getContent(),MovieClip,"stop");
      }
      
      protected function initClose(param1:Function, param2:Canvas) : void
      {
         var _loc3_:CloseButton = new CloseButton();
         _loc3_.addEventListener(MouseEvent.CLICK,param1);
         _loc3_.setStyle("left",this.closeButtonPosition.x);
         _loc3_.setStyle("top",this.closeButtonPosition.y);
         param2.addChild(_loc3_);
      }
   }
}

