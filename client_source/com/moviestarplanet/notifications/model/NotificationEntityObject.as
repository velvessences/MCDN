package com.moviestarplanet.notifications.model
{
   import com.moviestarplanet.notification.INotificationEntityObject;
   import com.moviestarplanet.notification.NotificationCategory;
   
   public class NotificationEntityObject extends NotificationObject implements INotificationEntityObject
   {
      
      private var _entityId:int;
      
      private var _entityType:int;
      
      private var _snapshotSubPath:String;
      
      public function NotificationEntityObject()
      {
         super();
      }
      
      public static function create(param1:int, param2:String, param3:String, param4:int, param5:int, param6:String, param7:String = "", param8:int = 1, param9:String = "", param10:String = "") : NotificationEntityObject
      {
         var _loc11_:NotificationEntityObject = NotificationObject.createAsClass(NotificationEntityObject,param1,param2,param3,param7,NotificationCategory.ENTITY_CONTENT,param8,param9,param10) as NotificationEntityObject;
         _loc11_.entityId = param4;
         _loc11_.entityType = param5;
         _loc11_.entitySnapshotSubPath = param6;
         return _loc11_;
      }
      
      public function get entityId() : int
      {
         return this._entityId;
      }
      
      public function get entityType() : int
      {
         return this._entityType;
      }
      
      public function get entitySnapshotSubPath() : String
      {
         return this._snapshotSubPath;
      }
      
      public function set entityId(param1:int) : void
      {
         this._entityId = param1;
      }
      
      public function set entityType(param1:int) : void
      {
         this._entityType = param1;
      }
      
      public function set entitySnapshotSubPath(param1:String) : void
      {
         this._snapshotSubPath = param1;
      }
   }
}

