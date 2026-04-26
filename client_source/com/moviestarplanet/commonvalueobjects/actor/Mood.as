package com.moviestarplanet.commonvalueobjects.actor
{
   import mx.collections.ArrayCollection;
   
   public class Mood
   {
      
      public var ActorId:int;
      
      public var FigureAnimation:String;
      
      private var faceAnimation:String;
      
      public var MouthAnimation:String;
      
      public var TextLine:String;
      
      public var SpeechLine:Boolean;
      
      public var IsBrag:Boolean;
      
      public var TextLineWhitelisted:String;
      
      public var TextLineBlacklisted:String;
      
      public var TextLineLastFiltered:Date;
      
      public var WallPostId:int;
      
      public var Likes:int;
      
      public var WallPostLinks:ArrayCollection;
      
      public function Mood()
      {
         super();
      }
      
      public function set FaceAnimation(param1:String) : void
      {
         if(this.isProperFaceAnimation(param1))
         {
            this.faceAnimation = param1;
         }
         else
         {
            this.faceAnimation = "neutral";
         }
      }
      
      public function get FaceAnimation() : String
      {
         if(!this.isProperFaceAnimation(this.faceAnimation))
         {
            this.faceAnimation = "neutral";
         }
         return this.faceAnimation;
      }
      
      internal function isProperFaceAnimation(param1:String) : Boolean
      {
         switch(param1)
         {
            case "neutral":
            case "sad":
            case "surprised":
            case "angry":
            case "happy":
               return true;
            default:
               return false;
         }
      }
   }
}

