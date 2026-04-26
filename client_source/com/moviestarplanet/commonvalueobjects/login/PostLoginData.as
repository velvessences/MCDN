package com.moviestarplanet.commonvalueobjects.login
{
   import com.moviestarplanet.amf.valueobjects.AmfServiceResultData;
   import com.moviestarplanet.chatCommunicator.chatHelpers.chatpermission.ChatPermissionInfo;
   import com.moviestarplanet.commonvalueobjects.activity.PagedTodoList;
   import com.moviestarplanet.commonvalueobjects.actor.BlockedAndBlockingActorsResult;
   import com.moviestarplanet.commonvalueobjects.actor.MoodWithVersion;
   import com.moviestarplanet.commonvalueobjects.advertisement.AdTechAdImpressions;
   import com.moviestarplanet.quest.valueobjects.SpecialQuestInitialUpdate;
   import mx.collections.ArrayCollection;
   
   public class PostLoginData
   {
      
      public var AdImpressions:AdTechAdImpressions;
      
      public var ActiveSpecialsItems:ArrayCollection;
      
      public var ActorId:int;
      
      public var AdControl:ArrayCollection;
      
      public var AnchorLatestActivities:Array;
      
      public var BlockedAndBlockingActors:BlockedAndBlockingActorsResult;
      
      public var CampaignOffers:ArrayCollection;
      
      public var CensorList:Array;
      
      public var ChatPermissionInfo:com.moviestarplanet.chatCommunicator.chatHelpers.chatpermission.ChatPermissionInfo;
      
      public var EmoticonPackages:Object;
      
      public var FriendRequestCount:int;
      
      public var GiftHuntInfo:ArrayCollection;
      
      public var HashValues:Array;
      
      public var MobileStartupReward:AmfServiceResultData;
      
      public var Mood:MoodWithVersion;
      
      public var NewTagFeature:String;
      
      public var Now:String;
      
      public var OfflineTodos:PagedTodoList;
      
      public var OnlineFriends:ArrayCollection;
      
      public var SoundMuted:Boolean;
      
      public var SponsoredFriendRequests:Array;
      
      public var SponsoredFriendReactivations:Array;
      
      public var WorldThemeChatRoomInfo:Object;
      
      public var SpecialEvent:SpecialQuestInitialUpdate;
      
      public var NumberOfUnopenedGifts:int;
      
      public var NumberOfFameNotifications:int;
      
      public var NumberOfUnredeemedMemberships:int;
      
      public function PostLoginData()
      {
         super();
      }
   }
}

