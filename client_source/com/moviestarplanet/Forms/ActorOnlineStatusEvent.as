package com.moviestarplanet.Forms
{
   import com.moviestarplanet.model.friends.IFriend;
   import flash.events.Event;
   
   public class ActorOnlineStatusEvent extends Event
   {
      
      public static const DEFAULT_NAME:String = "ActorOnlineStatusEvent";
      
      public static const ON_ACTOR_ONLINE:String = "onActorOnline";
      
      public static const ON_ACTOR_OFFLINE:String = "onActorOffline";
      
      public var friend:IFriend;
      
      public function ActorOnlineStatusEvent(param1:String, param2:IFriend, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.friend = param2;
      }
      
      override public function clone() : Event
      {
         return new ActorOnlineStatusEvent(type,this.friend,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("ActorOnlineStatusEvent","type","friend","bubbles","cancelable");
      }
   }
}

