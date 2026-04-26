package com.moviestarplanet.friendship.valueobjects
{
   import com.moviestarplanet.bonster.valueobjects.ActorBonsterRelItem;
   import com.moviestarplanet.commonvalueobjects.actor.Mood;
   import com.moviestarplanet.pet.valueobjects.ActorClickItemRel;
   import mx.collections.ArrayCollection;
   
   public class ActorSpecialSummary
   {
      
      private var _SpecialFriends:ArrayCollection;
      
      private var _AnimationMood:Mood;
      
      private var _LastUpdated:Date;
      
      private var _PetClickItem:ActorClickItemRel;
      
      private var _FriendsStatus:int;
      
      private var _Todos:ArrayCollection;
      
      private var _BonsterRelItem:ActorBonsterRelItem;
      
      public function ActorSpecialSummary()
      {
         super();
      }
      
      public function get LastUpdated() : Date
      {
         return this._LastUpdated;
      }
      
      public function set LastUpdated(param1:Date) : void
      {
         this._LastUpdated = param1;
      }
      
      public function get SpecialFriends() : ArrayCollection
      {
         return this._SpecialFriends;
      }
      
      public function get AnimationMood() : Mood
      {
         return this._AnimationMood;
      }
      
      public function get PetClickItem() : ActorClickItemRel
      {
         return this._PetClickItem;
      }
      
      public function get FriendsStatus() : int
      {
         return this._FriendsStatus;
      }
      
      public function get Todos() : ArrayCollection
      {
         return this._Todos;
      }
      
      public function get BonsterRelItem() : ActorBonsterRelItem
      {
         return this._BonsterRelItem;
      }
      
      public function set SpecialFriends(param1:*) : void
      {
         if(param1 is ArrayCollection)
         {
            this._SpecialFriends = param1;
         }
         else if(param1 is Array)
         {
            this._SpecialFriends = new ArrayCollection(param1);
         }
         else
         {
            if(param1 != null)
            {
               throw new Error("value of SpecialFriends must be a collection");
            }
            this._SpecialFriends = null;
         }
      }
      
      public function set AnimationMood(param1:Mood) : void
      {
         this._AnimationMood = param1;
      }
      
      public function set PetClickItem(param1:ActorClickItemRel) : void
      {
         this._PetClickItem = param1;
      }
      
      public function set FriendsStatus(param1:int) : void
      {
         this._FriendsStatus = param1;
      }
      
      public function set Todos(param1:*) : void
      {
         if(param1 is ArrayCollection)
         {
            this._Todos = param1;
         }
         else if(param1 is Array)
         {
            this._Todos = new ArrayCollection(param1);
         }
         else
         {
            if(param1 != null)
            {
               throw new Error("value of Todos must be a collection");
            }
            this._Todos = null;
         }
      }
      
      public function set BonsterRelItem(param1:ActorBonsterRelItem) : void
      {
         this._BonsterRelItem = param1;
      }
   }
}

