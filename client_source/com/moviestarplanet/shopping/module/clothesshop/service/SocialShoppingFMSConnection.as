package com.moviestarplanet.shopping.module.clothesshop.service
{
   import com.moviestarplanet.chatutils.ChatServerConnection;
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.model.notification.Notification;
   import com.moviestarplanet.notification.INotificationListener;
   import com.moviestarplanet.utils.net.ConnectionUtils;
   import flash.utils.ByteArray;
   
   public class SocialShoppingFMSConnection extends ChatServerConnection
   {
      
      [Inject]
      public var notificationListener:INotificationListener;
      
      private var _chatServerUrl:String;
      
      public function SocialShoppingFMSConnection(param1:int, param2:String, param3:String)
      {
         super(param1,param2);
         this._chatServerUrl = param3;
         InjectionManager.manager().injectMe(this);
      }
      
      public function sendRawData(param1:String, param2:Object) : void
      {
         ConnectionUtils.setTextInSo(_sharedObject,"tmp",param1);
         ConnectionUtils.setObjectInSo("obj",param2,_sharedObject);
         _sharedObject.send();
      }
      
      override protected function getChatServerName(param1:Function, param2:Function) : void
      {
         param1(this._chatServerUrl);
      }
      
      override protected function processIncommingData(param1:Object) : void
      {
         var ba:ByteArray = null;
         var activityObj:Object = null;
         var notification:Notification = null;
         var item:Object = param1;
         if(item.code == "change" && item.name == "obj")
         {
            ba = _sharedObject.data["obj"] as ByteArray;
            if(ba != null && ba.length > 0)
            {
               try
               {
                  ba.uncompress();
                  activityObj = SerializeUtils.deserialize(ba);
                  notification = Notification.fromObject(activityObj);
                  this.notificationListener.onNotification(notification);
               }
               catch(error:Error)
               {
               }
            }
         }
      }
   }
}

