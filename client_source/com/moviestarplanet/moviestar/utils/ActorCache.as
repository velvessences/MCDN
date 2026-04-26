package com.moviestarplanet.moviestar.utils
{
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.logging.Log;
   import com.moviestarplanet.model.IActorModel;
   import com.moviestarplanet.moviestar.service.IMovieStarService;
   import com.moviestarplanet.moviestar.valueObjects.Actor;
   import com.moviestarplanet.msg.ActionEvent;
   
   public class ActorCache
   {
      
      public static var movieStarService:IMovieStarService;
      
      private static var _instance:ActorCache;
      
      private static var actorCache:Object = {};
      
      private static var actorClothCache:Object = new Object();
      
      private static var loadedLists:Array = [];
      
      [Inject]
      public var actorModel:IActorModel;
      
      private var loadingActorIds:Vector.<int>;
      
      public function ActorCache(param1:Class)
      {
         super();
         if(param1 != SingletonBlocker)
         {
            throw new Error("ActorCache is a singleton class, use ActorCache.getInstance instead!");
         }
         InjectionManager.manager().injectMe(this);
      }
      
      public static function getInstance() : ActorCache
      {
         if(_instance == null)
         {
            _instance = new ActorCache(SingletonBlocker);
         }
         return _instance;
      }
      
      public static function loadActor(param1:Number, param2:Function, param3:Function = null) : void
      {
         var done:Function = null;
         var onFail:Function = null;
         var tempError:Error = null;
         var stackTrace:String = null;
         var actorId:Number = param1;
         var loadCallback:Function = param2;
         var failCallback:Function = param3;
         done = function(param1:Actor):void
         {
            if(actorId > 0 && actorId != param1.ActorId)
            {
               onFail();
            }
            else
            {
               setActor(param1);
               loadCallback(param1);
            }
         };
         onFail = function():void
         {
            if(failCallback != null)
            {
               failCallback();
            }
         };
         if(actorId < 0)
         {
            movieStarService.loadMovieStarActor(actorId,done,onFail);
         }
         else if(actorCache[actorId])
         {
            loadCallback(SerializeUtils.clone(actorCache[actorId]));
         }
         else if(Config.isMobile)
         {
            movieStarService.loadMovieStarActor(actorId,done,onFail);
         }
         else if(actorId != 0)
         {
            movieStarService.loadMovieStarActorFlat(actorId,done,onFail);
         }
         else
         {
            tempError = new Error();
            stackTrace = tempError.getStackTrace();
            Log.getInstance().log("ERROR","ActorCache: ActorId == 0",{"reportData":stackTrace});
            onFail();
         }
      }
      
      public static function isListLoaded(param1:Array) : Boolean
      {
         return loadedLists.indexOf(param1) != -1;
      }
      
      public static function loadActorList(param1:Array, param2:Function) : void
      {
         var unCachedActorIds:Array;
         var cachedActors:Array = null;
         var i:int = 0;
         var done:Function = null;
         var id:int = 0;
         var actorIds:Array = param1;
         var loadCallback:Function = param2;
         done = function(param1:Array):void
         {
            var _loc2_:Actor = null;
            for each(_loc2_ in param1)
            {
               if(_loc2_ != null)
               {
                  setActor(_loc2_);
               }
            }
            loadCallback(cachedActors.concat(param1));
         };
         if(loadedLists.indexOf(actorIds) == -1)
         {
            loadedLists.push(actorIds);
         }
         cachedActors = [];
         unCachedActorIds = [];
         i = 0;
         while(i < actorIds.length)
         {
            id = int(actorIds[i]);
            if(actorCache[id])
            {
               cachedActors.push(SerializeUtils.clone(actorCache[id]));
            }
            else
            {
               unCachedActorIds.push(id);
            }
            i++;
         }
         if(unCachedActorIds.length > 0)
         {
            movieStarService.loadMovieStarActorList(unCachedActorIds,done);
         }
         else
         {
            loadCallback(cachedActors);
         }
      }
      
      private static function cacheActor(param1:Actor) : void
      {
         if(param1 != null)
         {
            actorCache[param1.ActorId] = param1;
         }
      }
      
      public static function setActor(param1:Actor) : void
      {
         var actor:Actor = param1;
         new MovieStarRegistrator().registerClassAliases();
         if(actor != null)
         {
            try
            {
               cacheActor(SerializeUtils.clone(actor) as Actor);
            }
            catch(e:Error)
            {
               trace("Cache caught error: " + e.message);
            }
         }
      }
      
      public static function resetActor(param1:Number) : void
      {
         actorCache[param1] = null;
      }
      
      public function getActorClothItems(param1:Number, param2:Function) : void
      {
         var done:Function;
         var actorId:Number = param1;
         var resultCallBack:Function = param2;
         if(actorClothCache[actorId])
         {
            resultCallBack(actorClothCache[actorId]);
         }
         else
         {
            done = function(param1:Array):void
            {
               actorClothCache[actorId] = param1;
               MessageCommunicator.subscribe(ActionEvent.BUY_CLOTHES,onBoughtFromShop);
               resultCallBack(param1);
            };
            movieStarService.LoadActorItems(actorId,done);
         }
      }
      
      private function onBoughtFromShop(param1:MsgEvent) : void
      {
         var _loc2_:Array = actorClothCache[this.actorModel.actorId];
         actorClothCache[this.actorModel.actorId] = _loc2_.concat(param1.data);
      }
      
      public function resetActorClothItems(param1:Number) : void
      {
         actorClothCache[param1] = null;
         MessageCommunicator.unscribe(ActionEvent.BUY_CLOTHES,this.onBoughtFromShop);
      }
      
      public function getOwnActor() : Actor
      {
         return actorCache[this.actorModel.actorId] as Actor;
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
