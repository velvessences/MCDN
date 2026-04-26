package com.moviestarplanet.core.controller.listeners
{
   import com.moviestarplanet.Components.Friends.FriendshipManager;
   import com.moviestarplanet.activities.OldActivityCreator;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.dressing.DressingModuleManager;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.flash.components.popups.viponly.VIPOnlyPopUp;
   import com.moviestarplanet.globalsharedutils.SnapshotUrl;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.scrapblog.ScrapBlogTypes;
   import com.moviestarplanet.utils.EntityTypeType;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   
   public class ArtbookOperator
   {
      
      public function ArtbookOperator()
      {
         super();
      }
      
      public static function wireup() : void
      {
         MessageCommunicator.subscribe(MSPEvent.CHANGE_CLOTHES,openDressingModule);
         MessageCommunicator.subscribe(MSPEvent.ARTBOOK_COLOR_SHAPES_VIP_ONLY,openColorShapesVipPopup);
         MessageCommunicator.subscribe(MSPEvent.ARTBOOK_VIP_ONLY,openVipPopup);
         MessageCommunicator.subscribe(MSPEvent.ARTBOOK_SAVED,createNewScrapBlogActivity);
      }
      
      private static function createNewScrapBlogActivity(param1:MsgEvent) : void
      {
         var _loc2_:Object = {
            "actorId":ActorSession.getActorId(),
            "type":(param1.data[1] == ScrapBlogTypes.ARTBOOK ? "SCRAPBLOG_SAVE" : "BIO_UPDATE"),
            "entityId":param1.data[0],
            "entityType":EntityTypeType.SCRAPBLOG,
            "entitySnapshot":new SnapshotUrl(param1.data[0],EntityTypeType.SCRAPBLOG,"scrapblog").path
         };
         FriendshipManager.getInstance().convertLegacyEntityObjectAndSendToFriends(_loc2_);
         if(param1.data[1] == ScrapBlogTypes.ARTBOOK)
         {
            OldActivityCreator.getInstance().createActivity(10,0,0,0,0,param1.data[0]);
         }
      }
      
      private static function openVipPopup(param1:MsgEvent) : void
      {
         VIPOnlyPopUp.Show(MSPLocaleManagerWeb.getInstance().getString("VIP_ONLY_CLIPART"));
      }
      
      private static function openColorShapesVipPopup(param1:MsgEvent) : void
      {
         VIPOnlyPopUp.Show(MSPLocaleManagerWeb.getInstance().getString("VIP_ONLY_COLOURSHAPES"));
      }
      
      private static function openDressingModule(param1:MsgEvent) : void
      {
         DressingModuleManager.getInstance().openDressingRoom(param1.data.actorID,param1.data.callback);
      }
   }
}

