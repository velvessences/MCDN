package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.anchorCharacters.AnchorActivityManager;
   import com.moviestarplanet.anchorCharacters.service.AMFSponsoredCharacterService;
   import com.moviestarplanet.createuser.BrandedAnchorReactivatedScreen;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   
   public class HandleSponsoredReactivationCommand
   {
      
      private static var reference:HandleSponsoredReactivationCommand;
      
      public function HandleSponsoredReactivationCommand()
      {
         super();
         reference = this;
      }
      
      private static function onReactivationReady(param1:MsgEvent) : void
      {
         reference = null;
         MessageCommunicator.unscribe(AnchorActivityManager.SPCHAR_FRIEND_REACTIVATION_BUNDLE,onReactivationReady);
         var _loc2_:Array = param1.data.array;
         var _loc3_:Function = param1.data.callback;
         handleNext(_loc2_,_loc3_);
      }
      
      private static function handleNext(param1:Array, param2:Function) : void
      {
         var nextId:int = 0;
         var gotGifts:Function = null;
         var screenDone:Function = null;
         var aci:Array = param1;
         var callback:Function = param2;
         gotGifts = function(param1:Array):void
         {
            var _loc2_:BrandedAnchorReactivatedScreen = new BrandedAnchorReactivatedScreen(nextId,param1,screenDone);
            _loc2_.show();
         };
         screenDone = function(param1:int = 0):void
         {
            handleNext(aci,callback);
         };
         if(aci.length == 0)
         {
            callback();
            return;
         }
         nextId = int(aci.pop());
         new AMFSponsoredCharacterService().acceptGifts(nextId,gotGifts,screenDone);
      }
      
      public function execute() : void
      {
         MessageCommunicator.subscribe(AnchorActivityManager.SPCHAR_FRIEND_REACTIVATION_BUNDLE,onReactivationReady,100000);
      }
   }
}

