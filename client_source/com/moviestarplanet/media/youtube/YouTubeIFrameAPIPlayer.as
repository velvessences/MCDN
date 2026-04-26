package com.moviestarplanet.media.youtube
{
   import com.moviestarplanet.html.JSDiv;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class YouTubeIFrameAPIPlayer extends Sprite implements IAPIPlayerSprite
   {
      
      private var _wrappingDiv:JSDiv;
      
      private var _iFrame:YouTubeIFrame;
      
      private var _snapshot:DisplayObject;
      
      private var _width:Number = 440;
      
      private var _height:Number = 240;
      
      private var _wasPlayingWhenActive:Boolean;
      
      private var _active:Boolean = true;
      
      private var _autoplay:Boolean;
      
      private var _temporaryFill:Sprite;
      
      private var _appContainer:DisplayObjectContainer;
      
      public function YouTubeIFrameAPIPlayer()
      {
         super();
         addEventListener(Event.RENDER,this.forwardEventIn);
         this._temporaryFill = new Sprite();
         this._temporaryFill.graphics.beginFill(0);
         this._temporaryFill.graphics.drawRect(0,0,this._width,this._height);
         this._temporaryFill.graphics.endFill();
         addChild(this._temporaryFill);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      protected function onAddedToStage(param1:Event) : void
      {
         if(this._appContainer == null)
         {
            this._iFrame.container = null;
         }
         else
         {
            this._wrappingDiv.width = this._appContainer.width;
            this._wrappingDiv.height = this._appContainer.height;
            this._appContainer.addChild(this._wrappingDiv);
            this._iFrame.container = this._wrappingDiv;
         }
      }
      
      protected function onRemovedFromStage(param1:Event) : void
      {
         if(this._appContainer != null)
         {
            this._appContainer.removeChild(this._wrappingDiv);
         }
      }
      
      public function loadVideoById(param1:String) : void
      {
         SnapshotRetriever.getSnapshot(param1,this.onSnapshotLoaded);
         if(this._wrappingDiv == null)
         {
            this._wrappingDiv = new JSDiv();
            this._wrappingDiv.divName = "BOUNDING";
            this._wrappingDiv.setCSSProperty("pointer-events","none");
            this._wrappingDiv.showOverflow = false;
            this._iFrame = new YouTubeIFrame(param1,this._width,this._height,this._active);
            this._iFrame.visible = this._active;
            this._iFrame.setCSSProperty("pointer-events","visible");
            addChild(this._iFrame);
         }
         else
         {
            this._iFrame.loadVideoById(param1);
         }
      }
      
      private function onSnapshotLoaded(param1:DisplayObject) : void
      {
         if(this._snapshot != null)
         {
            removeChild(this._snapshot);
         }
         this._snapshot = param1;
         this._snapshot.width = this._width;
         this._snapshot.height = this._height;
         this._snapshot.visible = !this._active;
         addChild(this._snapshot);
         if(this._temporaryFill != null)
         {
            removeChild(this._temporaryFill);
         }
         this._temporaryFill = null;
      }
      
      protected function forwardEventIn(param1:Event) : void
      {
         if(this._iFrame != null)
         {
            this._iFrame.dispatchEvent(param1);
         }
      }
      
      public function set playbackQuality(param1:String) : void
      {
         if(this._iFrame != null)
         {
            this._iFrame.playbackQuality = param1;
         }
      }
      
      public function get playbackQuality() : String
      {
         if(this._iFrame == null)
         {
            return null;
         }
         return this._iFrame.playbackQuality;
      }
      
      public function mute() : void
      {
         if(this._iFrame != null)
         {
            this._iFrame.mute();
         }
      }
      
      public function unMute() : void
      {
         if(this._iFrame != null)
         {
            this._iFrame.unMute();
         }
      }
      
      public function isMuted() : Boolean
      {
         if(this._iFrame == null)
         {
            return false;
         }
         return this._iFrame.isMuted();
      }
      
      public function get availableQualityLevels() : Array
      {
         if(this._iFrame == null)
         {
            return new Array();
         }
         return this._iFrame.availableQualityLevels;
      }
      
      public function get isPlaying() : Boolean
      {
         if(this._iFrame == null)
         {
            return false;
         }
         return this._iFrame.state == YouTubeAPI.STATE_PLAYING;
      }
      
      public function getDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function set autoPlay(param1:Boolean) : void
      {
         this._autoplay = param1;
         if(this._iFrame != null)
         {
            this._iFrame.autoplay = param1 && this.active;
         }
      }
      
      public function set volume(param1:Number) : void
      {
         if(this._iFrame != null)
         {
            this._iFrame.volume = param1;
         }
      }
      
      public function get volume() : Number
      {
         if(this._iFrame == null)
         {
            return 0;
         }
         return this._iFrame.volume;
      }
      
      public function get duration() : Number
      {
         if(this._iFrame == null)
         {
            return 0;
         }
         return this._iFrame.duration;
      }
      
      public function get currentTime() : Number
      {
         if(this._iFrame == null)
         {
            return 0;
         }
         return this._iFrame.currentTime;
      }
      
      public function destroy() : void
      {
         if(this._iFrame != null)
         {
            this._iFrame.destroy();
         }
         removeEventListener(Event.RENDER,this.forwardEventIn);
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public function play() : void
      {
         if(this._iFrame != null)
         {
            this._iFrame.play();
         }
      }
      
      public function pause() : void
      {
         if(this._iFrame != null)
         {
            this._iFrame.pause();
         }
      }
      
      public function stop() : void
      {
         if(this._iFrame != null)
         {
            this._iFrame.stop();
         }
      }
      
      public function seekTo(param1:Number, param2:Boolean = false) : void
      {
         if(this._iFrame != null)
         {
            this._iFrame.seekTo(param1,param2);
         }
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         this._width = param1;
         this._height = param2;
         if(this._iFrame != null)
         {
            this._iFrame.width = param1;
            this._iFrame.height = param2;
         }
         if(this._snapshot != null)
         {
            this._snapshot.width = param1;
            this._snapshot.height = param2;
         }
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = param1;
         if(this._iFrame != null)
         {
            this._iFrame.dispatchEvent(new Event(Event.RENDER));
         }
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = param1;
         if(this._iFrame != null)
         {
            this._iFrame.dispatchEvent(new Event(Event.RENDER));
         }
      }
      
      override public function set rotation(param1:Number) : void
      {
         this._iFrame.rotation = param1;
      }
      
      public function get active() : Boolean
      {
         this._iFrame.autoplay = this._autoplay && this._active;
         return this._active;
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function get height() : Number
      {
         return this._height;
      }
      
      public function set active(param1:Boolean) : void
      {
         this._active = param1;
         if(this._snapshot != null)
         {
            this._snapshot.visible = !this._active;
         }
         if(this._iFrame != null)
         {
            this._iFrame.visible = this._active;
            if(!this._active)
            {
               this._wasPlayingWhenActive = this._iFrame.state == YouTubeAPI.STATE_PLAYING || (this._iFrame.state == YouTubeAPI.STATE_UNSTARTED || this._iFrame.state == YouTubeAPI.STATE_BUFFERING) && this._iFrame.autoplay;
               this.pause();
            }
            else if(this._wasPlayingWhenActive)
            {
               this.play();
            }
         }
      }
      
      public function get appContainer() : DisplayObjectContainer
      {
         return this._appContainer;
      }
      
      public function set appContainer(param1:DisplayObjectContainer) : void
      {
         this._appContainer = param1;
      }
   }
}

