package com.moviestarplanet.Components.pushcontent.frienddisplayer
{
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.platform.ApplicationId;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.window.stack.WindowStackableInterface;
   
   public class FriendDisplayerForSocialShopping extends FriendDisplayer implements WindowStackableInterface
   {
      
      private var _text:String;
      
      public function FriendDisplayerForSocialShopping(param1:Number, param2:Number, param3:String)
      {
         super(param1,param2,snapshotId);
         this._text = param3;
      }
      
      override protected function creationCompleteHandler() : void
      {
         super.passOnCreationCompleteHandler();
         this.title = MSPLocaleManagerWeb.getInstance().getString("SHOP_SOCIAL_SELECTFRIEND");
         var _loc1_:FriendDisplayerInner = new FriendDisplayerInnerForSocialShopping(this.getActivityObject(),ApplicationId.APPLICATION_WEB);
         _loc1_.percentWidth = 100;
         _loc1_.percentHeight = 100;
         super.removeChild(component);
         super.addChild(_loc1_);
      }
      
      override public function getActivityObject() : Object
      {
         return {
            "actorId":ActorSession.getActorId(),
            "type":"SOCIALSHOPPING_INVITE",
            "entityType":"SOCIALSHOPPING_INVITE"
         };
      }
   }
}

