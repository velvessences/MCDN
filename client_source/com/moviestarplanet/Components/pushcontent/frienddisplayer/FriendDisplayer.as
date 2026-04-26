package com.moviestarplanet.Components.pushcontent.frienddisplayer
{
   import com.moviestarplanet.Components.Friends.MyOnlineFriends;
   import com.moviestarplanet.Components.pushcontent.utils.FriendDisplayerEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.globalsharedutils.SnapshotUrl;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.utils.EntityTypeType;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.video.module.YouTube.YouTubeBrowser.utils.YouTubeBrowserHelpers;
   import com.moviestarplanet.window.stack.WindowStack;
   import com.moviestarplanet.window.stack.WindowStackableInterface;
   import com.moviestarplanet.window.utils.PopupUtils;
   import flash.events.Event;
   import mx.controls.Alert;
   
   public class FriendDisplayer extends MyOnlineFriends implements WindowStackableInterface
   {
      
      private var _entityId:Number;
      
      private var _entityType:Number;
      
      private var _snapshotId:*;
      
      public function FriendDisplayer(param1:Number, param2:Number, param3:*)
      {
         super();
         this._entityId = param1;
         this._entityType = param2;
         this._snapshotId = param3;
         this.initCloseListener();
      }
      
      internal function get entityId() : Number
      {
         return this._entityId;
      }
      
      internal function get entityType() : Number
      {
         return this._entityType;
      }
      
      internal function get snapshotId() : *
      {
         return this._snapshotId;
      }
      
      override protected function creationCompleteHandler() : void
      {
         super.creationCompleteHandler();
         this.title = MSPLocaleManagerWeb.getInstance().getString("SHARE_WITH");
         var _loc1_:FriendDisplayerInner = new FriendDisplayerInner(this.getActivityObject());
         _loc1_.percentWidth = 100;
         _loc1_.percentHeight = 100;
         super.removeChild(component);
         super.addChild(_loc1_);
      }
      
      protected function passOnCreationCompleteHandler() : void
      {
         super.creationCompleteHandler();
      }
      
      public function getActivityObject() : Object
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         switch(this._entityType)
         {
            case EntityTypeType.YOUTUBE:
               _loc1_ = "PUSH_CONTENT_YOUTUBE";
               _loc2_ = YouTubeBrowserHelpers.SNAPSHOT_URL.replace("{0}",this._snapshotId);
               break;
            case EntityTypeType.SCRAPBLOG:
               _loc1_ = "PUSH_CONTENT_SCRAPBLOG";
               _loc2_ = new SnapshotUrl(parseInt(this._snapshotId),EntityTypeType.SCRAPBLOG,"scrapblog").toString();
               break;
            case EntityTypeType.MOVIE:
               _loc1_ = "PUSH_CONTENT_MOVIE";
               _loc2_ = new SnapshotUrl(parseInt(this._snapshotId),EntityTypeType.MOVIE,"movie").toString();
               break;
            case EntityTypeType.LOOK:
               Alert.show("Use FriendDisplayerForLooks.as instead");
               break;
            case EntityTypeType.CLUBS:
               _loc1_ = "PUSH_CONTENT_CLUB";
               _loc2_ = new SnapshotUrl(parseInt(this._snapshotId),EntityTypeType.SCRAPBLOG,"scrapblog").toString() + "?antiCache=" + new Date().getTime();
               break;
            case EntityTypeType.EMBEDDEDGAME:
               Alert.show("Use FriendDisplayerForEmbeddedGames.as instead");
            case EntityTypeType.FORUM:
               Alert.show("Use FriendDisplayerForForum.as instead");
               break;
            case EntityTypeType.SOCIALSHOPPING:
               Alert.show("Use FriendDisplayerForSocialShopping.as instead");
               break;
            case EntityTypeType.IMAGE_UPLOAD:
               Alert.show("Use FriendDisplayerPhotoUpload.as instead");
               break;
            default:
               Alert.show("not implemented in PushContentActivityObjects");
         }
         return {
            "actorId":ActorSession.getActorId(),
            "type":_loc1_,
            "entityId":this._entityId,
            "entityType":this._entityType,
            "entitySnapshot":_loc2_
         };
      }
      
      private function initCloseListener() : void
      {
         switch(this._entityType)
         {
            case EntityTypeType.LOOK:
               MessageCommunicator.subscribe(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_LOOK,this.close);
               break;
            case EntityTypeType.MOVIE:
               MessageCommunicator.subscribe(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_MOVIE,this.close);
               break;
            case EntityTypeType.YOUTUBE:
               MessageCommunicator.subscribe(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_YOUTUBE,this.close);
               break;
            case EntityTypeType.SCRAPBLOG:
               MessageCommunicator.subscribe(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_SCRAPBLOG,this.close);
               break;
            case EntityTypeType.CLUBS:
               MessageCommunicator.subscribe(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_CLUB,this.close);
               break;
            case EntityTypeType.EMBEDDEDGAME:
               MessageCommunicator.subscribe(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_EMBEDDEDGAMES,this.close);
               break;
            case EntityTypeType.FORUM:
               MessageCommunicator.subscribe(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_FORUM,this.close);
               break;
            case EntityTypeType.SOCIALSHOPPING:
               MessageCommunicator.subscribe(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_SOCIALSHOPPING,this.close);
               break;
            case EntityTypeType.IMAGE_UPLOAD:
               MessageCommunicator.subscribe(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_IMAGE_UPLOAD,this.close);
               break;
            default:
               Alert.show("EntityType not impl in initCloseListener inside FriendDisplayer");
         }
      }
      
      private function removeCloseListener() : void
      {
         switch(this._entityType)
         {
            case EntityTypeType.LOOK:
               MessageCommunicator.unscribe(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_LOOK,this.close);
               break;
            case EntityTypeType.MOVIE:
               MessageCommunicator.unscribe(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_MOVIE,this.close);
               break;
            case EntityTypeType.YOUTUBE:
               MessageCommunicator.unscribe(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_YOUTUBE,this.close);
               break;
            case EntityTypeType.SCRAPBLOG:
               MessageCommunicator.unscribe(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_SCRAPBLOG,this.close);
               break;
            case EntityTypeType.CLUBS:
               MessageCommunicator.unscribe(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_CLUB,this.close);
               break;
            case EntityTypeType.EMBEDDEDGAME:
               MessageCommunicator.unscribe(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_EMBEDDEDGAMES,this.close);
               break;
            case EntityTypeType.FORUM:
               MessageCommunicator.unscribe(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_FORUM,this.close);
               break;
            case EntityTypeType.SOCIALSHOPPING:
               MessageCommunicator.unscribe(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_SOCIALSHOPPING,this.close);
               break;
            case EntityTypeType.IMAGE_UPLOAD:
               MessageCommunicator.unscribe(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_IMAGE_UPLOAD,this.close);
               break;
            default:
               Alert.show("EntityType not impl in initCloseListener inside FriendDisplayer");
         }
      }
      
      override public function close(param1:Event = null) : void
      {
         this.removeCloseListener();
         if(WindowStack.contains(this))
         {
            WindowStack.removeViewStackable(this);
         }
         else
         {
            PopupUtils.removePopup(this,null,this.parent);
         }
      }
   }
}

