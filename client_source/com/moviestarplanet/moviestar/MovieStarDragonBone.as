package com.moviestarplanet.moviestar
{
   import com.moviestarplanet.dragonbones.DBWConstants;
   import com.moviestarplanet.dragonbones.DragonBonesWrapper;
   import com.moviestarplanet.dragonbones.loading.SwfArmatureLoaderForJsonC;
   import com.moviestarplanet.moviestar.valueObjects.Eye;
   import com.moviestarplanet.moviestar.valueObjects.EyeShadow;
   import com.moviestarplanet.moviestar.valueObjects.FacePart;
   import com.moviestarplanet.moviestar.valueObjects.Mouth;
   import com.moviestarplanet.moviestar.valueObjects.Nose;
   import com.moviestarplanet.utils.assets.AssetCacheManager;
   import com.moviestarplanet.utils.loader.ContentUrl;
   import flash.display.MovieClip;
   
   public class MovieStarDragonBone
   {
      
      public static const EYES_NEUTRAL_ANIM:String = "EyesNeutral";
      
      public static const EYES_STATIC_ANIM:String = "EyesStatic";
      
      public static const EYES_CODE:String = "eyeball";
      
      public static const EYESHADOW_CODE:String = DBWConstants.COLOR_LABEL;
      
      public const MOUTH_NEUTRAL_ANIM:String = "MouthNeutral";
      
      public const MOUTH_STATIC_ANIM:String = "MouthStatic";
      
      private var eyeColorCode:String;
      
      private var eyeShadowColorCode:String;
      
      protected var graphicLoaders:Object = new Object();
      
      public var isDragonBoneEyes:Boolean;
      
      public var isDragonBoneMouth:Boolean;
      
      public var isDragonBoneNose:Boolean;
      
      private var isJsonCSet:Boolean;
      
      private var isJsonC:Boolean;
      
      public function MovieStarDragonBone()
      {
         super();
         this.isDragonBoneEyes = false;
         this.isDragonBoneMouth = false;
         this.isDragonBoneNose = false;
         this.eyeColorCode = null;
         this.eyeShadowColorCode = null;
      }
      
      public function getFrontEyesMovieClip(param1:FacePart, param2:Function) : void
      {
         var path:String;
         var frontPartGraphicloader:DragonBonesWrapper = null;
         var frontEyesDone:Function = null;
         var facepart:FacePart = param1;
         var callback:Function = param2;
         frontEyesDone = function(param1:DragonBonesWrapper):void
         {
            frontPartGraphicloader.colorize(facepart.DefaultColors,"eyeball");
            playDragonBoneAnimation(EYES_STATIC_ANIM,true,Eye.TYPE,false);
            callback(facepart,param1.getDisplay() as MovieClip);
         };
         this.eyeColorCode = "eyeball";
         path = ContentUrl.DRAGONBONE_FACEPARTS_SUBPATH + facepart.SWFLocation;
         frontPartGraphicloader = this.getGraphicLoader(Eye.TYPE);
         frontPartGraphicloader.loadWithCallback(path,null,facepart.type,frontEyesDone,null);
      }
      
      public function loadFacePartDragonBone(param1:String, param2:String, param3:String, param4:String, param5:String, param6:Function, param7:Function, param8:Function = null, param9:Function = null) : void
      {
         var amountReady:int = 0;
         var frontLoadDone:Function = null;
         var sideLoadDone:Function = null;
         var path:String = param1;
         var skeletonPath:String = param2;
         var armatureName:String = param3;
         var colors:String = param4;
         var colorCode:String = param5;
         var attachFront:Function = param6;
         var attachSide:Function = param7;
         var callback:Function = param8;
         var failCallback:Function = param9;
         frontLoadDone = function(param1:DragonBonesWrapper):void
         {
            getGraphicLoader(armatureName);
            param1.colorize(colors,colorCode);
            setExpression(armatureName,true);
            attachFront(param1.getDisplay() as MovieClip);
            attachFront = null;
            if(callback != null)
            {
               --amountReady;
               if(amountReady <= 0)
               {
                  callback();
                  callback = null;
               }
            }
         };
         sideLoadDone = function(param1:DragonBonesWrapper):void
         {
            getGraphicLoader("side" + armatureName);
            param1.colorize(colors,colorCode);
            setExpression(armatureName,false);
            attachSide(param1.getDisplay() as MovieClip);
            attachSide = null;
            if(callback != null)
            {
               --amountReady;
               if(amountReady <= 0)
               {
                  callback();
                  callback = null;
               }
            }
         };
         AssetCacheManager.initialize();
         amountReady = 0;
         if(attachFront != null)
         {
            amountReady++;
            this.getGraphicLoader(armatureName).loadWithCallback(path,skeletonPath,armatureName,frontLoadDone,null);
         }
         if(attachSide != null)
         {
            amountReady++;
            this.getGraphicLoader("side" + armatureName).loadWithCallback(path,skeletonPath,"side" + armatureName,sideLoadDone,null);
         }
      }
      
      protected function getGraphicLoader(param1:String) : DragonBonesWrapper
      {
         if(this.graphicLoaders[param1] == null)
         {
            this.graphicLoaders[param1] = new DragonBonesWrapper(new SwfArmatureLoaderForJsonC());
         }
         return this.graphicLoaders[param1] as DragonBonesWrapper;
      }
      
      public function playDragonBoneAnimation(param1:String, param2:Boolean, param3:String, param4:Boolean = true) : void
      {
         var _loc5_:DragonBonesWrapper = null;
         var _loc6_:DragonBonesWrapper = null;
         switch(param3)
         {
            case Eye.TYPE:
            case EyeShadow.TYPE:
            case Mouth.TYPE:
            case Nose.TYPE:
               _loc5_ = this.getGraphicLoader(param3);
               _loc5_.play(param1,param2);
               _loc6_ = this.getGraphicLoader("side" + param3);
               if(param4)
               {
                  _loc6_.play(param1,param2);
               }
               break;
            default:
               trace("trying to play an unknown dragonbone type animation",param3);
         }
      }
      
      public function colorizePart(param1:String, param2:String = null, param3:String = "both") : void
      {
         var _loc4_:DragonBonesWrapper = null;
         var _loc5_:DragonBonesWrapper = null;
         var _loc6_:Boolean = true;
         var _loc7_:Boolean = true;
         var _loc8_:String = DBWConstants.COLOR_LABEL;
         if(param1 == Eye.TYPE)
         {
            _loc8_ = EYES_CODE;
         }
         if(param3 == "front")
         {
            _loc7_ = false;
         }
         if(param3 == "side")
         {
            _loc6_ = false;
         }
         switch(param1)
         {
            case Eye.TYPE:
            case EyeShadow.TYPE:
            case Mouth.TYPE:
            case Nose.TYPE:
               if(_loc6_)
               {
                  _loc4_ = this.getGraphicLoader(param1);
                  if(_loc4_ != null)
                  {
                     _loc4_.colorize(param2,_loc8_);
                  }
               }
               if(_loc7_)
               {
                  _loc5_ = this.getGraphicLoader("side" + param1);
                  if(_loc5_ != null)
                  {
                     _loc5_.colorize(param2,_loc8_);
                  }
               }
               break;
            default:
               trace("trying to colorize an unknown type");
         }
      }
      
      protected function setExpression(param1:String, param2:Boolean) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param1 == Eye.TYPE)
         {
            _loc3_ = EYES_NEUTRAL_ANIM;
            _loc4_ = EYES_NEUTRAL_ANIM;
         }
         if(param1 == Mouth.TYPE)
         {
            _loc3_ = _loc4_ = this.MOUTH_NEUTRAL_ANIM;
         }
         if(_loc3_ != null)
         {
            if(param2)
            {
               this.getGraphicLoader(param1).play(_loc3_,true);
            }
            else
            {
               this.getGraphicLoader("side" + param1).play(_loc4_,true);
            }
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in this.graphicLoaders)
         {
            if(this.graphicLoaders[_loc1_] is DragonBonesWrapper)
            {
               (this.graphicLoaders[_loc1_] as DragonBonesWrapper).dispose();
            }
            this.graphicLoaders[_loc1_] = null;
         }
      }
   }
}

