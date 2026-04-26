package com.moviestarplanet.Components.pushcontent.frienddisplayer
{
   import com.moviestarplanet.globalsharedutils.SnapshotUrl;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.utils.EntityTypeType;
   
   public class FriendDisplayerForLooks extends FriendDisplayer
   {
      
      private var _creatorId:Number;
      
      private var _creatorName:String;
      
      private var _subjectId:Number;
      
      public function FriendDisplayerForLooks(param1:Number, param2:Number, param3:*, param4:Number, param5:String, param6:Number)
      {
         super(param1,param2,param3);
         this._creatorId = param4;
         this._creatorName = param5;
         this._subjectId = param6;
      }
      
      override public function getActivityObject() : Object
      {
         return {
            "actorId":ActorSession.getActorId(),
            "type":"PUSH_CONTENT_LOOK",
            "entityId":entityId,
            "entityType":entityType,
            "entitySnapshot":new SnapshotUrl(parseInt(snapshotId),EntityTypeType.LOOK,"look").toString(),
            "creatorId":this._creatorId,
            "creatorName":this._creatorName,
            "subjectId":this._subjectId
         };
      }
   }
}

