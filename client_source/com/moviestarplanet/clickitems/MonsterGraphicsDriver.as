package com.moviestarplanet.clickitems
{
   import com.moviestarplanet.IDestroyable;
   import com.moviestarplanet.math.NumberUtils;
   import flash.display.MovieClip;
   
   public class MonsterGraphicsDriver implements IDestroyable
   {
      
      public static const MOOD_SICK:String = "_sick";
      
      public static const MOOD_EAT:String = "_eat";
      
      public static const MOOD_HAPPY:String = "_happy";
      
      public static const MOOD_NORMAL:String = "";
      
      protected var _configuration:Object;
      
      protected var _monsterGraphics:MovieClip;
      
      protected var _mood:String = "";
      
      protected var acc:MovieClip;
      
      protected var body:MovieClip;
      
      protected var eyes:MovieClip;
      
      protected var horns:MovieClip;
      
      protected var mouth:MovieClip;
      
      protected var paws:MovieClip;
      
      public var accOptions:Array = ["acc1","acc2","acc3","acc4"];
      
      public var bodyOptions:Array = ["body1","body2","body3","body4","body5","body6","body7","body8","body9"];
      
      public var eyeOptions:Array = ["eyes1","eyes2"];
      
      public var hornOptions:Array = ["horns1","horns2","horns3","horns4"];
      
      public var mouthOptions:Array = ["mouth1","mouth2"];
      
      public var pawOptions:Array = ["paws1"];
      
      public function MonsterGraphicsDriver()
      {
         super();
      }
      
      public function destroy() : void
      {
         this._monsterGraphics = null;
         this.paws = null;
         this.mouth = null;
         this.horns = null;
         this.body = null;
         this.acc = null;
         this.eyes = null;
      }
      
      public function repaint() : void
      {
         if(!this._configuration)
         {
            if(this.body)
            {
               this.body.gotoAndStop(1);
            }
            if(this.horns)
            {
               this.horns.gotoAndStop(1);
            }
            if(this.acc)
            {
               this.acc.gotoAndStop(1);
            }
            if(this.paws)
            {
               this.paws.gotoAndPlay(1);
            }
            if(this.eyes)
            {
               this.eyes.gotoAndPlay(1);
            }
            if(this.mouth)
            {
               this.mouth.gotoAndPlay(1);
            }
            return;
         }
         if(this.body)
         {
            MovieClipUtilities.tryGotoAndStop(this.body,this._configuration.body);
         }
         if(this.horns)
         {
            MovieClipUtilities.tryGotoAndStop(this.horns,this._configuration.horns);
         }
         if(this.acc)
         {
            MovieClipUtilities.tryGotoAndStop(this.acc,this._configuration.acc);
         }
         if(this.paws)
         {
            MovieClipUtilities.tryGotoAndPlay(this.paws,this._configuration.paws);
         }
         if(this.eyes)
         {
            MovieClipUtilities.tryGotoAndPlay(this.eyes,this._configuration.eyes);
         }
         if(this.mouth)
         {
            MovieClipUtilities.tryGotoAndPlay(this.mouth,this._configuration.mouth);
         }
         this.paintMood();
      }
      
      public function paintMood() : void
      {
         if(!this._configuration)
         {
            return;
         }
         if(this.paws)
         {
            MovieClipUtilities.tryGotoAndPlay(this.paws,this._configuration.paws + this._mood);
         }
         if(this.mouth)
         {
            MovieClipUtilities.tryGotoAndPlay(this.mouth,this._configuration.mouth + this._mood);
         }
         if(this.eyes)
         {
            MovieClipUtilities.tryGotoAndPlay(this.eyes,this._configuration.eyes + this._mood);
         }
      }
      
      public function setMood(param1:String) : void
      {
         if(this._mood != param1)
         {
            this._mood = param1;
            this.paintMood();
         }
      }
      
      public function hatch() : void
      {
         this._monsterGraphics.gotoAndPlay(0);
      }
      
      public function hatchEgg(param1:int) : void
      {
         this.adjustConfigurationOptions(param1);
         this.randomizeConfiguration();
      }
      
      public function crack(param1:int) : void
      {
         var _loc2_:int = 0;
         if(this._monsterGraphics)
         {
            _loc2_ = this._monsterGraphics.totalFrames / 100 * param1;
            this._monsterGraphics.gotoAndStop(_loc2_);
         }
      }
      
      public function randomizeConfiguration() : void
      {
         this._configuration = new Object();
         this._configuration.body = this.bodyOptions[NumberUtils.random(0,this.bodyOptions.length - 1)];
         this._configuration.horns = this.hornOptions[NumberUtils.random(0,this.hornOptions.length - 1)];
         this._configuration.acc = this.accOptions[NumberUtils.random(0,this.accOptions.length - 1)];
         this._configuration.paws = this.pawOptions[NumberUtils.random(0,this.pawOptions.length - 1)];
         this._configuration.mouth = this.mouthOptions[NumberUtils.random(0,this.mouthOptions.length - 1)];
         this._configuration.eyes = this.eyeOptions[NumberUtils.random(0,this.eyeOptions.length - 1)];
         this.repaint();
      }
      
      public function adjustConfigurationOptions(param1:int) : void
      {
         switch(param1)
         {
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 7:
               break;
            case 6:
            case 8:
               this.bodyOptions = ["body1","body2","body3"];
               this.hornOptions = ["horns1","horns2","horns3"];
               this.accOptions = [];
               this.pawOptions = ["paws1"];
               this.mouthOptions = ["mouth1"];
               this.eyeOptions = ["eyes1","eyes2","eyes3","eyes4","eyes5","eyes6","eyes8","eyes9","eyes10"];
               break;
            case 19:
               this.accOptions = ["acc1"];
               this.bodyOptions = ["body1"];
               this.eyeOptions = ["eyes2"];
               this.hornOptions = ["horns1"];
               this.mouthOptions = ["mouth1"];
               this.pawOptions = ["paws1"];
               break;
            default:
               this.accOptions = ["acc1"];
               this.bodyOptions = ["body1"];
               this.eyeOptions = ["eyes2"];
               this.hornOptions = ["horns1"];
               this.mouthOptions = ["mouth2"];
               this.pawOptions = ["paws1"];
         }
      }
      
      public function playAnimation(param1:String) : void
      {
         this._monsterGraphics.gotoAndPlay(param1);
      }
      
      public function stopAnimation() : void
      {
         this._monsterGraphics.gotoAndStop("stand");
      }
      
      public function set graphicsMc(param1:MovieClip) : void
      {
         this._monsterGraphics = param1;
         this.paws = this._monsterGraphics.paws;
         this.mouth = this._monsterGraphics.mouth;
         this.horns = this._monsterGraphics.horns;
         this.body = this._monsterGraphics.body;
         this.acc = this._monsterGraphics.acc;
         this.eyes = this._monsterGraphics.eyes;
         this.repaint();
      }
      
      public function get configuration() : Object
      {
         return this._configuration;
      }
      
      public function set configuration(param1:Object) : void
      {
         this._configuration = param1;
         this.repaint();
      }
   }
}

