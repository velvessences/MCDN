package com.moviestarplanet.Components.FontSelector
{
   import com.moviestarplanet.globalsharedutils.messaging.MessageStyleUtility;
   import com.moviestarplanet.utils.displayobject.DisplayObjectUtilities;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class FontColorSelector extends Sprite implements FontColorSelectorInterface
   {
      
      private static const PADDING_PERCENTAGE:Number = 0.2;
      
      public function FontColorSelector(param1:int, param2:int)
      {
         var _loc4_:ColorCube = null;
         super();
         var _loc3_:int = 0;
         while(_loc3_ < MessageStyleUtility.ALL_COLORS.length)
         {
            _loc4_ = new ColorCube(MessageStyleUtility.ALL_COLORS[_loc3_],param2);
            addChild(_loc4_);
            _loc4_.x = _loc3_ % param1 * (param2 + PADDING_PERCENTAGE * param2);
            _loc4_.y = Math.floor(_loc3_ / param1) * (param2 + PADDING_PERCENTAGE * param2);
            DisplayObjectUtilities.buttonize(_loc4_,this.colorClicked);
            _loc3_++;
         }
      }
      
      private function colorClicked(param1:Event) : void
      {
         var _loc2_:uint = uint(uint((param1.currentTarget as ColorCube).cubecolor));
         dispatchEvent(new FontColorSelectorEvent(FontColorSelectorEvent.FONTCOLOR_SELECTED,_loc2_));
      }
   }
}

