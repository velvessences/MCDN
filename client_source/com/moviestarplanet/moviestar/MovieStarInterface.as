package com.moviestarplanet.moviestar
{
   import com.moviestarplanet.body.FaceExpression;
   import com.moviestarplanet.display.IDisplayObject;
   import com.moviestarplanet.media.valueobjects.Animation;
   import com.moviestarplanet.moviestar.valueObjects.Actor;
   import com.moviestarplanet.moviestar.valueObjects.ActorClothesRel;
   import flash.display.MovieClip;
   import flash.events.IEventDispatcher;
   
   public interface MovieStarInterface extends IEventDispatcher
   {
      
      function get movieStarPopupEnabled() : Boolean;
      
      function get actor() : Actor;
      
      function get isInChatRoom() : Boolean;
      
      function GetAttachedClothes() : Array;
      
      function SetClothes(param1:Array, param2:Function = null) : void;
      
      function TakeOffCloth(param1:ActorClothesRel) : void;
      
      function get animation() : Animation;
      
      function get stopFrame() : int;
      
      function set stopFrame(param1:int) : void;
      
      function get startFrame() : int;
      
      function get finalFrame() : int;
      
      function attachFrontEyesDragonBone(param1:MovieClip) : void;
      
      function attachSideEyesDragonBone(param1:MovieClip) : void;
      
      function attachFrontEyeShadowDragonBone(param1:MovieClip) : void;
      
      function attachSideEyeShadowDragonBone(param1:MovieClip) : void;
      
      function setAnimation(param1:Animation, param2:Function = null, param3:int = 0) : void;
      
      function set faceExpression(param1:FaceExpression) : void;
      
      function get skinColor() : uint;
      
      function set skinColor(param1:uint) : void;
      
      function removeEyeShadow() : void;
      
      function set scale(param1:Number) : void;
      
      function get scale() : Number;
      
      function LoadFacePart(param1:String, param2:String, param3:Function, param4:String = null, param5:Boolean = false) : void;
      
      function destroy() : void;
      
      function flipHorizontally() : void;
      
      function get clothLoader() : IClothLoader;
      
      function get displayObject() : IDisplayObject;
      
      function setFacePartColors(param1:String, param2:String) : void;
   }
}

