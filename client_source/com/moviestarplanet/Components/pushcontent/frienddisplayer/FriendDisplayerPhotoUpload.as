package com.moviestarplanet.Components.pushcontent.frienddisplayer
{
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.platform.ApplicationId;
   import com.moviestarplanet.utils.EntityTypeType;
   import com.moviestarplanet.utils.loader.ObfuscatedSnapshotUrl;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   
   public class FriendDisplayerPhotoUpload extends FriendDisplayer
   {
      
      private var _photoToShare:Object;
      
      public function FriendDisplayerPhotoUpload(param1:Number, param2:Number, param3:*, param4:Object)
      {
         this._photoToShare = param4;
         super(param1,param2,param3);
      }
      
      override protected function creationCompleteHandler() : void
      {
         super.passOnCreationCompleteHandler();
         this.title = MSPLocaleManagerWeb.getInstance().getString("SHARE_WITH");
         var _loc1_:FriendDisplayerInner = new FriendDisplayerInner(this.getActivityObject(),ApplicationId.APPLICATION_WEB);
         _loc1_.percentWidth = 100;
         _loc1_.percentHeight = 100;
         super.removeChild(component);
         super.addChild(_loc1_);
      }
      
      override public function getActivityObject() : Object
      {
         var _loc1_:ObfuscatedSnapshotUrl = new ObfuscatedSnapshotUrl(this._photoToShare.ActorId,EntityTypeType.IMAGE_UPLOAD,EntityTypeType.EntityTypeAsString(EntityTypeType.IMAGE_UPLOAD),this._photoToShare.Guid,false);
         return {
            "actorId":ActorSession.getActorId(),
            "type":"PUSH_CONTENT_IMAGE_UPLOAD",
            "entityId":entityId,
            "entityType":entityType,
            "entitySnapshot":_loc1_.toString(),
            "sharedPhoto":this._photoToShare
         };
      }
   }
}

