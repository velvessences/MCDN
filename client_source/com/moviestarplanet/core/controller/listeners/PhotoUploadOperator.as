package com.moviestarplanet.core.controller.listeners
{
   import com.moviestarplanet.Components.Friends.FriendshipManager;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.pictures.PicturesModuleManager;
   import com.moviestarplanet.utils.EntityTypeType;
   
   public class PhotoUploadOperator
   {
      
      public function PhotoUploadOperator()
      {
         super();
      }
      
      public static function wireup() : void
      {
         MessageCommunicator.subscribe(MSPEvent.OPEN_PHOTO_UPLOAD,openPhotoUpload);
         MessageCommunicator.subscribe(MSPEvent.NEW_PHOTO_UPLOAD,sendPhotoToFriends);
      }
      
      private static function openPhotoUpload(param1:MsgEvent) : void
      {
         PicturesModuleManager.getInstance().openPictureUpload(param1.data);
      }
      
      private static function sendPhotoToFriends(param1:MsgEvent) : void
      {
         var _loc2_:Object = {
            "actorId":ActorSession.loggedInActor.actorId,
            "entityId":param1.data.imageUpload.ImageUploadId,
            "type":"PUSH_CONTENT_IMAGE_UPLOAD",
            "entityType":EntityTypeType.IMAGE_UPLOAD,
            "entitySnapshot":param1.data.url,
            "sharedPhoto":param1.data.imageUpload
         };
         FriendshipManager.getInstance().convertLegacyEntityObjectAndSendToFriends(_loc2_);
      }
   }
}

