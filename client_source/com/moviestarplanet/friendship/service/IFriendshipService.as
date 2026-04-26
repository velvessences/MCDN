package com.moviestarplanet.friendship.service
{
   import com.moviestarplanet.friendship.valueobjects.AcceptToBeMySpecialFriendArgs;
   import com.moviestarplanet.friendship.valueobjects.AskToBeMySpecialFriendArgs;
   import com.moviestarplanet.friendship.valueobjects.RejectMySpecialFriendArgs;
   
   public interface IFriendshipService
   {
      
      function GetFriendListWithNameAndScore(param1:int, param2:Function) : void;
      
      function getActorSpecialSummary(param1:int, param2:int, param3:Function) : void;
      
      function RequestFriendship(param1:int, param2:int, param3:String, param4:Function) : void;
      
      function GetProfileTodos(param1:int, param2:Function) : void;
      
      function GetProfileTodosCount(param1:int, param2:Function) : void;
      
      function GetPagedProfileTodos(param1:int, param2:int, param3:int, param4:Function) : void;
      
      function GetSpecialRelationship(param1:int, param2:Function) : void;
      
      function AskToBeMySpecialFriend(param1:AskToBeMySpecialFriendArgs, param2:Function) : void;
      
      function AcceptMySpecialFriend(param1:AcceptToBeMySpecialFriendArgs, param2:Function) : void;
      
      function RejectMySpecialFriend(param1:RejectMySpecialFriendArgs, param2:Function) : void;
      
      function GetFriendShipStatus(param1:int, param2:int, param3:Function) : void;
      
      function GetFriendList(param1:int, param2:Function) : void;
      
      function DeleteFriendship(param1:int, param2:int, param3:Function) : void;
      
      function ApproveFriendship(param1:int, param2:int, param3:Function) : void;
      
      function RejectFriendship(param1:int, param2:int, param3:Function = null) : void;
      
      function BreakUp(param1:int, param2:int, param3:int, param4:Function) : void;
      
      function AskToBeBoyFriend(param1:int, param2:int, param3:int, param4:Function) : void;
      
      function AcceptBoyfriend(param1:int, param2:int, param3:int, param4:Function) : void;
      
      function RejectBoyfriend(param1:int, param2:int, param3:int, param4:Function) : void;
      
      function FindUserForFriendBrowser(param1:Object, param2:int, param3:int, param4:Function) : void;
   }
}

