package
{
   import flash.display.DisplayObjectContainer;
   import flash.geom.Rectangle;
   
   public class ApplicationReference
   {
      
      private static const applicationSize:Rectangle = new Rectangle(235,80,980,500);
      
      public function ApplicationReference()
      {
         super();
      }
      
      public static function getApplicationSize() : Rectangle
      {
         return applicationSize.clone();
      }
      
      public static function getApplicationRoot() : DisplayObjectContainer
      {
         return Main.Instance.mainCanvas;
      }
      
      public static function getApplicationScale() : Number
      {
         var _loc1_:DisplayObjectContainer = getApplicationRoot();
         return Math.min(_loc1_.scaleX,_loc1_.scaleY);
      }
   }
}

