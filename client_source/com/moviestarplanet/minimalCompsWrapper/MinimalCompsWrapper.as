package com.moviestarplanet.minimalCompsWrapper
{
   import com.bit101.components.Component;
   import com.bit101.components.HUISlider;
   import com.bit101.components.Label;
   import com.bit101.components.Panel;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.utils.Dictionary;
   
   public class MinimalCompsWrapper
   {
      
      private static var parent:DisplayObjectContainer;
      
      private static var panels:Dictionary = new Dictionary();
      
      private static var components:Dictionary = new Dictionary();
      
      private static var padding:Number = 10;
      
      private static const IS_DEBUG:Boolean = false;
      
      public function MinimalCompsWrapper()
      {
         super();
      }
      
      public static function getParent() : DisplayObjectContainer
      {
         if(parent == null)
         {
            parent = new Sprite();
         }
         return parent;
      }
      
      public static function showMinimalComps(param1:String, param2:Stage) : void
      {
         parent.x = 0;
         param2.addChild(parent);
         var _loc3_:Panel = Panel(panels[param1]);
         _loc3_.visible = true;
      }
      
      public static function hideMinimalComps() : void
      {
      }
      
      public static function createPanel(param1:String, param2:Number = 100, param3:Number = 200) : void
      {
         var _loc6_:Object = null;
         var _loc7_:Label = null;
         var _loc8_:String = null;
         var _loc9_:Panel = null;
         if(!IS_DEBUG)
         {
            return;
         }
         if(panels[param1] != null)
         {
            return;
         }
         var _loc4_:Panel = new Panel(getParent(),0,0);
         _loc4_.name = param1;
         _loc4_.setSize(param2,param3);
         var _loc5_:Number = 0;
         for(_loc6_ in panels)
         {
            _loc8_ = String(_loc6_);
            _loc9_ = panels[_loc6_];
            if(_loc9_.x > _loc5_)
            {
               _loc5_ = _loc9_.x + _loc9_.width;
            }
         }
         _loc4_.x = _loc5_ + padding;
         panels[param1] = _loc4_;
         _loc4_.visible = false;
         _loc7_ = new Label(_loc4_,padding,padding,param1);
      }
      
      private static function getComponent(param1:String) : Component
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc4_:Component = null;
         if(!IS_DEBUG)
         {
            return null;
         }
         for(_loc2_ in components)
         {
            _loc3_ = String(_loc2_);
            _loc4_ = components[_loc2_];
            if(_loc4_.name == param1)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public static function addPercentage(param1:String, param2:String, param3:* = null) : void
      {
         if(!IS_DEBUG)
         {
            return;
         }
         var _loc4_:Panel = Panel(panels[param1]);
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:Number = 0;
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.content.numChildren)
         {
            if(_loc5_ < _loc4_.content.getChildAt(_loc6_).y)
            {
               _loc5_ = _loc4_.content.getChildAt(_loc6_).y + _loc4_.content.getChildAt(_loc6_).height;
            }
            _loc6_++;
         }
         var _loc7_:HUISlider = new HUISlider(panels[param1],0,_loc5_ + padding,param2.substr(param2.length - 20,20));
         _loc7_.name = param2;
         components[_loc7_] = _loc7_;
         _loc4_.height = _loc5_ + _loc7_.height + padding;
      }
      
      public static function updatePercentage(param1:String, param2:Number, param3:Number, param4:Number = 0.5) : void
      {
         if(!IS_DEBUG)
         {
            return;
         }
         var _loc5_:Component = getComponent(param1);
         if(_loc5_ == null)
         {
            return;
         }
         HUISlider(_loc5_).setSliderParams(param2,param3,param4);
      }
      
      public static function removePercentage(param1:String) : void
      {
         var _loc2_:Panel = null;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:Panel = null;
         if(!IS_DEBUG)
         {
            return;
         }
         if(param1.indexOf("Silhouettes") != -1)
         {
            trace("found one");
         }
         var _loc3_:Component = getComponent(param1);
         if(_loc3_ == null)
         {
            return;
         }
         for(_loc4_ in panels)
         {
            _loc5_ = String(_loc4_);
            _loc6_ = panels[_loc4_];
            if(_loc6_.contains(_loc3_))
            {
               _loc2_ = _loc6_;
            }
         }
         if(_loc2_ == null)
         {
            return;
         }
         removeFromPanel(param1,_loc2_.name);
         delete components[_loc3_];
      }
      
      public static function moveComponent(param1:String, param2:String, param3:String) : void
      {
         if(!IS_DEBUG)
         {
            return;
         }
         var _loc4_:Panel = panels[param2];
         var _loc5_:Panel = panels[param3];
         var _loc6_:Component = removeFromPanel(param1,param2);
         if(_loc6_ == null)
         {
            return;
         }
         addToPanel(_loc6_,param3);
      }
      
      private static function addToPanel(param1:Component, param2:String) : void
      {
         if(!IS_DEBUG)
         {
            return;
         }
         var _loc3_:Panel = Panel(panels[param2]);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:Number = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.content.numChildren)
         {
            if(_loc4_ <= _loc3_.content.getChildAt(_loc5_).y)
            {
               _loc4_ = _loc3_.content.getChildAt(_loc5_).y + _loc3_.content.getChildAt(_loc5_).height;
            }
            _loc5_++;
         }
         _loc3_.content.addChild(param1);
         param1.x = 0;
         param1.y = _loc4_ + padding;
         _loc3_.height = _loc4_ + param1.height + padding;
      }
      
      private static function removeFromPanel(param1:String, param2:String) : Component
      {
         var _loc3_:Component = null;
         var _loc9_:DisplayObject = null;
         var _loc10_:Component = null;
         if(!IS_DEBUG)
         {
            return null;
         }
         var _loc4_:Panel = panels[param2];
         var _loc5_:Number = 0;
         var _loc6_:Boolean = false;
         if(_loc4_ == null)
         {
            return null;
         }
         var _loc7_:int = 0;
         var _loc8_:int = int(_loc4_.content.numChildren);
         while(_loc7_ < _loc4_.content.numChildren)
         {
            if(param1 == _loc4_.content.getChildAt(_loc7_).name && !_loc6_)
            {
               _loc6_ = true;
               _loc3_ = Component(_loc4_.content.getChildAt(_loc7_));
               _loc4_.content.removeChild(_loc3_);
               _loc8_ = _loc7_;
               _loc5_ = _loc3_.height + padding;
            }
            if(_loc7_ >= _loc8_ && _loc7_ < _loc4_.content.numChildren)
            {
               _loc9_ = _loc4_.content.getChildAt(_loc7_);
               _loc9_.y -= _loc5_;
            }
            _loc7_++;
         }
         if(_loc4_.content.numChildren >= 1)
         {
            _loc10_ = Component(_loc4_.content.getChildAt(_loc4_.content.numChildren - 1));
            _loc4_.height = _loc10_.y + _loc10_.height + padding;
         }
         else if(_loc3_ != null)
         {
            _loc4_.height = _loc3_.height + padding;
         }
         return _loc3_;
      }
   }
}

