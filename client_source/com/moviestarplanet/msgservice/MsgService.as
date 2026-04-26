package com.moviestarplanet.msgservice
{
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.messenger.MSPMessenger;
   import com.moviestarplanet.msgservice.loading.MsgServicePath;
   import com.moviestarplanet.msgservice.loading.MsgServicePoster;
   import com.moviestarplanet.msgservice.loading.MsgServiceStatus;
   import com.moviestarplanet.msgservice.utils.MsgServiceHelpers;
   import com.moviestarplanet.msgservice.valueobjects.MsgServiceConversation;
   import com.moviestarplanet.service.restbase.RestBaseGetter;
   
   public class MsgService implements IMsgService
   {
      
      private static var _instance:MsgService;
      
      [Inject(name="messagesSessionTicket")]
      public var messagesSessionTicket:String;
      
      [Inject(name="msgServiceServerUrl")]
      public var msgServiceServerUrl:String;
      
      [Inject(name="oldMessagesServerUrl")]
      public var oldMessagesServerUrl:String;
      
      [Inject(name="sendMessagesToCassandra")]
      public var sendMessagesToCassandra:Boolean;
      
      private var mspMessenger:MSPMessenger;
      
      public function MsgService(param1:Class)
      {
         super();
         if(param1 != ConstructorBlocker)
         {
            throw new Error("MsgService is instantiated through MsgService.initialize(). To get a reference use MsgService.getInstance!");
         }
         InjectionManager.manager().injectMe(this);
         MSPMessenger.init(this.messagesSessionTicket,this.oldMessagesServerUrl);
         this.mspMessenger = MSPMessenger.get();
      }
      
      public static function getInstance() : MsgService
      {
         if(_instance == null)
         {
            throw new Error("MsgService needs to be initialized");
         }
         return _instance;
      }
      
      public static function initialize() : void
      {
         _instance = new MsgService(ConstructorBlocker);
      }
      
      public function sendMessage(param1:String, param2:Boolean, param3:Array, param4:String = null, param5:Function = null) : void
      {
         if(this.sendMessagesToCassandra)
         {
            this.mspMessenger.sendMessage(param1,param2,param3,param4,param5);
         }
      }
      
      public function getNewMessagesCount(param1:Function) : void
      {
         var _loc2_:Object = {"ticket":this.messagesSessionTicket};
         new RestBaseGetter(null,param1).load(this.msgServiceServerUrl + MsgServicePath.GET_NEW_MESSAGES_COUNT_PATH,_loc2_);
      }
      
      public function getActiveGroupConversations(param1:Array, param2:Function, param3:Function = null) : void
      {
         var _loc4_:String = this.getActorIdStringFromArray(param1);
         var _loc5_:Object = {"ticket":this.messagesSessionTicket};
         new RestBaseGetter(this.conversationListParserFactory,param2,param3).load(this.msgServiceServerUrl + MsgServicePath.GET_ACTIVE_GROUP_CONVERSATIONS_PATH,_loc5_);
      }
      
      public function getUserConversationStates(param1:Function, param2:Function = null) : void
      {
         var _loc3_:Object = {"ticket":this.messagesSessionTicket};
         new RestBaseGetter(this.userConversationStatesParserFactory,param1,param2).load(this.msgServiceServerUrl + MsgServicePath.GET_USER_CONVERSATION_STATES,_loc3_);
      }
      
      public function getConversations(param1:Date, param2:int, param3:Function, param4:Function = null) : void
      {
         var _loc5_:Date = null;
         var _loc6_:Object = {
            "ticket":this.messagesSessionTicket,
            "latestTimestamp":this.getTimestampMillis(param1),
            "pageSize":param2
         };
         new RestBaseGetter(this.conversationsParserFactory,param3,param4).load(this.msgServiceServerUrl + MsgServicePath.GET_CONVERSATIONS_PATH,_loc6_);
      }
      
      public function getConversation(param1:String, param2:Function, param3:Function = null) : void
      {
         var _loc4_:Object = {
            "ticket":this.messagesSessionTicket,
            "conversationId":param1
         };
         new RestBaseGetter(this.conversationParserFactory,param2,param3).load(this.msgServiceServerUrl + MsgServicePath.GET_CONVERSATION_PATH,_loc4_);
      }
      
      public function getMessages(param1:String, param2:Date, param3:int, param4:Function, param5:Function = null) : void
      {
         var _loc6_:Object = {
            "ticket":this.messagesSessionTicket,
            "conversationId":param1,
            "latestTimestamp":this.getTimestampMillis(param2),
            "pageSize":param3
         };
         new RestBaseGetter(this.messageParserFactory,param4,param5).load(this.msgServiceServerUrl + MsgServicePath.GET_MESSAGES_PATH,_loc6_);
      }
      
      public function getCassandraMessages(param1:String, param2:String, param3:int, param4:Function, param5:Function = null) : void
      {
         var _loc6_:Object = {
            "ticket":this.messagesSessionTicket,
            "conversationId":param1,
            "lastTimeUUID":param2,
            "pageSize":param3
         };
         new RestBaseGetter(this.messageParserFactory,param4,param5).load(this.msgServiceServerUrl + MsgServicePath.GET_ONE_TO_ONE_MESSAGES_PATH,_loc6_);
      }
      
      public function addUsersToConversation(param1:String, param2:Array, param3:Function = null) : void
      {
         var _loc4_:String = this.getActorIdStringFromArray(param2);
         var _loc5_:Object = {
            "ticket":this.messagesSessionTicket,
            "conversationId":param1,
            "addedUsers":_loc4_
         };
         new RestBaseGetter(this.statusParserFactory,param3).load(this.msgServiceServerUrl + MsgServicePath.ADD_USERS_TO_CONVERSATION_PATH,_loc5_);
      }
      
      public function markRead(param1:String, param2:Function = null) : void
      {
         var _loc3_:Object = {
            "ticket":this.messagesSessionTicket,
            "postParams":param1
         };
         new MsgServicePoster(this.statusParserFactory,param2).load(this.msgServiceServerUrl + MsgServicePath.MARK_READ_PATH,_loc3_);
      }
      
      public function setConversationHidden(param1:String, param2:Function = null) : void
      {
         var _loc3_:Object = {
            "ticket":this.messagesSessionTicket,
            "postParams":param1
         };
         new MsgServicePoster(this.statusParserFactory,param2).load(this.msgServiceServerUrl + MsgServicePath.SET_CONVERSATION_HIDDEN_PATH,_loc3_);
      }
      
      public function muteConversation(param1:String, param2:Function = null) : void
      {
         var _loc3_:Object = {
            "ticket":this.messagesSessionTicket,
            "postParams":param1
         };
         new MsgServicePoster(this.statusParserFactory,param2).load(this.msgServiceServerUrl + MsgServicePath.MUTE_CONVERSATION,_loc3_);
      }
      
      public function createConversation(param1:Array, param2:String = "", param3:Function = null, param4:Function = null) : void
      {
         var _loc5_:String = this.getActorIdStringFromArray(param1);
         var _loc6_:Object = {
            "ticket":this.messagesSessionTicket,
            "addedUsers":_loc5_,
            "conversationName":param2
         };
         new RestBaseGetter(this.conversationIdParserFactory,param3,param4).load(this.msgServiceServerUrl + MsgServicePath.CREATE_CONVERSATION_PATH,_loc6_);
      }
      
      public function renameConversation(param1:String, param2:String, param3:Function = null, param4:Function = null) : void
      {
         var _loc5_:Object = {
            "ticket":this.messagesSessionTicket,
            "conversationId":param1,
            "newName":param2
         };
         new RestBaseGetter(this.conversationIdParserFactory,param3,param4).load(this.msgServiceServerUrl + MsgServicePath.RENAME_CONVERSATION_PATH,_loc5_);
      }
      
      public function leaveConversation(param1:String, param2:Function = null) : void
      {
         var _loc3_:Object = {
            "ticket":this.messagesSessionTicket,
            "postParams":param1
         };
         new MsgServicePoster(this.statusParserFactory,param2).load(this.msgServiceServerUrl + MsgServicePath.LEAVE_CONVERSATION_PATH,_loc3_);
      }
      
      private function conversationIdParserFactory(param1:Object) : String
      {
         return JSON.parse(param1 as String) as String;
      }
      
      private function statusParserFactory(param1:Object) : MsgServiceStatus
      {
         var _loc2_:String = param1 as String;
         var _loc3_:Object = JSON.parse(_loc2_);
         var _loc4_:MsgServiceStatus = new MsgServiceStatus();
         _loc4_.parse(_loc3_);
         return _loc4_;
      }
      
      private function conversationParserFactory(param1:Object) : IMsgServiceConversation
      {
         var _loc2_:String = param1 as String;
         var _loc3_:Object = JSON.parse(_loc2_);
         var _loc4_:IMsgServiceConversation = new MsgServiceConversation();
         _loc4_.parse(_loc3_);
         return _loc4_;
      }
      
      private function conversationListParserFactory(param1:Object) : Array
      {
         var _loc2_:String = param1 as String;
         var _loc3_:Object = JSON.parse(_loc2_);
         if(!(_loc3_ is Array))
         {
            return [];
         }
         return _loc3_ as Array;
      }
      
      private function conversationsParserFactory(param1:Object) : Vector.<IMsgServiceConversation>
      {
         var _loc5_:Object = null;
         var _loc6_:IMsgServiceConversation = null;
         var _loc2_:String = param1 as String;
         var _loc3_:Array = JSON.parse(_loc2_) as Array;
         var _loc4_:Vector.<IMsgServiceConversation> = new Vector.<IMsgServiceConversation>();
         for each(_loc5_ in _loc3_)
         {
            _loc6_ = new MsgServiceConversation();
            _loc6_.parse(_loc5_);
            _loc4_.push(_loc6_);
         }
         return _loc4_;
      }
      
      private function messageParserFactory(param1:Object) : Vector.<IMsgServiceMessage>
      {
         var _loc5_:Object = null;
         var _loc6_:IMsgServiceMessage = null;
         var _loc2_:String = param1 as String;
         var _loc3_:Array = JSON.parse(_loc2_) as Array;
         var _loc4_:Vector.<IMsgServiceMessage> = new Vector.<IMsgServiceMessage>();
         for each(_loc5_ in _loc3_)
         {
            _loc6_ = MsgServiceHelpers.parseIntoSpecificMessage(_loc5_);
            _loc4_.push(_loc6_);
         }
         return _loc4_;
      }
      
      private function userConversationStatesParserFactory(param1:Object) : Object
      {
         return JSON.parse(param1 as String);
      }
      
      private function getActorIdStringFromArray(param1:Array) : String
      {
         var _loc2_:String = null;
         if(Boolean(param1) && param1.length > 0)
         {
            _loc2_ = param1.join(",");
         }
         else
         {
            _loc2_ = "empty";
         }
         return _loc2_;
      }
      
      private function getTimestampMillis(param1:Date) : String
      {
         var _loc2_:String = null;
         if(param1 != null)
         {
            _loc2_ = param1.time.toString();
         }
         else
         {
            _loc2_ = "";
         }
         return _loc2_;
      }
   }
}

class ConstructorBlocker
{
   
   public function ConstructorBlocker()
   {
      super();
   }
}
