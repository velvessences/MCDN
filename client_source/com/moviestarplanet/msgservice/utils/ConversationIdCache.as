package com.moviestarplanet.msgservice.utils
{
   import com.moviestarplanet.msgservice.MsgService;
   import flash.utils.Dictionary;
   
   public class ConversationIdCache
   {
      
      private static var _instance:ConversationIdCache;
      
      private var conversationIdDictionary:Dictionary;
      
      public function ConversationIdCache(param1:Class)
      {
         super();
         if(param1 != SingletonBlocker)
         {
            throw new Error("ConversationIdCache is a singleton class, use ConversationIdCache.getInstance instead!");
         }
         this.conversationIdDictionary = new Dictionary();
      }
      
      public static function getInstance() : ConversationIdCache
      {
         if(_instance == null)
         {
            _instance = new ConversationIdCache(SingletonBlocker);
         }
         return _instance;
      }
      
      public function getConversationIdForActorId(param1:int) : String
      {
         return this.conversationIdDictionary[param1];
      }
      
      public function addConversationIdForActorId(param1:int, param2:String) : void
      {
         this.conversationIdDictionary[param1] = param2;
      }
      
      public function getOrCreateConversationIdForActorId(param1:int, param2:Function) : void
      {
         var _loc3_:String = this.conversationIdDictionary[param1];
         if(_loc3_ == null)
         {
            new CreateConversation(MsgService.getInstance(),param1,this.conversationIdDictionary,param2);
         }
         else
         {
            param2(_loc3_);
         }
      }
      
      public function destroy() : void
      {
         this.conversationIdDictionary = null;
         _instance = null;
      }
   }
}

class SingletonBlocker
{
   
   public function SingletonBlocker()
   {
      super();
   }
}
