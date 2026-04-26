package com.moviestarplanet.notifications.model
{
   import com.moviestarplanet.notification.INotificationAppearanceObject;
   import com.moviestarplanet.notification.NotificationCategory;
   
   public class NotificationAppearanceObject extends NotificationObject implements INotificationAppearanceObject
   {
      
      private var _appearanceData:Object;
      
      public function NotificationAppearanceObject()
      {
         super();
      }
      
      public static function create(param1:int, param2:String, param3:String, param4:Object, param5:String = "", param6:int = 1, param7:String = "", param8:String = "") : NotificationAppearanceObject
      {
         var _loc9_:NotificationAppearanceObject = NotificationObject.createAsClass(NotificationAppearanceObject,param1,param2,param3,param5,NotificationCategory.APPEARANCE,param6,param7,param8) as NotificationAppearanceObject;
         _loc9_.appearanceData = param4;
         return _loc9_;
      }
      
      public function get appearanceData() : Object
      {
         return this._appearanceData;
      }
      
      public function set appearanceData(param1:Object) : void
      {
         this._appearanceData = param1;
      }
   }
}

