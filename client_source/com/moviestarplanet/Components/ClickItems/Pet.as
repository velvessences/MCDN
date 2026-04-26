package com.moviestarplanet.Components.ClickItems
{
   import com.moviestarplanet.analytics.AnalyticsReceiveCurrencyCommand;
   import com.moviestarplanet.analytics.constants.AnalyticsConstants;
   import com.moviestarplanet.chat.ChatRoomController;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.core.model.actor.reload.ActorReload;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.moviestar.MovieStar;
   import com.moviestarplanet.pet.service.PetAMFService;
   import com.moviestarplanet.pet.utils.ClickItemUtil;
   import com.moviestarplanet.pet.valueobjects.ActorClickItemRel;
   import com.moviestarplanet.utils.DateUtils;
   import com.moviestarplanet.utils.DisplayUtils;
   import com.moviestarplanet.utils.MSP_SWFLoader;
   import com.moviestarplanet.utils.loader.RawUrl;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import mx.core.UIComponent;
   import mx.effects.Move;
   import mx.effects.Parallel;
   import mx.effects.Resize;
   import mx.effects.Rotate;
   import mx.effects.Sequence;
   import mx.effects.easing.Back;
   import mx.effects.easing.Linear;
   import mx.effects.easing.Sine;
   import mx.managers.CursorManager;
   import mx.managers.CursorManagerPriority;
   
   public class Pet extends Monster
   {
      
      private static const PLAY_LEVELS:Array = [0,50,500,1500,4000,7000,12000,18000,26000,36000,50000];
      
      private var dirtState:int = 0;
      
      private var _tricks:Array;
      
      private var ball:Ball;
      
      private var responseTime:int;
      
      private var ballState:int;
      
      private var count:int;
      
      private var ballTimeout:Timer;
      
      private var BOUNDS_MAX:int = 500;
      
      private var BOUNDS_MIN:int = 250;
      
      private var lowerBoundsLeft:int;
      
      private var upperBoundsLeft:int;
      
      private var lowerBoundsRight:int;
      
      private var upperBoundsRight:int;
      
      private var soapCursorId:int = 0;
      
      private var isSoapOver:Boolean = false;
      
      private var soapCursorClass:Class = Pet_soapCursorClass;
      
      private var bubbles:MovieClip = null;
      
      private var bubbleTimer:Timer;
      
      private var washTimer:Timer;
      
      private var vanishTimer:Timer;
      
      private var isWashing:Boolean;
      
      private var _playLevel:int = -1;
      
      public function Pet(param1:ActorClickItemRel)
      {
         this._tricks = [{
            "label":"Spin (level 0)",
            "trickCall":this.rotate
         },{
            "label":"Hop (level 1)",
            "trickCall":this.hopUpAndDown
         },{
            "label":"Squash (level 2)",
            "trickCall":this.squashPet
         },{
            "label":"Hop away (level 3)",
            "trickCall":this.hopAround
         },{
            "label":"Roll (level 4)",
            "trickCall":this.rollTrick
         },{
            "label":"Flick (level 5)",
            "trickCall":this.jumpAndRoll
         },{
            "label":"Head Hop (level 6)",
            "trickCall":this.hopOnHead
         },{
            "label":"3ple Flick (level 7)",
            "trickCall":this.tripleFlick
         },{
            "label":"Hop\'n\'roll (level 8)",
            "trickCall":this.hopHigherAndRoll
         },{
            "label":"MegaHop (level 9)",
            "trickCall":this.hopToTheCeiling
         },{
            "label":"Shoot (level 10)",
            "trickCall":this.shootAround
         }];
         super(param1);
      }
      
      override public function update() : void
      {
         super.update();
         this.updateDirtState();
         this.updatePlayLevel();
      }
      
      override public function paintMood() : void
      {
         super.paintMood();
      }
      
      override public function click(param1:Event = null) : void
      {
         this.resetCursor();
         super.click(param1);
      }
      
      public function get tricks() : Array
      {
         if(this.playLevel + 1 < this._tricks.length)
         {
            return this._tricks.slice(0,this.playLevel + 1);
         }
         return this._tricks;
      }
      
      public function doTrick(param1:int) : void
      {
         if(this.tricks.length > param1)
         {
            this.tricks[param1].trickCall();
         }
      }
      
      public function broadcastTrick(param1:int) : void
      {
         if(parent is MovieStar && (parent as MovieStar).isInChatRoom)
         {
            ChatRoomController.chatRoomView.sendPetTrickToFriends(param1);
         }
      }
      
      public function hopToLocation() : void
      {
         var _loc1_:Number = clickItemData.y - y;
         var _loc2_:Number = clickItemData.x - x;
         var _loc3_:Number = 60;
         var _loc4_:int = Math.abs(_loc2_ / _loc3_) + 1;
         _loc3_ = _loc2_ / _loc4_;
         var _loc5_:Number = _loc1_ / (_loc4_ * 2);
         var _loc6_:Move = this.up(-100 + _loc5_,200);
         _loc6_.xBy = _loc3_ / 2;
         var _loc7_:Move = this.down(100 + _loc5_,200);
         _loc7_.xBy = _loc3_ / 2;
         var _loc8_:Sequence = new Sequence();
         var _loc9_:int = 0;
         while(_loc9_ < _loc4_)
         {
            _loc8_.addChild(_loc6_);
            _loc8_.addChild(_loc7_);
            _loc9_++;
         }
         _loc8_.play([this]);
      }
      
      public function playBall() : void
      {
         if(!parent)
         {
            return;
         }
         ChatRoomController.walkEnabled = false;
         ChatRoomController.isPlayingChatroomGame = true;
         if(this.ballTimeout)
         {
            this.ballTimeout.stop();
         }
         this.responseTime = 1500;
         this.count = 0;
         if(this.ball == null)
         {
            this.ball = new Ball();
            this.ball.loadSource("swf/games/ball.swf",this.ballLoaded);
            this.ball.addEventListener(MouseEvent.MOUSE_DOWN,this.ballClicked);
         }
         else
         {
            this.ballLoaded();
         }
      }
      
      public function wash() : void
      {
         var loadBubblesDone:Function;
         var bubblesSwfUrl:String = null;
         var addBubbles:Function = function():void
         {
            addChild(bubbles);
            if(isSoapOver)
            {
               bubbles.play();
            }
            else
            {
               bubbles.visible = false;
            }
         };
         this.washTimer = new Timer(1000,(this.dirtState + 1) * 3);
         this.washTimer.addEventListener(TimerEvent.TIMER,this.washCounter);
         this.bubbleTimer = new Timer(100,9999);
         this.bubbleTimer.addEventListener(TimerEvent.TIMER,this.bubbleTimeout);
         this.vanishTimer = new Timer(500,1);
         this.vanishTimer.addEventListener(TimerEvent.TIMER,this.vanishBubbles);
         addEventListener(Event.REMOVED_FROM_STAGE,this.resetCursor);
         addEventListener(MouseEvent.MOUSE_OVER,this.playWash);
         addEventListener(MouseEvent.MOUSE_OUT,this.pauseWash);
         addEventListener(MouseEvent.MOUSE_MOVE,this.moveSoap);
         this.soapCursor();
         if(this.bubbles == null)
         {
            loadBubblesDone = function(param1:MSP_SWFLoader):void
            {
               bubbles = param1.content as MovieClip;
               addBubbles();
               if(parent is MovieStar)
               {
                  bubbles.scaleX = scaleX * 0.25;
                  bubbles.scaleY = scaleY * 0.25;
               }
               else
               {
                  bubbles.scaleX = scaleX * 0.7;
                  bubbles.scaleY = scaleY * 0.7;
               }
            };
            bubblesSwfUrl = "swf/games/bobbles00.swf";
            MSP_SWFLoader.RequestLoad(new RawUrl(bubblesSwfUrl),loadBubblesDone);
         }
         else
         {
            addBubbles();
         }
         this.isWashing = true;
      }
      
      override protected function hatchDone(param1:Event) : void
      {
         super.hatchDone(param1);
         clickItemData.LastWashTime = DateUtils.nowUTC;
      }
      
      private function rollForward() : Sequence
      {
         var _loc1_:Rectangle = this.getBounds(parent);
         var _loc2_:Rotate = new Rotate();
         _loc2_.originX = _loc1_.width;
         _loc2_.originY = _loc1_.height;
         _loc2_.angleTo = 90;
         _loc2_.duration = 200;
         _loc2_.easingFunction = Sine.easeIn;
         var _loc3_:Rotate = new Rotate();
         _loc3_.originX = _loc1_.width;
         _loc3_.originY = 0;
         _loc3_.angleFrom = 90;
         _loc3_.angleTo = 180;
         _loc3_.duration = 200;
         _loc3_.easingFunction = Linear.easeNone;
         var _loc4_:Rotate = new Rotate();
         _loc4_.originX = 0;
         _loc4_.originY = 0;
         _loc4_.angleFrom = 180;
         _loc4_.angleTo = 270;
         _loc4_.duration = 200;
         _loc4_.easingFunction = Linear.easeNone;
         var _loc5_:Rotate = new Rotate();
         _loc5_.originX = 0;
         _loc5_.originY = _loc1_.height;
         _loc5_.angleFrom = 270;
         _loc5_.angleTo = 360;
         _loc5_.duration = 200;
         _loc5_.easingFunction = Sine.easeOut;
         var _loc6_:Sequence = new Sequence();
         _loc6_.addChild(_loc2_);
         _loc6_.addChild(_loc3_);
         _loc6_.addChild(_loc4_);
         _loc6_.addChild(_loc5_);
         return _loc6_;
      }
      
      private function rollBack() : Sequence
      {
         var _loc1_:Rectangle = this.getBounds(parent);
         var _loc2_:Rotate = new Rotate();
         _loc2_.originX = _loc1_.width;
         _loc2_.originY = _loc1_.height;
         _loc2_.angleFrom = -270;
         _loc2_.angleTo = -360;
         _loc2_.duration = 200;
         _loc2_.easingFunction = Sine.easeOut;
         var _loc3_:Rotate = new Rotate();
         _loc3_.originX = _loc1_.width;
         _loc3_.originY = 0;
         _loc3_.angleFrom = -180;
         _loc3_.angleTo = -270;
         _loc3_.duration = 200;
         _loc3_.easingFunction = Linear.easeNone;
         var _loc4_:Rotate = new Rotate();
         _loc4_.originX = 0;
         _loc4_.originY = 0;
         _loc4_.angleFrom = -90;
         _loc4_.angleTo = -180;
         _loc4_.duration = 200;
         _loc4_.easingFunction = Linear.easeNone;
         var _loc5_:Rotate = new Rotate();
         _loc5_.originX = 0;
         _loc5_.originY = _loc1_.height;
         _loc5_.angleFrom = 0;
         _loc5_.angleTo = -90;
         _loc5_.duration = 200;
         _loc5_.easingFunction = Sine.easeIn;
         var _loc6_:Sequence = new Sequence();
         _loc6_.addChild(_loc5_);
         _loc6_.addChild(_loc4_);
         _loc6_.addChild(_loc3_);
         _loc6_.addChild(_loc2_);
         return _loc6_;
      }
      
      private function rollTrick() : void
      {
         var _loc1_:Sequence = new Sequence();
         _loc1_.addChild(this.rollForward());
         _loc1_.addChild(this.sit(200));
         _loc1_.addChild(this.rollBack());
         _loc1_.play([this]);
      }
      
      private function jumpAndRoll() : void
      {
         var _loc1_:Rectangle = this.getBounds(parent);
         var _loc2_:Rotate = new Rotate();
         _loc2_.originX = _loc1_.width / 2;
         _loc2_.originY = _loc1_.height / 2;
         _loc2_.angleTo = 180;
         _loc2_.duration = 400;
         _loc2_.easingFunction = Linear.easeOut;
         var _loc3_:Rotate = new Rotate();
         _loc3_.originX = _loc1_.width / 2;
         _loc3_.originY = _loc1_.height / 2;
         _loc3_.angleFrom = 180;
         _loc3_.angleTo = 360;
         _loc3_.duration = 400;
         _loc3_.easingFunction = Linear.easeIn;
         var _loc4_:Move = this.up(-100,400);
         var _loc5_:Move = this.down(100,400);
         var _loc6_:Parallel = new Parallel();
         var _loc7_:Parallel = new Parallel();
         _loc6_.addChild(_loc2_);
         _loc6_.addChild(_loc4_);
         _loc7_.addChild(_loc3_);
         _loc7_.addChild(_loc5_);
         var _loc8_:Sequence = new Sequence();
         _loc8_.addChild(_loc6_);
         _loc8_.addChild(_loc7_);
         _loc8_.play([this]);
      }
      
      private function tripleFlick() : void
      {
         var _loc1_:Rectangle = this.getBounds(parent);
         var _loc2_:Rotate = new Rotate();
         _loc2_.originX = _loc1_.width / 2;
         _loc2_.originY = _loc1_.height / 2;
         _loc2_.angleTo = 540;
         _loc2_.duration = 600;
         _loc2_.easingFunction = Linear.easeOut;
         var _loc3_:Rotate = new Rotate();
         _loc3_.originX = _loc1_.width / 2;
         _loc3_.originY = _loc1_.height / 2;
         _loc3_.angleFrom = 540;
         _loc3_.angleTo = 1080;
         _loc3_.duration = 600;
         _loc3_.easingFunction = Linear.easeIn;
         var _loc4_:Move = this.up(-200,600);
         var _loc5_:Move = this.down(200,600);
         var _loc6_:Parallel = new Parallel();
         var _loc7_:Parallel = new Parallel();
         _loc6_.addChild(_loc2_);
         _loc6_.addChild(_loc4_);
         _loc7_.addChild(_loc3_);
         _loc7_.addChild(_loc5_);
         var _loc8_:Sequence = new Sequence();
         _loc8_.addChild(_loc6_);
         _loc8_.addChild(_loc7_);
         _loc8_.play([this]);
      }
      
      private function rotate() : void
      {
         var _loc1_:Rectangle = this.getBounds(parent);
         var _loc2_:Rotate = new Rotate();
         _loc2_.originX = _loc1_.width / 2;
         _loc2_.originY = _loc1_.height / 2;
         _loc2_.angleFrom = 0;
         _loc2_.angleTo = 360;
         _loc2_.duration = 800;
         _loc2_.easingFunction = Linear.easeInOut;
         var _loc3_:Sequence = new Sequence();
         _loc3_.addChild(_loc2_);
         _loc3_.play([this]);
      }
      
      private function squeezePet() : void
      {
         maintainAspectRatio = false;
         var _loc1_:Rectangle = this.getBounds(parent);
         var _loc2_:Number = Number(width);
         var _loc3_:Resize = new Resize();
         _loc3_.widthTo = _loc2_ / 3;
         _loc3_.heightTo = height * 1.5;
         _loc3_.duration = 900;
         _loc3_.easingFunction = Sine.easeOut;
         var _loc4_:Move = new Move();
         _loc4_.yBy = -_loc1_.height * 0.25;
         _loc4_.duration = 900;
         _loc4_.easingFunction = Sine.easeOut;
         var _loc5_:Resize = new Resize();
         _loc5_.duration = 100;
         _loc5_.widthTo = _loc2_;
         _loc5_.heightTo = height;
         _loc5_.easingFunction = Back.easeOut;
         var _loc6_:Move = new Move();
         _loc6_.yBy = _loc1_.height * 0.25;
         _loc6_.duration = 100;
         _loc6_.easingFunction = Linear.easeNone;
         var _loc7_:Parallel = new Parallel();
         _loc7_.addChild(_loc3_);
         _loc7_.addChild(_loc4_);
         var _loc8_:Parallel = new Parallel();
         _loc8_.addChild(_loc5_);
         _loc8_.addChild(_loc6_);
         var _loc9_:Sequence = new Sequence();
         _loc9_.addChild(_loc7_);
         _loc9_.addChild(_loc8_);
         _loc9_.addChild(_loc7_);
         _loc9_.addChild(_loc8_);
         _loc9_.addChild(_loc7_);
         _loc9_.addChild(_loc8_);
         _loc9_.play([this]);
      }
      
      private function squashPet() : void
      {
         maintainAspectRatio = false;
         var _loc1_:DisplayObjectContainer = this.getContainingRoom();
         var _loc2_:Rectangle = this.getBounds(_loc1_);
         var _loc3_:Resize = new Resize();
         _loc3_.heightTo = height / 2;
         _loc3_.duration = 400;
         _loc3_.easingFunction = Sine.easeOut;
         var _loc4_:Move = this.down(_loc2_.height / 2,400);
         _loc4_.easingFunction = Sine.easeOut;
         var _loc5_:Resize = new Resize();
         _loc5_.duration = 100;
         _loc5_.heightTo = height;
         _loc5_.easingFunction = Sine.easeOut;
         var _loc6_:Move = this.up(-_loc2_.height / 2,100);
         _loc6_.easingFunction = Sine.easeIn;
         var _loc7_:Parallel = new Parallel();
         _loc7_.addChild(_loc3_);
         _loc7_.addChild(_loc4_);
         var _loc8_:Parallel = new Parallel();
         _loc8_.addChild(_loc5_);
         _loc8_.addChild(_loc6_);
         var _loc9_:Move = this.up(-120,200);
         var _loc10_:Move = this.down(120,200);
         var _loc11_:Sequence = new Sequence();
         _loc11_.addChild(_loc7_);
         _loc11_.addChild(_loc8_);
         _loc11_.addChild(_loc9_);
         _loc11_.addChild(_loc10_);
         _loc11_.addChild(_loc7_);
         _loc11_.addChild(this.sit(200));
         _loc11_.addChild(_loc8_);
         _loc11_.play([this]);
      }
      
      private function up(param1:Number, param2:Number) : Move
      {
         var _loc3_:Move = new Move();
         _loc3_.yBy = param1 / parent.scaleY;
         _loc3_.duration = param2;
         _loc3_.easingFunction = Sine.easeOut;
         return _loc3_;
      }
      
      private function down(param1:Number, param2:Number) : Move
      {
         var _loc3_:Move = new Move();
         _loc3_.yBy = param1 / parent.scaleY;
         _loc3_.duration = param2;
         _loc3_.easingFunction = Sine.easeIn;
         return _loc3_;
      }
      
      private function sit(param1:Number) : Move
      {
         var _loc2_:Move = new Move();
         _loc2_.yBy = 0;
         _loc2_.duration = param1;
         _loc2_.easingFunction = Linear.easeNone;
         return _loc2_;
      }
      
      private function shootAround() : void
      {
         var _loc37_:Move = null;
         var _loc38_:Move = null;
         var _loc39_:Move = null;
         maintainAspectRatio = false;
         var _loc1_:DisplayObjectContainer = this.getContainingRoom();
         var _loc2_:Rectangle = this.getBounds(_loc1_);
         var _loc3_:Number = Number(_loc2_.y);
         var _loc4_:Number = (_loc1_.width - _loc2_.width) / parent.scaleX;
         var _loc5_:Number = _loc2_.x / parent.scaleX;
         var _loc6_:int = 7;
         var _loc7_:Number = _loc4_ / _loc6_;
         var _loc8_:Number = _loc5_ % _loc7_;
         var _loc9_:Number = _loc8_ / _loc7_;
         var _loc10_:int = 100;
         var _loc11_:int = 40;
         var _loc12_:Number = _loc3_ * (1 - _loc9_);
         var _loc13_:Number = _loc3_ - _loc12_;
         var _loc14_:int = _loc10_ * (1 - _loc9_);
         var _loc15_:int = _loc10_ - _loc14_;
         var _loc16_:Number = _loc5_;
         var _loc17_:int = 1;
         var _loc18_:int = -1;
         var _loc19_:Number = Number(width);
         var _loc20_:Resize = new Resize();
         _loc20_.widthTo = _loc19_ / 2;
         _loc20_.heightTo = height * 1.5;
         _loc20_.duration = _loc11_;
         _loc20_.easingFunction = Sine.easeOut;
         var _loc21_:Move = this.up(-_loc2_.height / 4,_loc11_);
         var _loc22_:Resize = new Resize();
         _loc22_.duration = _loc11_;
         _loc22_.widthTo = _loc19_;
         _loc22_.heightTo = height;
         _loc22_.easingFunction = Sine.easeIn;
         var _loc23_:Move = this.down(_loc2_.height / 4,_loc11_);
         var _loc24_:Parallel = new Parallel();
         _loc24_.addChild(_loc20_);
         _loc24_.addChild(_loc21_);
         var _loc25_:Parallel = new Parallel();
         _loc25_.addChild(_loc22_);
         _loc25_.addChild(_loc23_);
         var _loc26_:Move = this.up(-_loc2_.height / 4,_loc11_);
         _loc26_.xBy = _loc19_ / 2;
         var _loc27_:Move = this.down(_loc2_.height / 4,_loc11_);
         _loc27_.xBy = -_loc19_ / 2;
         var _loc28_:Parallel = new Parallel();
         _loc28_.addChild(_loc20_);
         _loc28_.addChild(_loc26_);
         var _loc29_:Parallel = new Parallel();
         _loc29_.addChild(_loc22_);
         _loc29_.addChild(_loc27_);
         var _loc30_:Resize = new Resize();
         _loc30_.heightTo = height / 2;
         _loc30_.duration = 100;
         _loc30_.easingFunction = Sine.easeOut;
         var _loc31_:Move = this.down(_loc2_.height / 2,100);
         _loc31_.easingFunction = Sine.easeOut;
         var _loc32_:Resize = new Resize();
         _loc32_.duration = 100;
         _loc32_.heightTo = height;
         _loc32_.easingFunction = Sine.easeIn;
         var _loc33_:Move = this.up(-_loc2_.height / 2,100);
         _loc33_.easingFunction = Sine.easeIn;
         var _loc34_:Parallel = new Parallel();
         _loc34_.addChild(_loc30_);
         _loc34_.addChild(_loc31_);
         var _loc35_:Parallel = new Parallel();
         _loc35_.addChild(_loc32_);
         _loc35_.addChild(_loc33_);
         var _loc36_:Sequence = new Sequence();
         var _loc40_:int = 0;
         while(_loc40_ < _loc6_ * 2)
         {
            if(_loc17_ > 0 && _loc16_ + _loc7_ > _loc4_)
            {
               _loc38_ = _loc18_ > 0 ? this.down(_loc12_,_loc14_) : this.up(-_loc12_,_loc14_);
               _loc39_ = _loc18_ > 0 ? this.down(_loc13_,_loc15_) : this.up(-_loc13_,_loc15_);
               _loc38_.xBy = _loc7_ - _loc8_;
               _loc39_.xBy = -_loc8_;
               _loc36_.addChild(_loc38_);
               _loc36_.addChild(_loc28_);
               _loc36_.addChild(_loc29_);
               _loc36_.addChild(_loc39_);
               _loc16_ += _loc7_ - 2 * _loc8_;
               _loc17_ = -1;
            }
            else if(_loc17_ < 0 && _loc16_ - _loc7_ < 0)
            {
               _loc38_ = _loc18_ > 0 ? this.down(_loc12_,_loc14_) : this.up(-_loc12_,_loc14_);
               _loc39_ = _loc18_ > 0 ? this.down(_loc13_,_loc15_) : this.up(-_loc13_,_loc15_);
               _loc38_.xBy = _loc8_ - _loc7_;
               _loc39_.xBy = _loc8_;
               _loc36_.addChild(_loc38_);
               _loc36_.addChild(_loc24_);
               _loc36_.addChild(_loc25_);
               _loc36_.addChild(_loc39_);
               _loc16_ += 2 * _loc8_ - _loc7_;
               _loc17_ = 1;
            }
            else
            {
               _loc37_ = _loc18_ > 0 ? this.down(_loc3_,_loc10_) : this.up(-_loc3_,_loc10_);
               _loc37_.xBy = _loc17_ * _loc7_;
               _loc36_.addChild(_loc37_);
               _loc16_ += _loc17_ * _loc7_;
            }
            if(_loc18_ > 0)
            {
               _loc36_.addChild(_loc34_);
               _loc36_.addChild(_loc35_);
            }
            else
            {
               _loc36_.addChild(_loc30_);
               _loc36_.addChild(_loc32_);
            }
            _loc18_ *= -1;
            _loc40_++;
         }
         _loc36_.play([this]);
      }
      
      private function hopToTheCeiling() : void
      {
         maintainAspectRatio = false;
         var _loc1_:Rectangle = this.getBounds(this.getContainingRoom());
         var _loc2_:Number = -_loc1_.y;
         var _loc3_:Move = this.up(_loc2_ / 3,300);
         var _loc4_:Move = this.down(-_loc2_ / 3,300);
         var _loc5_:Move = this.up(_loc2_ * 3 / 5,400);
         var _loc6_:Move = this.down(-_loc2_ * 3 / 5,400);
         var _loc7_:Move = this.up(_loc2_,500);
         _loc7_.easingFunction = Linear.easeNone;
         var _loc8_:Resize = new Resize();
         _loc8_.heightTo = height / 3;
         _loc8_.duration = 400;
         _loc8_.easingFunction = Sine.easeOut;
         var _loc9_:Move = this.down(-_loc2_ + _loc1_.height * 2 / 3,1000);
         _loc9_.easingFunction = Linear.easeIn;
         var _loc10_:Resize = new Resize();
         _loc10_.duration = 100;
         _loc10_.heightTo = height;
         _loc10_.easingFunction = Sine.easeIn;
         var _loc11_:Move = this.up(-_loc1_.height * 2 / 3,100);
         var _loc12_:Parallel = new Parallel();
         _loc12_.addChild(_loc10_);
         _loc12_.addChild(_loc11_);
         var _loc13_:Sequence = new Sequence();
         _loc13_.addChild(_loc3_);
         _loc13_.addChild(_loc4_);
         _loc13_.addChild(_loc5_);
         _loc13_.addChild(_loc6_);
         _loc13_.addChild(_loc7_);
         _loc13_.addChild(_loc8_);
         _loc13_.addChild(this.sit(500));
         _loc13_.addChild(_loc9_);
         _loc13_.addChild(_loc12_);
         _loc13_.play([this]);
      }
      
      private function hopHigherAndRoll() : void
      {
         var _loc1_:Rectangle = this.getBounds(parent);
         var _loc2_:Number = _loc1_.width * 2 + _loc1_.height * 2;
         var _loc3_:Number = _loc2_ / 6;
         var _loc4_:Move = this.up(-100,200);
         _loc4_.xBy = _loc3_;
         var _loc5_:Move = this.down(100,200);
         _loc5_.xBy = _loc3_;
         var _loc6_:Move = this.up(-150,200);
         _loc6_.xBy = _loc3_;
         var _loc7_:Move = this.down(150,200);
         _loc7_.xBy = _loc3_;
         var _loc8_:Move = this.up(-200,400);
         _loc8_.xBy = _loc3_;
         var _loc9_:Move = this.down(200,400);
         _loc9_.xBy = _loc3_;
         var _loc10_:Rotate = new Rotate();
         _loc10_.originX = _loc1_.width / 2;
         _loc10_.originY = _loc1_.height / 2;
         _loc10_.angleFrom = 0;
         _loc10_.angleTo = 180;
         _loc10_.duration = 200;
         _loc10_.easingFunction = Linear.easeOut;
         var _loc11_:Rotate = new Rotate();
         _loc11_.originX = _loc1_.width / 2;
         _loc11_.originY = _loc1_.height / 2;
         _loc11_.angleFrom = 180;
         _loc11_.angleTo = 360;
         _loc11_.duration = 200;
         _loc11_.easingFunction = Linear.easeIn;
         var _loc12_:Rotate = new Rotate();
         _loc12_.originX = _loc1_.width / 2;
         _loc12_.originY = _loc1_.height / 2;
         _loc12_.angleFrom = 0;
         _loc12_.angleTo = 540;
         _loc12_.duration = 400;
         _loc12_.easingFunction = Linear.easeOut;
         var _loc13_:Rotate = new Rotate();
         _loc13_.originX = _loc1_.width / 2;
         _loc13_.originY = _loc1_.height / 2;
         _loc13_.angleFrom = 540;
         _loc13_.angleTo = 1080;
         _loc13_.duration = 400;
         _loc13_.easingFunction = Linear.easeIn;
         var _loc14_:Parallel = new Parallel();
         _loc14_.addChild(_loc4_);
         _loc14_.addChild(_loc10_);
         var _loc15_:Parallel = new Parallel();
         _loc15_.addChild(_loc5_);
         _loc15_.addChild(_loc11_);
         var _loc16_:Parallel = new Parallel();
         _loc16_.addChild(_loc6_);
         _loc16_.addChild(_loc10_);
         var _loc17_:Parallel = new Parallel();
         _loc17_.addChild(_loc7_);
         _loc17_.addChild(_loc11_);
         var _loc18_:Parallel = new Parallel();
         _loc18_.addChild(_loc8_);
         _loc18_.addChild(_loc12_);
         var _loc19_:Parallel = new Parallel();
         _loc19_.addChild(_loc9_);
         _loc19_.addChild(_loc13_);
         var _loc20_:Sequence = new Sequence();
         _loc20_.addChild(_loc14_);
         _loc20_.addChild(_loc15_);
         _loc20_.addChild(_loc16_);
         _loc20_.addChild(_loc17_);
         _loc20_.addChild(_loc18_);
         _loc20_.addChild(_loc19_);
         _loc20_.addChild(this.sit(200));
         _loc20_.addChild(this.rollBack());
         _loc20_.play([this]);
      }
      
      private function hopOnHead() : void
      {
         maintainAspectRatio = false;
         var _loc1_:Rectangle = this.getBounds(parent);
         var _loc2_:Rotate = new Rotate();
         _loc2_.originX = _loc1_.width / 2;
         _loc2_.originY = _loc1_.height / 2;
         _loc2_.angleFrom = 0;
         _loc2_.angleTo = 180;
         _loc2_.duration = 200;
         _loc2_.easingFunction = Linear.easeOut;
         var _loc3_:Rotate = new Rotate();
         _loc3_.originX = _loc1_.width / 2;
         _loc3_.originY = _loc1_.height / 2;
         _loc3_.angleFrom = 180;
         _loc3_.angleTo = 0;
         _loc3_.duration = 200;
         _loc3_.easingFunction = Linear.easeIn;
         var _loc4_:Number = 80 / parent.scaleX;
         var _loc5_:Move = this.up(-100,200);
         _loc5_.xBy = _loc4_;
         var _loc6_:Move = this.down(100,200);
         _loc6_.xBy = _loc4_;
         var _loc7_:Move = this.up(-100,200);
         _loc7_.xBy = -_loc4_;
         var _loc8_:Move = this.down(100,200);
         _loc8_.xBy = -_loc4_;
         var _loc9_:Parallel = new Parallel();
         _loc9_.addChild(_loc2_);
         _loc9_.addChild(_loc5_);
         var _loc10_:Parallel = new Parallel();
         _loc10_.addChild(_loc3_);
         _loc10_.addChild(_loc8_);
         var _loc11_:Resize = new Resize();
         _loc11_.heightTo = height / 2;
         _loc11_.duration = 200;
         _loc11_.easingFunction = Sine.easeOut;
         var _loc12_:Resize = new Resize();
         _loc12_.duration = 100;
         _loc12_.heightTo = height;
         _loc12_.easingFunction = Sine.easeIn;
         var _loc13_:Sequence = new Sequence();
         _loc13_.addChild(_loc9_);
         _loc13_.addChild(_loc6_);
         _loc13_.addChild(_loc11_);
         _loc13_.addChild(_loc12_);
         _loc13_.addChild(_loc7_);
         _loc13_.addChild(_loc8_);
         _loc13_.addChild(_loc11_);
         _loc13_.addChild(_loc12_);
         _loc13_.addChild(_loc7_);
         _loc13_.addChild(_loc8_);
         _loc13_.addChild(_loc11_);
         _loc13_.addChild(_loc12_);
         _loc13_.addChild(_loc5_);
         _loc13_.addChild(_loc6_);
         _loc13_.addChild(_loc11_);
         _loc13_.addChild(_loc12_);
         _loc13_.addChild(_loc5_);
         _loc13_.addChild(_loc6_);
         _loc13_.addChild(_loc11_);
         _loc13_.addChild(_loc12_);
         _loc13_.addChild(_loc7_);
         _loc13_.addChild(_loc10_);
         _loc13_.play([this]);
      }
      
      private function hopAround() : void
      {
         var _loc1_:Number = 80 / parent.scaleX;
         var _loc2_:Move = this.up(-100,200);
         _loc2_.xBy = _loc1_;
         var _loc3_:Move = this.down(100,200);
         _loc3_.xBy = _loc1_;
         var _loc4_:Move = this.up(-100,200);
         _loc4_.xBy = -_loc1_;
         var _loc5_:Move = this.down(100,200);
         _loc5_.xBy = -_loc1_;
         var _loc6_:Sequence = new Sequence();
         _loc6_.addChild(_loc2_);
         _loc6_.addChild(_loc3_);
         _loc6_.addChild(_loc2_);
         _loc6_.addChild(_loc3_);
         _loc6_.addChild(_loc2_);
         _loc6_.addChild(_loc3_);
         _loc6_.addChild(_loc4_);
         _loc6_.addChild(_loc5_);
         _loc6_.addChild(_loc4_);
         _loc6_.addChild(_loc5_);
         _loc6_.addChild(_loc4_);
         _loc6_.addChild(_loc5_);
         _loc6_.play([this]);
      }
      
      private function hopUpAndDown() : void
      {
         var _loc1_:Rectangle = this.getBounds(parent);
         var _loc2_:Move = this.up(-60,200);
         var _loc3_:Move = this.down(60,200);
         var _loc4_:Sequence = new Sequence();
         _loc4_.addChild(_loc2_);
         _loc4_.addChild(_loc3_);
         _loc4_.addChild(_loc2_);
         _loc4_.addChild(_loc3_);
         _loc4_.addChild(_loc2_);
         _loc4_.addChild(_loc3_);
         _loc4_.addChild(_loc2_);
         _loc4_.addChild(_loc3_);
         _loc4_.play([this]);
      }
      
      private function ballLoaded() : void
      {
         parent.addChild(this.ball);
         this.ball.move(this.x,this.y);
         if(!(parent is MovieStar))
         {
            this.ball.scaleX = scaleX * 0.5;
            this.ball.scaleY = scaleY * 0.5;
         }
         var _loc1_:Number = this.x + this.width / 2 - this.ball.contentWidth / 2;
         var _loc2_:Number = this.y - this.ball.contentHeight / 2;
         this.ball.moveBall(_loc1_,_loc2_);
         this.lowerBoundsLeft = Math.max(this.x - this.BOUNDS_MAX,100);
         this.upperBoundsLeft = Math.max(this.x - this.BOUNDS_MIN,100);
         this.lowerBoundsRight = Math.min(this.x + this.BOUNDS_MIN,850);
         this.upperBoundsRight = Math.min(this.x + this.BOUNDS_MAX,850);
         this.ballFromMonster();
      }
      
      private function ballFromMonster() : void
      {
         this.ballState = 1;
         this.responseTime *= 0.95;
         var _loc1_:int = this.lowerBoundsLeft + Math.random() * this.upperBoundsRight;
         if(Math.abs(_loc1_ - this.x) < this.BOUNDS_MIN)
         {
            if(_loc1_ < this.x && this.lowerBoundsLeft != this.upperBoundsLeft)
            {
               _loc1_ = this.lowerBoundsLeft + Math.random() * (this.upperBoundsLeft - this.lowerBoundsLeft);
            }
            else
            {
               _loc1_ = this.lowerBoundsRight + Math.random() * (this.upperBoundsRight - this.lowerBoundsRight);
            }
         }
         var _loc2_:int = this.ball.y + this.ball.height;
         this.ball.bounceAway(_loc1_,_loc2_,this.responseTime,this.ballLanded);
      }
      
      private function ballToMonster() : void
      {
         this.ballState = 2;
         this.ball.bounceBack(this.ballFromMonster);
      }
      
      private function ballClicked(param1:MouseEvent) : void
      {
         if(this.ballState == 1)
         {
            this.ballToMonster();
            ++this.count;
         }
         param1.stopPropagation();
      }
      
      private function ballLanded() : void
      {
         var ballStopped:Function = null;
         var that:Monster = null;
         var done:Function = null;
         ballStopped = function():void
         {
            ballTimeout = new Timer(3000,1);
            ballTimeout.addEventListener(TimerEvent.TIMER,vanishBall);
            ballTimeout.start();
         };
         done = function(param1:int):void
         {
            clickItemData.PlayPoints += param1;
            updatePlayLevel();
            if(param1 > 0)
            {
               DisplayUtils.showPointImage(param1.toString(),that);
            }
         };
         ChatRoomController.walkEnabled = true;
         ChatRoomController.isPlayingChatroomGame = false;
         this.ball.bounceAtEnd(ballStopped);
         this.ballState = 0;
         that = this;
         if(this.count > 0)
         {
            new PetAMFService().PlayedPetGame(clickItemData.ActorClickItemRelId,this.count,done);
         }
      }
      
      private function vanishBall(param1:TimerEvent) : void
      {
         if(Boolean(parent) && Boolean(parent.contains(this.ball)))
         {
            parent.removeChild(this.ball);
         }
         this.ballTimeout.stop();
      }
      
      public function get playLevel() : int
      {
         return this._playLevel;
      }
      
      public function get nextPlayLevelPoints() : int
      {
         if(this.playLevel < PLAY_LEVELS.length - 1)
         {
            return PLAY_LEVELS[this.playLevel + 1];
         }
         return this.currentPlayLevelPoints;
      }
      
      public function get currentPlayLevelPoints() : int
      {
         return PLAY_LEVELS[this.playLevel];
      }
      
      private function updatePlayLevel() : void
      {
         var alertClosed:Function;
         var playPoints:int = clickItemData.PlayPoints;
         var hasChanged:Boolean = false;
         var i:int = 0;
         while(i < PLAY_LEVELS.length - 1 && PLAY_LEVELS[i + 1] < playPoints)
         {
            i++;
         }
         if(this.playLevel >= 0 && i > this.playLevel)
         {
            hasChanged = true;
         }
         this._playLevel = i;
         if(hasChanged)
         {
            if(_dispatchUpdates)
            {
               alertClosed = function():void
               {
                  tricks[tricks.length - 1].trickCall();
               };
               MessageCommunicator.sendMessage(E_MONSTER_UPDATED,this);
               MessageCommunicator.send(new MsgEvent(MSPEvent.PET_LEVEL_WENT_UP,this._playLevel));
            }
            if(_monsterPopup != null)
            {
               _monsterPopup.updateMonster();
            }
         }
      }
      
      private function updateDirtState() : void
      {
         var _loc1_:Number = ClickItemUtil.calculateDirtPoints(clickItemData.LastWashTime,clickItemData.ClickItemId,clickItemData.Stage);
         if(this.dirtState != _loc1_)
         {
            this.dirtState = _loc1_;
         }
      }
      
      private function get isDirty() : Boolean
      {
         return this.dirtState > 0;
      }
      
      private function soapCursor() : void
      {
         this.soapCursorId = CursorManager.setCursor(this.soapCursorClass,CursorManagerPriority.MEDIUM);
      }
      
      private function moveSoap(param1:MouseEvent) : void
      {
         if(this.soapCursorId == 0)
         {
            this.soapCursor();
         }
         setMood("_happy");
         if(this.bubbles == null)
         {
            return;
         }
         this.bubbleTimer.reset();
         this.vanishTimer.stop();
         if(!this.bubbles.visible)
         {
            this.bubbles.x = contentMouseX - 16;
            this.bubbles.y = contentMouseY;
         }
         this.bubbles.visible = true;
         this.bubbles.play();
         this.bubbleTimer.start();
         this.washTimer.start();
      }
      
      private function playWash(param1:MouseEvent) : void
      {
         this.isSoapOver = true;
      }
      
      private function pauseWash(param1:MouseEvent) : void
      {
         this.isSoapOver = false;
      }
      
      private function bubbleTimeout(param1:TimerEvent) : void
      {
         this.bubbles.stop();
         this.bubbleTimer.stop();
         this.vanishTimer.reset();
         this.vanishTimer.start();
      }
      
      private function vanishBubbles(param1:TimerEvent) : void
      {
         this.bubbles.visible = false;
         this.washTimer.stop();
         if(!this.isWashing)
         {
            if(contains(this.bubbles))
            {
               removeChild(this.bubbles);
            }
         }
      }
      
      private function washCounter(param1:TimerEvent) : void
      {
         if(this.washTimer.currentCount == this.washTimer.repeatCount)
         {
            this.allClean();
         }
      }
      
      private function allClean() : void
      {
         var that:Pet = null;
         var done:Function = null;
         done = function(param1:Object):void
         {
            var _loc2_:int = int(param1.amount as int);
            var _loc3_:int = int(param1.awardedFame as int);
            if(_loc2_ > 0)
            {
               AnalyticsReceiveCurrencyCommand.execute(AnalyticsConstants.EARN_SC_SINGLE_OLDPET_WASHED,_loc2_);
               clickItemData.LastWashTime = new Date();
               updateDirtState();
               ActorReload.getInstance().requestReload();
               DisplayUtils.showMoneyImage(_loc2_.toString(),that);
            }
            if(_loc3_ > 0)
            {
               DisplayUtils.showPointImage(_loc3_.toString(),that);
            }
         };
         removeEventListener(MouseEvent.MOUSE_OVER,this.playWash);
         removeEventListener(MouseEvent.MOUSE_OUT,this.pauseWash);
         removeEventListener(MouseEvent.MOUSE_MOVE,this.moveSoap);
         CursorManager.removeAllCursors();
         this.soapCursorId = 0;
         this.isWashing = false;
         setMood("_happy");
         new PetAMFService().WashPet(ActorSession.getActorId(),clickItemData.ActorClickItemRelId,done);
         that = this;
      }
      
      private function resetCursor(param1:Event = null) : void
      {
         if(this.soapCursorId)
         {
            CursorManager.removeAllCursors();
            this.soapCursorId = 0;
         }
      }
      
      private function getContainingRoom() : DisplayObjectContainer
      {
         var _loc1_:UIComponent = parent as UIComponent;
         while(_loc1_.id != "sliderCanvas" && _loc1_.id != "MainView" && _loc1_.parent != null)
         {
            _loc1_ = _loc1_.parent as UIComponent;
         }
         return _loc1_;
      }
   }
}

