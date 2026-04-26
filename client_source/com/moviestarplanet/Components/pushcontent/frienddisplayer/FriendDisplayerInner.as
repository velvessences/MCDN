package com.moviestarplanet.Components.pushcontent.frienddisplayer
{
   import com.moviestarplanet.Components.Friends.MyOnlineFriendsComponent;
   import com.moviestarplanet.Forms.ActorOnlineStatusEvent;
   import com.moviestarplanet.anchorCharacters.AnchorCharacters;
   import com.moviestarplanet.friends.FriendsManager;
   import com.moviestarplanet.model.friends.IFriend;
   import flash.utils.Dictionary;
   import mx.core.ClassFactory;
   import mx.events.FlexEvent;
   import mx.utils.ObjectUtil;
   
   public class FriendDisplayerInner extends MyOnlineFriendsComponent
   {
      
      private var _activityObj:Object;
      
      protected var _applicationType:String = "";
      
      private var dict:Dictionary = new Dictionary();
      
      public function FriendDisplayerInner(param1:Object, param2:String = "")
      {
         super();
         this._activityObj = param1;
         this._applicationType = param2;
         addEventListener(FlexEvent.CREATION_COMPLETE,this.this_creationCompleteHandler);
      }
      
      protected function this_creationCompleteHandler(param1:FlexEvent) : void
      {
         list.itemRenderer = new ClassFactory(FriendDisplayerListItem);
         super.btn_Invite.visible = false;
         super.btn_Invite.includeInLayout = false;
      }
      
      override protected function actorOnlineHandler(param1:ActorOnlineStatusEvent) : void
      {
         var _loc7_:String = null;
         var _loc8_:Object = null;
         if(!this.allowAdd(param1.friend))
         {
            return;
         }
         labelNoFriendsYet.visible = false;
         labelNoOnlineFriends.visible = false;
         var _loc2_:Number = Number(list.verticalScrollPosition);
         var _loc3_:int = int(list.dataProvider.length);
         var _loc4_:String = param1.friend.name;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         while(_loc6_ < list.dataProvider.length && !_loc5_)
         {
            _loc7_ = Object(list.dataProvider[_loc6_]).friend.friendName;
            if(ObjectUtil.stringCompare(_loc7_,_loc4_,true) > 0)
            {
               _loc5_ = true;
               _loc3_ = _loc6_;
            }
            _loc6_++;
         }
         if(this.dict[param1.friend.userId] == null)
         {
            _loc8_ = new Object();
            _loc8_.friend = param1.friend;
            _loc8_.isClicked = false;
            _loc8_.activityObj = this._activityObj;
            this.dict[param1.friend.userId] = _loc8_;
         }
         list.dataProvider.addItemAt(this.dict[param1.friend.userId],_loc3_);
         list.verticalScrollPosition = _loc2_;
      }
      
      override protected function actorOfflineHandler(param1:ActorOnlineStatusEvent) : void
      {
         var _loc2_:Object = null;
         try
         {
            for each(_loc2_ in list.dataProvider)
            {
               if(_loc2_.friend.userId == param1.friend.userId)
               {
                  list.dataProvider.removeItemAt(list.dataProvider.getItemIndex(this.dict[param1.friend.userId]));
                  break;
               }
            }
         }
         catch(error:Error)
         {
         }
         if(list.dataProvider.length == 0)
         {
            labelNoFriendsYet.visible = false;
            labelNoOnlineFriends.visible = true;
         }
      }
      
      override protected function populate() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:IFriend = null;
         var _loc3_:Object = null;
         list.dataProvider = new Array();
         if(FriendsManager.getInstance().getNumFriends() == 0)
         {
            labelNoFriendsYet.visible = true;
            labelNoOnlineFriends.visible = false;
         }
         else if(FriendsManager.getInstance().numFriendsOnline == 0 && FriendsManager.getInstance().getNumFriends() != 0)
         {
            labelNoFriendsYet.visible = false;
            labelNoOnlineFriends.visible = true;
         }
         else
         {
            labelNoFriendsYet.visible = false;
            labelNoOnlineFriends.visible = false;
            _loc1_ = Number(list.verticalScrollPosition);
            for each(_loc2_ in FriendsManager.getInstance().getOnlineFriends())
            {
               if(this.dict[_loc2_.userId] == null)
               {
                  _loc3_ = new Object();
                  _loc3_.friend = _loc2_;
                  _loc3_.isClicked = false;
                  _loc3_.activityObj = this._activityObj;
                  this.dict[_loc2_.userId] = _loc3_;
               }
               if(this.allowAdd(_loc2_))
               {
                  list.dataProvider.addItem(this.dict[_loc2_.userId]);
               }
            }
            list.verticalScrollPosition = _loc1_;
         }
      }
      
      protected function allowAdd(param1:IFriend) : Boolean
      {
         if(AnchorCharacters.isSpecialCharacter(param1.userId))
         {
            return false;
         }
         return param1.applicationType == this._applicationType || this._applicationType == "";
      }
   }
}

