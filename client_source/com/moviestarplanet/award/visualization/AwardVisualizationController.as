package com.moviestarplanet.award.visualization
{
   import com.moviestarplanet.actorutils.ActorValueType;
   import com.moviestarplanet.core.model.actor.reload.ActorReload;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.piggybank.events.PiggyEvents;
   import com.moviestarplanet.utils.actorvalues.ActorValueManager;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   
   public class AwardVisualizationController implements IAwardSpawner
   {
      
      private static var visualization:AwardVisualization;
      
      private static var instance:AwardVisualizationController;
      
      public function AwardVisualizationController()
      {
         super();
      }
      
      public static function getInstance() : AwardVisualizationController
      {
         if(instance == null)
         {
            instance = new AwardVisualizationController();
         }
         return instance;
      }
      
      public static function spawnAwards(param1:Number, param2:Number, param3:int, param4:int, param5:int, param6:Boolean, param7:Number = -1, param8:Number = -1, param9:Function = null, param10:Function = null, param11:Function = null) : void
      {
         var starcoinsAccepted:Function = null;
         var fameAccepted:Function = null;
         var diamondsAccepted:Function = null;
         var stageX:Number = param1;
         var stageY:Number = param2;
         var starcoins:int = param3;
         var fame:int = param4;
         var diamonds:int = param5;
         var clientCalculated:Boolean = param6;
         var destinationX:Number = param7;
         var destinationY:Number = param8;
         var starcoinsCB:Function = param9;
         var fameCB:Function = param10;
         var diamondsCB:Function = param11;
         starcoinsAccepted = function(param1:int):void
         {
            ActorValueManager.getInstance().addValue(ActorValueType.STARCOINS,param1,clientCalculated);
         };
         fameAccepted = function(param1:int):void
         {
            ActorValueManager.getInstance().addValue(ActorValueType.FAME,param1,clientCalculated);
         };
         diamondsAccepted = function(param1:int):void
         {
            ActorValueManager.getInstance().addValue(ActorValueType.DIAMONDS,param1,clientCalculated);
         };
         var starcoinsCallback:Function = starcoinsCB == null ? starcoinsAccepted : starcoinsCB;
         var fameCallback:Function = fameCB == null ? fameAccepted : fameCB;
         var diamondCallback:Function = diamondsCB == null ? diamondsAccepted : diamondsCB;
         if(visualization == null)
         {
            visualization = new AwardVisualization(starcoinsCallback,fameCallback,diamondCallback);
         }
         else
         {
            visualization.forceTimeout(0);
            visualization.setStarcoinsAcceptedCallback(starcoinsCallback);
            visualization.setFameAcceptedCallback(fameCallback);
            visualization.setDiamondsAcceptedCallback(diamondCallback);
         }
         ActorReload.getInstance().suspendReload(3000);
         visualization.spawn(ApplicationReference.getApplicationRoot().stage,stageX,stageY,starcoins,fame,diamonds,destinationX,destinationY);
         if(fame > 0 && destinationX == -1 && destinationY == -1)
         {
            MessageCommunicator.send(new MsgEvent(PiggyEvents.ADD_FAME,fame * 0.25));
         }
      }
      
      public static function spawnAwardsFromType(param1:int, param2:int, param3:int, param4:int, param5:Boolean = false) : void
      {
         var _loc8_:Point = null;
         var _loc9_:Point = null;
         var _loc10_:Point = null;
         var _loc11_:Point = null;
         var _loc12_:Point = null;
         var _loc6_:Point = new Point(0,0);
         var _loc7_:DisplayObjectContainer = ApplicationReference.getApplicationRoot();
         switch(param1)
         {
            case AwardVisualizationType.QUEST:
               _loc8_ = new Point(100,360);
               _loc6_ = _loc7_.localToGlobal(_loc8_);
               break;
            case AwardVisualizationType.DIAMOND_FAME_WHEEL:
               _loc9_ = new Point(930,360);
               _loc6_ = _loc7_.localToGlobal(_loc9_);
               break;
            case AwardVisualizationType.ACHIEVEMENT:
               _loc10_ = new Point(920,360);
               _loc6_ = _loc7_.localToGlobal(_loc10_);
               break;
            case AwardVisualizationType.SCREEN_CENTER:
               _loc11_ = new Point(730,390);
               _loc6_ = _loc7_.localToGlobal(_loc11_);
               break;
            case AwardVisualizationType.SCREEN_LOWER_RIGHT_MID:
               _loc12_ = new Point(1095,585);
               _loc6_ = _loc7_.localToGlobal(_loc12_);
         }
         spawnAwards(_loc6_.x,_loc6_.y,param2,param3,param4,param5);
      }
      
      public static function getCurrentAmountOfTweeningAwards() : int
      {
         return visualization.currentAmountOfTweeingAwards;
      }
      
      public function spawnAwardsNonStatic(param1:Number, param2:Number, param3:int, param4:int, param5:int, param6:Boolean, param7:Number = -1, param8:Number = -1, param9:Function = null, param10:Function = null, param11:Function = null) : void
      {
         spawnAwards(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
   }
}

