package com.moviestarplanet.activityservice.valueObjects
{
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.model.IActorModel;
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class ActivityImageUpload
   {
      
      [Inject]
      public var actorModel:IActorModel;
      
      public var ImageUploadId:int;
      
      public var ActorId:int;
      
      public var Uploaded:Date;
      
      private var _Headline:String;
      
      public var Guid:String;
      
      public var Likes:int;
      
      public var Views:int;
      
      public var Status:int;
      
      public var CommentsCount:int;
      
      public var hasLiked:Boolean = false;
      
      public var ActorName:String;
      
      public var IsVip:Boolean;
      
      public var VipTier:int;
      
      public var Published:Boolean;
      
      public var Activities:Object;
      
      public function ActivityImageUpload()
      {
         super();
         InjectionManager.manager().injectMe(this);
      }
      
      public function get Headline() : String
      {
         return this._Headline;
      }
      
      public function set Headline(param1:String) : void
      {
         this._Headline = UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(param1);
      }
      
      public function set ActorImage(param1:Object) : void
      {
         this.ActorName = param1.Name;
         this.VipTier = param1.VipTier;
         this.IsVip = this.actorModel.lastLogin < param1.MembershipTimeoutDate;
      }
      
      public function set ImageActorLikes(param1:Object) : void
      {
         var _loc2_:Array = param1.source;
         this.hasLiked = _loc2_.length > 0;
      }
   }
}

