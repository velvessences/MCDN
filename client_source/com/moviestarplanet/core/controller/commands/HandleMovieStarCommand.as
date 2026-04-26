package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.core.model.actor.reload.ActorReload;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.moviestar.controller.SaveClothesCommand;
   import com.moviestarplanet.moviestar.utils.ActorCache;
   import com.moviestarplanet.moviestar.valueObjects.ActorClothesRel;
   
   public class HandleMovieStarCommand
   {
      
      public function HandleMovieStarCommand()
      {
         super();
      }
      
      public static function saveCloth(param1:MsgEvent) : void
      {
         var onClothesSet:Function = null;
         var onClothesSaved:Function = null;
         var acrArray:Array = null;
         var acr:ActorClothesRel = null;
         var e:MsgEvent = param1;
         onClothesSet = function():void
         {
            new SaveClothesCommand(Main.Instance.mainCanvas.applicationViewStack.mainView.moviestarContainer.myMovieStar).SaveClothes(onClothesSaved,e.data.silent);
         };
         onClothesSaved = function():void
         {
            ActorReload.getInstance().requestReload();
            callback();
         };
         var callback:Function = e.data.callback;
         ActorCache.getInstance().resetActorClothItems(ActorSession.getActorId());
         MessageCommunicator.sendMessage(ActorEvent.ACTORCLOTHESCOLLECTIONCHANGED,ActorSession.getActorId());
         if(e.data.acrArray != null)
         {
            acrArray = e.data.acrArray;
            Main.Instance.mainCanvas.applicationViewStack.mainView.moviestarContainer.myMovieStar.PutOnClothes(acrArray,onClothesSet);
         }
         else
         {
            acr = e.data.acr;
            Main.Instance.mainCanvas.applicationViewStack.mainView.moviestarContainer.myMovieStar.PutOnCloth(acr,onClothesSet);
         }
      }
      
      public function execute() : void
      {
         MessageCommunicator.subscribe(MSPEvent.MY_SAVE_CLOTH,saveCloth);
      }
   }
}

