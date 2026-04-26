package com.moviestarplanet.managers
{
   import com.moviestarplanet.assetManager.DeviceAssetURL;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.constants.ConstantsPlatform;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.msg.MSP_Event;
   import com.moviestarplanet.utils.loader.AssetUrl;
   import com.moviestarplanet.utils.sound.SoundManagerEvent;
   import com.moviestarplanet.utils.sound.Sounds;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   
   public class SoundManager extends EventDispatcher
   {
      
      private static var _instance:SoundManager;
      
      private const SOUNDS_PATH_DEVICE:String = "assets/sounds/";
      
      private var _orgVolume:Number;
      
      private var _isMuted:Boolean;
      
      private var _sndRefs:Dictionary = new Dictionary();
      
      private var _sndLoopsRefs:Dictionary = new Dictionary();
      
      private var _sndChannelRefs:Dictionary = new Dictionary();
      
      private var _sndTransformRefs:Dictionary = new Dictionary();
      
      public function SoundManager(param1:SingletonBlocker)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use MSP_SoundManager.getInstance() instead of new.");
         }
      }
      
      public static function Instance() : SoundManager
      {
         if(_instance == null)
         {
            _instance = new SoundManager(new SingletonBlocker());
         }
         return _instance;
      }
      
      public function toggleSound() : void
      {
         this.isMuted = !this.isMuted;
      }
      
      public function get isMuted() : Boolean
      {
         return this._isMuted;
      }
      
      public function set isMuted(param1:Boolean) : void
      {
         if(param1 != this._isMuted)
         {
            this._isMuted = param1;
            if(this.isMuted)
            {
               this._orgVolume = SoundMixer.soundTransform.volume;
               SoundMixer.soundTransform.volume = 0;
               this.muteAllSounds();
            }
            else
            {
               SoundMixer.soundTransform.volume = this._orgVolume;
            }
            this.dispatchMuteChanged();
         }
      }
      
      public function dispatchMuteChanged() : void
      {
         dispatchEvent(new Event(MSP_Event.E_MUTE_CHANGED));
         MessageCommunicator.send(new SoundManagerEvent(SoundManagerEvent.MUTE_CHANGED));
      }
      
      public function playSoundEffect(param1:String, param2:int = 0) : void
      {
         var _loc3_:Sound = null;
         var _loc4_:SoundLoader = null;
         if(!this.isMuted && param1 != null)
         {
            _loc3_ = this._sndRefs[param1] as Sound;
            if(this._sndChannelRefs[param1] != null)
            {
               this._sndChannelRefs[param1].stop();
            }
            if(_loc3_ == null)
            {
               if(ConstantsPlatform.isMobile)
               {
                  _loc4_ = SoundLoader.create(param1,new DeviceAssetURL(param1,DeviceAssetURL.SOUNDS),this.onSuccess,this.onDeviceLoadFail,false);
               }
               else
               {
                  _loc4_ = SoundLoader.create(param1,new AssetUrl(param1,AssetUrl.SOUNDS),this.onSuccess,this.onFail);
               }
               this._sndLoopsRefs[_loc4_] = param2;
               _loc4_.load();
            }
            else
            {
               this._sndChannelRefs[param1] = _loc3_.play(0,param2,this.getTransformFromSound(param1));
            }
         }
      }
      
      private function onDeviceLoadFail(param1:SoundLoader) : void
      {
         var _loc2_:SoundLoader = SoundLoader.create(param1.getSoundUrl(),new AssetUrl(param1.getSoundUrl(),AssetUrl.SOUNDS),this.onSuccess,this.onFail);
         var _loc3_:int = int(this._sndLoopsRefs[param1]);
         delete this._sndLoopsRefs[param1];
         param1.dispose();
         this._sndLoopsRefs[_loc2_] = _loc3_;
         _loc2_.load();
      }
      
      public function stopSoundEffect(param1:String) : void
      {
         if(this._sndChannelRefs[param1] != null)
         {
            this._sndChannelRefs[param1].stop();
         }
      }
      
      private function onSuccess(param1:SoundLoader) : void
      {
         var _loc2_:Sound = param1.getSound();
         this._sndRefs[param1.getSoundUrl()] = _loc2_;
         this._sndChannelRefs[param1.getSoundUrl()] = _loc2_.play(0,this._sndLoopsRefs[param1],this.getTransformFromSound(param1.getSoundUrl()));
         delete this._sndLoopsRefs[param1];
         param1.dispose();
      }
      
      private function onFail(param1:SoundLoader) : void
      {
         delete this._sndLoopsRefs[param1];
         param1.dispose();
         trace("Sound failed to play");
         if(Config.IsRunningInDevelopment)
         {
            throw new Error("Sound failed to play");
         }
      }
      
      private function muteAllSounds() : void
      {
         var _loc1_:SoundChannel = null;
         for each(_loc1_ in this._sndChannelRefs)
         {
            _loc1_.stop();
         }
      }
      
      private function getTransformFromSound(param1:String) : SoundTransform
      {
         if(this._sndTransformRefs[param1] !== undefined)
         {
            return this._sndTransformRefs[param1];
         }
         switch(param1)
         {
            case Sounds.BUTTON_HOVER:
               this._sndTransformRefs[param1] = new SoundTransform(0.3);
               break;
            case Sounds.CHAT_SEND:
               this._sndTransformRefs[param1] = new SoundTransform(0.4);
               break;
            case Sounds.PICKUP_COIN_FAME:
            case Sounds.PICKUP_DIAMOND:
            case Sounds.BUTTON_CLICK:
               this._sndTransformRefs[param1] = new SoundTransform(0.5);
               break;
            case Sounds.BUTTON_PAGING_CLICK:
               this._sndTransformRefs[param1] = new SoundTransform(0.8);
               break;
            default:
               this._sndTransformRefs[param1] = null;
         }
         return this._sndTransformRefs[param1];
      }
   }
}

class SingletonBlocker
{
   
   public function SingletonBlocker()
   {
      super();
   }
}
