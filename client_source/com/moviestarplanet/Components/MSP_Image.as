package com.moviestarplanet.Components
{
   import com.moviestarplanet.amf.ServiceUrlUtil;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.managers.SoundManager;
   import com.moviestarplanet.utils.loader.MSP_LoaderManager;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import mx.controls.Image;
   import mx.effects.IEffectInstance;
   
   public class MSP_Image extends Image
   {
      
      private var _clicksound:String = "click.mp3";
      
      public function MSP_Image()
      {
         super();
         addEventListener(MouseEvent.CLICK,this.clickHandler);
         this.loaderContext = new LoaderContext(true,Config.isMobile ? ApplicationDomain.currentDomain : null,Config.getSecurityDomain());
      }
      
      override protected function clickHandler(param1:MouseEvent) : void
      {
         if(!enabled)
         {
            param1.stopImmediatePropagation();
         }
      }
      
      public function set clickSound(param1:String) : void
      {
         this._clicksound = param1;
      }
      
      override public function set buttonMode(param1:Boolean) : void
      {
         super.buttonMode = param1;
         if(buttonMode)
         {
            addEventListener(MouseEvent.CLICK,this.clickSoundHandler,false,0,true);
         }
         else
         {
            removeEventListener(MouseEvent.CLICK,this.clickSoundHandler);
         }
      }
      
      private function clickSoundHandler(param1:MouseEvent) : void
      {
         if(enabled)
         {
            SoundManager.Instance().playSoundEffect(this._clicksound);
         }
      }
      
      override public function set source(param1:Object) : void
      {
         if(Config.isMobile)
         {
            param1 = ServiceUrlUtil.makeAbsoluteUrl(param1);
         }
         if(param1 is String)
         {
            param1 = MSP_LoaderManager.applyVersionToString(param1 as String);
         }
         super.source = param1;
      }
      
      override public function effectFinished(param1:IEffectInstance) : void
      {
         super.effectFinished(param1);
      }
   }
}

