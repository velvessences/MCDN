package com.moviestarplanet.friendship.service
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.amf.PagerResultObject;
   import com.moviestarplanet.friendship.valueobjects.AcceptToBeMySpecialFriendArgs;
   import com.moviestarplanet.friendship.valueobjects.AskToBeMySpecialFriendArgs;
   import com.moviestarplanet.friendship.valueobjects.PagedActorBrowseItemList;
   import com.moviestarplanet.friendship.valueobjects.RejectMySpecialFriendArgs;
   import com.moviestarplanet.friendship.valueobjects.RetrievedSchoolFriendsLoggerList;
   
   public class FriendshipServiceWeb implements IFriendshipService
   {
      
      private static var _instance:FriendshipServiceWeb;
      
      private static var amfCaller:AmfCaller = new AmfCaller("MovieStarPlanet.WebService.Friendships.AMFFriendshipService");
      
      public static const SAME_USER:int = 0;
      
      public static const NOT_FRIENDS:int = 1;
      
      public static const FRIENDS:int = 2;
      
      public static const WAITING_FOR_ANSWER:int = 3;
      
      public static const WANTS_TO_BE_FRIENDS:int = 4;
      
      public function FriendshipServiceWeb()
      {
         super();
      }
      
      public static function get instance() : FriendshipServiceWeb
      {
         if(_instance == null)
         {
            _instance = new FriendshipServiceWeb();
         }
         return _instance;
      }
      
      public function GetFriendListWithNameAndScore(param1:int, param2:Function) : void
      {
         amfCaller.callFunction("GetFriendListWithNameAndScore",[param1],true,param2);
      }
      
      public function getActorSpecialSummary(param1:int, param2:int, param3:Function) : void
      {
         amfCaller.callFunction("GetActorSpecialSummary",[param1,param2],true,param3);
      }
      
      public function RequestFriendship(param1:int, param2:int, param3:String, param4:Function) : void
      {
         if(RetrievedSchoolFriendsLoggerList.getInstance().contains(param2))
         {
            amfCaller.callFunction("RequestFriendshipFromSchoolmate",[param1,param2,param3],true,param4);
         }
         else
         {
            amfCaller.callFunction("RequestFriendship",[param1,param2,param3],true,param4);
         }
      }
      
      public function GetProfileTodos(param1:int, param2:Function) : void
      {
         amfCaller.callFunction("GetProfileTodos",[param1],true,param2);
      }
      
      public function GetProfileTodosCount(param1:int, param2:Function) : void
      {
         amfCaller.callFunction("GetProfileTodosCount",[param1],true,param2);
      }
      
      public function GetPagedProfileTodos(param1:int, param2:int, param3:int, param4:Function) : void
      {
         var webMethodDone:Function = null;
         var actorId:int = param1;
         var pageId:int = param2;
         var pageSize:int = param3;
         var onSuccess:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            var _loc3_:Array = null;
            var _loc2_:Boolean = param1.items.length == pageSize;
            if(param1.items is Array)
            {
               _loc3_ = param1.items;
            }
            else
            {
               _loc3_ = param1.items.toArray();
            }
            var _loc4_:PagerResultObject = new PagerResultObject(param1.totalRecords,_loc2_,_loc3_,pageId);
            onSuccess(_loc4_);
         };
         amfCaller.callFunction("GetPagedProfileTodos",[actorId,pageId,pageSize],true,webMethodDone);
      }
      
      public function GetSpecialRelationship(param1:int, param2:Function) : void
      {
         amfCaller.callFunction("GetSpecialRelationship",[param1],true,param2);
      }
      
      public function AskToBeMySpecialFriend(param1:AskToBeMySpecialFriendArgs, param2:Function) : void
      {
         if(RetrievedSchoolFriendsLoggerList.getInstance().contains(param1.NewMySpecialFriendActorId))
         {
            amfCaller.callFunction("AskToBeMySpecialFriendFromSchoolmate",[param1],true,param2);
         }
         else
         {
            amfCaller.callFunction("AskToBeMySpecialFriend",[param1],true,param2);
         }
      }
      
      public function AcceptMySpecialFriend(param1:AcceptToBeMySpecialFriendArgs, param2:Function) : void
      {
         amfCaller.callFunction("AcceptMySpecialFriend",[param1],true,param2);
      }
      
      public function RejectMySpecialFriend(param1:RejectMySpecialFriendArgs, param2:Function) : void
      {
         amfCaller.callFunction("RejectMySpecialFriend",[param1],true,param2);
      }
      
      public function GetFriendShipStatus(param1:int, param2:int, param3:Function) : void
      {
         amfCaller.callFunction("GetFriendShipStatus",[param1,param2],true,param3);
      }
      
      public function GetFriendList(param1:int, param2:Function) : void
      {
         amfCaller.callFunction("GetFriendList",[param1],true,param2);
      }
      
      public function DeleteFriendship(param1:int, param2:int, param3:Function) : void
      {
         amfCaller.callFunction("DeleteFriendship",[param1,param2],true,param3);
      }
      
      public function ApproveFriendship(param1:int, param2:int, param3:Function) : void
      {
         amfCaller.callFunction("ApproveFriendship",[param1,param2],true,param3);
      }
      
      public function RejectFriendship(param1:int, param2:int, param3:Function = null) : void
      {
         amfCaller.callFunction("RejectFriendShip",[param1,param2],true,param3);
      }
      
      public function BreakUp(param1:int, param2:int, param3:int, param4:Function) : void
      {
         var webMethodDone:Function = null;
         var userId:int = param1;
         var friendId:int = param2;
         var friendType:int = param3;
         var onSuccess:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            onSuccess();
         };
         amfCaller.callFunction("BreakUp",[userId,friendId,friendType],true,webMethodDone);
      }
      
      public function AskToBeBoyFriend(param1:int, param2:int, param3:int, param4:Function) : void
      {
         if(RetrievedSchoolFriendsLoggerList.getInstance().contains(param2))
         {
            amfCaller.callFunction("AskToBeBoyFriendFromSchoolmate",[param1,param2,param3],true,param4);
         }
         else
         {
            amfCaller.callFunction("AskToBeBoyFriend",[param1,param2,param3],true,param4);
         }
      }
      
      public function AcceptBoyfriend(param1:int, param2:int, param3:int, param4:Function) : void
      {
         amfCaller.callFunction("AcceptBoyfriend",[param1,param2,param3],true,param4);
      }
      
      public function RejectBoyfriend(param1:int, param2:int, param3:int, param4:Function) : void
      {
         amfCaller.callFunction("RejectBoyfriend",[param1,param2,param3],true,param4);
      }
      
      public function FindUserForFriendBrowserClientMerge(param1:Object, param2:int, param3:int, param4:Function) : void
      {
         FakeAMFFindFriendClientMerge.FindUserForFriendBrowserClientMerge(param1,param2,param3,param4,false);
      }
      
      public function FindUserForFriendBrowser(param1:Object, param2:int, param3:int, param4:Function) : void
      {
         var onSuccess:Function = null;
         var params:Object = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var resultCallBack:Function = param4;
         onSuccess = function(param1:Object):void
         {
            var _loc2_:PagedActorBrowseItemList = param1 as PagedActorBrowseItemList;
            var _loc3_:Boolean = _loc2_.items.length == pageSize;
            var _loc4_:PagerResultObject = new PagerResultObject(_loc2_.totalRecords,_loc3_,_loc2_.items,pageIndex);
            resultCallBack(_loc4_);
         };
         amfCaller.callFunction("FindUserForFriendBrowser",[params.actorId,params.includeDeleted,params.searchString,pageIndex,pageSize],true,onSuccess);
      }
      
      public function approveDefaultAnchorFriendship(param1:int, param2:Function) : void
      {
         amfCaller.callFunction("ApproveDefaultAnchorFriendship",[param1],true,param2);
      }
   }
}

