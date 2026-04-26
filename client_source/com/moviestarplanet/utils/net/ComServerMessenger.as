package com.moviestarplanet.utils.net
{
   import com.moviestarplanet.chatutils.ComServerConnector;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.model.notification.Notification;
   import com.moviestarplanet.notification.INotificationChannel;
   import com.moviestarplanet.notification.INotificationListener;
   import flash.events.SyncEvent;
   import flash.net.NetConnection;
   import flash.net.Responder;
   import flash.net.SharedObject;
   import flash.utils.ByteArray;
   
   public class ComServerMessenger
   {
      
      public static var notificationListener:INotificationListener;
      
      public static var notificationChannel:INotificationChannel;
      
      public static var persistSOs:Boolean = true;
      
      private static var text_so:SharedObject = null;
      
      private static var isFirstTimeSync:Boolean = true;
      
      public function ComServerMessenger()
      {
         super();
      }
      
      public static function onComServConnect(param1:MsgEvent) : void
      {
         var con:NetConnection = null;
         var persistReturned:Function = null;
         var e:MsgEvent = param1;
         persistReturned = function(param1:Boolean):void
         {
            persistSOs = param1;
            if(text_so == null)
            {
               text_so = SharedObject.getRemote("actorId-" + ActorSession.getActorId(),con.uri,persistSOs);
               text_so.addEventListener(SyncEvent.SYNC,onMessage);
            }
            text_so.connect(con);
         };
         con = ComServerConnector.getNetCon(ActorSession.getActorId());
         var responder:Responder = new Responder(persistReturned);
         con.call("doPersistConnections",responder);
      }
      
      public static function onMessage(param1:SyncEvent) : void
      {
         var e:SyncEvent = param1;
         if(isFirstTimeSync)
         {
            isFirstTimeSync = false;
            return;
         }
         if(Boolean(text_so.data.hasOwnProperty("obj")) && text_so.data["obj"] != null)
         {
            try
            {
               parseObject(text_so.data["obj"]);
            }
            catch(error:Error)
            {
               if(text_so.data.hasOwnProperty("tmp"))
               {
                  parseString(text_so.data["tmp"]);
               }
            }
         }
         else if(text_so.data.hasOwnProperty("tmp"))
         {
            parseString(text_so.data["tmp"]);
         }
      }
      
      private static function parseObject(param1:Object) : void
      {
         var _loc3_:Object = null;
         var _loc2_:ByteArray = param1 as ByteArray;
         if(_loc2_ != null && _loc2_.length > 0)
         {
            try
            {
               _loc2_.uncompress();
               _loc3_ = SerializeUtils.deserialize(_loc2_);
               postNotification(_loc3_);
            }
            catch(error:Error)
            {
            }
         }
      }
      
      private static function parseString(param1:Object) : void
      {
         var _loc2_:String = param1 as String;
         postNotificationStr(_loc2_);
      }
      
      public static function postNotification(param1:Object) : void
      {
         var _loc2_:Notification = Notification.fromObject(param1);
         postNotificationInner(param1.toString(),_loc2_);
      }
      
      public static function postNotificationStr(param1:String) : void
      {
         var _loc2_:Notification = Notification.fromString(param1);
         postNotificationInner(param1,_loc2_);
      }
      
      private static function postNotificationInner(param1:String, param2:Notification) : void
      {
         if(Boolean(param2.type) && param2.type == "CONNECTED")
         {
            if(notificationChannel == null)
            {
               throw new Error("notificationChannel should be set in ComServerMessenger");
            }
            notificationChannel.connectToFriend(param2.actorId);
         }
         else if(Boolean(param2.type) && param2.type != "")
         {
            notificationListener.onNotification(param2);
         }
      }
   }
}

