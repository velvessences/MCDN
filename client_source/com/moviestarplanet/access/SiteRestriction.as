package com.moviestarplanet.access
{
   import com.moviestarplanet.config.ISiteConfig;
   import com.moviestarplanet.config.ISiteRestriction;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.model.IActorModel;
   import com.moviestarplanet.model.IActorPersonalInfo;
   import com.moviestarplanet.utils.DateUtils;
   
   public class SiteRestriction implements ISiteRestriction
   {
      
      [Inject]
      public var siteConfig:ISiteConfig;
      
      [Inject(name="isServerRestricted")]
      public var _isServerRestricted:Boolean;
      
      [Inject]
      public var actorModel:IActorModel;
      
      public function SiteRestriction()
      {
         super();
         InjectionManager.manager().injectMe(this);
      }
      
      public function isUnderage() : Boolean
      {
         var _loc1_:IActorPersonalInfo = this.actorModel.actorPersonalInfo;
         var _loc2_:int = DateUtils.getYearsSince(_loc1_.birthDate);
         return _loc2_ < this.siteConfig.ageCutoff();
      }
      
      public function isServerRestricted() : Boolean
      {
         return this._isServerRestricted;
      }
   }
}

