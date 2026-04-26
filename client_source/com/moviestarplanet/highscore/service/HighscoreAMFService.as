package com.moviestarplanet.highscore.service
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.amf.PagerResultObject;
   import com.moviestarplanet.anchorCharacters.AnchorCharacters;
   import com.moviestarplanet.blob.service.IBlobService;
   import com.moviestarplanet.highscore.valueobjects.ActorHighscore;
   import com.moviestarplanet.highscore.valueobjects.AnimationHighscore;
   import com.moviestarplanet.highscore.valueobjects.BackgroundHighscore;
   import com.moviestarplanet.highscore.valueobjects.BonsterHighscoreVO;
   import com.moviestarplanet.highscore.valueobjects.ClothHighscore;
   import com.moviestarplanet.highscore.valueobjects.HighscoreParams;
   import com.moviestarplanet.highscore.valueobjects.LookItemHighscore;
   import com.moviestarplanet.highscore.valueobjects.MovieHighscore;
   import com.moviestarplanet.highscore.valueobjects.PetHighscore;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.model.IActorModel;
   import com.moviestarplanet.model.friends.IFriend;
   import com.moviestarplanet.model.friends.IFriendList;
   import com.moviestarplanet.moviestar.utils.ActorCache;
   import com.moviestarplanet.moviestar.valueObjects.Actor;
   import com.moviestarplanet.scrapblog.valueobjects.PagedScrapBlogList;
   import com.moviestarplanet.scrapblog.valueobjects.ScrapBlogActorLike;
   import com.moviestarplanet.scrapblog.valueobjects.ScrapBlogActorNameValueObject;
   import com.moviestarplanet.scrapblog.valueobjects.ScrapBlogListItem;
   import flash.net.registerClassAlias;
   
   public class HighscoreAMFService
   {
      
      protected static var amfCaller:AmfCaller = new AmfCaller("MovieStarPlanet.WebService.Highscore.AMFHighscoreService");
      
      [Inject]
      public var blobService:IBlobService;
      
      [Inject]
      public var friendList:IFriendList;
      
      [Inject]
      public var actorModel:IActorModel;
      
      public function HighscoreAMFService()
      {
         super();
         registerClassAlias("MovieStarPlanet.DBML.ActorHighscore",ActorHighscore);
         registerClassAlias("MovieStarPlanet.DBML.HighscoreAnimations",AnimationHighscore);
         registerClassAlias("MovieStarPlanet.DBML.HighscoreBackground",BackgroundHighscore);
         registerClassAlias("MovieStarPlanet.DBML.HighscoreClickItem",PetHighscore);
         registerClassAlias("MovieStarPlanet.WebService.Highscore.ValueObjects.BonsterHighscoreVO",BonsterHighscoreVO);
         registerClassAlias("MovieStarPlanet.DBML.HighscoreCloth",ClothHighscore);
         registerClassAlias("MovieStarPlanet.DBML.HighscoreLookItem",LookItemHighscore);
         registerClassAlias("MovieStarPlanet.WebService.Highscore.ValueObjects.MovieHighscoreVO",MovieHighscore);
         registerClassAlias("MovieStarPlanet.WebService.ScrapBlog.ScrapBlogListItem",ScrapBlogListItem);
         registerClassAlias("MovieStarPlanet.WebService.ScrapBlog.AMFScrapBlogService.PagedScrapBlogList",PagedScrapBlogList);
         registerClassAlias("MovieStarPlanet.WebService.ScrapBlog.ScrapBlogActorName",ScrapBlogActorNameValueObject);
         registerClassAlias("MovieStarPlanet.WebService.ScrapBlog.ScrapBlogActorLike",ScrapBlogActorLike);
         InjectionManager.manager().injectMe(this);
      }
      
      public static function getHighscoreScrapBlogsHelper(param1:HighscoreParams, param2:int, param3:int, param4:Function) : void
      {
         var done:Function = null;
         var highscoreParams:HighscoreParams = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var doneCallback:Function = param4;
         done = function(param1:PagerResultObject):void
         {
            service = null;
            doneCallback(param1);
         };
         var service:HighscoreAMFService = new HighscoreAMFService();
         service.getHighscoreScrapBlogs(highscoreParams,pageIndex,pageSize,done);
      }
      
      public function getHighscoreYouTube(param1:HighscoreParams, param2:int, param3:int, param4:Function = null) : void
      {
         var done:Function = null;
         var parameters:HighscoreParams = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var onResponse:Function = param4;
         done = function(param1:Object):void
         {
            returnResult(param1,pageIndex,pageSize,onResponse);
         };
         amfCaller.callFunction("GetHighscoreYouTube",[parameters.actorId,parameters.forFriends,parameters.lastWeek,parameters.orderBy,pageIndex,pageSize],true,done,this.fail);
      }
      
      public function getHighscoreActor(param1:HighscoreParams, param2:int, param3:int, param4:Function) : void
      {
         var done:Function;
         var parameters:HighscoreParams = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var onResponse:Function = param4;
         if(parameters.forFriends)
         {
            onResponse(this.getFriendHighscore(pageIndex,pageSize,parameters.lastWeek,parameters.orderBy));
         }
         else
         {
            done = function(param1:Object):void
            {
               returnResult(param1,pageIndex,pageSize,onResponse);
            };
            amfCaller.callFunction("GetHighscoreActor",[parameters.actorId,parameters.forFriends,parameters.lastWeek,parameters.orderBy,pageIndex,pageSize],true,done,this.fail);
         }
      }
      
      private function getFriendHighscore(param1:int, param2:int, param3:Boolean, param4:String) : PagerResultObject
      {
         var loadActorCallback:Function = null;
         var pageIndex:int = param1;
         var pageSize:int = param2;
         var lastWeek:Boolean = param3;
         var orderBy:String = param4;
         loadActorCallback = function(param1:Actor):void
         {
            friendList.getFriendById(param1.ActorId).assignHighscoreValues(param1.Money,param1.Fame,param1.Fortune,param1.FriendCount,param1.RoomLikes,param1.MembershipTimeoutDate,param1.MembershipTimeoutDate,param1.IsExtra,param1.LastLogin);
         };
         var actorHighscoreArray:Array = [];
         var friendVector:Vector.<IFriend> = this.friendList.friendList;
         var oneWeekAgo:Date = this.getDateOneWeekAgo();
         var i:int = 0;
         while(i < friendVector.length)
         {
            if(!AnchorCharacters.isSpecialCharacter(friendVector[i].userId))
            {
               if(friendVector[i].fame == 0)
               {
                  ActorCache.loadActor(friendVector[i].userId,loadActorCallback);
               }
               if(lastWeek)
               {
                  if(friendVector[i].lastLogin > oneWeekAgo)
                  {
                     actorHighscoreArray.push(this.createFriendHighscoreObject(friendVector[i]));
                  }
               }
               else
               {
                  actorHighscoreArray.push(this.createFriendHighscoreObject(friendVector[i]));
               }
            }
            i++;
         }
         actorHighscoreArray.push(this.createActorHighscoreObject());
         actorHighscoreArray.sortOn(this.fixCasingForOrderBy(orderBy),Array.NUMERIC | Array.DESCENDING);
         return this.createPagerResultObject(actorHighscoreArray,pageIndex,pageSize);
      }
      
      private function createFriendHighscoreObject(param1:IFriend) : ActorHighscore
      {
         var _loc2_:ActorHighscore = new ActorHighscore();
         _loc2_.ActorId = param1.userId;
         _loc2_.Fame = param1.fame;
         _loc2_.Fortune = param1.fortune;
         _loc2_.FriendCount = param1.friendCount;
         _loc2_.Level = param1.level;
         _loc2_.Money = param1.money;
         _loc2_.Name = param1.name;
         _loc2_.RoomLikes = param1.roomLikes;
         _loc2_.VipTier = param1.vipTier;
         _loc2_.MembershipPurchasedDate = param1.membershipPurchasedDate;
         _loc2_.MembershipTimeoutDate = param1.membershipTimeoutDate;
         _loc2_.IsExtra = param1.isExtra;
         _loc2_.LastLogin = param1.lastLogin;
         return _loc2_;
      }
      
      private function createActorHighscoreObject() : ActorHighscore
      {
         var _loc1_:ActorHighscore = new ActorHighscore();
         _loc1_.ActorId = this.actorModel.actorId;
         _loc1_.Fame = this.actorModel.fame;
         _loc1_.Fortune = this.actorModel.fortune;
         _loc1_.FriendCount = this.actorModel.friendCount;
         _loc1_.IsExtra = this.actorModel.isExtra;
         _loc1_.LastLogin = this.actorModel.lastLogin;
         _loc1_.Level = this.actorModel.level;
         _loc1_.MembershipPurchasedDate = this.actorModel.membershipPurchasedDate;
         _loc1_.MembershipTimeoutDate = this.actorModel.membershipTimeOutDate;
         _loc1_.Money = this.actorModel.money;
         _loc1_.Name = this.actorModel.actorName;
         _loc1_.RoomLikes = this.actorModel.roomLikes;
         _loc1_.VipTier = this.actorModel.VipTier;
         return _loc1_;
      }
      
      private function createPagerResultObject(param1:Array, param2:int, param3:int) : PagerResultObject
      {
         var _loc6_:Array = null;
         var _loc4_:int = param2 * param3;
         var _loc5_:int = _loc4_ + param3;
         var _loc7_:Boolean = true;
         if(_loc5_ > param1.length)
         {
            _loc5_ = int(param1.length);
            _loc7_ = false;
         }
         if(_loc4_ > param1.length)
         {
            _loc6_ = [];
         }
         else
         {
            _loc6_ = param1.slice(_loc4_,_loc5_);
         }
         return new PagerResultObject(param1.length,_loc7_,_loc6_,param2);
      }
      
      private function getDateOneWeekAgo() : Date
      {
         var _loc1_:Date = new Date();
         var _loc2_:Date = new Date();
         _loc2_.setDate(_loc1_.date - 7);
         return _loc2_;
      }
      
      private function fixCasingForOrderBy(param1:String) : String
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case "LEVEL":
               _loc2_ = "Fame";
               break;
            case "FORTUNE":
               _loc2_ = "Fortune";
               break;
            case "ROOMLIKES":
               _loc2_ = "RoomLikes";
         }
         return _loc2_;
      }
      
      public function getHighscoreMovie(param1:HighscoreParams, param2:int, param3:int, param4:Function) : void
      {
         var done:Function = null;
         var parameters:HighscoreParams = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var onResponse:Function = param4;
         done = function(param1:Object):void
         {
            returnResult(param1,pageIndex,pageSize,onResponse);
         };
         amfCaller.callFunction("GetHighscoreMovie",[parameters.actorId,parameters.forFriends,parameters.lastWeek,parameters.orderBy,pageIndex,pageSize],true,done,this.fail);
      }
      
      public function getHighscoreScrapBlogs(param1:HighscoreParams, param2:int, param3:int, param4:Function) : void
      {
         var done:Function = null;
         var parameters:HighscoreParams = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var onResponse:Function = param4;
         done = function(param1:Object):void
         {
            var _loc2_:Boolean = param1.list.length == pageSize;
            var _loc3_:Array = getObjArrayForScraplog(param1);
            var _loc4_:PagerResultObject = new PagerResultObject(param1.totalRecords,_loc2_,_loc3_,pageIndex);
            onResponse(_loc4_);
         };
         amfCaller.callFunction("GetHighscoreScrapBlog",[parameters.actorId,parameters.forFriends,parameters.lastWeek,parameters.orderBy,pageIndex,pageSize],true,done,this.fail);
      }
      
      public function getHighscoreLook(param1:HighscoreParams, param2:int, param3:int, param4:Function) : void
      {
         var done:Function = null;
         var parameters:HighscoreParams = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var onResponse:Function = param4;
         done = function(param1:Object):void
         {
            var callResultCallback:Function = null;
            var obj:Object = param1;
            callResultCallback = function():void
            {
               returnResult(obj,pageIndex,pageSize,onResponse);
            };
            blobService.FillInWithLookData(obj.items,callResultCallback);
         };
         if(parameters.orderBy == null || ["LIKES","SELLS"].indexOf(parameters.orderBy.toUpperCase()) == -1)
         {
            parameters.orderBy = "LIKES";
         }
         amfCaller.callFunction("GetHighscoreLook",[parameters.actorId,parameters.forFriends,parameters.lastWeek,parameters.orderBy,pageIndex,pageSize],true,done,this.fail);
      }
      
      public function getHighscoreClickItem(param1:HighscoreParams, param2:int, param3:int, param4:Function) : void
      {
         var done:Function = null;
         var parameters:HighscoreParams = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var onResponse:Function = param4;
         done = function(param1:Object):void
         {
            returnResult(param1,pageIndex,pageSize,onResponse);
         };
         amfCaller.callFunction("GetHighscorePet",[parameters.actorId,parameters.forFriends,parameters.lastWeek,parameters.orderBy,pageIndex,pageSize],true,done,this.fail);
      }
      
      public function getHighscoreBonster(param1:HighscoreParams, param2:int, param3:int, param4:Function) : void
      {
         var done:Function = null;
         var parameters:HighscoreParams = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var onResponse:Function = param4;
         done = function(param1:Object):void
         {
            returnResult(param1,pageIndex,pageSize,onResponse);
         };
         amfCaller.callFunction("GetHighscoreBonster",[parameters.actorId,parameters.forFriends,parameters.lastWeek,parameters.orderBy,pageIndex,pageSize],true,done,this.fail);
      }
      
      public function getHighscoreAnimation(param1:int, param2:int, param3:Function) : void
      {
         var done:Function = null;
         var pageIndex:int = param1;
         var pageSize:int = param2;
         var onResponse:Function = param3;
         done = function(param1:Object):void
         {
            returnResult(param1,pageIndex,pageSize,onResponse);
         };
         amfCaller.callFunction("GetHighscoreAnimations",[pageIndex,pageSize],true,done,this.fail);
      }
      
      public function getHighscoreBackgrounds(param1:int, param2:int, param3:Function) : void
      {
         var done:Function = null;
         var pageIndex:int = param1;
         var pageSize:int = param2;
         var onResponse:Function = param3;
         done = function(param1:Object):void
         {
            returnResult(param1,pageIndex,pageSize,onResponse);
         };
         amfCaller.callFunction("GetHighscoreBackgrounds",[pageIndex,pageSize],true,done,this.fail);
      }
      
      public function getHighscoreClothes(param1:int, param2:int, param3:Function) : void
      {
         var done:Function = null;
         var pageIndex:int = param1;
         var pageSize:int = param2;
         var onResponse:Function = param3;
         done = function(param1:Object):void
         {
            returnResult(param1,pageIndex,pageSize,onResponse);
         };
         amfCaller.callFunction("GetHighscoreClothes",[pageIndex,pageSize],true,done,this.fail);
      }
      
      public function getHighscoreItems(param1:int, param2:int, param3:Function) : void
      {
         var done:Function = null;
         var pageIndex:int = param1;
         var pageSize:int = param2;
         var onResponse:Function = param3;
         done = function(param1:Object):void
         {
            returnResult(param1,pageIndex,pageSize,onResponse);
         };
         amfCaller.callFunction("GetHighscoreItems",[pageIndex,pageSize],true,done,this.fail);
      }
      
      private function returnResult(param1:Object, param2:int, param3:int, param4:Function) : void
      {
         var _loc5_:Boolean = param1.items.length == param3;
         var _loc6_:Array = this.getObjArray(param1);
         var _loc7_:PagerResultObject = new PagerResultObject(param1.totalRecords,_loc5_,_loc6_,param2);
         param4(_loc7_);
      }
      
      private function fail(param1:Object) : void
      {
         trace("HighscoreAMFService - SERVER FAIL");
      }
      
      private function getObjArray(param1:Object) : Array
      {
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < param1.items.length)
         {
            _loc2_[_loc3_] = param1.items[_loc3_];
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function getObjArrayForScraplog(param1:Object) : Array
      {
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < param1.list.length)
         {
            _loc2_[_loc3_] = param1.list[_loc3_];
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

