package com.moviestarplanet.service
{
   import com.hurlant.crypto.hash.MD5;
   import com.hurlant.util.Hex;
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.globalsharedutils.messaging.MessageStyleUtility;
   import com.moviestarplanet.notification.INotification;
   import com.moviestarplanet.utils.Hashids;
   
   public class PushNotificationsAMFServiceWeb
   {
      
      protected var amfCaller:AmfCaller;
      
      private const CONVERSATION_ID_SALT:String = "msp-push-notification-911-salt";
      
      private const CONVERSATION_ID_MIN_CHARS:int = 11;
      
      private const HASH_ALPHABET:String = "abcdefghijklmnopqrstuvwxyz1234567890";
      
      public function PushNotificationsAMFServiceWeb()
      {
         super();
         this.amfCaller = new AmfCaller(this.amfEndPoint);
      }
      
      protected function get amfEndPoint() : String
      {
         return "MovieStarPlanet.WebService.AMFPushNotifications";
      }
      
      public function addActorsToGroupChat(param1:Array, param2:int, param3:String, param4:String, param5:Function = null) : void
      {
         this.amfCaller.callFunction("ActorAddedToGroupChat",[this.getHashedString(param1),param2,param3,param4],true,param5);
      }
      
      public function sendMessageToMany(param1:Array, param2:String, param3:INotification, param4:int = -1, param5:String = null, param6:String = null, param7:Function = null) : void
      {
         var _loc8_:String = this.createMessageFromNotification(param2,param3);
         this.amfCaller.callFunction("SendMessage",[_loc8_,this.getHashedMessage(_loc8_),this.getHashedString(param1),param4,null,param6],true,param7);
      }
      
      public function sendStringMessageToMany(param1:Array, param2:String, param3:String, param4:int = -1, param5:String = null, param6:String = null, param7:Function = null) : void
      {
         var _loc8_:String = this.createMessageFromString(param2,param3);
         this.amfCaller.callFunction("SendMessage",[_loc8_,this.getHashedMessage(_loc8_),this.getHashedString(param1),param4,param5,param6],true,param7);
      }
      
      public function sendMessage(param1:int, param2:String, param3:INotification, param4:int = -1, param5:Function = null) : void
      {
         var _loc6_:String = this.createMessageFromNotification(param2,param3);
         this.amfCaller.callFunction("SendMessage",[_loc6_,this.getHashedMessage(_loc6_),this.getHashedString(param1),param4,null,null],true,param5);
      }
      
      public function sendStringMessage(param1:int, param2:String, param3:String, param4:int = -1, param5:Function = null) : void
      {
         var _loc6_:String = this.createMessageFromString(param2,param3);
         this.amfCaller.callFunction("SendMessage",[_loc6_,this.getHashedMessage(_loc6_),this.getHashedString(param1),param4,null,null],true,param5);
      }
      
      public function SendFriendRequest(param1:int, param2:int = -1, param3:Function = null) : void
      {
         this.amfCaller.callFunction("FriendRequestSent",[param1,param2],true,param3);
      }
      
      public function SendBestFriendRequest(param1:int, param2:Function = null) : void
      {
         this.amfCaller.callFunction("BestFriendRequestSent",[param1],true,param2);
      }
      
      public function SendBoyfriendRequest(param1:int, param2:Function = null) : void
      {
         this.amfCaller.callFunction("BoyfriendRequestSent",[param1],true,param2);
      }
      
      public function registerDevice(param1:String, param2:String, param3:Function = null, param4:Function = null) : void
      {
         this.amfCaller.callFunction("RegisterDevice",[param1,param2],true,param3,param4);
      }
      
      public function unregisterDevice(param1:String, param2:Function = null) : void
      {
         this.amfCaller.callFunction("UnregisterDevice",[param1],true,param2);
      }
      
      internal function createMessageFromNotification(param1:String, param2:INotification) : String
      {
         var _loc3_:String = param2.rawObj["blacklistedMessage"];
         _loc3_ = MessageStyleUtility.removeFontCode(_loc3_);
         return param1 + ": " + _loc3_;
      }
      
      internal function createMessageFromString(param1:String, param2:String) : String
      {
         var _loc3_:String = param2;
         _loc3_ = MessageStyleUtility.removeFontCode(_loc3_);
         return param1 + ": " + _loc3_;
      }
      
      internal function getHashedString(param1:*) : String
      {
         var _loc2_:Hashids = new Hashids(this.CONVERSATION_ID_SALT,this.CONVERSATION_ID_MIN_CHARS,this.HASH_ALPHABET);
         return _loc2_.encode(param1);
      }
      
      internal function getHashedMessage(param1:String) : String
      {
         var _loc2_:MD5 = new MD5();
         return Hex.fromArray(_loc2_.hash(Hex.toArray(Hex.fromString(param1))));
      }
   }
}

