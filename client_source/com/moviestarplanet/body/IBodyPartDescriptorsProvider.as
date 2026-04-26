package com.moviestarplanet.body
{
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   
   public interface IBodyPartDescriptorsProvider
   {
      
      function get bodyPartDescriptors() : Dictionary;
      
      function GetBodyPartDescriptor(param1:String) : BodyPartDescriptor;
      
      function get skinParts() : Dictionary;
      
      function get skinMC() : MovieClip;
      
      function get mouthMC() : MovieClip;
      
      function get noseMC() : MovieClip;
      
      function get eyesMC() : MovieClip;
      
      function playEyeAnimation(param1:String) : void;
      
      function playMouthAnimation(param1:String) : void;
      
      function get isDragonBoneEyes() : Boolean;
      
      function get isDragonBoneMouth() : Boolean;
      
      function get isDragonBoneNose() : Boolean;
      
      function get frontEyes() : MovieClip;
      
      function get sideEyes() : MovieClip;
      
      function get frontMouth() : MovieClip;
      
      function get sideMouth() : MovieClip;
      
      function get frontNose() : MovieClip;
      
      function get sideNose() : MovieClip;
      
      function get frontEyeShadow() : MovieClip;
      
      function get sideEyeShadow() : MovieClip;
      
      function get AttachedItems() : Array;
      
      function Repaint() : void;
      
      function get HeadWearCount() : int;
      
      function set HeadWearCount(param1:int) : void;
      
      function get currentHair() : AttachedHairItem;
      
      function set currentHair(param1:AttachedHairItem) : void;
      
      function get isWearingHighHeels() : Boolean;
   }
}

