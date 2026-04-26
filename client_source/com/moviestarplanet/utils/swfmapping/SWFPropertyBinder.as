package com.moviestarplanet.utils.swfmapping
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.utils.ComponentUtilities;
   import com.moviestarplanet.utils.FontManager;
   import com.moviestarplanet.utils.MSP_SWFLoader;
   import com.moviestarplanet.utils.loader.ContentUrl;
   import com.moviestarplanet.utils.loader.RawUrl;
   import com.moviestarplanet.utils.swfmapping.visualmapping.AbstractPropertyMappingVisual;
   import com.moviestarplanet.utils.swfmapping.visualmapping.PropertyMappingVisualObjectInterface;
   import com.moviestarplanet.utils.swfmapping.visualmapping.PropertyMappingVisualUrlInterface;
   import com.moviestarplanet.window.stack.WindowStackableInterface;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import mx.containers.Canvas;
   import mx.core.UIComponent;
   import mx.events.PropertyChangeEvent;
   
   public class SWFPropertyBinder extends Canvas implements WindowStackableInterface
   {
      
      private var animation:MSP_SWFLoader;
      
      public var content:MovieClip;
      
      private var complete:Boolean;
      
      private var subcontentCache:Dictionary = new Dictionary();
      
      private var containerVisuals:Dictionary = new Dictionary();
      
      private var _671260250propertyMappings:Array = new Array();
      
      public function SWFPropertyBinder(param1:Boolean = true)
      {
         super();
         this.complete = false;
         this.animation = new MSP_SWFLoader(param1);
         this.animation.LoadCallBack = this.swfComplete;
      }
      
      public function addPropertyMapping(param1:PropertyMappingInterface) : void
      {
         param1.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.mappingChanged);
         this.propertyMappings.push(param1);
      }
      
      private function mappingChanged(param1:PropertyChangeEvent) : void
      {
         var _loc2_:PropertyMappingInterface = PropertyMappingInterface(param1.source);
         if(this.content != null)
         {
            this.modelProperty(_loc2_);
         }
      }
      
      public function set contentUrl(param1:String) : void
      {
         this.animation.LoadUrl(new ContentUrl(param1,ContentUrl.SWF));
      }
      
      public function set url(param1:String) : void
      {
         this.animation.LoadUrl(new RawUrl(param1));
      }
      
      public function get isComplete() : Boolean
      {
         return this.complete;
      }
      
      public function getContent() : MovieClip
      {
         return this.content;
      }
      
      public function getSubContent(param1:PathSelectorInterface, param2:Boolean = true) : MovieClip
      {
         var _loc3_:Array = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(this.subcontentCache[param1] != null)
         {
            return this.subcontentCache[param1];
         }
         _loc3_ = param1.getIdentifiers();
         _loc4_ = this.content;
         _loc5_ = int(_loc3_.length);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = ComponentUtilities.findInstanceBFS(_loc3_[_loc6_],_loc4_);
            _loc6_++;
         }
         if(param2 == true)
         {
            this.subcontentCache[param1] = _loc4_;
         }
         return _loc4_ as MovieClip;
      }
      
      protected function swfComplete(param1:MSP_SWFLoader) : void
      {
         this.content = MovieClip(this.animation.content.root);
         FontManager.remapAllFontsForDisplayObject(this.content);
         this.determineSize();
         var _loc2_:UIComponent = new UIComponent();
         _loc2_.addChild(this.content);
         addChild(_loc2_);
         this.modelProperties();
         this.complete = true;
         dispatchEvent(new MsgEvent(MSPEvent.PROPERTY_BINDER_CONTENT_READY));
      }
      
      private function determineSize() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(width == 0 && height == 0)
         {
            width = this.content.width;
            height = this.content.height;
         }
         else
         {
            _loc1_ = width / this.content.loaderInfo.width;
            _loc2_ = height / this.content.loaderInfo.height;
            this.content.scaleX = Math.min(_loc2_,_loc1_);
            this.content.scaleY = Math.min(_loc2_,_loc1_);
            this.content.x = (width - this.content.loaderInfo.width * this.content.scaleX) / 2;
            this.content.y = (height - this.content.loaderInfo.height * this.content.scaleY) / 2;
         }
      }
      
      private function modelProperty(param1:PropertyMappingInterface) : void
      {
         var _loc6_:DisplayObject = null;
         var _loc7_:Array = null;
         var _loc8_:DisplayObject = null;
         var _loc2_:Array = param1.getPathSelector().getIdentifiers();
         var _loc3_:Array = new Array();
         _loc3_.push(this.content);
         var _loc4_:int = int(_loc2_.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = new Array();
            for each(_loc8_ in _loc3_)
            {
               if(_loc2_[_loc5_] is Class)
               {
                  _loc7_.push(ComponentUtilities.findInstancesByClass(_loc8_,_loc2_[_loc5_]));
               }
               else
               {
                  _loc7_.push(ComponentUtilities.findInstanceBFS(_loc2_[_loc5_],_loc8_));
               }
            }
            _loc3_ = ComponentUtilities.flattenArray(_loc7_);
            _loc5_++;
         }
         for each(_loc6_ in _loc3_)
         {
            if(_loc6_ != null)
            {
               if(param1 is PropertyMappingValueInterface)
               {
                  this.modelValue(_loc6_,PropertyMappingValueInterface(param1));
               }
               else if(param1 is PropertyMappingActionInterface)
               {
                  this.modelAction(_loc6_,PropertyMappingActionInterface(param1));
               }
               else if(param1 is PropertyMappingVisualObjectInterface)
               {
                  this.modelVisualObject(_loc6_,PropertyMappingVisualObjectInterface(param1));
               }
               else if(param1 is PropertyMappingVisualUrlInterface)
               {
                  this.modelVisualUrl(_loc6_,PropertyMappingVisualUrlInterface(param1));
               }
            }
         }
      }
      
      private function modelVisualUrl(param1:DisplayObject, param2:PropertyMappingVisualUrlInterface) : void
      {
         var swfLoader:MSP_SWFLoader = null;
         var iComplete:Function = null;
         var instance:DisplayObject = param1;
         var modelVisual:PropertyMappingVisualUrlInterface = param2;
         iComplete = function(param1:Event):void
         {
            if(instance is DisplayObjectContainer)
            {
               insertVisualObject(instance as DisplayObjectContainer,swfLoader.content,modelVisual.getFittingStrategy());
            }
         };
         swfLoader = new MSP_SWFLoader();
         swfLoader.addEventListener(Event.COMPLETE,iComplete);
         swfLoader.source = modelVisual.getVisualUrl();
         swfLoader.load();
      }
      
      private function modelVisualObject(param1:DisplayObject, param2:PropertyMappingVisualObjectInterface) : void
      {
         var _loc3_:DisplayObjectContainer = null;
         var _loc4_:DisplayObject = null;
         if(param1 is DisplayObjectContainer)
         {
            _loc3_ = DisplayObjectContainer(param1);
            _loc4_ = param2.getVisualObject();
            this.insertVisualObject(_loc3_,_loc4_,param2.getFittingStrategy());
         }
      }
      
      private function insertVisualObject(param1:DisplayObjectContainer, param2:DisplayObject, param3:int) : void
      {
         var _loc4_:DisplayObject = null;
         var _loc5_:Rectangle = null;
         var _loc6_:Rectangle = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         if(param2 != null)
         {
            _loc4_ = this.containerVisuals[param1];
            if(_loc4_ != null)
            {
               param1.removeChild(_loc4_);
            }
            _loc5_ = param1.getBounds(param1);
            _loc6_ = param2.getBounds(param2);
            param1.addChild(param2);
            this.containerVisuals[param1] = param2;
            _loc7_ = _loc5_.width / (_loc6_.width + Math.abs(_loc6_.x) * 2);
            _loc8_ = _loc5_.height / (_loc6_.height + Math.abs(_loc6_.y) * 2);
            param2.scaleX = 1;
            param2.scaleY = 1;
            switch(param3)
            {
               case AbstractPropertyMappingVisual.FITTING_STRATEGY_KEEP_ASPECT:
                  _loc9_ = Math.min(_loc7_,_loc8_) - 0.05;
                  param2.scaleX *= _loc9_;
                  param2.scaleY *= _loc9_;
                  break;
               case AbstractPropertyMappingVisual.FITTING_STRATEGY_STRETCH:
                  param2.scaleX *= _loc7_;
                  param2.scaleY *= _loc8_;
                  break;
               default:
                  throw new Error("Unhandled fitting strategy " + param3);
            }
            param2.x = _loc5_.x + (_loc5_.width - (_loc6_.width + _loc6_.x * 2) * _loc9_) / 2;
            param2.y = _loc5_.y + (_loc5_.height - (_loc6_.height + _loc6_.y * 2) * _loc9_) / 2;
         }
      }
      
      private function modelAction(param1:DisplayObject, param2:PropertyMappingActionInterface) : void
      {
         var internalClicked:Function = null;
         var internalMouseOver:Function = null;
         var internalMouseOut:Function = null;
         var instance:DisplayObject = param1;
         var actionMapping:PropertyMappingActionInterface = param2;
         internalClicked = function(param1:Event):void
         {
            var _loc2_:Function = actionMapping.getClick();
            if(_loc2_ != null)
            {
               _loc2_(actionMapping.getData());
            }
         };
         internalMouseOver = function(param1:MouseEvent):void
         {
            buttonMode = true;
         };
         internalMouseOut = function(param1:MouseEvent):void
         {
            buttonMode = false;
         };
         instance.addEventListener(MouseEvent.CLICK,internalClicked);
         instance.addEventListener(MouseEvent.MOUSE_OVER,internalMouseOver);
         instance.addEventListener(MouseEvent.MOUSE_OUT,internalMouseOut);
      }
      
      private function modelValue(param1:DisplayObject, param2:PropertyMappingValueInterface) : void
      {
         var _loc3_:* = param2.getValue();
         if(_loc3_ != null && param1 != null)
         {
            param1[param2.getProperty()] = param2.getValue();
         }
      }
      
      private function modelProperties() : void
      {
         var _loc1_:PropertyMappingInterface = null;
         for each(_loc1_ in this.propertyMappings)
         {
            if(!_loc1_.hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE))
            {
               _loc1_.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.mappingChanged);
            }
            this.modelProperty(_loc1_);
         }
      }
      
      private function findInstance(param1:String, param2:DisplayObjectContainer) : DisplayObject
      {
         var _loc4_:DisplayObject = null;
         var _loc5_:DisplayObject = null;
         var _loc3_:int = 0;
         while(_loc3_ < param2.numChildren)
         {
            _loc4_ = param2.getChildAt(_loc3_);
            if(_loc4_.name == param1)
            {
               return _loc4_;
            }
            if(_loc4_ is DisplayObjectContainer)
            {
               _loc5_ = this.findInstance(param1,DisplayObjectContainer(_loc4_));
               if(_loc5_ != null)
               {
                  return _loc5_;
               }
            }
            _loc3_++;
         }
         return null;
      }
      
      [Bindable(event="propertyChange")]
      public function get propertyMappings() : Array
      {
         return this._671260250propertyMappings;
      }
      
      public function set propertyMappings(param1:Array) : void
      {
         var _loc2_:Object = this._671260250propertyMappings;
         if(_loc2_ !== param1)
         {
            this._671260250propertyMappings = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"propertyMappings",_loc2_,param1));
            }
         }
      }
   }
}

