package com.moviestarplanet.award.visualization
{
   import com.greensock.TimelineLite;
   import com.greensock.TimelineMax;
   import com.greensock.TweenAlign;
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.moviestarplanet.award.AwardColors;
   import com.moviestarplanet.award.visualization.graphic.AwardGraphicInterface;
   import com.moviestarplanet.award.visualization.supply.SupplyDI;
   import com.moviestarplanet.award.visualization.supply.SupplyFA;
   import com.moviestarplanet.award.visualization.supply.SupplySC;
   import com.moviestarplanet.award.visualization.supply.VisualSupplyInterface;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.managers.SoundManager;
   import com.moviestarplanet.physics.GraphicsPhysicsController;
   import com.moviestarplanet.physics.GraphicsPhysicsRequest;
   import com.moviestarplanet.physics.PhysicCollisionType;
   import com.moviestarplanet.utils.FontManager;
   import com.moviestarplanet.utils.sound.Sounds;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   
   internal class AwardVisualization
   {
      
      private static const STARCOINS_END_POINT:Point = new Point(350,25);
      
      private static const STARCOINS_SEGMENT_VALUES:Array = [20000,5000,1000,500,100,25,10,5,1];
      
      private static const FAME_END_POINT:Point = new Point(260,60);
      
      private static const FAME_SEGMENT_VALUES:Array = [20000,5000,1000,500,100,25,10,5,1];
      
      private static const DIAMOND_END_POINT:Point = new Point(260,25);
      
      private static const DIAMOND_SEGMENT_VALUES:Array = [20000,5000,1000,500,100,25,10,5,1];
      
      private var starcoinsEndPoint:Point = new Point(0,0);
      
      private var fameEndPoint:Point = new Point(0,0);
      
      private var diamondEndPoint:Point = new Point(0,0);
      
      private var soundmanager:SoundManager;
      
      private var request:GraphicsPhysicsRequest;
      
      private var container:DisplayObjectContainer;
      
      private var timer:Timer;
      
      private var tweenableGraphics:Array;
      
      private var starcoinsAccepted:Function;
      
      private var fameAccepted:Function;
      
      private var diamondsAccepted:Function;
      
      private var supplierSC:VisualSupplyInterface;
      
      private var supplierFA:VisualSupplyInterface;
      
      private var supplierDI:VisualSupplyInterface;
      
      public var currentAmountOfTweeingAwards:int = 0;
      
      public function AwardVisualization(param1:Function, param2:Function, param3:Function)
      {
         super();
         this.starcoinsAccepted = param1;
         this.fameAccepted = param2;
         this.diamondsAccepted = param3;
         this.soundmanager = SoundManager.Instance();
         this.tweenableGraphics = new Array();
         this.supplierSC = new SupplySC();
         this.supplierFA = new SupplyFA();
         this.supplierDI = new SupplyDI();
         this.timer = new Timer(5000,1);
         this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.timerUp,false,0,true);
      }
      
      public function setStarcoinsAcceptedCallback(param1:Function) : void
      {
         this.starcoinsAccepted = param1;
      }
      
      public function setFameAcceptedCallback(param1:Function) : void
      {
         this.fameAccepted = param1;
      }
      
      public function setDiamondsAcceptedCallback(param1:Function) : void
      {
         this.diamondsAccepted = param1;
      }
      
      public function spawn(param1:DisplayObjectContainer, param2:Number, param3:Number, param4:int, param5:int, param6:int, param7:Number = -1, param8:Number = -1) : void
      {
         var _loc22_:Point = null;
         var _loc23_:DisplayObject = null;
         this.container = param1;
         param4 = int(Math.max(0,param4));
         param5 = int(Math.max(0,param5));
         param6 = int(Math.max(0,param6));
         this.timer.stop();
         this.timer.reset();
         var _loc9_:Point = param1.globalToLocal(new Point(param2,param3));
         if(param7 == -1 || param8 == -1)
         {
            this.starcoinsEndPoint = STARCOINS_END_POINT;
            this.fameEndPoint = FAME_END_POINT;
            this.diamondEndPoint = DIAMOND_END_POINT;
         }
         else
         {
            _loc22_ = new Point(param7,param8);
            this.starcoinsEndPoint = this.fameEndPoint = this.diamondEndPoint = _loc22_;
         }
         var _loc10_:DisplayObjectContainer = ApplicationReference.getApplicationRoot();
         var _loc11_:Number = Number(Math.min(_loc10_.scaleX,_loc10_.scaleY));
         var _loc12_:Array = AwardVisualizationUtility.createAwardVisual(param4,STARCOINS_SEGMENT_VALUES,this.supplierSC,AwardType.TYPE_STARCOINS,_loc11_);
         var _loc13_:Array = AwardVisualizationUtility.createAwardVisual(param5,FAME_SEGMENT_VALUES,this.supplierFA,AwardType.TYPE_FAME,_loc11_);
         var _loc14_:Array = AwardVisualizationUtility.createAwardVisual(param6,DIAMOND_SEGMENT_VALUES,this.supplierDI,AwardType.TYPE_DIAMONDS,_loc11_);
         var _loc15_:Array = this.shuffle(_loc12_.concat(_loc13_).concat(_loc14_));
         var _loc16_:int = 0;
         while(_loc16_ < _loc15_.length)
         {
            this.tweenableGraphics.push(_loc15_[_loc16_]);
            _loc16_++;
         }
         var _loc17_:Rectangle = new Rectangle(param1.x,param1.y,param1.width,param1.height);
         var _loc18_:Rectangle = _loc10_.getBounds(null);
         var _loc19_:Point = _loc18_.topLeft;
         var _loc20_:Point = _loc18_.bottomRight;
         _loc19_ = _loc10_.localToGlobal(_loc19_);
         _loc20_ = _loc10_.localToGlobal(_loc20_);
         _loc19_ = param1.globalToLocal(_loc19_);
         _loc20_ = param1.globalToLocal(_loc20_);
         _loc18_ = new Rectangle(_loc19_.x,_loc19_.y,_loc20_.x - _loc19_.x,_loc20_.y - _loc19_.y);
         if(_loc9_.y < _loc18_.y)
         {
            _loc9_.y = _loc18_.y;
         }
         this.request = GraphicsPhysicsController.spawnGraphicsPhysics(param1,_loc18_,_loc9_.x,_loc9_.y,_loc15_,this.awardCollided);
         var _loc21_:int = 0;
         while(_loc21_ < _loc15_.length)
         {
            _loc23_ = _loc15_[_loc21_] as DisplayObject;
            _loc23_.addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOver,false,0,false);
            ++this.currentAmountOfTweeingAwards;
            _loc21_++;
         }
         this.timer.start();
         this.soundmanager.playSoundEffect(Sounds.BURST);
      }
      
      private function awardCollided(param1:AwardGraphicInterface, param2:int) : void
      {
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         switch(param2)
         {
            case PhysicCollisionType.LEFT:
            case PhysicCollisionType.RIGHT:
               _loc3_ = 0.9;
               _loc4_ = 1.1;
               break;
            case PhysicCollisionType.TOP:
            case PhysicCollisionType.BOTTOM:
               _loc3_ = 1.1;
               _loc4_ = 0.9;
         }
         var _loc5_:TimelineLite = new TimelineLite();
         _loc5_.appendMultiple([TweenLite.to(param1,0.1,{
            "scaleX":param1.scaleOrgX * _loc3_,
            "scaleY":param1.scaleOrgY * _loc4_
         }),TweenLite.to(param1,0.1,{
            "scaleX":param1.scaleOrgX,
            "scaleY":param1.scaleOrgY
         })],0,TweenAlign.SEQUENCE,0);
      }
      
      private function timerUp(param1:TimerEvent) : void
      {
         this.pickupAll(this.tweenableGraphics.concat());
         this.tweenableGraphics = new Array();
      }
      
      private function pickupAll(param1:Array, param2:Number = 50) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            param1[_loc3_].removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOver,false);
            if(param2 != 0)
            {
               setTimeout(this.pickup,param2 * _loc3_,param1[_loc3_]);
            }
            else
            {
               this.pickup(param1[_loc3_]);
            }
            _loc3_++;
         }
      }
      
      private function pickup(param1:AwardGraphicInterface) : void
      {
         this.request.removeFromPhysics(param1 as DisplayObject);
         this.tweeningStart(param1);
      }
      
      public function forceTimeout(param1:Number) : void
      {
         if(this.timer.running)
         {
            this.pickupAll(this.tweenableGraphics.concat(),param1);
            this.tweenableGraphics = new Array();
            this.timer.stop();
         }
      }
      
      private function mouseRollOver(param1:MouseEvent) : void
      {
         var _loc2_:AwardGraphicInterface = param1.currentTarget as AwardGraphicInterface;
         this.request.removeFromPhysics(_loc2_ as DisplayObject);
         var _loc3_:int = int(this.tweenableGraphics.indexOf(_loc2_));
         if(_loc3_ > -1)
         {
            this.tweenableGraphics.splice(_loc3_,1);
         }
         _loc2_.removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOver,false);
         this.tweeningStart(_loc2_);
      }
      
      private function tweeningStart(param1:AwardGraphicInterface) : void
      {
         this.tweeningGraphicComplete(param1);
         var _loc2_:DisplayObject = param1 as DisplayObject;
         var _loc3_:uint = 0;
         var _loc4_:Point = new Point(0,0);
         switch(param1.type)
         {
            case AwardType.TYPE_STARCOINS:
               _loc4_ = this.starcoinsEndPoint;
               _loc3_ = AwardColors.COLOR_STARCOINS;
               this.soundmanager.playSoundEffect(Sounds.PICKUP_COIN_FAME);
               break;
            case AwardType.TYPE_DIAMONDS:
               _loc4_ = this.diamondEndPoint;
               _loc3_ = AwardColors.COLOR_DIAMONDS;
               this.soundmanager.playSoundEffect(Sounds.PICKUP_DIAMOND);
               break;
            case AwardType.TYPE_FAME:
               _loc4_ = this.fameEndPoint;
               _loc3_ = AwardColors.COLOR_FAME;
               this.soundmanager.playSoundEffect(Sounds.PICKUP_COIN_FAME);
         }
         _loc4_ = ApplicationReference.getApplicationRoot().localToGlobal(_loc4_);
         _loc4_ = this.container.globalToLocal(_loc4_);
         var _loc5_:GlowFilter = new GlowFilter();
         _loc5_.color = 16777215;
         _loc5_.strength = 230;
         _loc5_.blurX = 3;
         _loc5_.blurY = 3;
         var _loc6_:TextField = new TextField();
         _loc6_.mouseEnabled = false;
         _loc6_.type = TextFieldType.DYNAMIC;
         _loc6_.selectable = false;
         _loc6_.defaultTextFormat = new TextFormat("Arezzo-Rounded-Bold",26,_loc3_);
         _loc6_.text = "+" + param1.value;
         _loc6_.x = _loc2_.x;
         _loc6_.y = _loc2_.y;
         _loc6_.filters = [_loc5_];
         FontManager.remapFonts(_loc6_);
         _loc6_.alpha = 0;
         this.container.addChild(_loc6_);
         TweenLite.to(_loc6_,0.3,{"alpha":1});
         var _loc7_:TimelineLite = new TimelineLite({
            "onComplete":this.tweeningTextComplete,
            "onCompleteParams":[_loc6_]
         });
         _loc7_.appendMultiple([TweenLite.to(_loc6_,0.3,{
            "alpha":1,
            "y":_loc6_.y - 40
         }),TweenLite.to(_loc6_,0.3,{
            "alpha":0,
            "y":_loc6_.y - 80
         })],0,TweenAlign.SEQUENCE,2);
         var _loc8_:TimelineMax = new TimelineMax({
            "onComplete":this.tweeningRemoveGraphic,
            "onCompleteParams":[param1]
         });
         _loc8_.appendMultiple([TweenLite.to(param1,0.3,{
            "scaleX":param1.scaleOrgX * 2,
            "scaleY":param1.scaleOrgX * 2
         }),TweenMax.to(param1,0.6,{
            "scaleX":param1.scaleOrgX,
            "scaleY":param1.scaleOrgY,
            "bezier":[{
               "x":_loc4_.x,
               "y":_loc2_.y
            },{
               "x":_loc4_.x,
               "y":_loc4_.y
            }]
         }),TweenLite.to(param1,0.3,{"alpha":0})],0,TweenAlign.SEQUENCE,0);
      }
      
      private function tweeningTextComplete(param1:TextField) : void
      {
         this.container.removeChild(param1);
      }
      
      private function tweeningRemoveGraphic(param1:AwardGraphicInterface) : void
      {
         this.container.removeChild(param1 as DisplayObject);
         switch(param1.type)
         {
            case AwardType.TYPE_STARCOINS:
               this.supplierSC.release(param1);
               break;
            case AwardType.TYPE_DIAMONDS:
               this.supplierDI.release(param1);
               break;
            case AwardType.TYPE_FAME:
               this.supplierFA.release(param1);
         }
      }
      
      private function tweeningGraphicComplete(param1:AwardGraphicInterface) : void
      {
         switch(param1.type)
         {
            case AwardType.TYPE_STARCOINS:
               this.starcoinsAccepted(param1.value);
               break;
            case AwardType.TYPE_DIAMONDS:
               this.diamondsAccepted(param1.value);
               break;
            case AwardType.TYPE_FAME:
               this.fameAccepted(param1.value);
         }
         --this.currentAmountOfTweeingAwards;
         if(this.currentAmountOfTweeingAwards == 0)
         {
            MessageCommunicator.send(new MsgEvent(MSPEvent.ALL_AWARD_TWEENS_DONE));
         }
      }
      
      private function shuffle(param1:Array) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         var _loc2_:* = int(param1.length - 1);
         while(_loc2_ >= 0)
         {
            _loc3_ = int(Math.random() * 1000) % _loc2_;
            _loc4_ = param1[_loc2_];
            param1[_loc2_] = param1[_loc3_];
            param1[_loc3_] = _loc4_;
            _loc2_--;
         }
         return param1;
      }
   }
}

