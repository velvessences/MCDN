package com.moviestarplanet.usersession.valueobjects
{
   import com.moviestarplanet.actor.INewActorCreationData;
   
   public class NewActorCreationData implements INewActorCreationData
   {
      
      public var ChosenActorName:String;
      
      public var ChosenPassword:String;
      
      public var SkinIsMale:Boolean;
      
      public var SkinColor:String;
      
      public var EyeId:int;
      
      public var EyeColors:String;
      
      public var MouthId:int;
      
      public var MouthColors:String;
      
      public var NoseId:int;
      
      public var InvitedByActorId:int;
      
      public var Clothes:Array;
      
      public function NewActorCreationData(param1:ActorDetails = null, param2:Array = null, param3:String = null)
      {
         super();
         if(param1 == null && param2 == null && param3 == null)
         {
            return;
         }
         this.ChosenActorName = param1.Name;
         this.ChosenPassword = param3;
         this.SkinIsMale = param1.SkinSWF == "maleskin";
         this.SkinColor = param1.SkinColor;
         this.EyeId = param1.EyeId;
         this.EyeColors = param1.EyeColors;
         this.MouthId = param1.MouthId;
         this.MouthColors = param1.MouthColors;
         this.NoseId = param1.NoseId;
         this.InvitedByActorId = param1.InvitedByActorId;
         this.Clothes = param2;
      }
      
      public function getChosenActorName() : String
      {
         return this.ChosenActorName;
      }
      
      public function getChosenPassword() : String
      {
         return this.ChosenPassword;
      }
      
      public function getSkinIsMale() : Boolean
      {
         return this.SkinIsMale;
      }
      
      public function getSkinColor() : String
      {
         return this.SkinColor;
      }
      
      public function getEyeId() : int
      {
         return this.EyeId;
      }
      
      public function getEyeColors() : String
      {
         return this.EyeColors;
      }
      
      public function getMouthId() : int
      {
         return this.MouthId;
      }
      
      public function getMouthColors() : String
      {
         return this.MouthColors;
      }
      
      public function getNoseId() : int
      {
         return this.NoseId;
      }
      
      public function getInvitedByActorId() : int
      {
         return this.InvitedByActorId;
      }
      
      public function getClothes() : Array
      {
         return this.Clothes;
      }
   }
}

