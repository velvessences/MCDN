package com.moviestarplanet.statusbar.ActorStatus
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import mx.core.ClassFactory;
   
   public class ActorStateHandler
   {
      
      private static var instance:ActorStateHandler;
      
      private static const EVENTS:Dictionary = new Dictionary(false);
      
      EVENTS[MSPEvent.BECOME_VIP] = ActionBecomeVIP;
      
      private var visualContainer:DisplayObjectContainer;
      
      public function ActorStateHandler(param1:DisplayObjectContainer)
      {
         var _loc2_:Object = null;
         super();
         this.visualContainer = param1;
         for(_loc2_ in EVENTS)
         {
            MessageCommunicator.subscribe(_loc2_ as String,this.handleEvent,-1);
         }
      }
      
      public static function instantiate(param1:DisplayObjectContainer) : void
      {
         instance = new ActorStateHandler(param1);
      }
      
      private function handleEvent(param1:Event) : void
      {
         var _loc2_:Class = EVENTS[param1.type];
         var _loc3_:ClassFactory = new ClassFactory(_loc2_);
         var _loc4_:ActionInterface = _loc3_.newInstance() as ActionInterface;
         if(_loc4_ == null)
         {
            throw new Error(getQualifiedClassName(this) + " does not handle action of type: " + _loc2_);
         }
         _loc4_.invokeAction(this.visualContainer);
      }
   }
}

