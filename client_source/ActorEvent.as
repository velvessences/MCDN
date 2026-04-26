package
{
   import flash.events.Event;
   
   public class ActorEvent extends Event
   {
      
      public static const ACTORCHANGED:String = "ACTORCHANGED";
      
      public static const ACTORCLOTHESCOLLECTIONCHANGED:String = "ACTORCLOTHESCOLLECTIONCHANGED";
      
      private var _actorId:int;
      
      public function ActorEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         this._actorId = param2;
         super(param1,param3,param4);
      }
      
      public function get ActorId() : int
      {
         return this._actorId;
      }
   }
}

