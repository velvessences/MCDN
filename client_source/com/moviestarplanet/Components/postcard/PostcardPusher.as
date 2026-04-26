package com.moviestarplanet.Components.postcard
{
   import com.moviestarplanet.window.stack.WindowStack;
   
   public class PostcardPusher
   {
      
      public function PostcardPusher()
      {
         super();
      }
      
      public static function showContentEmailForm(param1:Number, param2:Number, param3:String) : void
      {
         var _loc4_:SendContentAsMailPopup = new SendContentAsMailPopup();
         _loc4_.contentId = param1;
         _loc4_.contentType = param2;
         _loc4_.contentName = param3;
         WindowStack.showViewStackable(_loc4_,400,200,WindowStack.Z_NOTICE);
      }
   }
}

