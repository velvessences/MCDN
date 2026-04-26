package com.moviestarplanet.services.userservice.valueObjects
{
   import com.moviestarplanet.advertisement.AdvertisementCountryMapping;
   import com.moviestarplanet.usersession.valueobjects.ActorDetails;
   import mx.collections.ArrayCollection;
   
   public class CreateNewUserStatus
   {
      
      private var _actor:ActorDetails;
      
      private var _hDetails:String;
      
      private var _adCountryMap:ArrayCollection;
      
      private var _adCountryMap_leaf:AdvertisementCountryMapping;
      
      private var _ticket:String;
      
      private var _amsHash:String;
      
      private var _features:ArrayCollection;
      
      public function CreateNewUserStatus()
      {
         super();
      }
      
      public function get actor() : ActorDetails
      {
         return this._actor;
      }
      
      public function get hDetails() : String
      {
         return this._hDetails;
      }
      
      public function get adCountryMap() : ArrayCollection
      {
         return this._adCountryMap;
      }
      
      public function get ticket() : String
      {
         return this._ticket;
      }
      
      public function get amsHash() : String
      {
         return this._amsHash;
      }
      
      public function set amsHash(param1:String) : void
      {
         this._amsHash = param1;
      }
      
      public function get features() : ArrayCollection
      {
         return this._features;
      }
      
      public function set features(param1:ArrayCollection) : void
      {
         this._features = param1;
      }
      
      public function set ticket(param1:String) : void
      {
         this._ticket = param1;
      }
      
      public function set actor(param1:ActorDetails) : void
      {
         this._actor = param1;
      }
      
      public function set hDetails(param1:String) : void
      {
         this._hDetails = param1;
      }
      
      public function set adCountryMap(param1:*) : void
      {
         this._adCountryMap = param1;
      }
   }
}

