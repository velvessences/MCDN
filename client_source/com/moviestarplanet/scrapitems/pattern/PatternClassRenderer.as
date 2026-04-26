package com.moviestarplanet.scrapitems.pattern
{
   import com.moviestarplanet.scrapitems.msg.ScrapItemEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class PatternClassRenderer extends PatternRenderer
   {
      
      private var clazz:Class;
      
      public function PatternClassRenderer(param1:Class, param2:MovieClip, param3:Number, param4:Number)
      {
         super(param2,param3,param4);
         this.clazz = param1;
      }
      
      override public function repaint() : void
      {
         var _loc4_:int = 0;
         var _loc5_:Sprite = null;
         var _loc1_:int = int(Math.ceil(diameter / (caWidth * patternScale)));
         var _loc2_:int = int(Math.ceil(diameter / (caHeight * patternScale)));
         removeChildren();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc1_)
            {
               _loc5_ = tiles[_loc3_ * _loc1_ + _loc4_];
               if(_loc5_ == null)
               {
                  _loc5_ = new this.clazz();
                  tiles.push(_loc5_);
                  invalidateColor();
               }
               addChild(_loc5_);
               _loc5_.x = _loc4_ * caWidth * patternScale;
               _loc5_.y = _loc3_ * caHeight * patternScale;
               _loc5_.scaleX = patternScale;
               _loc5_.scaleY = patternScale;
               _loc4_++;
            }
            _loc3_++;
         }
         if(colorInvalid)
         {
            reApplyColor();
         }
         dispatchEvent(new ScrapItemEvent(ScrapItemEvent.RENDERER_COMPLETE));
      }
   }
}

