package com.moviestarplanet.color.mobilecolorpicker.display
{
   import com.moviestarplanet.color.mobilecolorpicker.events.DualEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.events.TouchEvent;
   import starling.events.TouchPhase;
   
   public class GraphicContainer extends EventDispatcher
   {
      
      public var displayObject:Object;
      
      public var customData:Object = new Object();
      
      private var _starling:Boolean;
      
      private var _clickListenerCount:int = 0;
      
      public function GraphicContainer(param1:Boolean)
      {
         super();
         this._starling = param1;
         if(param1)
         {
            this.displayObject = new starling.display.Sprite();
         }
         else
         {
            this.displayObject = new flash.display.Sprite();
         }
      }
      
      public function addChild(param1:Object) : void
      {
         if(param1 is starling.display.DisplayObject)
         {
            this.displayObject.addChild(param1 as starling.display.DisplayObject);
         }
         else if(param1 is flash.display.DisplayObject)
         {
            this.displayObject.addChild(param1 as flash.display.DisplayObject);
         }
         else
         {
            this.displayObject.addChild(param1.displayObject);
         }
      }
      
      public function removeChild(param1:Object) : void
      {
         if(param1 is starling.display.DisplayObject)
         {
            this.displayObject.removeChild(param1 as starling.display.DisplayObject);
         }
         else if(param1 is flash.display.DisplayObject)
         {
            this.displayObject.removeChild(param1 as flash.display.DisplayObject);
         }
         else
         {
            this.displayObject.removeChild(param1.displayObject);
         }
      }
      
      public function set rotation(param1:Number) : void
      {
         this.displayObject.rotation = param1;
      }
      
      public function set vertical(param1:Boolean) : void
      {
         if(this.displayObject is starling.display.DisplayObject)
         {
            this.displayObject.rotation = param1 ? Math.PI / 2 : 0;
         }
         else
         {
            this.displayObject.rotation = param1 ? 90 : 0;
         }
      }
      
      public function get vertical() : Boolean
      {
         return this.displayObject.rotation != 0;
      }
      
      public function set alpha(param1:Number) : void
      {
         this.displayObject.alpha = param1;
      }
      
      public function get alpha() : Number
      {
         return this.displayObject.alpha;
      }
      
      public function set x(param1:Number) : void
      {
         this.displayObject.x = param1;
      }
      
      public function get x() : Number
      {
         return this.displayObject.x;
      }
      
      public function set y(param1:Number) : void
      {
         this.displayObject.y = param1;
      }
      
      public function get y() : Number
      {
         return this.displayObject.y;
      }
      
      public function get width() : Number
      {
         return this.displayObject.width;
      }
      
      public function get height() : Number
      {
         return this.displayObject.height;
      }
      
      public function set visible(param1:Boolean) : void
      {
         this.displayObject.visible = param1;
      }
      
      public function get visible() : Boolean
      {
         return this.displayObject.visible;
      }
      
      public function get numChildren() : int
      {
         return this.displayObject.numChildren;
      }
      
      public function setChildIndex(param1:Object, param2:int) : void
      {
         this.displayObject.setChildIndex(param1,param2);
      }
      
      public function addListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(param1 == DualEvent.CLICK)
         {
            if(this._clickListenerCount == 0)
            {
               if(this._starling)
               {
                  Sprite(this.displayObject).addEventListener(TouchEvent.TOUCH,this.onTouch);
               }
               else
               {
                  Sprite(this.displayObject).addEventListener(MouseEvent.CLICK,this.onClick);
               }
            }
            ++this._clickListenerCount;
         }
         addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(param1 == DualEvent.CLICK)
         {
            --this._clickListenerCount;
            if(this._clickListenerCount == 0)
            {
               if(this._starling)
               {
                  Sprite(this.displayObject).addEventListener(TouchEvent.TOUCH,this.onTouch);
               }
               else
               {
                  Sprite(this.displayObject).addEventListener(MouseEvent.CLICK,this.onClick);
               }
            }
         }
         addEventListener(param1,param2,param3,param4,param5);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         dispatchEvent(new Event(DualEvent.CLICK));
      }
      
      private function onTouch(param1:TouchEvent) : void
      {
         if(param1.getTouch(Sprite(this.displayObject)) != null)
         {
            if(param1.getTouch(Sprite(this.displayObject)).phase == TouchPhase.ENDED)
            {
               dispatchEvent(new Event(DualEvent.CLICK));
            }
         }
      }
   }
}

