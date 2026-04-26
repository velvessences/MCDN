package com.moviestarplanet.moviestar.controller
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.moviestar.MovieStarInterface;
   import com.moviestarplanet.moviestar.service.MovieStarService;
   import com.moviestarplanet.moviestar.utils.ActorCache;
   
   public class SaveClothesCommand
   {
      
      private var movieStar:MovieStarInterface;
      
      public function SaveClothesCommand(param1:MovieStarInterface)
      {
         super();
         this.movieStar = param1;
      }
      
      public function SaveClothes(param1:Function, param2:Boolean = false) : void
      {
         var clothesRels:Array = null;
         var i:int = 0;
         var saveClothesCompleted:Function = null;
         var done:Function = param1;
         var silent:Boolean = param2;
         saveClothesCompleted = function():void
         {
            updateCachedActorClothes(clothesRels);
            MessageCommunicator.sendMessage(MSPEvent.MY_CLOTHES_CHANGED,{
               "actorId":movieStar.actor.ActorId,
               "movieStar":movieStar,
               "silent":silent
            });
            if(done != null)
            {
               done();
            }
         };
         clothesRels = this.movieStar.GetAttachedClothes();
         var actorClothesRelIds:Array = [];
         var itemCount:int = int(clothesRels.length);
         i = 0;
         while(i < itemCount)
         {
            actorClothesRelIds.push(clothesRels[i].ActorClothesRelId);
            i++;
         }
         new MovieStarService().UpdateClothes(this.movieStar.actor.ActorId,actorClothesRelIds,saveClothesCompleted);
         actorClothesRelIds.length = 0;
         actorClothesRelIds = null;
      }
      
      private function updateCachedActorClothes(param1:Array) : void
      {
         this.movieStar.actor.ActorClothesRels = param1;
         ActorCache.setActor(this.movieStar.actor);
      }
   }
}

