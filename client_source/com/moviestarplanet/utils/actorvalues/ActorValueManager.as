package com.moviestarplanet.utils.actorvalues
{
   import com.moviestarplanet.activespecials.ActiveSpecialsHandler;
   import com.moviestarplanet.activespecials.ActiveSpecialsType;
   import com.moviestarplanet.actorutils.ActorValueSetter;
   import com.moviestarplanet.actorutils.ActorValueType;
   import com.moviestarplanet.actorvalues.IActorValueManager;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.utils.observer.AbstractObserverManager;
   
   public class ActorValueManager extends AbstractObserverManager implements IActorValueManager
   {
      
      private static var instance:ActorValueManager;
      
      public function ActorValueManager(param1:SingletonEnforcer)
      {
         super();
         if(param1 == null)
         {
            throw new Error("ActorValueManager is a singleton class, use getInstance() instead.");
         }
      }
      
      public static function getInstance() : ActorValueManager
      {
         if(instance == null)
         {
            instance = new ActorValueManager(new SingletonEnforcer());
         }
         return instance;
      }
      
      public function addValue(param1:int, param2:Number, param3:Boolean = true) : void
      {
         if(param1 == ActorValueType.FAME && param3 == true)
         {
            if(ActorSession.loggedInActor.isCeleb)
            {
               param2 *= 1.1;
            }
            if(ActiveSpecialsHandler.hasActiveSpecial(ActiveSpecialsType.FAMEBOOSTER))
            {
               param2 *= 2;
            }
         }
         notify({
            "actorValueType":param1,
            "amount":param2,
            "setter":ActorValueSetter.ADD
         });
      }
      
      public function setValue(param1:int, param2:Number) : void
      {
         notify({
            "actorValueType":param1,
            "amount":param2,
            "setter":ActorValueSetter.SET
         });
      }
   }
}

class SingletonEnforcer
{
   
   public function SingletonEnforcer()
   {
      super();
   }
}
