package com.moviestarplanet.anchorCharacters
{
   import com.moviestarplanet.anchorCharacters.service.AMFSponsoredCharacterService;
   import com.moviestarplanet.anchorCharacters.valueobjects.AnchorCharacterInfoVO;
   import com.moviestarplanet.globalsharedutils.SnapshotUrl;
   import com.moviestarplanet.globalsharedutils.storage.ObjectCache;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.platform.ApplicationId;
   
   public class AnchorCharacters
   {
      
      private static var voCache:Object;
      
      public static var spCharListCacheWeb:Object;
      
      private static var _spCharService:AMFSponsoredCharacterService;
      
      public static var applicationType:String;
      
      public static var FEMALE_ANCHOR:int = 3;
      
      public static var MALE_ANCHOR:int = 4;
      
      public static var GOSSIP_GIRL:int = 414;
      
      private static var _anchorCharacterIds:Array = [FEMALE_ANCHOR,MALE_ANCHOR];
      
      private static var waitingForSpecialChars:Vector.<Function> = new Vector.<Function>();
      
      private static var loadigSpecialChars:Boolean = false;
      
      public function AnchorCharacters()
      {
         super();
      }
      
      public static function isSpecialCharacter(param1:int) : Boolean
      {
         if(isAnchorCharacter(param1) || isSponsoredAnchorCharacter(param1))
         {
            return true;
         }
         return false;
      }
      
      public static function isAnchorCharacter(param1:int) : Boolean
      {
         if(_anchorCharacterIds.indexOf(param1) >= 0)
         {
            return true;
         }
         return false;
      }
      
      public static function getSpecialCharacterType(param1:int) : int
      {
         if(isAnchorCharacter(param1))
         {
            return AnchorCharacterInfoVO.TYPE_ANCHOR;
         }
         var _loc2_:AnchorCharacterInfoVO = getSpecialCharacterInfo(param1);
         if(_loc2_ != null)
         {
            return _loc2_.CharacterType;
         }
         return -1;
      }
      
      public static function shouldUseSpecialBitmapSnapshot(param1:int) : Boolean
      {
         var _loc2_:AnchorCharacterInfoVO = getSpecialCharacterInfo(param1);
         if(_loc2_ != null)
         {
            return _loc2_.CharacterType == AnchorCharacterInfoVO.TYPE_SPONSORED;
         }
         return false;
      }
      
      public static function isSponsoredAnchorCharacter(param1:int) : Boolean
      {
         var _loc2_:AnchorCharacterInfoVO = getSpecialCharacterInfo(param1);
         if(_loc2_ != null && _anchorCharacterIds.indexOf(param1) == -1)
         {
            return _loc2_.IsSponsored;
         }
         return false;
      }
      
      public static function isSponsoredNoContentCharacter(param1:int) : Boolean
      {
         var _loc2_:AnchorCharacterInfoVO = getSpecialCharacterInfo(param1);
         if(_loc2_ != null)
         {
            return !_loc2_.CanUseInContent;
         }
         return false;
      }
      
      public static function getMyAnchorId(param1:Boolean) : int
      {
         return param1 ? FEMALE_ANCHOR : MALE_ANCHOR;
      }
      
      public static function getNameForId(param1:int) : String
      {
         switch(param1)
         {
            case FEMALE_ANCHOR:
               return "Pixi Star";
            case MALE_ANCHOR:
               return "Zac Sky";
            default:
               return "";
         }
      }
      
      public static function getNameForGender(param1:Boolean) : String
      {
         if(param1)
         {
            return getNameForId(FEMALE_ANCHOR);
         }
         return getNameForId(MALE_ANCHOR);
      }
      
      public static function getIdOfBestFriend(param1:int) : int
      {
         switch(param1)
         {
            case FEMALE_ANCHOR:
               return MALE_ANCHOR;
            case MALE_ANCHOR:
               return FEMALE_ANCHOR;
            default:
               return -1;
         }
      }
      
      public static function getChatRoomInstanceName(param1:int) : String
      {
         return "AnchorCharacter" + param1;
      }
      
      public static function updateSpCharListCache(param1:Function) : void
      {
         if(loadigSpecialChars)
         {
            waitingForSpecialChars.push(param1);
            return;
         }
         if(applicationType == ApplicationId.APPLICATION_MOBILE)
         {
            updateMobileCache(param1);
         }
         else
         {
            updateWebCache(param1);
         }
      }
      
      private static function updateWebCache(param1:Function) : void
      {
         var callback:Function = null;
         var onUpdated:Function = param1;
         callback = function(param1:Array):void
         {
            if(param1 != null && param1.length > 0)
            {
               spCharListCacheWeb = param1;
               SnapshotUrl.setupSponsoredFunction(shouldUseSpecialBitmapSnapshot);
               onUpdated();
               loadigSpecialChars = false;
               emptyWaitingCallbacks();
            }
         };
         if(spCharListCacheWeb != null)
         {
            onUpdated();
            return;
         }
         loadigSpecialChars = true;
         spCharService.getSponsoredCharactersList(callback);
      }
      
      private static function emptyWaitingCallbacks() : void
      {
         var _loc1_:Function = null;
         for each(_loc1_ in waitingForSpecialChars)
         {
            _loc1_();
         }
      }
      
      private static function get spCharService() : AMFSponsoredCharacterService
      {
         if(_spCharService == null)
         {
            _spCharService = InjectionManager.manager().getInstance(AMFSponsoredCharacterService);
         }
         return _spCharService;
      }
      
      private static function updateMobileCache(param1:Function) : void
      {
         var callback:Function = null;
         var onUpdated:Function = param1;
         callback = function(param1:Array):void
         {
            if(param1 != null && param1.length > 0)
            {
               ObjectCache.getInstance().setObject(ObjectCache.ANCHOR_CHARACTER_LIST_KEY,param1);
               SnapshotUrl.setupSponsoredFunction(isSponsoredAnchorCharacter);
               onUpdated();
               loadigSpecialChars = false;
               emptyWaitingCallbacks();
            }
         };
         if(ObjectCache.getInstance().shouldUpdate(ObjectCache.ANCHOR_CHARACTER_LIST_KEY))
         {
            loadigSpecialChars = true;
            spCharService.getSponsoredCharactersList(callback);
         }
         else
         {
            onUpdated();
         }
      }
      
      public static function getAllSpecialCharacters() : Array
      {
         if(applicationType == ApplicationId.APPLICATION_MOBILE)
         {
            return ObjectCache.getInstance().getObject(ObjectCache.ANCHOR_CHARACTER_LIST_KEY) as Array;
         }
         return spCharListCacheWeb as Array;
      }
      
      public static function getSpecialCharacterInfo(param1:int) : AnchorCharacterInfoVO
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         if(param1 <= 0)
         {
            return null;
         }
         if(voCache == null)
         {
            if(applicationType == ApplicationId.APPLICATION_MOBILE)
            {
               _loc2_ = ObjectCache.getInstance().getObject(ObjectCache.ANCHOR_CHARACTER_LIST_KEY) as Array;
            }
            else
            {
               _loc2_ = spCharListCacheWeb as Array;
            }
            if(!_loc2_)
            {
               return null;
            }
            voCache = new Object();
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               voCache[_loc2_[_loc3_].ActorId] = _loc2_[_loc3_];
               _loc3_++;
            }
         }
         if(voCache[param1] == undefined)
         {
            return null;
         }
         return voCache[param1];
      }
   }
}

