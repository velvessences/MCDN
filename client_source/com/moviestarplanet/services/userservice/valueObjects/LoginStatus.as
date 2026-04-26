package com.moviestarplanet.services.userservice.valueObjects
{
   import com.moviestarplanet.combat.valueobject.CombatCategorisation;
   import com.moviestarplanet.piggybank.service.PiggyBank;
   import com.moviestarplanet.usersession.valueobjects.ActorDetails;
   import mx.collections.ArrayCollection;
   
   public class LoginStatus
   {
      
      public var status:String;
      
      public var actor:ActorDetails;
      
      public var statusDetails:String;
      
      public var actorLocale:ArrayCollection;
      
      public var lbse:ArrayCollection;
      
      public var userType:String;
      
      public var adCountryMap:ArrayCollection;
      
      public var postLoginSeq:PostLoginSequenceDomain;
      
      public var previousLastLogin:String;
      
      public var version:String;
      
      public var userIp:int;
      
      public var ticket:String;
      
      public var piggyBank:PiggyBank;
      
      public var purchaseTypeId:int;
      
      public var mutedUntil:Date;
      
      public var helpMessage:String;
      
      public var amsHash:String;
      
      public var combatCategorisation:CombatCategorisation;
      
      public function LoginStatus()
      {
         super();
      }
      
      public static function fromObject(param1:Object) : LoginStatus
      {
         var _loc2_:LoginStatus = new LoginStatus();
         _loc2_.status = param1.status;
         _loc2_.actor = param1.actor;
         _loc2_.statusDetails = param1.statusDetails;
         _loc2_.actorLocale = new ArrayCollection(param1.actorLocale);
         _loc2_.lbse = new ArrayCollection(param1.lbs);
         _loc2_.userType = param1.userType;
         _loc2_.adCountryMap = new ArrayCollection(param1.adCountryMap);
         _loc2_.postLoginSeq = param1.postLoginSeq ? PostLoginSequenceDomain.fromObject(param1.postLoginSeq) : null;
         _loc2_.previousLastLogin = param1.previousLastLogin;
         _loc2_.version = param1.version;
         _loc2_.userIp = param1.userIp;
         _loc2_.ticket = param1.ticket;
         _loc2_.piggyBank = param1.piggyBank;
         _loc2_.mutedUntil = param1.mutedUntil;
         _loc2_.helpMessage = param1.helpMessage;
         _loc2_.purchaseTypeId = param1.purchaseTypeId;
         _loc2_.amsHash = param1.amsHash;
         _loc2_.combatCategorisation = param1.combatCategorisation;
         return _loc2_;
      }
   }
}

