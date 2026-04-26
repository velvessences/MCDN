package com.moviestarplanet.Forms.minigame.queue
{
   import com.moviestarplanet.chatutils.ComServerConnection;
   import com.moviestarplanet.model.ActorSession;
   import flash.events.NetStatusEvent;
   import flash.net.NetConnection;
   import flash.net.Responder;
   
   public class OperatorRequester
   {
      
      private static const LOAD_BAL_NAME:String = "_OPERATOR";
      
      private static var requestingFromLoadBalServ:Boolean = false;
      
      private static var connection:NetConnection = null;
      
      public function OperatorRequester()
      {
         super();
      }
      
      public static function getAppServForAppType(param1:String, param2:String, param3:Function) : void
      {
         var onRoomRequestReturn:Function = null;
         var onStatus:Function = null;
         var serverName:String = param1;
         var appType:String = param2;
         var callback:Function = param3;
         onRoomRequestReturn = function(param1:String):void
         {
            var _loc2_:String = param1.split("/")[1];
            callback(_loc2_);
            requestingFromLoadBalServ = false;
            connection.close();
         };
         onStatus = function(param1:NetStatusEvent):void
         {
            if(requestingFromLoadBalServ)
            {
               if(param1.info.code == "NetConnection.Connect.Success")
               {
                  connection.call("getNextAppServ",new Responder(onRoomRequestReturn,null));
               }
               else
               {
                  requestingFromLoadBalServ = false;
                  callback("");
                  if(connection.connected)
                  {
                     connection.close();
                  }
               }
            }
         };
         if(!requestingFromLoadBalServ)
         {
            requestingFromLoadBalServ = true;
            connection = new NetConnection();
            connection.connect(ComServerConnection.curProtocol + serverName + "/" + appType + LOAD_BAL_NAME,ActorSession.loggedInActor.ActorId);
            connection.addEventListener(NetStatusEvent.NET_STATUS,onStatus);
         }
      }
   }
}

