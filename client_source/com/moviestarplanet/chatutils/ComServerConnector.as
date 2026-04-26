package com.moviestarplanet.chatutils
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.connection.IComServerConnection;
   import com.moviestarplanet.connection.IComServerConnector;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import flash.net.NetConnection;
   
   public class ComServerConnector implements IComServerConnector
   {
      
      private static var AppSetting:Function;
      
      private static var savedActorId:int;
      
      private static var connectedCount:int = 0;
      
      private static var totalComServers:int = 0;
      
      private static var comServUrlToNetConnection:Object = {};
      
      public function ComServerConnector()
      {
         super();
      }
      
      public static function registerListeners(param1:Function) : void
      {
         trace("ComServerConnector registerListeners");
         AppSetting = param1;
         MessageCommunicator.subscribe(MSPEvent.LOGIN_SUCCESS,onLoginSuccessHandler);
         MessageCommunicator.subscribe(MSPEvent.DO_LOGOUT,onDoLogoutHandler);
         MessageCommunicator.subscribe(MSPEvent.COMSERV_RECONNECTING,onComServReconnecting);
         MessageCommunicator.subscribe(MSPEvent.DO_LOGOUT_ALL_SESSIONS,closeAllSessions);
      }
      
      private static function onLoginSuccessHandler(param1:MsgEvent) : void
      {
         trace("ComServerConnector onLoginSuccessHandler");
         onLoginSuccessInternal(param1.data.actor.actorId);
      }
      
      private static function onLoginSuccessInternal(param1:int) : void
      {
         var onConnectionSuccess:Function = null;
         var onAppSettings:Function = null;
         var userId:int = param1;
         onConnectionSuccess = function(param1:ComServerConnection):void
         {
            trace("ComServerConnector onConnectionSuccess");
            recountConnected();
            if(connectedCount == totalComServers)
            {
               MessageCommunicator.send(new MsgEvent(MSPEvent.COMSERV_SUCCESS));
            }
         };
         onAppSettings = function(param1:String):void
         {
            var _loc3_:String = null;
            trace("ComServerConnector onAppSettings attempting to connect to " + param1);
            var _loc2_:Array = param1.split(";");
            totalComServers = _loc2_.length;
            for each(_loc3_ in _loc2_)
            {
               comServUrlToNetConnection[_loc3_] = new ComServerConnection(_loc3_,onConnectionSuccess,userId);
            }
         };
         savedActorId = userId as int;
         AppSetting("CommFMSServer",onAppSettings);
      }
      
      public static function getNetCon(param1:Number) : NetConnection
      {
         var _loc2_:ComServerConnection = getComConnection(param1);
         if(_loc2_ != null)
         {
            return getComConnection(param1).netConnection;
         }
         return null;
      }
      
      private static function getComConnection(param1:Number) : ComServerConnection
      {
         var _loc3_:ComServerConnection = null;
         var _loc2_:Array = [];
         for each(_loc3_ in comServUrlToNetConnection)
         {
            _loc2_.push(_loc3_);
         }
         _loc2_ = _loc2_.sortOn("uri",Array.DESCENDING | Array.CASEINSENSITIVE);
         return _loc2_[param1 % _loc2_.length] as ComServerConnection;
      }
      
      private static function onDoLogoutHandler(param1:MsgEvent) : void
      {
         onDoLogoutInternal();
      }
      
      private static function onDoLogoutInternal() : void
      {
         var _loc1_:ComServerConnection = null;
         for each(_loc1_ in comServUrlToNetConnection)
         {
            _loc1_.closeConnection();
         }
         comServUrlToNetConnection = {};
      }
      
      private static function onComServReconnecting(param1:MsgEvent) : void
      {
         recountConnected();
      }
      
      private static function recountConnected() : void
      {
         var _loc2_:ComServerConnection = null;
         var _loc1_:int = 0;
         for each(_loc2_ in comServUrlToNetConnection)
         {
            if(_loc2_.connected)
            {
               _loc1_++;
            }
         }
         connectedCount = _loc1_;
         trace("ComServerConnector recountConnected " + connectedCount);
      }
      
      public static function callOnAllServers(param1:String, param2:*) : void
      {
         var _loc3_:ComServerConnection = null;
         for each(_loc3_ in comServUrlToNetConnection)
         {
            _loc3_.netConnection.call(param1,null,param2);
         }
      }
      
      public static function get connected() : Boolean
      {
         var _loc1_:ComServerConnection = null;
         for each(_loc1_ in comServUrlToNetConnection)
         {
            if(_loc1_.connected == false)
            {
               trace("ComServerConnector connection not connected " + _loc1_.uri);
               return false;
            }
         }
         if(connectedCount > 0)
         {
            trace("ComServerConnector connected ok");
         }
         return true;
      }
      
      public static function get serverList() : Array
      {
         var _loc2_:ComServerConnection = null;
         var _loc1_:Array = [];
         for each(_loc2_ in comServUrlToNetConnection)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      private static function closeAllSessions(param1:MsgEvent) : void
      {
         if(param1.data == null || !param1.data is int)
         {
            return;
         }
         var _loc2_:int = param1.data;
         closeAllSessionsInternal(_loc2_);
      }
      
      private static function closeAllSessionsInternal(param1:int) : void
      {
         var onConnectionSuccess:Function = null;
         var onAppSettings:Function = null;
         var actorId:int = param1;
         onConnectionSuccess = function(param1:ComServerConnection):void
         {
            recountConnected();
            if(connectedCount == totalComServers)
            {
               onDoLogoutInternal();
            }
         };
         onAppSettings = function(param1:String):void
         {
            var _loc3_:String = null;
            var _loc2_:Array = param1.split(";");
            totalComServers = _loc2_.length;
            for each(_loc3_ in _loc2_)
            {
               comServUrlToNetConnection[_loc3_] = new ComServerConnection(_loc3_,onConnectionSuccess,actorId);
            }
         };
         AppSetting("CommFMSServer",onAppSettings);
      }
      
      public function onLoginSuccess(param1:Number) : void
      {
         trace("ComServerConnector onLoginSuccess");
         onLoginSuccessInternal(param1);
      }
      
      public function getNetConnection(param1:Number) : NetConnection
      {
         return getNetCon(param1);
      }
      
      public function getComServerConnection(param1:Number) : IComServerConnection
      {
         return getComConnection(param1);
      }
      
      public function onDoLogout() : void
      {
         onDoLogoutInternal();
      }
      
      public function callOnAllConnections(param1:String, param2:*) : void
      {
         callOnAllServers(param1,param2);
      }
      
      public function get isConnected() : Boolean
      {
         return connected;
      }
      
      public function get connectionList() : Array
      {
         return serverList;
      }
      
      public function close() : void
      {
         onDoLogoutInternal();
      }
      
      public function closeAllConnections() : void
      {
         closeAllSessionsInternal(savedActorId as int);
      }
      
      public function get userId() : int
      {
         return savedActorId;
      }
   }
}

